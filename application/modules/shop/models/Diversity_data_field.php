<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Category of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Diversity_data_field extends EloquentModel {

    /**
     *
     * @var string 
     */
    protected $table = "diversity_value_has_products";
    protected $guarded = [ '' ];
    public $timestamps = false;

    public function varient()
    {
        return $this->belongsTo('Diversity_data' , 'product_diversity_data_id' , 'id');
    }

    public function value()
    {
        return $this->belongsTo('Diversity_value' , 'diversity_value_id' , 'id');
    }

}
