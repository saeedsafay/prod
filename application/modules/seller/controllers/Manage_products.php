<?php

use Intervention\Image\ImageManagerStatic as Image;

(defined('BASEPATH')) or exit('No direct script access allowed');

require_once APPPATH.'/modules/seller/handlers/MockupsHandler.php';

/**
 * Shop Front Controller For managing products by users
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2017
 * @license     MIT License
 * @link saeedtavakoli.ir author's personal website.
 */
class Manage_products extends Seller_Controller
{

    public $validation_rules = array(
        'add_product' => array(
            ['field' => 'title', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'عنوان محصول'],
            ['field' => 'title_en', 'rules' => 'trim|htmlspecialchars', 'label' => 'عنوان لاتین محصول'],
            ['field' => 'internal_code', 'rules' => 'trim|htmlspecialchars', 'label' => 'کد طرح'],
            ['field' => 'product_type_id', 'rules' => 'trim|required|htmlspecialchars|numeric', 'label' => 'نوع محصول'],
            [
                'field' => 'product_category_id',
                'rules' => 'trim|required|htmlspecialchars|numeric',
                'label' => 'دسته‌بندی محصول'
            ],
            ['field' => 'desc', 'rules' => 'max_length[8000]', 'label' => 'توضیحات محصول'],
            ['field' => 'picHidden', 'rules' => 'required|htmlspecialchars|trim', 'label' => 'عکس اصلی'],
        ),
        'sales' => array(
            ['field' => 'product_id', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'انتخاب محصول'],
            ['field' => 'discount_price', 'rules' => 'required|numeric|htmlspecialchars|trim', 'label' => 'قیمت']
        ),
        'add_variant' => array(
            ['field' => 'diversity[price]', 'rules' => 'trim|required|htmlspecialchars|numeric', 'label' => 'قیمت'],
            ['field' => 'diversity[stock]', 'rules' => 'required|numeric|htmlspecialchars|trim', 'label' => 'موجودی'],
            [
                'field' => 'diversity[max_order]',
                'rules' => 'required|numeric|htmlspecialchars|trim',
                'label' => 'حداکثر تعداد قابل سفارش برای هر مشتری'
            ],
            [
                'field' => 'diversity[lead_time]',
                'rules' => 'required|numeric|htmlspecialchars|trim',
                'label' => 'بازه ارسال'
            ]
        ),
        'edit_varient' => array(
            ['field' => 'diversity[price]', 'rules' => 'trim|required|htmlspecialchars|numeric', 'label' => 'قیمت'],
            ['field' => 'diversity[stock]', 'rules' => 'required|numeric|htmlspecialchars|trim', 'label' => 'موجودی'],
            [
                'field' => 'diversity[max_order]',
                'rules' => 'required|numeric|htmlspecialchars|trim',
                'label' => 'حداکثر تعداد قابل سفارش برای هر مشتری'
            ],
            [
                'field' => 'diversity[lead_time]',
                'rules' => 'required|numeric|htmlspecialchars|trim',
                'label' => 'بازه ارسال'
            ]
        )
    );
    /**
     * @var \ProductsHandler
     */
    private $productsHandler;


    public function __construct()
    {
        parent::__construct();
        list($path, $_model) = Modules::find('ProductsHandler', 'seller', 'handlers/');
        Modules::load_file($_model, $path);
        $this->productsHandler = new ProductsHandler();
    }

    /**
     * for creating recursive drop down options
     * @param $categories
     * @return mixed
     */
    private function recursiveParents($categories)
    {
        foreach ($categories as $category) {
            $titleArr[$category->id][$category->id] = $category->title;
            if ($category->parent) {
                $parent = $category->parents;
                while ($parent) {
                    $titleArr[$category->id][$parent->id] = $parent->title;
                    $parent = $parent->parent;
                }
            }
            ksort($titleArr[$category->id]);
        }
        return $titleArr;
    }


