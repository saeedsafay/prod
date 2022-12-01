<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Colors of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Product_type extends EloquentModel
{

    /**
     *
     * @var string
     */
    protected $table = "product_types";
    protected $guarded = [''];
    public $timestamps = false;

    /**
     *
     * @return type
     */
    public function products()
    {
        return $this->hasMany('Product', 'product_type_id', 'id');
    }

    public function categories()
    {
        return $this->hasMany('Category', 'product_type_id', 'id');
    }

    public function mainCategories()
    {
        return $this->hasMany('Category', 'product_type_id', 'id')
            ->where('parent_id', null)
            ->with('children');
    }

    public function filters()
    {
        return $this->hasMany('Filter', 'product_type_id', 'id');
    }

}
