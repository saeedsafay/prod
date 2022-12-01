<?php
/* 
 *  ======================================= 
 *  Author     : Saeed Tavakoli 
 *  License    : Protected 
 *  Email      : saeed.g71@gmail.com 
 *   
 *  Php excel library, for working with xls, xlsx, csv and etc files in php projects 
 *  
 *  ======================================= 
 */  
require_once APPPATH."/third_party/PHPExcel/PHPExcel.php"; 
class MirookExcel extends PHPExcel { 
    
    public function __construct() { 
        parent::__construct(); 
    }
}