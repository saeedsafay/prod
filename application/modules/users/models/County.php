<?php

if ( !defined('BASEPATH') )
    exit('No direct script access allowed');

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of User
 *
 * @author Saeed
 */
class County extends Model {

    /**
     * {@inheritDoc}
     */
    protected $guarded = [ ];
    protected $table = 'county';

    public function __construct ( array $attributes = array() ) {
        parent::__construct($attributes);
    }

    public function city () {
        return $this->hasMany('City');
    }

    public function province () {
        return $this->belongsTo('Province');
    }

    public function user () {
        return $this->belongsTo('User');
    }

}