    public function add_product($id = null)
    {
        try {
            if ($id) {
                $product = Product::with([
                    'product_type',
                    'category',
                    'child_category',
                    'thematicCategories',
                    'filters',
                    'hidden',
                    'varients.fields.value'
                ])
                    ->where(['soft_delete' => 0])
                    ->find($id);
                if ( ! $product || $product->user_id != $this->user->id) {
                    show_404();
                }
                $title = 'ویرایش '.$product->title;
                $this->smart->assign([
                    'Product' => $product,
                ]);
            } else {
                $title = 'درج محصول جدید';
                $product = new Product();
            }
        } catch (Throwable $e) {
            log_exception($e);
            show_flash_message($e->getMessage(), "fail", '/seller/manage-products/add-product/'.$id);

        }
        if ($this->formValidate()) {
            $product->forceFill([
                'title' => $this->input->post('title', true),
                'title_en' => $this->input->post('title_en', true),
                'internal_code' => $this->input->post('internal_code', true),
                'desc' => $this->input->post('desc', true),
                'price' => $this->input->post('price', true),
                'product_category_id' => $this->input->post('product_category_id', true),
                'product_child_category_id' => $this->input->post('product_child_category_id', true),
                'product_type_id' => $this->input->post('product_type_id', true),
                'status' => 0,
                'user_id' => $this->user->id,
                'type' => 4, // general products
                'slug' => slug($this->input->post('title')),
                'edited_time' => time(),
            ]);
            if ($id && $this->input->post('picHidden', true) != $product->pic) {
                $oldPic = $product->pic;
                unlink(PUBLICPATH.'upload/products/pic/'.$oldPic);
                unlink(PUBLICPATH.'upload/products/pic/thumbnails/'.$oldPic);
            }
            $product->pic = $this->input->post('picHidden', true);

            try {
                $product->save();
                $this->manageHiddenProducts($this->input->post('hidden_product'),
                    $product);// Doing filters' fields stuff
                $this->filterHandler($product);
                //                $product->user()->update(array('edited_product_time' => time()));
            } catch (Throwable $e) {
                log_exception($e);
                show_flash_message($e->getMessage(), "fail", '/seller/manage-products/add-product/'.$id);
            }
            if ($product->id) {
                $this->message->set_message(
                    'محصول شما با موفقیت ثبت شد و پس از تایید، انتشار می‌بابد.', 'success', 'ثبت محصول آماده',
                    'seller/manage-products/add-product/'.$product->id)->redirect();
            } else {
                $this->message->set_message(
                    'مشکلی در ثبت محصول به وجود آمده لطفا دوباره سعی کنید..', 'fail', 'ثبت محصول آماده',
                    'seller/manage-products/add-product/'.$product->id)->redirect();
            }
        } else {

            $thematicRecursive = $this->recursiveParents(Thematic_category::with("parents")->get());
            $this->smart->assign(array(
                'title' => $title,
                'validation_errors' => validation_errors(),
                'thematicCategories' => $thematicRecursive,
                'product_types' => Product_type::all(),
            ));
            $this->smart->view('add_product');
        }
    }

    public function thematicCategories($productId)
    {
        try {
            if ( ! $productId) {
                redirect('/seller/manage-products/list-products');
            }

            $catIds = $this->input->post('thematic_cat_id');
            if (count($catIds) < 1) {
                $this->message->set_message(
                    'دسته بندی موضوعی را انتخاب کنید', 'fail', 'ثبت دسته بندی موضوعی',
                    'seller/manage-products/add-product/'.$productId)->redirect();
            }
            $product = Product::query()->findOrFail($productId);
        } catch (Throwable $e) {
            log_exception($e);
            $this->message->set_message(
                'خطایی رخ داد لطفا مجدد تلاش کنید', 'fail', 'ثبت دسته بندی موضوعی',
                'seller/manage-products/add-product/'.$productId)->redirect();
        }

        try {
            $product->thematicCategories()->sync($catIds);
            $this->message->set_message(
                'دسته بندی موضوعی با موفقیت بر روی محصول ثبت شد', 'success', 'ثبت دسته بندی موضوعی',
                'seller/manage-products/add-product/'.$productId)->redirect();
        } catch (Throwable $e) {
            log_exception($e);
            $this->message->set_message(
                'خطایی رخ داد لطفا مجدد تلاش کنید', 'fail', 'ثبت دسته بندی موضوعی',
                'seller/manage-products/add-product/'.$productId)->redirect();
        }

    }


    private function manageHiddenProducts($isHidden, $product)
    {
        if ($isHidden) {
            if ($this->user->id == 189) {
                return Product_hidden::query()->updateOrCreate(['product_id' => $product->id],
                    ['product_id' => $product->id]);
            }
        } else {
            return $product->hidden ? $product->hidden->delete() : true;
        }

    }

    private function filterHandler($product)
    {
        if ($this->input->post('filters') !== null and ! empty($this->input->post('filters'))) {
            foreach ($this->input->post('filters') as $key => $value):
                $FilterObject = Filter::where('name', $key)->first();
                if ($FilterObject->field_type != 3) {
                    foreach ($value as $filter_value_id):
                        $filters_val[] = ( int )$filter_value_id;
                    endforeach;
                } elseif ($FilterObject->field_type == 3) {
                    foreach ($value as $filter_value_text):
                        $dataa['title'] = trim($filter_value_text);
                        $dataa['product_filter_id'] = $FilterObject->id;
                        $textValue = Filter_value::updateOrCreate(['title' => $dataa['title']],
                            ['title' => $dataa['title'], 'product_filter_id' => $FilterObject->id]);
                        $filters_val[] = ( int )$textValue->id;
                    endforeach;
                }
            endforeach;
            $product->filters()->sync($filters_val, true);
        }
        return true;
    }

