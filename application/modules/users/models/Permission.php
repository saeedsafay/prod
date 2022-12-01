<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

use \Illuminate\Database\Eloquent\Model as Model;
use Illuminate\Contracts\Support\Jsonable;
use Illuminate\Contracts\Support\Arrayable;

/**
 * Permission list for ACL
 * 
 * @author		Saeed Tavakoli <saeed.g71@gmail.com>
 * @package		
 * @subpackage	Permission for storing available permissions list
 * @copyright	GPLv2
 *
 */
class Permission extends Model implements ArrayAccess {

    /**
     *
     * @var string 
     */
    protected $table = "permissions";
    protected $fillable = ['module_name', 'permission'];

}
