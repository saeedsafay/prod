<?php

if( !defined('BASEPATH') )
    exit('No direct script access allowed');

/**
 * Menu Navigation model
 * 
 * @author		Pouya Mobasher Behrouz
 * @package		daloRADIUS
 * @subpackage	Menu Navigation module for CodeIgniter
 * @copyright	GPLv2
 *
 */
class Banner extends \Illuminate\Database\Eloquent\Model
{

    /**
     *
     * @var string 
     */
    protected $table = "banners";
    public $timestamps = false;
    protected $guarded = [ 'id' ];

}
