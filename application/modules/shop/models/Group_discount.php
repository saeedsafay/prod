<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Group discount of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Group_discount extends EloquentModel {

    /**
     *
     * @var string 
     */
    protected $table = "product_discount_groups";
    protected $guarded = ['' ];

    public function products () {
        return $this->belongsToMany('Product' , 'product_has_group_discounts' , 'group_discount_id' , 'product_id');
    }


}
