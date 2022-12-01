<?php

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;
use Illuminate\Database\Eloquent\ModelNotFoundException;

(defined('BASEPATH')) or exit('No direct script access allowed');

class Payments extends Public_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent([
            'Product',
            'Transaction',
        ]);
    }

    /**
     * ایجاد صفحه و فرم مربوط به پرداخت قبل از انتقال به بانک
     */
    public function index()
    {
        $this->checkAuth(true);
        $this->load->eloquent("users/Users_address");
        try {
            $userCart = Cart::where('user_id', $this->user->id)->where('status', 0)->firstOrFail();
        } catch (ModelNotFoundException $e) {
            log_exception($e);
            return redirect("/");
        }
        if ($email = $this->input->post('email')) {
            $userCart->user()->update(['email' => $email]);
        }
        if ($addressId = $this->input->post('delivery_address_id')) {
            $token = hash("sha256", md5($userCart->id.time()));
            $userCart->update(['delivery_address_id' => $addressId, 'token' => $token]);
        } else {
            show_flash_message('آدرس تحویل را تعیین نمایید.', 'warning');
        }

        $coupon = Coupon::where(['cart_id' => $userCart->id, 'status' => 1])->first();
        $this->smart->assign([
            'title' => 'بازبینی نهایی خرید',
            'cart_id' => $userCart->id, //شناسه فاکتور و سبد خرید
            'Cart' => $userCart,
            'delivery' => $userCart->delivery,
            'token' => $token,
            'coupon' => $coupon == null ? 0 : $coupon->discount,
            'transportation_price' => Setting::findByCode('transportation_price')->value,
            'action' => '/payment/payments/gateway/',
        ]);
        $this->smart->view('payment/productPayment');
    }


    /**
     *
     */
    public function gateway()
    {
        $token = $this->input->post("token");
        if ( ! $token) {
            redirect("/");
        }
        try {
            $userCart = Cart::where("token", $token)->with("varients.product.child_category")->firstOrFail();

            $amount = $this->cartConcern->assessOrderBeforePayment($userCart);
        } catch (ModelNotFoundException $e) {

            $this->monolog->error("cart not found for gateway payment for token: $token ");
            redirect("/");
        } catch (Throwable $e) {
            log_exception($e);
            show_flash_message($e->getMessage()
                , "fail"
                , "/shop/cart"
            );
        }

        try {
            $response = $this->request([
                'order_id' => $userCart->id,
                'amount' => $amount,
                'name' => $userCart->user->first_name." ".$userCart->user->last_name,
                'callback' => base_url("payment/payments/verify"),
            ], "payment");
        } catch (GuzzleException $e) {
            log_exception($e);
            show_error($e->getMessage());
        }
        if ($response['response']->getStatusCode() != 201) {

            $this->monolog->error("PAYMENT GATEWAY=> Error code: {$response['response_body']['error_code']} ");
            show_flash_message("خطای درگاه پرداخت. لطفا به پشتیبانی اطلاع دهید"
                , "fail"
                , "/shop/cart"
            );
        }

        $this->monolog->info("PAYMENT created for cart #{$userCart->id}");
        load_events('payment', 'PaymentCreatedEvent');
        event(new PaymentCreatedEvent($response['response_body']['id'], $userCart, $amount, $this->messages(0)));

        $this->monolog->info("Redirecting to payment gateway");
        redirect($response['response_body']['link']);
    }


    /**
     *
     */
    public function verify()
    {
        $data = $this->input->post();
        // waiting for payment confirmation
        $transaction = Transaction::query()
            ->where([
                "trans_id" => $data['id'],
                "amount" => $data['amount'],
                "order_id" => $data['order_id']
            ])->with(
                'cart.varients.fields.value', 'cart.varients.product.child_category',
                'cart.user:id,email,mobile,first_name,last_name')
            ->first();
        if ( ! $transaction || $transaction->transaction_state_id == 1) {

            $this->monolog->error("double spending trans_id = {$data['id']}");
            redirect('/orders');
        }

        // status = 10 pending for verify, 100 = success payment
        if ($data['status'] != 100 && $data['status'] != 10) {
            try {
                load_events('payment', 'PaymentFailedEvent');
                event(new PaymentFailedEvent(
                        $transaction, $data['track_id'], $data['status'], $this->messages($data['status'])
                    )
                );

                $this->monolog->info("failed payment", $data);
                $this->message->set_message(
                    $this->messages($data['status']).". کد وضعیت پرداخت: {$data['status']} شماره رهگیری تراکنش: {$data['track_id']}",
                    'fail',
                    'پرداخت انجام نشد',
                    '/orders')->redirect();
            } catch (Throwable $e) {
                log_exception($e);
                redirect('/orders');
            }
        }

        // verify the payment transaction
        try {
            $response = $this->request([
                'order_id' => $data['order_id'],
                'id' => $data['id'],
            ], "payment/verify");
        } catch (GuzzleException $e) {
            log_exception($e);
            show_error($e->getMessage());
        }

        if ($response['response']->getStatusCode() != 200) {
            $this->monolog->error("Request verify payment error: ", $response);
            $this->message->set_message(
                $this->messages($response['response_body']['status'])." خطا در تایید تراکنش. لطفا موضوع را به پشتیبانی اطلاع دهید",
                'fail',
                'خطا',
                '/orders')->redirect();
        }


        $this->monolog->info("Payment succeeded. loading event listeners", $response);
        load_events('payment', 'PaymentSuccessEvent');
        event(new PaymentSuccessEvent(
            $transaction, $response['response_body']['payment']['track_id'],
            $response['response_body']['verify']['date'], $this->messages(100)
        ));

        $this->message->set_message(
            "پرداخت و ثبت سفارش شما با موفقیت انجام شد. شناسه سفارش: {$transaction->order_id}",
            'success',
            'پرداخت انجام شد',
            '/orders')->redirect();
    }


    private function toUrl($uri)
    {
        return $_ENV["IDPAY_API_URL"].$uri;
    }


    private function request($params, $uri)
    {
        try {
            $client = new Client();
            $response = $client->post($this->toUrl($uri), [
                'timeout' => 10.0,
                'http_errors' => $_ENV['TEST_PAYMENT'],
                'decode_content' => 'application/json',
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept-Encoding' => 'application/json',
                    'X-API-KEY' => $_ENV["IDPAY_API_KEY"],
                    "X-SANDBOX" => $_ENV["TEST_PAYMENT"]
                ],
                'json' => $params
            ]);
            $resBody = json_decode($response->getBody()->getContents(), 1);
        } catch (GuzzleException $e) {
            log_exception($e);
            show_error($e->getMessage());
        } catch (Throwable $e) {
            log_exception($e);
            show_error($e->getMessage());
        }
        return ['response' => $response, 'response_body' => $resBody];
    }

    private function messages($status)
    {
        $msg = [
            0 => "انتقال از سایت به درگاه پرداخت",
            1 => "پرداخت انجام نشده است",
            2 => "پرداخت ناموفق بوده است",
            3 => "خطا رخ داده است",
            4 => "بلوکه شده",
            5 => "برگشت به پرداخت کننده",
            6 => "برگشت خورده سیستمی",
            7 => "انصراف از پرداخت",
            8 => "به درگاه پرداخت منتقل شد",
            10 => "در انتظار تایید پرداخت",
            100 => "پرداخت تایید شده است",
            101 => "پرداخت قبلا تایید شده است",
            200 => "موفق. به دریافت کننده واریز شد",
        ];
        return $msg[$status];
    }


    public function inquiry($orderId, $id)
    {

        try {
            $response = $this->request([
                'order_id' => $orderId,
                'id' => $id,
            ], "payment/inquiry");
        } catch (GuzzleException $e) {
            log_message("error", $e->getMessage());
            show_error($e->getMessage());
        }


        if ($response['response']->getStatusCode() != 200) {
            show_error("Error payment verify. ".$this->messages($response['response_body']['status']));
        }
        dd($response);
    }

}