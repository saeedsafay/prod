<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

require_once FCPATH . 'application/modules/users/models/User.php';
/**
 * Model: Shipping for products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Search_log extends EloquentModel
{

    /**
     *
     * @var string 
     */
    protected $table = "search_log";
    protected $guarded = [ '' ];

    /**
     * 
     * @return type
     */
    public function user()
    {
        return $this->belongsTo('User' , 'user_id' , 'id');
    }

}
