<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

require_once FCPATH . 'application/modules/shop/models/Product.php';

/**
 * Model: Colors of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Filter_value extends EloquentModel
{

    /**
     *
     * @var string 
     */
    protected $table = "filter_values";
    protected $guarded = [ '' ];
    public $timestamps = false;

    /**
     * Get all of the products that are assigned this value.
     */
    public function products()
    {
        return $this->morphedByMany('Product' , 'filter_valuable')->withPivot('name');
    }

    /**
     * Get the filter that are assigned this value.
     */
    public function filter()
    {
        return $this->morphOne('Product_type' , 'filter_valuable');
    }

    public function parentFilter()
    {
        return $this->belongsTo('Filter' , 'product_filter_id' , 'id');
    }

}
