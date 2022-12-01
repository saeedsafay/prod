<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Colors of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Product_image extends EloquentModel
{

    /**
     *
     * @var string
     */
    protected $table = "product_images";
    protected $guarded = ['id'];
    public $timestamps = false;

    /**
     * @return mixed
     */
    public function product()
    {
        return $this->belongsTo('Product', 'product_id', 'id');
    }

    public function variants()
    {
        return $this->hasMany('Diversity_data', 'product_image_id');
    }

}
