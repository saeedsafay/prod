<?php


use Symfony\Contracts\EventDispatcher\Event;

class SendTelegramFailedPaymentListener
{

    public function handle(Event $event)
    {
        try {
            $user = $event->transaction->user->full_name;
            $message = 'یه پرداختی ناموفق داریم :(';
            $message .= ' تراکنش با شناسه %1$d و به مبلغ %2$s ریال ناموفق بود. علت: %3$s ';
            $message .= ' کاربر: %4$s';
            $message = sprintf(
                $message,
                $event->transaction->id,
                $event->transaction->amount,
                $event->message,
                $user
            );
            (new Logger())->channel('telegram')->critical($message);
            return true;
        } catch (Throwable $e) {
            log_exception($e);
            return null;
        }
    }
}