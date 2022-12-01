<?php


use Symfony\Contracts\EventDispatcher\Event;

class SendSlackNewRegisterListener
{

    public function handle(Event $event)
    {
        try {
            $user = $event->user->first_name.' '.$event->user->last_name;
            $message = 'کاربر جدیدی تو سایت ثبت نام کرد :)';
            $message .= 'نام کاربر: %1$s ';
            $message = sprintf(
                $message,
                $user
            );
            (new Logger())->channel('slack')->critical($message);
            return true;
        } catch (Throwable $e) {
            log_exception($e);
            return null;
        }
    }
}