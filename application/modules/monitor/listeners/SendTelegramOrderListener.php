<?php


use Symfony\Contracts\EventDispatcher\Event;

class SendTelegramOrderListener
{

    public function handle(Event $event)
    {
        try {
            $ci =& get_instance();
            $total = $ci->cartConcern->getCartTotal($event->invoice, 1);
            $user = $event->invoice->user->full_name;
            $message = 'سفارش جدید تو سایت گرفتیم!';
            $message .= ' سفارش با شناسه %1$d و به مبلغ %2$s ریال پرداخت و ثبت شد. کاربر سفارش دهنده: %3$s ';
            $message = sprintf($message, $event->invoice->id, number_format($total), $user);
            (new Logger())->channel('telegram')->critical($message);
            return true;
        } catch (Throwable $e) {
            log_exception($e);
            return null;
        }
    }
}