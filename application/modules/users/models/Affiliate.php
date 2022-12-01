<?php

if( !defined('BASEPATH') )
    exit('No direct script access allowed');

require_once FCPATH . 'application/modules/shop/models/Product_type.php';

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of User
 *
 * @author Saeed
 */
class Affiliate extends Model
{

    /**
     * {@inheritDoc}
     */
    protected $table = 'affiliates_pro';
    protected $guarded = [];
    public $timestamps = false;

    public function __construct( array $attributes = array() )
    {
        parent::__construct($attributes);
    }

    /**
     * 
     * @return type
     */
    public function user()
    {
        return $this->belongsTo('User');
    }

    public function product_type()
    {
        return $this->belongsTo('Product_type' , 'product_type_id' , 'id');
    }

}
