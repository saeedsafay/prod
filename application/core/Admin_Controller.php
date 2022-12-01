<?php

(defined('BASEPATH')) OR exit('No direct script access allowed');

class Admin_Controller extends MY_Controller {

    public $user;
    public $auth = true;

    function __construct () {
        parent::__construct();

//        $this->sentinel->login($this->sentinel->findById(2));
        if ( $this->uri->segment(4) != 'resetPasswordBySms' AND ! ($this->user = $this->sentinel->check()) ) {
            redirect(ADMIN_PATH . '/users/login');
        }
        $this->load->eloquent('shop/Product');
        $this->load->eloquent('shop/Cart');
        $this->load->eloquent('content/Comment');
        $this->load->eloquent('contacts/Contact');
        $notification['product_all'] = Product::getProducts(4)->count();
        $expiredCount = 0;
        $current_date = date('Y-m-d H:i:s');

        $notification['orders'] = Cart::where('status' , 1)->get()->count();

        $this->activation = $this->sentinel->getActivationRepository();
        $notification['users'] = $this->user->all()->count();
        $notification['non_activate'] = $this->activation->where('completed' , 0)->count();

        $notification['unverify_comments'] = Comment::where('status' , 0)->get()->count();
        $notification['true_comments'] = Comment::where('status' , 1)->get()->count();

        $notification['contacts'] = Contact::all()->count();

        $this->load->helper('admin_helper');
        $this->smart->assign(
                [
                    'Announce' => $this->announcements() ,
                    'notif' => $notification ,
                ]
        );
        $this->smart->load('default' , true);
    }

    public function _remap ( $method , $params = array() ) {
        // Making access string
        $accessString = $this->router->fetch_module() . '.admin.' . $this->router->fetch_class();
        if ( $this->router->fetch_method() != 'index' )
            $accessString .= '.' . $this->router->fetch_method();
        // check access for roles of user
        $Roles = $this->user->roles;
        $RoleHasAccess = false;
        foreach ( $Roles as $role ):
            // only one role access is enough for permission
            if ( $role->hasAnyAccess($accessString) )
                $RoleHasAccess = true;
        endforeach;
        // Check group type Administrator's permissions for access
        if ( $this->uri->segment(4) != 'resetPasswordBySms' AND ! $RoleHasAccess AND ! $this->user->hasAnyAccess($accessString) && !$this->user->inRole(SUPER_ADMIN) ) {                // Access forbidden:
            header('HTTP/1.1 403 Forbidden');

            return $this->smart->view('users/permission_denied');
        }

        if ( method_exists($this , $method) ) {
            return call_user_func_array(array( $this , $method ) , $params);
        }

        show_404();
    }

    public function announcements () {
        $this->load->eloquent('Contacts/Contact');
        return Contact::getAnnouncement();
    }

}
