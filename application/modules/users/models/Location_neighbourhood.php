<?php

if ( !defined('BASEPATH') )
    exit('No direct script access allowed');

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of User
 *
 * @author Saeed
 */
class Location_neighbourhood extends Model {

    /**
     * {@inheritDoc}
     */
    protected $guarded = [ ];
    protected $table = 'location_neighbourhood';
    public $timestamps = false;

    public function __construct ( array $attributes = array() ) {
        parent::__construct($attributes);
    }

    public function region () {
        return $this->hasMany('Location_region' , 'location_region_id');
    }

    public function province () {
        return $this->belongsTo('Province');
    }

}
