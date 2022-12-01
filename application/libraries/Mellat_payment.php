<?php

if (!defined('BASEPATH'))
    exit('No direct script access allowed');
/*
 *  ======================================= 
 *  کلاس پرداخت برای درگاه الکترونیکی بانک ملت
 *  
 *  @license   Protected 
 *  @author    Saeed Tavakoli <saeed.g71@gmail.com> 
 *  @since     1394-04 
 *  
 *  
 *  =======================================  
 */
require_once APPPATH . "/third_party/Payment/MellatBank/lib/MellatBank.php";

class mellat_payment extends MellatBank {

    public function __construct() {
        parent::__construct();
        error_reporting(E_ALL);
    }

    /**
     * تابع اصلی مربوط به پرداخت از طریق درگاه بانک ملت
     * @param type $invoice_id شناسه فاکتور مربوطه
     */
    public function payment_mellat_bank( $amount_must_pay, $callBackUrl,$params) {
        $mellat = new MellatBank();
        /**
         * پرداخت مبلغ و انتقال به درگاه بانک
         */
        $mellat->startPayment($amount_must_pay, $callBackUrl, $params);
    }

    /**
     * تابع مربوط به تایید تراکنش بانک ملت
     * @param type $invoice_id
     * 
     */
    public function verify_payment() {

        $mellat = new MellatBank();

        /**
         * تایید تراکنش
         */
        $results = $mellat->checkPayment($_POST);
        /**
         * return value will be : 
         * 	$results['status'],
         *      $results["trans"]=> "SaleReferenceId",
         *      $results["order_id"]=> "SaleOrderId"
         */
        return $results;
    }

}
