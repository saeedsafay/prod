<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

require_once APPPATH."modules/shop/models/Filter_value.php";
/**
 * Model: Colors of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Filter extends EloquentModel
{

    /**
     *
     * @var string 
     */
    protected $table = "product_filters";
    protected $guarded = [ '' ];
    public $timestamps = false;

    /**
     * 
     * @return type
     */
    public function product_type()
    {
        return $this->belongsTo('Product_type' , 'product_type_id' , 'id');
    }

    public function values()
    {
        return $this->hasMany('Filter_value' , 'product_filter_id' , 'id');
    }

    public function parent_category()
    {
        return $this->belongsTo('Category' , 'product_category_id' , 'id');
    }

    public function child_category()
    {
        return $this->belongsTo('Category' , 'product_child_category_id' , 'id');
    }

}