    /**
     * Storing image entity for product
     * @param  type  $product_id
     */
    public function storeImages($product_id)
    {
        //عکس ها و فایل تکمیلی
        if ( ! empty($_FILES['product_image']['name'])) {
            $data = $this->input->imageFile('product_image', 'products/pic');
        }
        foreach ($data as $file):
            Product_image::create(['file_name' => $file->__get('name'), 'product_id' => $product_id]);
        endforeach;

        $this->message->set_message('تصاویر تکمیلی بارگذاری شدند.', 'success', 'ثبت تصاویر محصول',
            'seller/manage-products/add-product/'.$product_id)->redirect();
    }

    public function delete_image($id)
    {
        $Product_image = Product_image::find($id);
        $product_id = $Product_image->product_id;
        $file_name = $Product_image->file_name;
        if ($Product_image) {
            $Product_image->delete();
            unlink(PUBLICPATH.'upload/products/pic/'.$file_name);
        }
        $this->message->set_message('تصویر مربوطه حذف شد.', 'success', 'حذف تصویر محصول',
            'seller/manage-products/add-product/'.$product_id)->redirect();
    }

    public function list_products()
    {
        $addURL = site_url('seller/manage-products/add-product');

        $page = $this->input->get("page") ? $this->input->get("page", true) : 1;
        $params = [];
        $params['title'] = $this->input->get("title") ? $this->input->get("title", true) : null;
        $params['id'] = $this->input->get("npi") ? $this->input->get("npi", true) : null;
        $params['product_type'] = $this->input->get("product_type") ? $this->input->get("product_type", true) : null;
        $params['category'] = $this->input->get("category") ? $this->input->get("category", true) : null;

        try {
            $products = $this->productsHandler->getProducts($params, $page);
        } catch (Throwable $e) {
            log_exception($e);
            show_error($e->getMessage());
        }
        $this->smart->assign([
            'title' => 'لیست محصولات ',
            'addURL' => $addURL,
            'products' => $products,
            "pagination" => $products->toArray(),
            'filter_params' => $params,
            'has_filter' => count($this->input->get()) && ! (count($this->input->get()) == 1 && $this->input->get('page')),
        ]);
        $this->smart->view('list_products');
    }

    public function sales()
    {
        if ( ! $this->user->inRole('seller')) {
            show_404();
        }
        //        $prv_discount = Product::where('user_id' , $this->user->id)->whereNotNull('discount_price')->first();
        $discounts = Product::where('user_id', $this->user->id)->whereNotNull('discount_price')->get();
        if ($this->formValidate(false)) {
            $data = [
                'discount_price' => $this->input->post('discount_price'),
                'is_discount' => 1,
            ];

            //            if( $discounts ) {
            //                if( $discounts->count() > 4 && 0 )
            //                    $this->message->set_message('هر فروشنده مجاز به ثبت ۵ محصول به عنوان حراجی است.' , 'warning' , 'ثبت حراجی' , 'seller/manage-products/sales')->redirect();
            //            }
            //            if ( $prv_discount )
            //                $prv_discount->update(array( 'discount_price' => null , 'is_discount' => 0 ));

            $product = Product::find($this->input->post('product_id'));

            if ($product->price < $data['discount_price']) {
                $this->message->set_message('قیمت حراجی باید کمتر از قیمت اصلی محصول باشد!', 'success', 'ثبت حراجی',
                    'seller/manage-products/sales')->redirect();
            } else {
                $product->update($data);
            }
            $this->message->set_message('تغییرات محصول حراجی ثبت شد', 'success', 'ثبت حراجی',
                'seller/manage-products/sales')->redirect();
        } else {
            $products = Product::where(['type' => 4, 'user_id' => $this->user->id, 'soft_delete' => 0])->get();
            $sortedProductById = [];
            foreach ($products as $val):
                $sortedProductById[$val->id] = $val;
            endforeach;
            ksort($sortedProductById);
            $this->smart->assign([
                'title' => 'ثبت محصول حراجی',
                'products' => $sortedProductById,
                //                'prv_discount' => $prv_discount
                'discounts' => $discounts,
            ]);
            $this->smart->view('sales');
        }
    }

