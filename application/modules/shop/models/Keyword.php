<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Tariff for selling advertisement to users
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Keyword extends EloquentModel {

    /**
     *
     * @var string 
     */
    protected $table = "product_keywords";
    protected $guarded = [''];
    public $timestamps = false;

    public function product() {
        return $this->belongsToMany('Product', 'product_keyword_has_product',
                        'product_keyword_id','product_id');
    }

    public static function findByName($keyword) {
        return self::where('keyword', $keyword)->get();
    }

}
