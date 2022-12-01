<?php

use Illuminate\Database\Eloquent\ModelNotFoundException;

(defined('BASEPATH')) or exit('No direct script access allowed');
require_once APPPATH."modules/shop/models/Product.php";

class ProductConcerns
{

    private $ci;

    public function __construct($CI)
    {
        $this->ci = $CI;
    }

    public function getLastMostOrderedProducts($days, $categoryId = null)
    {
        try {
            return Diversity_data::query()
                ->with([
                    "product",
                    "product.child_category",
                    "product.varients" => function ($q) {
                        $q->where('status', 1)->orderBy('price', 'asc')->where('stock', '>', 0);
                    }
                ])
                ->whereHas("orders",
                    function ($q) use ($days) {
                        $q->where("status", 1)->whereDate("pay_at", ">",
                            date("Y-m-d H:i:s", strtotime("-{$days} days")));
                    })
                ->whereHas(
                    "product.category", function ($q) use ($categoryId) {
                    if ($categoryId) {
                        $q->whereKey($categoryId);
                    }
                })->orderBy("product_id", "desc")->groupBy("product_id")->get();

        } catch (Throwable $e) {
            log_exception($e);
            show_error($e->getMessage());
        }
    }

    /**
     * @param $slug
     * @return mixed
     * @throws \Exception
     */
    public function getProductBySlug($slug)
    {
        return $this->getProduct($slug, 'slug');
    }


    /**
     * @param $id
     * @return mixed
     * @throws \Exception
     */
    public function getProductById($id)
    {
        return $this->getProduct($id);
    }


    /**
     * @param $value
     * @param  string  $column
     * @return mixed
     * @throws \Exception
     */
    public function getProduct($value, $column = 'id')
    {
        try {
            return Product::query()->where($column, $value)
                ->active()
                ->with([
                    'varients' => function ($q) {
                        $q->with("fields.value.parentDiversity")
                            ->where('status', 1)
                            ->where("stock", ">=", 1)
                            ->orderBy("price", "asc");
                    },
                    'filters.parentFilter',
                    'images',
                    'category',
                    'child_category.diversities' => function ($query) {
                        $query->where("deleted", 0)->with("values");
                    },
                    'comments' => function ($q) {
                        $q->where('status', 1);
                    }
                ])->first();
        } catch (Throwable $e) {
            log_exception($e);
            throw new Exception($e->getMessage(), $e->getCode());
        }
    }


    /**
     * payload json data for the order form of business cards
     * @param $category
     * @param  int  $hasOrderForm
     * @return array
     * @throws \Exception
     */
    public function categoryVariantsPayLoad($category, $hasOrderForm = 1)
    {
        try {
            $sizesCollection = $category->diversities()->with('values')
                ->where(['diversity_type' => 1, 'deleted' => 0])->firstOrFail();
        } catch (Throwable $e) {
            log_message('error', "Error querying sizes for categoryId[{$category->id}]: ".$e->getMessage());
            throw new InvalidArgumentException('Error querying sizes collections for the domain', 404);
        }
        try {
            $servicesCollection = $category->diversities()->with([
                'values' => function ($query) {
                    return $query->orderBy('id', 'asc');
                }
            ])->where(['diversity_type' => 2, 'deleted' => 0])->orderBy('priority', 'desc')->get();
        } catch (Throwable $e) {
            log_message("error", "Error querying services for categoryId[{$category->id}] :".$e->getMessage());
            throw new InvalidArgumentException('Error querying services collections for the domain', 404);
        }

        $sizes = ['name' => $sizesCollection->name];
        $services = [];
        foreach ($sizesCollection->values as $item) {
            $sizes['values'][] = array(
                'diversity_value_id' => $item->id,
                'diversity_id' => $item->product_diversity_id,
                'title' => $item->title,
                'image' => $item->image,
            );
        }

        foreach ($servicesCollection as $item) {
            foreach ($item->values as $value) {
                $services[$item->name]['label'] = $item->label;
                $services[$item->name]['values'][] = array(
                    'diversity_value_id' => $value->id,
                    'diversity_id' => $value->product_diversity_id,
                    'title' => $value->title,
                    'image' => $value->image,
                );
            }
        }
        if ($category->variants_as_package) {
            try {
                $qtyCollection = $category->diversities()->with('values')
                    ->where(['diversity_type' => 3, 'deleted' => 0])->firstOrFail();
            } catch (Throwable $e) {
                log_message("error", "Error querying qty for categoryId[{$category->id}] :".$e->getMessage());
                throw new InvalidArgumentException('Error querying qty collections for the domain', 404);
            }
            $qty = ['name' => $qtyCollection->name];
            foreach ($qtyCollection->values as $item) {

                $qty['values'][] = array(
                    'diversity_value_id' => $item->id,
                    'diversity_id' => $item->product_diversity_id,
                    'title' => $item->title,
                    'image' => $item->image,
                );
            }
        } else {
            $qty = null;
        }


        try {
            $product = Product::query()->where(['user_id' => 189, 'status' => 1, 'soft_delete' => 0])
                ->with([
                    'varients' => function ($query) {
                        return $query->where('status', 1);
                    },
                    'varients.fields.value.parentDiversity'
                ])
                ->whereHas('child_category', function ($query) use ($category, $hasOrderForm) {
                    $query->whereKey($category->id)
                        ->where('has_order_form', $hasOrderForm);
                })->whereHas('hidden')->firstOrFail();

        } catch (ModelNotFoundException $e) {
            log_message('error',
                "Product issue with JSON payload data not initialized for categoryId[{$category->id}]."
                .$e->getMessage());
            throw new InvalidArgumentException('Product issue error JSON payload form data', 404);
        }

        $lead_times_arrays = [];
        foreach ($product->varients as $variant) {
            $lead_times_arrays[] = $variant->lead_time;
        }

        $jsonData = array(
            'formInitData' => array(
                'available_lead_times' => array_unique($lead_times_arrays),
                'sizes' => $sizes,
                'qty' => $qty,
                'services' => $services,
            ),
            'variants' => $this->getProductVariants($product)
        );
        return $jsonData;
    }


