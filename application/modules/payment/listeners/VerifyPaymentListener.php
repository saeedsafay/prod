<?php


use Symfony\Contracts\EventDispatcher\Event;

class VerifyPaymentListener
{

    public function handle(Event $event)
    {
        $ci = &get_instance();
        try {
            $event->transaction->update([
                "transaction_state_id" => 1,
                "payment_track_id" => $event->trackId,
                "description" => $event->message,
            ]);
        } catch (Throwable $e) {
            $ci->monolog->critical(
                "error verifying payment for the Transaction #{$event->transaction->id} and Cart #{$event->transaction->order_id}: {$e->getMessage()}"
            );
            $event->stopPropagation();
            $ci->message->set_message(
                "خطا در تایید پرداخت. لطفا موضوع را با پشتیبانی سایت اطلاع دهید. شناسه سفارش: {$event->transaction->order_id} - شماره رهگیری تراکنش: {$event->trackId} ",
                'fail',
                'خطای تایید تراکنش',
                '/orders')->redirect();
        }
        return true;
    }

}