<?php

defined('BASEPATH') OR exit('No direct script access allowed');

/**
 * 
 * 
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2012
 * @license     MIT License
 */
class Advertise_plugin extends Plugin {

    private $menu;
    private $menu_group;

    /**
     * Aids in formatting the returned data from the method call
     * 
     * @param		string		method name
     * @param		mixed		arguments passed to the method
     * @param		string		format type, one of: array, json, serialize. defaults to php's array
     * @return		mixed		representation of model's data result based on the format provided
     */
    public function getFields() {
        //load Models
        $this->load->eloquent('advertise/Advertise');
        $this->load->eloquent('advertise/Ads_field');
        //parameters
        $ads_id = $this->attribute("ads_id");
        $key = $this->attribute("key");
        //init object advertise
        $Ads = Advertise::find($ads_id);
        // get field meta value
        if ($Ads->fields)
            return $Ads->fields->getAdsField($key)->ads_field_value;
        else
            return null;
    }

}
