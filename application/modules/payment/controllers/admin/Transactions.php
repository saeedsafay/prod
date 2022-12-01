<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Transactions
 *
 * @author Saeed
 */
class Transactions extends Admin_Controller {

    public function __construct() {
        parent::__construct();
        $this->load->eloquent('Transaction');
    }

    public function index() {
        $transactions = Transaction::orderBy('id','desc')->get();
        $this->smart->assign([
            'title' => 'تراکنش های مالی کاربران',
            'transactions' => $transactions
        ]);
        $this->smart->view('trans');
    }

}
