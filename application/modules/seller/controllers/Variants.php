<?php

use Illuminate\Database\Eloquent\ModelNotFoundException;

/**
 * Class Variants
 */
class Variants extends Seller_Controller
{

    public $validation_rules = array(
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
        'edit_variant' => array(
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

    public function index()
    {

        $page = $this->input->get("page") ? $this->input->get("page") : 1;
        $userId = $this->user->id;

        $variants = Diversity_data::query()->with(['fields', 'product'])->whereHas('product',
            function ($query) use ($userId) {
                $query->where('user_id', $userId);
            })->orderBy("id", "desc")
            ->paginate(config("per_page"), '*', 'page', $page)->setPath('');

        $this->smart->assign(
            [
                'title' => 'تنوع محصولات',
                'items' => $variants,
                "pagination" => $variants->toArray(),
            ]
        );
        $this->smart->view('variants_list');
    }

    /**
     * Load Diversity information for the given category id
     */
    public function getDiversitiesByCategory()
    {
        try {
            $categoryId = $this->input->get('product_category_id');
            $diversities = Diversity::query()->whereHas("child_category", function ($q) use ($categoryId) {
                $q->whereKey($categoryId);
            })->with("values")
                ->where('deleted', 0)
                ->orderBy('priority', 'desc')
                ->get();
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => $e->getMessage()
            ], $e->getCode());
        }

        if ($diversities->isEmpty()) {
            log_message("error", "Diversity not found for the category #".$this->input->get('product_category_id'));
            return $this->output->jsonResponse([
                "error" => "مولفه های تنوع برای دسته بندی مورد نظر یافت نشد لطفا به پشتیبانی اطلاع دهید."
            ], 422);
        }
        return $this->output->jsonResponse([
            'diversities' => $diversities
        ]);
    }