    /**
     * creat an array of variants info
     * @param $product
     * @return array
     */
    public function getProductVariants($product)
    {
        if ($variantData = cache('product_variant_data_'.$product->id)) {
            return $variantData;
        } else {
            $variantData = [];
        }
        try {
            foreach ($product->varients as $variant) {
                $variantData[$variant->id] = [
                    'price' => $variant->price,
                    'lead_time' => $variant->lead_time,
                    'product_image_id' => $variant->product_image_id
                ];
                $fieldsAndValues = [];
                foreach ($variant->fields as $field) {
                    $mainDiversity = [
                        'id' => $field->value->parentDiversity->id,
                        'label' => $field->value->parentDiversity->label,
                        'name' => $field->value->parentDiversity->name,
                        'value' => array(
                            'id' => $field->value->id,
                            'title' => $field->value->title,
                        ),
                    ];
                    $fieldsAndValues[$mainDiversity['id']] = $mainDiversity;
                }
                $variantData[$variant->id]['fields'] = $fieldsAndValues;
            }
            cache_set('product_variant_data_'.$product->id, $variantData);
            return $variantData;
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
    }

    public function relatedProductsQuery($productId)
    {
        return (new Product())
            ->active()
            ->whereKeyNot($productId)
            ->with([
                "varients" => function ($q) {
                    $q->with("fields.value.parentDiversity")
                        ->where('status', 1)
                        ->where("stock", ">=", 1)
                        ->orderBy("price", "asc");
                }
            ]);
    }

    /**
     * @param $category
     * @return mixed
     * @throws \Exception
     */
    public function getRelatedByCategory($category)
    {
        try {
            return $category->child_cat_products()
                ->active()
                ->with([
                    "varients" => function ($q) {
                        $q->with("fields.value.parentDiversity")
                            ->where('status', 1)
                            ->where("stock", ">=", 1)
                            ->orderBy("price", "asc");
                    }
                ])
                ->take(10)
                ->get();
        } catch (Throwable $e) {
            log_exception($e);
            throw new Exception($e->getMessage(), $e->getCode());
        }
    }

    /**
     * @param $productTypeId
     * @param  null  $categoryId
     * @return \Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection
     * @throws \Exception
     */
    public function getLatestByProductType($productTypeId, $categoryId = null)
    {
        try {
            return Product::query()
                ->active()
                ->where('product_type_id', $productTypeId)
                ->whereHas(
                    "category", function ($q) use ($categoryId) {
                    if ($categoryId) {
                        $q->whereKey($categoryId);
                    }
                })
                ->with([
                    "varients" => function ($q) {
                        $q->with("fields.value.parentDiversity")
                            ->where('status', 1)
                            ->where("stock", ">=", 1)
                            ->orderBy("price", "asc");
                    }
                ])
                ->orderBy("created_at", "desc")
                ->take(10)
                ->get();
        } catch (Throwable $e) {
            log_exception($e);
            throw new Exception($e->getMessage(), $e->getCode());
        }
    }

    /**
     * @param $cart
     * @return bool
     * @throws \Exception
     */
    public function updateVariantQuantity($cart)
    {
        try {
            foreach ($cart->varients as $variantData) {
                $variantData->stock = $variantData->stock - $variantData->pivot->qty;
                $variantData->save();
            }
            return true;
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
    }

    public function generateCoupon(array $data = [])
    {
        if ( ! key_exists("discount", $data)) {
            throw new InvalidArgumentException("Discount value is missing");
        }
        try {
            $data = array_replace([
                'user_id' => $this->ci->user->id ? $this->ci->user->id : null,
                'status' => 0,
                'code' => substr(md5(time()), 5, 6),
            ], $data);
            return Coupon::query()->create($data);
        } catch (Throwable $e) {
            log_exception($e);
            return false;
        }
    }

}