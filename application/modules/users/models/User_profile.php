<?php

if ( !defined('BASEPATH') )
    exit('No direct script access allowed');

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of User
 *
 * @author Saeed
 */
class User_profile extends Model {

    /**
     * {@inheritDoc}
     */
    protected $guarded = [ ];
    protected $table = 'users_profiles';
    public $timestamps = false;

    public function __construct ( array $attributes = array() ) {
        parent::__construct($attributes);
    }
    
    public function user(){
        return $this->belongsTo('User');
    }

}