    public function getDiversityById()
    {
        try {
            $diversity_data_row = Diversity_data::whereKey($this->input->get('diversity_data_id'))
                ->with('fields')
                ->with([
                    'product' => function ($q) {
                        return $q->select('id', 'product_child_category_id', 'user_id')
                            ->with([
                                'child_category.diversities' => function ($q) {
                                    return $q->with('values')->where(['deleted' => 0])->orderByDesc('priority');
                                }
                            ]);
                    }
                ])
                ->firstOrFail();
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'errors' => "بروز خطا، مجدد تلاش کنید"
            ], 500);
        }

        if ($diversity_data_row->product->user_id != $this->user->id) {
            return $this->output->jsonResponse([
                'errors' => 'درخواست نامعتبر'
            ], 422);
        }

        return $this->output->jsonResponse([
            'results' => $diversity_data_row,
            'allDiversities' => $diversity_data_row->product->child_category->diversities
        ]);
    }


    /**
     * Add a new variant for the specified product id
     * @param $productId
     * @return
     */
    public function add_variant($productId)
    {
        if ( ! $this->formValidate()) {
            return $this->output->jsonResponse([
                'success' => 0,
                'errors' => validation_errors()
            ], 422);
        }

        try {
            $product = Product::with("varients.fields", "child_category.diversities")->find($productId);
        } catch (ModelNotFoundException $e) {
            log_message("error", 'Product not found for adding variants.');
            return $this->output->jsonResponse([
                'success' => 0,
                'errors' => 'درخواست نامعتبر. محصول یافت نشد.'
            ], $e->getCode());
        }
        if ( ! $product || $product->user_id != $this->user->id || $product->soft_delete) {
            log_message("error", 'SECURITY PROBLEM WITH ADD VARIANT.');
            return $this->output->jsonResponse([
                'success' => 0,
                'errors' => 'درخواست نامعتبر'
            ], 422);
        }
        $diversityInputs = $this->input->post('diversity[particular]');

        // validation
        if ( ! $diversityInputs) {
            return $this->output->jsonResponse([
                'success' => 0,
                'errors' => 'خطای ارسال فیلد. پر کردن فیلدهای تنوع اجباری است.'
            ], 422);
        }
        // validation of all field are required
        foreach ($product->child_category->diversities as $value) {
            if ( ! key_exists($value->name, $diversityInputs) && ! $value->deleted) {
                return $this->output->jsonResponse([
                    'success' => 0,
                    'errors' => "پر کردن فیلد {$value->label} اجباری است"
                ], 422);
            }
        }

        // checking duplicate entry
        if ($this->checkDuplicates($product->varients, $diversityInputs)) {
            return $this->output->jsonResponse([
                'success' => 0,
                'errors' => '<p class="error">این تنوع قبلا درج شده است</p>'
            ], 422);
        }

        $variantAttr = [
            'price' => $this->input->post('diversity[price]'),
            'stock' => $this->input->post('diversity[stock]'),
            'max_order' => $this->input->post('diversity[max_order]'),
            'lead_time' => $this->input->post('diversity[lead_time]'),
            'status' => $this->input->post('diversity[status]'),
            'product_id' => $product->id
        ];

        try {
            $variantData = Diversity_data::create($variantAttr);
        } catch (Throwable $e) {
            log_message('error', 'error creating variant: '.$e->getMessage());
            return $this->output->jsonResponse([
                'success' => 0,
                'errors' => $e->getMessage()
            ], $e->getCode());
        }

        foreach ($diversityInputs as $key => $diversity_value_id):
            $fields = [
                'product_id' => $product->id,
                'diversity_value_id' => $diversity_value_id,
                'product_diversity_data_id' => $variantData->id,
            ];
            try {
                Diversity_data_field::create($fields);
            } catch (Throwable $e) {
                log_message('error', 'error creating variant: '.$e->getMessage());
                return $this->output->jsonResponse([
                    'success' => 0,
                    'errors' => 'خطای ثبت. مجدد تلاش کنید.'
                ], $e->getCode());
            }
        endforeach;
        return $this->output->jsonResponse([
            'success' => 1,
            'edit' => false,
            'variant_data' => $variantData,
            'product' => $product,
            'variant_fields' => $variantData->fields()->with('value')->get()
        ]);
    }

    public function edit_variant($productVariantId)
    {

        if ( ! $this->formValidate()) {
            return $this->output->jsonResponse([
                'success' => 0,
                'errors' => validation_errors()
            ], 422);
        }

        $variant = Diversity_data::with('product.child_category.diversities', 'fields.value')
            ->with('product.varients')
            ->find($productVariantId);
        if ( ! $variant || $variant->product->user_id != $this->user->id) {
            return $this->output->jsonResponse([
                'success' => 0,
                'errors' => 'درخواست نامعتبر.'
            ], 422);
        }

        $diversityInputs = $this->input->post('diversity[particular]');

        //        // validation
        //        if ( ! $diversityInputs) {
        //            return $this->output->jsonResponse([
        //                'success' => 0,
        //                'errors' => 'خطای ارسال فیلد. پر کردن فیلدهای تنوع اجباری است.'
        //            ], 422);
        //        }
        // validation of all field are required
        if ($diversityInputs) {
            foreach ($variant->product->child_category->diversities as $value) {
                if (in_array($value->name, $diversityInputs)) {
                    if ( ! key_exists($value->name, $diversityInputs) && ! $value->deleted) {
                        return $this->output->jsonResponse([
                            'success' => 0,
                            'errors' => "پر کردن فیلد {$value->label} اجباری است"
                        ], 422);
                    }
                }
            }
        }

        // checking duplicate entry
        if ($diversityInputs && $this->checkDuplicates($variant->product->varients, $diversityInputs)) {
            return $this->output->jsonResponse([
                'success' => 0,
                'errors' => '<p class="error">این تنوع قبلا درج شده است</p>'
            ], 422);
        }

        $variantData = [
            'price' => $this->input->post('diversity[price]'),
            'stock' => $this->input->post('diversity[stock]'),
            'max_order' => $this->input->post('diversity[max_order]'),
            'lead_time' => $this->input->post('diversity[lead_time]'),
            'status' => $this->input->post('diversity[status]'),
            'product_id' => $variant->product_id
        ];

        try {
            $variant->forceFill($variantData)->saveOrFail();

            if ($diversityInputs) {
                foreach ($diversityInputs as $key => $diversity_value_id):
                    $fields = [
                        'product_id' => $variant->product->id,
                        'diversity_value_id' => $diversity_value_id,
                        'product_diversity_data_id' => $variant->id,
                    ];
                    try {
                        $variant->fields()->create($fields);
                    } catch (Throwable $e) {
                        log_exception($e);
                        return $this->output->jsonResponse([
                            'success' => 0,
                            'errors' => 'خطای ثبت. مجدد تلاش کنید.'
                        ], $e->getCode());
                    }
                endforeach;
            }
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'success' => 0,
                'errors' => 'اشکال در عملیات. مجدد تلاش نمایید.'
            ], 500);
        }

        return $this->output->jsonResponse([
            'edit' => true,
            'variant_data' => $variant,
            'new_fields' => $variant->fields()->with('value')->get()->toArray()
        ]);
    }

    private function checkDuplicates($variant, $diversityInputs)
    {
        // checking duplicate entry
        foreach ($variant as $val):
            $prvIds = [];
            // create an array of value_ids from the previous variant fields to compare with the input array
            foreach ($val->fields as $field) {
                $prvIds[] = $field->diversity_value_id;
            }
            // check the difference
            if (count(array_diff($prvIds, $diversityInputs)) == 0
                && ($this->input->post('diversity[price]') == $val->price
                    || $this->input->post('diversity[lead_time]') == $val->lead_time)) {
                return true;
            }
        endforeach;

        return false;
    }


    /**
     * assign the variant's id to the given product photo
     * @return bool
     */
    public function sync_images()
    {
        try {
            $productImageId = $this->input->post('image_id');
            $variantIds = $this->input->post('variants');
            $productImage = Product_image::query()->with('product', 'variants')->find($productImageId);

            if ( ! $productImage || $productImage->product->user_id != $this->user->id) {
                return $this->output->jsonResponse([
                    'error' => 'تصویر نامعتبر است'
                ], 422);
            }
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطای سرور'
            ], 500);
        }
        try {
            $this->resetImageVariants($productImage);

            foreach ($variantIds as $key => $variantId) {
                if ($variant = Diversity_data::query()
                    ->whereKey($variantId)
                    ->where('product_id', $productImage->product_id)
                    ->first()) {
                    $productImage->variants()->save($variant);
                }
            }
            return $this->output->jsonResponse([
                'message' => 'تصویر با تنوع های درخواستی مرتبط شد'
            ]);
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطای سرور'
            ], 500);
        }

    }

    /**
     * remove all relations in to be reset
     * @param $productImage
     * @return bool
     * @throws \Throwable
     */
    private function resetImageVariants($productImage)
    {
        try {
            foreach ($productImage->variants as $variant) {
                $variant->forceFill(['product_image_id' => null])->save();
            }
            return true;
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
    }
}