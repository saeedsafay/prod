<?php


class Seller_Controller extends MY_Controller
{

    public $user;

    public function __construct()
    {
        parent::__construct();

        $is_logged_in = false;
        if ($this->user = $this->sentinel->check()) {
            $is_logged_in = true;
        }

        $this->checkAuth(true);
        $this->show_404_on(! $this->user->inRole('seller'));
        $this->load->eloquent([
            'shop/Product',
            'shop/Keyword',
            'shop/Diversity_data',
        ]);

        // Loading the dashboard template for frontend
        $this->smart->load('ModernDashboard');
        $this->smart->assign([
            'is_logged_in' => $is_logged_in,
            'user' => $this->user,
        ]);
    }

}