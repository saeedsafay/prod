<?php

if ( ! defined('BASEPATH')) {
    exit('No direct script access allowed');
}

/*
  |--------------------------------------------------------------------------
  | File and Directory Modes
  |--------------------------------------------------------------------------
  |
  | These prefs are used when checking and setting modes when working
  | with the file system.  The defaults are fine on servers with proper
  | security, but you may wish (or even need) to change the values in
  | certain environments (Apache running a separate process for each
  | user, PHP under CGI with Apache suEXEC, etc.).  Octal values should
  | always be used to set the mode correctly.
  |
 */
define('FILE_READ_MODE', 0644);
define('FILE_WRITE_MODE', 0666);
define('DIR_READ_MODE', 0755);
define('DIR_WRITE_MODE', 0777);

/*
  |--------------------------------------------------------------------------
  | File Stream Modes
  |--------------------------------------------------------------------------
  |
  | These modes are used when working with fopen()/popen()
  |
 */

define('FOPEN_READ', 'rb');
define('FOPEN_READ_WRITE', 'r+b');
define('FOPEN_WRITE_CREATE_DESTRUCTIVE', 'wb'); // truncates existing file data, use with care
define('FOPEN_READ_WRITE_CREATE_DESTRUCTIVE', 'w+b'); // truncates existing file data, use with care
define('FOPEN_WRITE_CREATE', 'ab');
define('FOPEN_READ_WRITE_CREATE', 'a+b');
define('FOPEN_WRITE_CREATE_STRICT', 'xb');
define('FOPEN_READ_WRITE_CREATE_STRICT', 'x+b');

/*
  |--------------------------------------------------------------------------
  | CMS Version
  |--------------------------------------------------------------------------
  |
  | Defines the version number for cms
  |
 */
define('CC_VERSION', '1.0.5');

/*
  |--------------------------------------------------------------------------
  | CMS Root Folder
  |--------------------------------------------------------------------------
  |
  | Defines the absolute path to the root folder of cms canvas
  |
 */
define('CMS_ROOT', dirname(BASEPATH).'/');

/*
  |--------------------------------------------------------------------------
  | Admin Path
  |--------------------------------------------------------------------------
  |
 */
define('ADMIN_PATH', 'backoffice');
/*
  |--------------------------------------------------------------------------
  | Modules Path
  |--------------------------------------------------------------------------
  |
 */
define('MODULE_PATH', APPPATH.'modules'.DIRECTORY_SEPARATOR);

/*
  |--------------------------------------------------------------------------
  | Group Types
  |--------------------------------------------------------------------------
  |
 */
define('USER', 'user');
define('ADMINISTRATOR', 'administrator');
define('SUPER_ADMIN', 'superadmin');

/*
  |--------------------------------------------------------------------------
  | CMS Image Cache Directory
  |--------------------------------------------------------------------------
  |
 */
define('IMAGE_CACHE', '/assets/cms/image-cache');

/*
  |--------------------------------------------------------------------------
  | User Data Storage
  |--------------------------------------------------------------------------
  |
 */
define('USER_DATA', '/assets/userdata/');


/*
  |--------------------------------------------------------------------------
  | Admin Access Area Options
  |--------------------------------------------------------------------------
  |
 */
$admin_access_options = array(
    ADMIN_PATH.'/content/entries' => 'Content / Entries',
    ADMIN_PATH.'/navigations' => 'Content / Navigations',
    ADMIN_PATH.'/galleries' => 'Content / Galleries',
    ADMIN_PATH.'/users' => 'Users',
    ADMIN_PATH.'/users/groups' => 'User Groups',
    ADMIN_PATH.'/content/types' => 'Tools / Content Types',
    ADMIN_PATH.'/content/snippets' => 'Tools / Code Snippets',
    ADMIN_PATH.'/categories' => 'Tools / Categories',
    ADMIN_PATH.'/settings/theme-editor' => 'Tools / Theme Editor',
    ADMIN_PATH.'/settings/general-settings' => 'General Settings',
    ADMIN_PATH.'/settings/clear-cache' => 'Settings / Clear Cache',
    ADMIN_PATH.'/settings/server-info' => 'Settings / Server Info',
);

define('ADMIN_ACCESS_OPTIONS', serialize($admin_access_options));

/*
  |--------------------------------------------------------------------------
  | Admin Missing Image
  |--------------------------------------------------------------------------
  |
 */
define('ADMIN_NO_IMAGE', '/application/themes/admin/assets/images/no_image.jpg');

/*
  |--------------------------------------------------------------------------
  | Reagent user percent for affiliate
  |--------------------------------------------------------------------------
  |
 */
define('REAGENT_PERCENT', 1.5);

/* End of file constants.php */
/* Location: ./system/application/config/constants.php */

