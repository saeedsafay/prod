<?php

if ( !defined('BASEPATH') )
    exit('No direct script access allowed');

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of User
 *
 * @author Saeed
 */
class Location_county extends Model {

    /**
     * {@inheritDoc}
     */
    protected $table = 'location_county';
    protected $guarded = [ ];
    public $timestamps = false;

    public function __construct ( array $attributes = array() ) {
        parent::__construct($attributes);
    }

    /**
     * 
     * @return type
     */
    public function province () {
        return $this->belongsTo('Province');
    }

    public function regions () {
        return $this->hasMany('Location_region' , 'location_county_id' , 'id');
    }

    public function user () {
        return $this->belongsTo('User');
    }

}
