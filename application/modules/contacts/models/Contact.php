<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

/**
 * Contact Model
 * 
 * @author		Saeed Tavakoli
 * @package		
 * @subpackage	
 * @copyright	
 *
 */
class Contact extends \Illuminate\Database\Eloquent\Model {

    /**
     *
     * @var string 
     */
    protected $table = "contacts";

    /**
     *
     * @var array 
     */
    protected $guarded = [];

    public static function getTickets() {
        return self::where('is_ticket' , 1)->get();
    }

    public static function getAnnouncement() {
        return self::where('is_announcement' , 1)->get();
    }
    public static function getContacts() {
        return self::where(['is_announcement'=>0,'is_ticket' => 0])->get();
    }

}
