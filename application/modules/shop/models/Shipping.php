<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Shipping for products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Shipping extends EloquentModel {

    /**
     *
     * @var string 
     */
    protected $table = "product_shippings";
    protected $guarded = [ '' ];
    public $timestamps = false;

    /**
     * 
     * @return type
     */
    public function carts () {
        return $this->hasMany('Cart' , 'product_shipping_id' , 'id');
    }

}
