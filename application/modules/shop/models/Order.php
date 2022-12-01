<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

require_once FCPATH.'application/modules/users/models/User.php';
require_once MODULE_PATH.'shop/models/Product.php';

/**
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2020
 * @license     MIT License
 */
class Order extends EloquentModel
{

    /**
     *
     * @var string
     */
    protected $table = "product_cart_has_product";
    protected $guarded = ['id'];
    public $casts = [
        'files' => 'array'
    ];

    public function cart()
    {
        return $this->belongsTo('Cart', 'cart_id', 'id');
    }

    public function shop()
    {
        return $this->belongsTo('User', 'shop_id', 'id');
    }

    public function product()
    {
        return $this->belongsTo('Product', 'product_id', 'id');
    }

    public function diversity()
    {
        return $this->belongsTo('Diversity_data', 'diversity_data_id');
    }

    public static function getOrders($sellerId)
    {
        return self::query()->where('shop_id', $sellerId)
            ->with('product', 'shop', 'cart', 'diversity.fields.value.parentDiversity')
            ->whereHas('cart', function ($q) {
                $q->where('status', 1);
            })
            ->orderByDesc('id')
            ->get();
    }

}
