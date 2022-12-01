<?php
(defined('BASEPATH')) or exit('No direct script access allowed');

use Symfony\Contracts\EventDispatcher\Event;

class SendDiscountCouponListener
{

    public function handle(Event $event)
    {
        if ( ! $event->user->mobile) {
            return true;
        }

        $ci =& get_instance();
        $discount = ($ci->productConcern->generateCoupon(['discount' => 30, 'user_id' => $event->user->id]));
        if ( ! $discount) {
            return false;
        }

        $sms = new Sms($event->user->mobile);
        try {
            return $sms->send(
                [
                    "Parameter" => "CouponCode",
                    "ParameterValue" => $discount->code
                ],
                Sms::COUPON_CODE
            );
        } catch (Throwable $e) {
            log_exception($e);
            return false;
        }
    }
}