<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
require_once APPPATH."modules/users/models/User.php";
require_once APPPATH."modules/shop/models/Order.php";
require_once APPPATH."modules/payment/models/Transaction.php";

/**
 * Model: Cart
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Cart extends EloquentModel
{

    /**
     *
     * @var string
     */
    protected $table = "product_carts";
    protected $guarded = [''];

    protected $casts = [
        "delivery_address" => "array"
    ];

    /**
     *
     * @return BelongsTo
     */
    public function user()
    {
        return $this->belongsTo('User', 'user_id', 'id');
    }

    /**
     *
     * @return BelongsTo
     */
    public function shop()
    {
        return $this->belongsTo('User', 'shop_id');
    }

    /**
     *
     * @return BelongsToMany
     */
    public function varients()
    {
        return $this->belongsToMany(
            'Diversity_data',
            'product_cart_has_product',
            'cart_id',
            'diversity_data_id'
        )
            ->withPivot(array(
                'qty',
                'shop_id',
                'unit_price',
                'is_package',
                'files',
                'printing_desc'
            ))
            ->with("fields.value.parentDiversity", "product");
    }

    /**
     *
     * @return BelongsTo
     */
    public function coupon()
    {
        return $this->belongsTo('Coupon', 'product_coupons_id', 'id');
    }

    /**
     * @return BelongsTo
     */
    public function delivery()
    {
        return $this->belongsTo('User_address', 'delivery_address_id', 'id');
    }

    public function transaction()
    {
        return $this->hasOne('Transaction', 'order_id');
    }

    public function scopeActiveCart($query, $userId)
    {
        return $query->where(['user_id' => $userId, 'status' => 0]);
    }

    public function redeemed()
    {
        return $this->belongsToMany(
            "Coupon",
            'product_coupons_redeemed',
            'cart_id',
            'product_coupon_id'
        )->withPivot(['status', 'user_id']);
    }

    /**
     * دریافت لیست آگهی های کاربر لاگین شده
     * @param  $user_id
     * @return \Illuminate\Database\Eloquent\Builder[]|\Illuminate\Database\Eloquent\Collection
     */
    public static function getCurrentUserCart($user_id)
    {
        return self::query()->where('user_id', $user_id)->orderBy('id', 'DESC')->get();
    }


}
