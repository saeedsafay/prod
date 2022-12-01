<?php

if ( !defined('BASEPATH') )
    exit('No direct script access allowed');

/**
 * Gallery_photo Model
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2017
 * @license     MIT License
 * @link http://www.saeedtavakoli.ir exclusive CMS.
 */
class Gallery_photo extends \Illuminate\Database\Eloquent\Model {

    /**
     *
     * @var string 
     */
    protected $table = "gallery_photos";
    protected $guarded = ['' ];

    public function gallery () {
        return $this->belongsTo('Gallery' , 'gallery_id' , 'id');
    }

}
