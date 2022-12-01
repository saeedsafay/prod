<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

require_once MODULE_PATH.'users/models/User.php';
require_once MODULE_PATH.'content/models/Comment.php';
require_once MODULE_PATH."shop/models/Product_type.php";
require_once MODULE_PATH."shop/models/Product_image.php";
require_once MODULE_PATH."shop/models/Product_hidden.php";
require_once MODULE_PATH."shop/models/Diversity_data.php";
require_once MODULE_PATH."shop/models/Category.php";
require_once MODULE_PATH."shop/models/Filter.php";
require_once MODULE_PATH."shop/models/Cart.php";
require_once MODULE_PATH."shop/models/Thematic_category.php";
require_once MODULE_PATH."shop/models/Wonder.php";
require_once MODULE_PATH."shop/models/Coupon.php";

/**
 * Model: Product for users
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Product extends EloquentModel
{

    /**
     *
     * @var string
     */
    protected $table = "products";
    protected $guarded = [''];

    public function product_type()
    {
        return $this->belongsTo('Product_type', 'product_type_id', 'id');
    }

    public function category()
    {
        return $this->belongsTo('Category', 'product_category_id', 'id');
    }

    public function child_category()
    {
        return $this->belongsTo('Category', 'product_child_category_id', 'id');
    }

    /**
     * Get all of the products that are assigned this value.
     */
    public function filters()
    {
        return $this->morphToMany('Filter_value', 'filter_valuable');
    }

    public function images()
    {
        return $this->hasMany('Product_image', 'product_id', 'id');
    }

    public function hidden()
    {
        return $this->hasOne('Product_hidden', 'product_id', 'id');
    }

    public function varients()
    {
        return $this->hasMany('Diversity_data', 'product_id', 'id');
    }

    public function diversities()
    {
        return $this->belongsToMany('Diversity_value', 'diversity_value_has_products', 'product_id',
            'diversity_value_id')
            ->withPivot(array('product_diversity_data_id'));
    }

    public function group_discount()
    {
        return $this->belongsToMany('Group_discount', 'product_has_group_discounts', 'product_id', 'group_discount_id');
    }

    public function keywords()
    {
        return $this->belongsToMany('Keyword', 'product_keyword_has_product', 'product_id', 'product_keyword_id');
    }

    public function thematicCategories()
    {
        return $this->belongsToMany(
            'Thematic_category',
            'products_has_thematic_categories',
            'product_id',
            'thematic_category_id'
        );
    }

    /**
     * Get the post's image.
     */
    public function comments()
    {
        return $this->morphMany('Comment', 'commentable');
    }

    /**
     *
     * @return BelongsToMany
     */
    public function cart()
    {
        return $this->belongsToMany('Cart', 'product_cart_has_product', 'product_id', 'cart_id');
    }

    /**
     *
     * @return BelongsTo
     */
    public function user()
    {
        return $this->belongsTo('User');
    }

    public function scopeActive($query, $enabled = 1)
    {
        return $query->where(['status' => $enabled, 'soft_delete' => 0])->whereDoesntHave('hidden');
    }

    public function getLinkAttribute()
    {
        try {
            if ($this->hidden()->first()) {
                return "/product-type/{$this->product_type->slug}/category/{$this->category->slug}/{$this->child_category->slug}";
            }
            return "/product/NPI-{$this->id}/".$this->slug;
        } catch (Throwable $e) {
            log_exception($e);
            return '/';
        }
    }

    public function getPicAttribute()
    {
        return $this->attributes['pic'];
    }

    /**
     * مدیریت وضعیت آگهی ها
     * @param  object  $obj
     * @return false|instance model
     */
    public static function toggleStatus($obj)
    {
        //تایید اولیه
        if ($obj->status == 0) {
            $data = array(
                'status' => 1,
                'start_publish_date' => date('Y-m-d H:i:s'),
                'start_period_date' => date('Y-m-d H:i:s')
            );
        }
        //رد کردن آگهی تایید شده
        if ($obj->status == 1) {
            return $obj->update(['status' => 2]);
        } elseif ($obj->status == 2 or $obj->status == 3) {
            return $obj->update(['status' => 1]);
        } elseif ($obj->status == 0) {
            return $obj->update($data);
        }
    }

    public function buildSearchQuery($query = null)
    {
        if ($query == null) {
            $query = self::query();
        }
        return $query->select("id", "title", "title_en", "slug",
            "product_type_id",
            "product_child_category_id", "product_category_id", "pic")
            ->where(['status' => 1, 'soft_delete' => 0])
            ->with([
                'product_type' => function ($q) {
                    $q->select("id", "title", "slug");
                },
                'category' => function ($q) {
                    $q->select("id", "title", "slug");
                },
                'child_category' => function ($q) {
                    $q->select("id", "title", "slug");
                }
            ])
            ->latest();
    }

    /**
     * @param $query
     * @param $search
     * @param  null  $cat_id
     * @return mixed
     */
    //    public function scopeSearch($query, $search, $cat_id = null)
    //    {
    //        if ($cat_id) {
    //            $query = $query->where('product_child_category_id', $cat_id);
    //        }
    //
    //        $query = $this->buildSearchQuery($query);
    //
    //        $search = explode(" ", $search);
    //
    //        return $query
    //            ->where(['soft_delete' => 0, 'status' => 1])
    //            ->where(function ($query) use ($search) {
    //                foreach ($search as $string) {
    //                    $query->where('title', 'like', '%'.$string.'%');
    //                }
    //            })->orWhere(function ($query) use ($search) {
    //                foreach ($search as $string) {
    //                    $query->where('desc', 'like', '%'.$string.'%');
    //                }
    //            })->orderByDesc("visit_counts")
    //            ->take(15);
    //    }

    /**
     * Get the product list by the given conditions
     * @param  int  $product_type_id
     * @param  array  $orderBy
     * @param  array  $params
     * @param  int  $page
     * @return array
     */
    public static function getGeneralProducts($product_type_id, $orderBy, $params, $page = 1)
    {
        // product type
        $query = self::active();

        if ($params["child_category"] != null) {
            $query = $query->where([
                'product_category_id' => $params['child_category']->parent_id,
                'product_child_category_id' => $params['child_category']->id
            ]);
        }
        if ($product_type_id != 0) {
            $query = $query->where('product_type_id', $product_type_id);
        } // Product type Filtering
        if ($params["thematic_category_id"] != null) {
            $query->whereHas('thematicCategories', function ($query) use ($params) {
                $query->where('thematic_category_id', $params["thematic_category_id"]);
            });
        }
        if (isset($params['is_discounnt']) and $params['is_discounnt'] == 1) {
            $query->where('is_discounnt', 1);
        }

        if ($params['stock_type']) {
            $query->where('stock_type', $params['stock_type']);
        }

        if ($params['free_shipping'] != null and $params['free_shipping'] != 100) {
            $query->where('free_shipping', ( int )$params['free_shipping']);
        }
        // Price Range:
        if ( ! empty($params['price'])) {
            if ($params['price']['min'] > 1000) {
                $query->where('price', '<=', $params['price']['max'])->where('price', '>', $params['price']['min']);
            }
        }
        //        if( $params['province_id'] ) {
        //            $query->whereHas('user.location' , function($query) use ($params) {
        //                $query->where('province_id' , $params['province_id']);
        //            });
        //        }
        //        if( $params['county_id'] ) {
        //            $query->whereHas('user.location' , function($query) use ($params) {
        //                $query->where('county_id' , $params['county_id']);
        //            });
        //        }
        //        if( $params['region_id'] ) {
        //            $query->whereHas('user.location' , function($query) use ($params) {
        //                $query->where('region_id' , $params['region_id']);
        //            });
        //        }
        //        if( $params['neighbourhood_id'] ) {
        //            $query->whereHas('user.location' , function($query) use ($params) {
        //                $query->where('neighbourhood_id' , $params['neighbourhood_id']);
        //            });
        //        }
        // Dynamic filtering
        if ( ! empty($params['dynamic_filter'])) {
            foreach ($params['dynamic_filter'] as $filter):
                if ( ! $filter) {
                    continue;
                }
                $query->whereHas('filters', function ($query) use ($filter) {
                    $query->where('filter_value_id', $filter); // filter_value_id should live on inputs' name
                });
            endforeach;
        }

        return $query->with([
                'varients' => function ($query) {
                    $query->where('status', 1)->where('stock', '>', 0)->orderBy('price', 'asc');
                }
            ]
        )
            ->orderBy($orderBy[0], $orderBy[1])
            ->paginate($params['per_page'], '*', 'page', $page)->setPath(set_path());
    }

    /**
     * دریافت لیست آگهی های فعال و پربازدید به ترتیب بیشترین بازدید
     * @param  int  $limit
     * @param  int  $offset
     * @return array
     */
    public static function getPopularProducts($limit = 10, $offset = 0)
    {
        return []; //self:: getProducts($limit , $offset , 'visit_counts');
    }

    /**
     * ط¯ط±غŒط§ظپطھ ط¢ع¯ظ‡غŒ ظ‡ط§ ط¨ط¯ظˆظ† ط¯ط± ظ†ط¸ط± ع¯ط±ظپطھظ† طھط§ط±غŒط® ط§ظ†ظ‚ط¶ط§
     * @param  int|varchar  $type
     * @param  int  $limit
     * @param  int  $offset
     * @param  varchar  $orderBy
     * @return array Collection
     */
    public static function getProducts($limit = 10, $offset = 0, $orderBy = 'start_publish_date')
    {
        $query = self::where('status', '=', 1)->where('soft_delete', 0)->where('type', 4);
        if ($limit > 0) {
            $query = $query->take($limit)->skip($offset);
        }
        $query = $query->orderBy($orderBy, 'DESC');
        return $query->get();
    }

    /**
     *
     * @param  varchar  $col
     * @param  array  $range
     * @return type
     */
    public static function filter
    (
        $col,
        $range = array()
    ) {
        $query = self:: where('pay_status', 1)->where(function ($query) {
            /** @var $query Illuminate\Database\Query\Builder */
            return $query->orWhere('status', '=', 1)// active status
            ->orWhere('status', '=', 5); // sold status
        });
        return $query->whereBetween($col, [$range[0], $range[1]])
            ->orWhere(function ($query) use ($col) {
                $query->where($col, null)
                    ->where($col, 0)
                    ->where($col, '');
            })
            ->get();
    }

}
