<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Colors of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2021
 * @license     MIT License
 */
class Product_hidden extends EloquentModel
{

    /**
     *
     * @var string
     */
    protected $table = "products_is_hidden";
    protected $guarded = ['id'];
    public $timestamps = false;

    /**
     * @return mixed
     */
    public function products()
    {
        return $this->belognsTo('Product', 'product_id', 'id');
    }

}
