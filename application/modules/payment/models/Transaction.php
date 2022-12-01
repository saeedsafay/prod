<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

require_once FCPATH.'application/modules/users/models/User.php';
//require_once FCPATH.'application/modules/shop/models/C.php';

/**
 * Model: Transactions of online payments
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Transaction extends EloquentModel
{

    protected $table = "transactions";
    protected $guarded = [""];
    public $timestamps = false;

    public function user()
    {
        return $this->belongsTo('User');
    }

    public function shop()
    {
        return $this->belongsTo('User', 'shop_id', 'id');
    }

    public function invited_user()
    {
        return $this->belongsTo('User', 'shop_id', 'id');
    }

    public function state()
    {
        return $this->belongsTo('Transaction_state', 'transaction_states_id', 'id');
    }

    public function cart()
    {
        return $this->belongsTo('Cart', 'order_id','id');
    }

}
