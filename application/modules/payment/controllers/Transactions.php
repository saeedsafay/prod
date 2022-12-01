<?php

/**
 * Description of Transactions
 *
 * @author Saeed
 */
class Transactions extends Public_Controller {

    public function __construct () {
        parent::__construct();
        $this->load->eloquent('Transaction');
    }

    public function index () {
        $this->checkAuth(true);
        $this->smart->load('Dashboard');
        if ( $this->user->type == 1 ) {
            $transactions = Transaction::where('shop_id' , $this->user->id)->orderBy('id' , 'desc')->get();
        }
        else
            $transactions = Transaction::where('user_id' , $this->user->id)->orderBy('id' , 'desc')->get();
        $this->smart->assign([
            'title' => 'تراکنش های مالی من' ,
            'transactions' => $transactions
        ]);
        $this->smart->view('index');
    }

    public function affiliates () {
        $this->checkAuth(true);
        $this->smart->load('Dashboard');
        $transactions = Transaction::where('user_id' , $this->user->id)->where('invoice_type' , 100)->orderBy('id' , 'desc')->get();
        $this->smart->assign([
            'title' => 'تراکنش‌های مالی کارمزد زیرمجموعه' ,
            'transactions' => $transactions
        ]);
        $this->smart->view('aff_transactions');
    }

}
