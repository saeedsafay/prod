<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

require_once FCPATH . 'application/modules/users/models/User.php';

/**
 * Model: Subscribe of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Subscribe extends EloquentModel {

    /**
     *
     * @var string 
     */
    protected $table = "subscribe_dates";
    protected $guarded = ['' ];

    /**
     * 
     * @return type
     */
    public function product () {
        return $this->belongsTo('Product' , 'product_id' , 'id');
    }

    /**
     * 
     * @return type
     */
    public function cart () {
        return $this->belongsTo('Cart' , 'cart_id' , 'id');
    }

    /**
     * 
     * @return type
     */
    public function user () {
        return $this->belongsTo('User','user_id','id');
    }

}
