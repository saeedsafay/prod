<?php

/**
 * کلاس درگاه پرداخت بانک ملت
 *
 * با استفاده از این کلاس میتوانید به راحتی از درگاه پرداخت بانک ملت 
 * در نرم افزار های تحت وب خود استفاده کنید، همچنین میتوایند از این
 * کلاس در سی ام اس هایی مانند وردپرس ، جوملا و .. نیز استفاده کنید.
 *
 * @category  Gateway
 * @package   Mellatbank
 * @license   http://www.opensource.org/licenses/BSD-3-Clause
 * @example   ../index.php
 * @example <br />
 *  $mellat = new MellatBank();<br />
 *  $mellat->startPayment('1000', 'http://localhost');<br />
 *  $results = $mellat->checkPayment($_POST);<br />
 *  if($results['status']=='success') echo 'OK';<br />
 * @version   1
 * @since     2014-12-10
 * @author    Ahmad Rezaei <info@freescript.ir>
 */
class MellatBank {
	
	/**
	 * ترمینال درگاه بانک ملت.
	 * @var intiger
	 */
	private $terminal = '2077992' ;
	
	/**
	 * نام کاربری درگاه بانک ملت.
	 * @var string
	 */
	private $username = 'piyano987' ;
	
	/**
	 * رمز عبور درگاه بانک ملت.
	 * @var string
	 */
	private $password = '38067666' ;
	
	
	function __construct() {
		require_once'nusoap.php' ;
	}
	
	
	/**
	 * تابع پرداخت
	 * با استفاده از این متد میتوانید درخواست پرداخت را به بانک ملت ارسال کنید.
	 *
	 * @param intiger $amount : مبلغ پرداخت
	 * @param string $callBackUrl : آدرس برگشت بعد از پرداخت
	 *
	 * @since   2014-12-10
	 * @author  Ahmad Rezaei <info@freescript.ir>
	 */
	public function startPayment($amount, $callBackUrl,$order_id)
	{			
		$client = new nusoap_client( 'https://bpm.shaparak.ir/pgwchannel/services/pgw?wsdl' ) ;
		$terminalId = $this->terminal ;
		$userName = $this->username;
		$userPassword = $this->password;
		$orderId = $order_id . (time() %1000) ;
		$amount = $amount;
		$localDate = date('ymj');
		$localTime = date('His');
		$additionalData = '';
		$callBackUrl = $callBackUrl;
		$payerId = 0;
		$err = $client->getError();
		if ($err) {
			echo '<h2>Constructor error</h2><pre>' . $err . '</pre>';
			die();
		}
		$parameters = array(
			'terminalId' => $terminalId,
			'userName' => $userName,
			'userPassword' => $userPassword,
			'orderId' => $orderId,
			'amount' => $amount,
			'localDate' => $localDate,
			'localTime' => $localTime,
			'additionalData' => $additionalData,
			'callBackUrl' => $callBackUrl,
			'payerId' => $payerId);
		$result = $client->call('bpPayRequest', $parameters, 'http://interfaces.core.sw.bps.com/');
		if ($client->fault) {
			echo '<h2>Fault</h2><pre>';
			print_r($result);
			echo '</pre>';
			die();
		} 
		else {
			$resultStr  = $result;
			$err = $client->getError();
			if ($err) {
				echo '<h2>Error</h2><pre>' . $err . '</pre>';
				die();
			} 
			else {
				$res = explode (',',$resultStr);
				echo '<div style="display:none;">Pay Response is : ' . $resultStr . '</div>';
				$ResCode = $res[0];	
				if ($ResCode == "0") {
					$this->postRefId($res[1]);
				} 
				else {
					$this->error($ResCode);
				}
			}
		}
			
	}
	
	
	/**
	 * تابع تایید پرداخت
	 * با استفاده از این تابع میتوانید درخواست تایید پرداخت را 
	 * به بانک ملت ارسال کنید و پاسخ آن را دریافت کنید.
	 *
	 * @param array $params : اطلاعات دریافتی از درگاه پرداخت
	 *
	 * @return  void
	 *
	 * @since   2014-12-10
	 * @author  Ahmad Rezaei <info@freescript.ir>
	 */
	public function verifyPayment($params) 
	{
		$client = new nusoap_client( 'https://bpm.shaparak.ir/pgwchannel/services/pgw?wsdl' ) ;
		$orderId = $params["SaleOrderId"];
		$verifySaleOrderId = $params["SaleOrderId"];
		$verifySaleReferenceId = $params['SaleReferenceId'];
		$err = $client->getError();
		if ($err) {
			echo '<h2>Constructor error</h2><pre>' . $err . '</pre>';
			die();
		}	  
		$parameters = array(
			'terminalId'=> $this->terminal, 
			'userName'=> $this->username, 
			'userPassword'=> $this->password, 
			'orderId' => $orderId,
			'saleOrderId' => $verifySaleOrderId,
			'saleReferenceId' => $verifySaleReferenceId);
		$result = $client->call('bpVerifyRequest', $parameters, 'http://interfaces.core.sw.bps.com/');
		if ($client->fault) {
			echo '<h2>Fault</h2><pre>';
			print_r($result);
			echo '</pre>';
			die();
		} 
		else {
			$resultStr = $result;	
			$err = $client->getError();
			if ($err) {
				echo '<h2>Error</h2><pre>' . $err . '</pre>';
				die();
			} 
			else {
				if( $resultStr == '0' ) {
					return true;
				}
			}
		}
		return false;
	}
	
	
	/**
	 * تابع درخواست تصفیه حساب
	 * با استفاده از این تابع میتوانید درخواست تصفیه حساب
	 * را به بانک ملت ارسال و نتیجه آن را دریافت کنید.
	 *
	 * @param array $params : اطلاعات دریافتی از درگاه پرداخت
	 *
	 * @return  void
	 *
	 * @since   2014-12-10
	 * @author  Ahmad Rezaei <info@freescript.ir>
	 */
	public function settlePayment($params) 
	{
		$client = new nusoap_client( 'https://bpm.shaparak.ir/pgwchannel/services/pgw?wsdl' ) ;
		$orderId = $params["SaleOrderId"];
		$settleSaleOrderId = $params["SaleOrderId"];
		$settleSaleReferenceId = $params['SaleReferenceId'];
		$err = $client->getError();
		if ($err) {
			echo '<h2>Constructor error</h2><pre>' . $err . '</pre>';
			die();
		}		  
		$parameters = array(
			'terminalId'=> $this->terminal, 
			'userName'=> $this->username, 
			'userPassword'=> $this->password, 
			'orderId' => $orderId,
			'saleOrderId' => $settleSaleOrderId,
			'saleReferenceId' => $settleSaleReferenceId);
		$result = $client->call('bpSettleRequest', $parameters, 'http://interfaces.core.sw.bps.com/');
		if ($client->fault) {
			echo '<h2>Fault</h2><pre>';
			print_r($result);
			echo '</pre>';
			die();
		} 
		else {
			$resultStr = $result;	
			$err = $client->getError();
			if ($err) {
				echo '<h2>Error</h2><pre>' . $err . '</pre>';
				die();
			} 
			else {
				if( $resultStr == '0' ) {
					return true;
				}
				return $resultStr ;
			}
		}
		return false;
	}
	
	
	/**
	 * تابع بررسی ترانش
	 * با استفاده از این تابع میتوانید درخواست تایید و تصفیه حساب را 
	 * ارسال کنید و از نتیجه آن آگاه شوید.
	 *
	 * @param array $params : اطلاعات دریافتی از درگاه پرداخت
	 *
	 * @return  void
	 *
	 * @since   2014-12-10
	 * @author  Ahmad Rezaei <info@freescript.ir>
	 */
	public function checkPayment($params) 
	{
		$params["RefId"] = $params["RefId"] ;
		$params["ResCode"] = $params["ResCode"] ;
		$params["SaleOrderId"] = $params["SaleOrderId"] ;
		$params["SaleReferenceId"] = $params["SaleReferenceId"] ;
		if( $params["ResCode"] == 0 ) 
		{
			if( $this->verifyPayment($params) == true ) {
				if( $this->settlePayment($params) == true ) {
					return array(
						"status"=>"success", 
						"trans"=>$params["SaleReferenceId"],
                                                "order_id"=>$params["SaleOrderId"]
					);
				}
			}
		}
		return false;
	}	
	
	
	protected function postRefId($refIdValue) 
	{
		echo '<script language="javascript" type="text/javascript"> 
				function postRefId (refIdValue) {
				var form = document.createElement("form");
				form.setAttribute("method", "POST");
				form.setAttribute("action", "https://bpm.shaparak.ir/pgwchannel/startpay.mellat");         
				form.setAttribute("target", "_self");
				var hiddenField = document.createElement("input");              
				hiddenField.setAttribute("name", "RefId");
				hiddenField.setAttribute("value", refIdValue);
				form.appendChild(hiddenField);
	
				document.body.appendChild(form);         
				form.submit();
				document.body.removeChild(form);
			}
			postRefId("' . $refIdValue . '");
			</script>';
	}
	
	
	protected function error($number) 
	{
		$err = $this->response($number);
		echo '<!doctype html><html><head><meta charset="utf-8"><title>خطا</title></head><body dir="rtl">';
		echo '<style>div.error{direction:rtl;background:#A80202;float:right;text-align:right;color:#fff;';
		echo 'font-family:tahoma;font-size:13px;padding:3px 10px}</style>';
		echo '<div class="error"><strong>خطا</strong> : ' . $err . '</div>';
		die ;
	}
	
	
	