    public function delete_discount($id)
    {
        $prd = Product::find($id);
        if ( ! $prd or ! $id or $prd->user_id != $this->user->id) {
            show_404();
        } else {
            $prd->update(array('discount_price' => null, 'is_discount' => 0));
            $this->message->set_message('تغییرات محصول حراجی ثبت شد', 'success', 'ثبت حراجی',
                'seller/manage-products/sales')->redirect();
        }
    }

    public function favorites()
    {
        $this->load->eloquent('shop/Favorite');
        $favs = Favorite::getUserFavs($this->user->id);
        $this->smart->assign([
            'title' => 'لیست علاقمندی‌های من ',
            'favs' => $favs,
        ]);
        $this->smart->view('buyer/favorites');
    }

    public function my_purchases()
    {

        $this->load->eloquent('shop/Cart');
        //        dd(Cart::where('user_id',$this->user->id)->get());
        $my_purchases = Cart::where('user_id', $this->user->id)->where('status', 1)->orWhere('status',
            3)->orderBy('updated_at', 'desc')->with('products')->get();
        //         $this->config->item('per_page'),
        //                        $this->config->item('per_page') * ($page )
        //Pagination configs
        //        $config["base_url"] = base_url() . "/seller/ads/keywords/" . $keyword;
        //        $config["total_rows"] = $ads->count();
        //        $config["uri_segment"] = 5;
        $this->load->eloquent('Subscribe');
        $subscribes = Subscribe::where(['user_id' => $this->user->id])->get();
        $this->smart->assign(
            [
                'title' => 'لیست خریدهای من',
                'Items' => $my_purchases,
                'subscribes' => $subscribes,
            ]
        );
        $this->smart->view('buyer/my_purchases');
    }

    public function calendar_orders()
    {
        if ( ! $this->user->inRole('seller')) {
            redirect();
        }
        $this->load->eloquent('Subscribe');
        $where = [
            'shop_id' => $this->user->id,
        ];
        $subscribes = Subscribe::where($where)->orderBy('id', 'desc')->get();
        $this->smart->assign([
            'title' => 'تقویم سفارشات',
            'subscribes' => $subscribes,
        ]);
        $this->smart->view('calendar_orders');
    }

    public function orders()
    {
        $this->load->eloquent('shop/Order');

        $orders = Order::getOrders($this->user->id);
        $this->smart->assign(
            [
                'title' => 'سفارش‌های تایید شده',
                'Items' => $orders,
            ]
        );
        $this->smart->view('orders');
    }

    public function crop()
    {
        $data = json_decode($this->input->post('avatar_data'), 1);

        try {
            $destFile = time().".jpg";
            $savePath = PUBLICPATH.'upload/products/pic/'.$destFile;

            $image = Image::make($_FILES['avatar_file']['tmp_name'])->crop(
                (int)$data["width"],
                (int)$data["height"],
                (int)$data["x"],
                (int)$data["y"]
            );
            $image->save($savePath, 100, "jpg");

            if ($image->save($savePath, 100, "jpg")) {
                // creating thumbnail
                $mockupHandler = new MockupsHandler();
                $mockupHandler->createThumbnail($savePath, $destFile);
            } else {
                log_message("debug", "Product picture '{$savePath}' not saved after crop.");
            }

        } catch (Throwable $e) {
            return $this->output->jsonResponse([
                'message' => $e->getMessage(),
                'result' => null
            ], 500);
        }

        return $this->output->jsonResponse([
            'state' => 200,
            'message' => "تصویر با موفقیت افزوده شد",
            'result' => $destFile
        ]);
    }

    public function changeStateProduct()
    {
        $product = Product::find($this->input->post('product_id'));
        if ($product->update(array('stock_type' => $this->input->post('state')))) {
            die(json_encode(['result' => 1]));
        }
    }

    public function delete($product_id)
    {
        $Prd = Product::find($product_id);
        if ( ! $Prd) {
            show_404();
        }
        if ($Prd->update(['soft_delete' => 1])) {
            $Prd->filters()->detach();
            $this->message->set_message('محصول مربوطه حذف گردید', 'success', 'حذف محصول ',
                'seller/manage-products/general-products')->redirect();
        }
    }

    public function delete_fav($f_id)
    {
        $this->load->eloquent('Favorite');
        if ($Fav = Favorite::find($f_id)) {
            if ($Fav->delete()) {
                $this->message->set_message('علاقمندی مربوطه حذف گردید', 'success', 'حذف علاقمندی ',
                    'seller/manage-products/favorites')->redirect();
            }
        } else {
            show_404();
        }
    }

}
