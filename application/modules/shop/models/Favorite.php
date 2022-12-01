<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Favorite products model
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Favorite extends EloquentModel {

    /**
     *
     * @var string 
     */
    protected $table = "product_favorites";
    protected $guarded = ['' ];
    public $timestamps = false;

    public function product () {
        return $this->belongsTo('Product' , 'product_id' , 'id');
    }

    /**
     * 
     * @return type
     */
    public function user () {
        return $this->belongsTo(CI::$APP->sentinel->getModel());
    }

    /**
     * حداکثر تعداد محصول برای مقایسه
     * @param type $product_id
     * @param type $user_id
     * @return boolean
     */
    public static function checkCompareSize ( $user_id ) {
        $cmp = self::where('user_id' , $user_id)->get();
        if ( $cmp->count() < 5 ) {
            return true;
        }
        return false;
    }

    /**
     * لیست محصولات اضافه شده علاقمندی برای کاربر
     * @param type $user_id
     * @return type
     */
    public static function getUserFavs ( $user_id ) {
        return self::where('user_id' , '=' , $user_id)->orderBy('id','desc')->get();
    }

}
