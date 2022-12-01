<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Category of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Wonder_category extends EloquentModel {

    /**
     *
     * @var string 
     */
    protected $table = "product_wonder_categories";
    protected $guarded = [ '' ];
    public $timestamps = false;

    public function wonder()
    {
        return $this->hasMany('Wonder' , 'wonder_category_id' , 'id');
    }

}
