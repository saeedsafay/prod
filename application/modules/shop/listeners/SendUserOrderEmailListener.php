<?php
(defined('BASEPATH')) or exit('No direct script access allowed');

use Symfony\Contracts\EventDispatcher\Event;

class SendUserOrderEmailListener
{

    public function handle(Event $event)
    {
        if ( ! $event->invoice->user->email) {
            return true;
        }

        try {
            list($path, $orderEmail) = Modules::find('OrderEmail', 'shop', 'notifications/');
            Modules::load_file($orderEmail, $path);

            $orderEmail = new OrderEmail($event->invoice->user->email, $event->invoice->toArray());
            send_email($orderEmail->toMailable());
        } catch (Throwable $e) {
            log_exception($e);
        }
        return true;
    }
}