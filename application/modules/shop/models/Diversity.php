<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Colors of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Diversity extends EloquentModel
{

    /**
     *
     * @var string 
     */
    protected $table = "product_diversities";
    protected $guarded = [ '' ];
    public $timestamps = false;

    /**
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function product_type()
    {
        return $this->belongsTo('Product_type' , 'product_type_id' , 'id');
    }

    public function values()
    {
        return $this->hasMany('Diversity_value' , 'product_diversity_id' , 'id');
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
