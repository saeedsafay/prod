<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');

class MY_Exceptions extends CI_Exceptions {

    public $CI;

    function __construct() {
        parent::__construct();
        log_message('debug', 'MY_Exceptions Class Initialized');
    }

}

/* End of file MY_Exceptions.php */
/* Location: ./system/application/libraries/MY_Exceptions.php */ 
