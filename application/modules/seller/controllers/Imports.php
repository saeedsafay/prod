<?php

use Illuminate\Database\Eloquent\ModelNotFoundException;
use League\Flysystem\Config;

(defined('BASEPATH')) or exit('No direct script access allowed');

require_once APPPATH.'modules/seller/handlers/ImportHandler.php';

class Imports extends Seller_Controller
{

    /**
     * @var \ImportHandler
     */
    private $importHandler;

    public function __construct()
    {
        parent::__construct();
        $this->importHandler = new ImportHandler();
    }

    /**
     * create mock-up and import products
     */
    public function index()
    {
        $mockupTypes = config_item("import_seller");
        $mockups = [];
        foreach ($mockupTypes["mockup_types"] as $name => $mockupType) {
            if ($mockupType["active"]) {
                $mockups[$name] = [
                    'label' => $mockupType["label"],
                    'category_id' => $mockupType["category_id"],
                ];
            }
        }
        $this->smart->assign([
            'title' => 'واردسازی محصولات',
            "mockups" => $mockups
        ]);
        $this->smart->view('import/form');
    }

    /**
     * Handling the import action such as creating mockups
     */
    public function handle()
    {
        $requestedMockupTypes = $this->input->post("mockup_types");
        $creatMockups = $this->input->post("creat_mockups");
        if ($_FILES['file']['name'] == "") {
            return $this->output->jsonResponse([
                "error" => 'فایل زیپ شده را انتخاب نمایید.',
            ], 422);
        }
        //        if ($_FILES["file"]["type"] != 'application/x-zip-compressed') {
        //            return $this->output->jsonResponse([
        //                "error" => 'فایل انتخابی باید حتما با فرمت zip و فشرده باشد.',
        //            ], 422);
        //        }
        if ( ! $requestedMockupTypes) {
            return $this->output->jsonResponse([
                "error" => 'نوع موکاپ های مورد نظر را انتخاب نمایید',
            ], 422);
        }

        try {
            if ($creatMockups) {
                $data = $this->importHandler->createMockUps(
                    $_FILES['file'],
                    $requestedMockupTypes,
                    $this->user->id
                );
            } else {
                $data = $this->importHandler->getMockups(
                    $_FILES['file'],
                    $this->user->id
                );
            }
        } catch (Throwable $e) {
            log_exception($e);
            log_message("error", "{$e->getFile()} Line {$e->getLine()}: {$e->getMessage()} ");
            return $this->output->jsonResponse([
                "error" => $e->getMessage(),
            ], $e->getCode() ? $e->getCode() : 500);
        }

        return $this->output->jsonResponse([
            "content" => $data,
            "message" => 'موکاپ محصولات ساخته شد'
        ]);
    }


    /**
     * Operations for storing products
     * @return mixed
     */
    public function importData()
    {
        $postData = $this->input->post();
        $mockupHandler = new MockupsHandler();
        $importData = [];

        foreach ($postData["productImport"] as $productData) {
            if ($productData["title"] == "" || ! $productData["title"]) {
                continue;
            }
            try {
                $parentCategory = Category::with("product_type")->whereKey(en_numbers($productData['category_id']))
                    ->firstOrFail();
            } catch (ModelNotFoundException $e) {
                return $this->output->jsonResponse([
                    "error" => "دسته بندی معتبر در پایگاه داده برای {$productData["title"]} یافت نشد",
                ], 422);
            }
            try {
                $data = [
                    "title" => $productData['title'],
                    "internal_code" => $productData['internal_code'],
                    "product_child_category_id" => en_numbers($productData['category_id']),
                    "product_category_id" => $parentCategory->parentCat->id,
                    "product_type_id" => $parentCategory->product_type->id,
                    "desc" => $productData['description'],
                    "user_id" => $this->user->id,
                    "status" => 0,
                    "type" => 4,
                    "slug" => slug($productData['title'])
                ];

                $fileName = $mockupHandler->createFileName($productData);
                $thumbnail = $mockupHandler->createThumbnail(PUBLICPATH.$productData['pic'], $fileName);
                $data["pic"] = "{$thumbnail->filename}.{$thumbnail->extension}";

                $productPicDir = new League\Flysystem\Adapter\Local(
                    config_item("import_seller")["product_pic_prefix_dir"]
                );
                $stream = fopen(PUBLICPATH.$productData["pic"], 'r+');
                if ($productPicDir->writeStream("/{$data['pic']}", $stream, new Config())) {
                    $importData[] = [
                        'values' => $data,
                        'thematic_categories' => $this->getThematicCategories($productData['thematic_category_ids'])
                    ];
                }
            } catch (InvalidArgumentException $e) {
                log_exception($e);
                return $this->output->jsonResponse([
                    "error" => $e->getMessage()
                ], 500);
            } catch (Throwable $e) {
                log_exception($e);
                return $this->output->jsonResponse([
                    "error" => "خطای سروری. لطفا به پشتیبانی اطلاع دهید"
                ], 500);
            }
        }

        try {
            if ($this->importHandler->importProducts($importData)) {
                return $this->output->jsonResponse([
                    "message" => "واردسازی محصولات انجام شد"
                ]);
            }
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                "error" => $e->getMessage()
            ], 500);
        }
    }

    /**
     * @param $ids
     * @return array
     */
    private function getThematicCategories($ids)
    {
        if ( ! is_array($ids)) {

            $ids = en_numbers($ids);
            if (str_contains($ids, '/')) {

                $ids = explode('/', $ids);
            } else {

                $ids = explode('-', $ids);
            }
        }

        foreach ($ids as $id) {
            try {
                if (Thematic_category::query()->findOrFail(en_numbers($id))) {
                    continue;
                }
            } catch (Throwable $e) {
                throw new InvalidArgumentException("شناسه دسته بندی موضوعی '{$id}' نامعتبر است");
            }
        }
        return $ids;
    }

}