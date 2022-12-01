<?php

use Symfony\Contracts\EventDispatcher\Event;

class VerifyOrderListener
{

    public function handle(Event $event)
    {
        $ci = &get_instance();
        try {
            $ci->cartConcern->verifyOrder($event->transaction->cart, $event->verifyDate);
        } catch (Throwable $e) {
            $ci->monolog->critical(
                "error verifying order for the Transaction #{$event->transaction->id} and Cart #{$event->transaction->order_id}: {$e->getMessage()}"
            );
            $event->stopPropagation();
            $ci->message->set_message(
                "خطا در تایید سفارش. لطفا موضوع را با پشتیبانی سایت اطلاع دهید. شناسه سفارش: {$event->transaction->order_id} - شماره رهگیری تراکنش: {$event->trackId} ",
                'fail',
                'خطای تایید تراکنش',
                '/orders')->redirect();
        }
        return true;
    }

}