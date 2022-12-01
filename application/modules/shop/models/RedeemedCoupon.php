<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Redeemed Discounts for users
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class RedeemedCoupon extends EloquentModel {

    /**
     *
     * @var string 
     */
    protected $table = "product_coupons_redeemed";
    protected $guarded = ['' ];

    /**
     * 
     * @return type
     */
    public function user () {
        return $this->belongsTo(CI::$APP->sentinel->getModel());
    }

    public function cart () {
        return $this->hasOne('Cart' , 'product_coupons_id' , 'id');
    }

    /**
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function product () {
        return $this->belongsTo('Product' , 'product_id' , 'id');
    }

}
