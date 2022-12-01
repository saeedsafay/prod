<?php
(defined('BASEPATH')) or exit('No direct script access allowed');

use Symfony\Contracts\EventDispatcher\Event;

class SendUserOrderSMSListener
{

    public function handle(Event $event)
    {
        if ( ! $event->invoice->user->mobile) {
            return true;
        }

        try {
            $sms = new Sms($event->invoice->user->mobile);
            if ($sms->send(
                [
                    "Parameter" => "InvoiceID",
                    "ParameterValue" => $event->invoice->id
                ],
                Sms::ORDER_PLACED
            )) {
                return true;
            }
        } catch (Throwable $e) {
            log_exception($e);
        }
        return true;
    }
}