	protected function response($number) 
	{
		switch($number) {
			case 11 :
				$err = "شماره کارت نامعتبر است!";	
				break;
			case 12 :
				$err = "موجودی کافی نیست";	
				break;
			case 13 :
				$err = "رمز نادرست است";	
				break;
			case 14 :
				$err = "تعداد دفعات وارد کردن رمز بیش از حدمجاز است.";	
				break;
			case 15 :
				$err = "کارت نامعتبر است.";	
				break;
			case 16 :
				$err = "دفعات برداشت وجه بیش از حدمجاز است.";	
				break;
			case 17 :
				$err = "کاربر از انجام تراکنش منصرف شده است.";	
				break;
			case 18 :
				$err = "تاریخ انقضای کارت گذشته است.";	
				break;
			case 19 :
				$err = "مبلغ برداشت وجه بیش از حدمجاز است.";	
				break;
			case 111 :
				$err = "صادرکننده کارت نامعتبر است.";	
				break;
			case 112 :
				$err = "خطای سوییچ صادرکننده کارت.";	
				break;
			case 113 :
				$err = "پاسخی از صادرکننده کارت دریافت نشد.";	
				break;
			case 114 :
				$err = "دارنده کارت مجاز به انجام این تراکنش نیست.";	
				break;
			case 112 :
				$err = "خطای سوییچ صادرکننده کارت.";	
				break;
			case 31 :
				$err = "پاسخ نامعتبر است!";	
				break;
			case 17 :
				$err = "کاربر از انجام تراکنش منصرف شده است!";
				break;
			case 21 :
				$err = "پذیرنده نامعتبر است!";
				break;
			case 23 :
				$err = "خطای امنیتی رخ داده است!";
				break;
			case 24 :
				$err = "اطلاعات کاربری پذیرنده نامعتبر است!";
				break;
			case 25 :
				$err = "مبلغ نامعتبر است!";
				break;
			case 31 :
				$err = "پاسخ نامعتبر است!";
				break;
			case 32 :
				$err = "فرمت اطلاعات وارد شده صحیح نمی باشد!";
				break;
			case 33 :
				$err = "حساب معتبر نمی باشد!";
				break;
			case 34 :
				$err = "خطای سیستمی!";
				break;
			case 35 :
				$err = "تاریخ نامعتبر است!";
				break;
			case 41 :
				$err = "شماره درخواست تکراری است!";
				break;
			case 43 :
				$err = "قبلا درخواست verify داده شده است!";
				break;
			case 44 :
				$err = "درخواست Verify یافت نشد!";
				break;
			case 45 :
				$err = "تراکنش settle شده است!";
				break;
			case 46 :
				$err = "تراکنش settle نشده است!";
				break;
			case 47 :
				$err = "تراکنش settleیافت نشد !";
				break;
			case 412 :
				$err = "شناسه قبض نادرست است!";
				break;
			case 413 :
				$err = "شناسه پرداخت نادرست است!";
				break;
			case 414 :
				$err = "سازمان صادرکننده قبض نامعتبر است!";
				break;
			case 415 :
				$err = "زمان جلسه کاری به پایان رسیده است!";
				break;
			case 416 :
				$err = "خطا در ثبت اطلاعات!";
				break;
			case 417 :
				$err = "شناسه پرداخت کننده نامعتبر است!";
				break;
			case 418 :
				$err = "اشکال در تعریف اطلاعات مشتری!";
				break;
			case 419 :
				$err = "تعداد دفعات ورود اطلاعات از حد مجاز گذشته است!";
				break;
			case 421 :
				$err = "آی پی نامعتبر است!";
				break;
			case 412 :
				$err = "شناسه قبض نادرست است!";
				break;
			case 54 :
				$err = "تراکنش مرجع موجود نیست!";
				break;
			case 55 :
				$err = "تراکنش نامعتبر است!";
				break;
			case 61 :
				$err = "خطا در واریز!";
				break;
			
		}
		return $err ;
	}


}