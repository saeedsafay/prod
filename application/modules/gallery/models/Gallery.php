<?php

if ( !defined('BASEPATH') )
    exit('No direct script access allowed');

/**
 * Gallery Model
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2017
 * @license     MIT License
 * @link http://www.saeedtavakoli.ir exclusive CMS.
 */
class Gallery extends \Illuminate\Database\Eloquent\Model {

    /**
     *
     * @var string 
     */
    protected $table = "gallery";
    protected $guarded = ['' ];

    public function photos () {
        return $this->hasMany('Gallery_photo' , 'gallery_id' , 'id');
    }

    public function index_photo () {
        return $this->hasOne('Gallery_photo' , 'index_photo_id' , 'id');
    }

}
