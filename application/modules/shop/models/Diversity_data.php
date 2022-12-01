<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

require_once APPPATH."modules/shop/models/Diversity.php";
require_once APPPATH."modules/shop/models/Diversity_data_field.php";
require_once APPPATH."modules/shop/models/Diversity_value.php";

/**
 * Model: Category of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Diversity_data extends EloquentModel
{

    /**
     *
     * @var string
     */
    protected $table = "product_diversity_data";
    protected $guarded = [''];
    public $timestamps = false;

    public function fields()
    {
        return $this->hasMany('Diversity_data_field', 'product_diversity_data_id', 'id');
    }

    public function product()
    {
        return $this->belongsTo('Product', 'product_id', 'id');
    }

    /**
     *
     * @return BelongsToMany
     */
    public function orders()
    {
        return $this->belongsToMany('Cart', 'product_cart_has_product', 'diversity_data_id', 'cart_id')
            ->withPivot(array('qty', 'shop_id', 'unit_price'));
    }

    public function image()
    {
        return $this->belongsTo('Product_image', 'product_image_id', 'id');
    }

    public function getThumbnailAttribute()
    {
        return isset($this->image) ? $this->image->attributes['file_name'] :
            $this->product->pic;
    }
}
