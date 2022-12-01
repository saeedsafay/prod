<?php

if ( ! defined('BASEPATH')) {
    exit('No direct script access allowed');
}
/*
  | -------------------------------------------------------------------------
  | URI ROUTING
  | -------------------------------------------------------------------------
  | This file lets you re-map URI requests to specific controller functions.
  |
  | Typically there is a one-to-one relationship between a URL string
  | and its corresponding controller class/method. The segments in a
  | URL normally follow this pattern:
  |
  |	example.com/class/method/id/
  |
  | In some instances, however, you may want to remap this relationship
  | so that a different class/function is called than the one
  | corresponding to the URL.
  |
  | Please see the user guide for complete details:
  |
  |	http://codeigniter.com/user_guide/general/routing.html
  |
  | -------------------------------------------------------------------------
  | RESERVED ROUTES
  | -------------------------------------------------------------------------
  |
  | There area two reserved routes:
  |
  |	$route['default_controller'] = 'welcome';
  |
  | This route indicates which controller class should be loaded if the
  | URI contains no data. In the above example, the "welcome" class
  | would be loaded.
  |
  |	$route['404_override'] = 'errors/page_missing';
  |
  | This route will tell the Router what URI segments to use if those provided
  | in the URL cannot be matched to a valid route.
  |
 */
$route['default_controller'] = "content";
$route['404_override'] = 'content';
$route['([a-zA-Z_-]+)/admin/([a-zA-Z_-]+)'] = "";
// front routing
$route['product/NPI-(:num)'] = 'shop/products/view-product/$1';
$route['product/NPI-(:num)/(.+)'] = 'shop/products/view-product/$1/$2';
$route['product/npi-(:num)'] = 'shop/products/view-product/$1';
$route['product/npi-(:num)/(.+)'] = 'shop/products/view-product/$1/$2';
$route['festival/(.+)'] = 'shop/products/view-festival/$1';
$route['products'] = 'shop/products/list-products';
$route['shop/cart'] = 'shop/products/cart';
$route['shop/cart-address'] = 'shop/products/cart-delivery-address';
$route['shop/addToCart'] = 'shop/products/AddToCart';
$route['shop/removeCartItem'] = 'shop/products/removeCartItem';
$route['shop/coupon'] = 'shop/products/coupon';
$route['shop/checkout'] = 'shop/products/checkout';
$route['shop/uploadImages'] = 'shop/products/uploadImages';

$route['cats/(.+)'] = 'shop/products/list-category/$1';
$route['cats/(.+)/:num'] = 'shop/products/list-category/$1/$2';
$route['cats/(.+)/(.+)/:num'] = 'shop/products/list-category/$1/$2/$3';

$route['prd/(.+)'] = 'shop/products/general-products/$1';
$route['prd/(.+)/(.+)/(.+)'] = 'shop/products/general-products/$1/$2/$3';

$route['product-type/(.+)/category/(.+)/(.+)'] = 'shop/products/general-products/$1/$2/$3';

$route['search'] = 'shop/search/getResults';
$route['search-result'] = 'shop/products/search-result';

$route['payment'] = 'payment/payments/index';

$route['product-types/(.+)'] = "shop/product-types/getCategories/$1";
$route['subcategories/(.+)'] = "shop/product-types/getSubCategories/$1";

$route['dashboard'] = 'seller/dashboard/index';
$route['panel'] = 'dashboard/users-panel/index';
$route['profile'] = 'dashboard/users-panel/profile';
$route['orders'] = 'dashboard/users-panel/orders';
$route['addresses'] = 'dashboard/users-panel/addresses';
// for api service
$route['api/get-api/product/(:num)'] = 'api/get-api/product/id/$1'; // Example 4
$route['api/get-api/users/(:num)(\.)([a-zA-Z0-9_-]+)(.*)'] = 'api/test/users/id/$1/format/$3$4'; // Example 8

// Special Case Routes
$route[ADMIN_PATH.'/users/login'] = "users/login";
$route[ADMIN_PATH.'/users/logout'] = "users/logout";
$route[ADMIN_PATH.'/users/forgot-password'] = "users/forgot-password";
$route[ADMIN_PATH] = "dashboard/admin/dashboard";
$route[ADMIN_PATH.'/([a-zA-Z_-]+)/(.+)'] = "$1/admin/$2";
$route[ADMIN_PATH.'/([a-zA-Z_-]+)'] = "$1/admin/$1";
/* End of file routes.php */
/* Location: ./application/config/routes.php */


$route['visametric'] = 'monitor/visaMetric/checkVisaMetricDates';
$route['norderstedt'] = 'monitor/visaMetric/norderstedt';
