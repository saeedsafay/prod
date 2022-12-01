<?php

if ( !defined('BASEPATH') )
    exit('No direct script access allowed');

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of User
 *
 * @author Saeed
 */
class User_photo extends Model {

    /**
     * {@inheritDoc}
     */
    protected $table = 'users_photos';
    protected $guarded = [ ];
    public $timestamps = false;

    public function __construct ( array $attributes = array() ) {
        parent::__construct($attributes);
    }

    public function user(){
        return $this->belongsTo('User');
    }
}
