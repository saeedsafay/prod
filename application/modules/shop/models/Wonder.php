<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Featrues for products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Wonder extends EloquentModel {

    /**
     *
     * @var string 
     */
    protected $table = "product_wonders";
    protected $guarded = [ '' ];

    /**
     * 
     * @return type
     */
    public function product()
    {
        return $this->belongsTo('Product' , 'product_id' , 'id');
    }

    public function wonder_category()
    {
        return $this->belongsTo('Wonder_category' , 'wonder_category_id' , 'id');
    }

}
