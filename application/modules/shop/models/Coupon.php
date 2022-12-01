<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Discount for users
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Coupon extends EloquentModel
{

    const FIRST_ORDER_VALIDITY_TYPE = 1;
    const TIME_VALIDITY_TYPE = 2;
    /**
     *
     * @var string
     */
    protected $table = "product_coupons";
    protected $guarded = [''];

    /**
     *
     * @return type
     */
    public function user()
    {
        return $this->belongsTo(CI::$APP->sentinel->getModel());
    }

    public function cart()
    {
        return $this->hasOne('Cart', 'product_coupons_id', 'id');
    }

    public function redeemed()
    {
        return $this->belongsToMany(
            "Cart",
            'product_coupons_redeemed',
            'product_coupon_id',
            'cart_id'
        )->withPivot(['status', 'user_id']);
    }

    /**
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function product()
    {
        return $this->belongsTo('Product', 'product_id', 'id');
    }

}
