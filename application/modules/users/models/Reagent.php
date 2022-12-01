<?php

if ( !defined('BASEPATH') )
    exit('No direct script access allowed');

use \Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of User
 *
 * @author Saeed
 */
class Reagent extends Model {

    /**
     * {@inheritDoc}
     */
    protected $table = 'affiliate';
    protected $guarded = ['id' ];

    public function __construct ( array $attributes = array() ) {
        parent::__construct($attributes);
    }

    public function user () {
        return $this->belongsTo('User');
    }
    
    public function subset_member () {
        return $this->belongsTo('User','invited_user_id','id');
    }
    
    public static function subsetUsers($user_id){
        
        return self::where('user_id',$user_id)->get();
        
    }

}
