<?php

(defined('BASEPATH')) or exit('No direct script access allowed');

class Public_Controller extends MY_Controller
{

    public $user;

    public $searchConcerns = null;

    function __construct()
    {
        parent::__construct();

        $is_logged_in = false;
        if ($this->user = $this->sentinel->getUser()) {
            $is_logged_in = true;
        }
        $this->load->eloquent('shop/Product');
        $this->load->eloquent('users/User_profile');
        try {//Shopping Cart info in header
            if ($is_logged_in) {
                if ($Cart = $this->cartConcern->getCart()) {
                    //push single products to the cart
                    $cartItems = $Cart->varients;
                }
            } else { // else check for the session cart
                if ($sessionCart = $this->cartConcern->getSessionCart()) {
                    $cartItems = $this->cartConcern->prepareSessionCart($sessionCart);
                }
                $sessionCartDiscount = $this->session->userdata('session_cart_discount');
            }
        } catch (Throwable $e) {
            log_exception($e);
        }

        if ( ! $menus = cache('menus')) {
            $menus = cache_set('menus',
                Product_type::query()->orderByDesc('order_in_menu')->with('mainCategories')->get());
        }

        $this->load->eloquent('banners/Banner');
        if ( ! $Banners = cache('banners')) {
            $Banners = cache_set('banners', Banner::all());
        }
        $banner_home = array();
        foreach ($Banners as $value):
            $banner_home[$value->position] = $value;
        endforeach;

        $cart_total = isset($Cart) ? $this->cartConcern->getCartTotal($Cart) : [
            'total' => 0,
            'total_with_discount' => 0
        ];
        $sessionCart = isset($sessionCart) ? $this->cartConcern->getSessionCartTotal($sessionCart) : [
            'total' => 0,
            'total_with_discount' => 0
        ];

        if ( ! $this->input->is_ajax_request()) {
            $csrfToken = hash('sha256', random_string('alnum', 32).time());
            $this->session->set_userdata('csrf_token', $csrfToken);
        }


        $this->smart->assign([
            'CartItems' => isset($cartItems) ? $cartItems : collect([]),
            'Cart' => isset($Cart) ? $Cart : false,
            'sessionCartDiscount' => isset($sessionCartDiscount) ? $sessionCartDiscount['discount'] : 0,
            'cart_total' => $cart_total['total'] ? $cart_total['total'] : $sessionCart['total'],
            'cart_total_discount' => $cart_total['total_with_discount'] ? $cart_total['total_with_discount'] :
                $sessionCart['total_with_discount'],
            'is_logged_in' => $is_logged_in,
            'buyer' => $is_logged_in ? $this->user->roles->contains(3) : false,
            'is_home' => false,
            'banner_home' => $banner_home,
            'user' => $this->user,
            'profile' => isset($this->user->id) ? User::find($this->user->id)->profile : false,
            'menuProductTypes' => $menus,
            'production' => isset($_SERVER['CI_ENV']) && $_SERVER['CI_ENV'] == 'production',
            'csrfToken' => $this->session->userdata('csrf_token') ?? null,
        ]);
        $this->load->eloquent('settings/Setting');
        try {

            list($path, $_model) = Modules::find('SearchConcerns', 'shop', 'concerns/');
            Modules::load_file($_model, $path);
            $this->searchConcerns = new SearchConcerns($this);
            //Get theme for site
            if ( ! $site_theme = cache('site_name')) {
                $site_theme = cache_set('site_name', Setting::findByCode('theme')->value, 86400 * 7);
            }
            if (isset($site_theme)) {
                $this->smart->load($site_theme, false);
            }
            if ( ! $site_theme = cache('site_status')) {
                $site_theme = cache_set('site_status', Setting::findByCode('site_status')->value, 3600 * 60);
            }
            if ($site_theme == 0) {
                $this->smart->setLayout('maintenance_mode');
            }
        } catch (Throwable $e) {
            log_exception($e);
            show_error(500, 'An Error Was Encountered With Template Loading.');
        }
    }

    protected function cookieProducts()
    {

        $productId = $this->input->cookie('id_tracker_global', false);
        try {
            if ( ! $productId) {
                $cat = Category::select('id')->first();

                $result = $cat->product()->active()->take(10)->skip(0)->get();
            } else {
                $product = Product::query()->findOrFail($productId);

                if ($product->category) {
                    $result = $product->category->product()->active()->take(10)->skip(0)->get();
                } else {
                    $result = Category::select('id')->first()->product()->active()->take(10)->skip(0)->get();
                }
            }
            return $result;
        } catch (Throwable $e) {
            log_exception($e);
            return [];
        }
    }

    /**
     * Remaping for authentication check
     */
    //    public function _remap($method, $params = array()) {
    //        if (!($this->user = $this->sentinel->check()) AND $this->auth_arr) {
    //            redirect('/users/login');
    //        }
    //
    //        if (method_exists($this, $method)) {
    //            return call_user_func_array(array($this, $method), $params);
    //        }
    //
    //        show_404();
    //    }

}