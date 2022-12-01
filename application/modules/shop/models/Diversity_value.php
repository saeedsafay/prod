<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

require_once FCPATH.'application/modules/shop/models/Product.php';

/**
 * Model: Colors of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Diversity_value extends EloquentModel
{

    /**
     *
     * @var string
     */
    protected $table = "diversity_values";
    protected $guarded = [''];
    public $timestamps = false;

    /**
     * Get all of the products that are assigned this value.
     */
    public function products()
    {
        return $this->morphedByMany('Product', 'diversity_valuable')->withPivot('product_diversity_data_id');
    }

    /**
     * Get the diversity that are assigned this value.
     */
    public function diversity()
    {
        return $this->morphOne('Product_type', 'diversity_valuable');
    }

    public function parentDiversity()
    {
        return $this->belongsTo('Diversity', 'product_diversity_id', 'id')
            ->orderBy("priority", "desc");
    }

}
