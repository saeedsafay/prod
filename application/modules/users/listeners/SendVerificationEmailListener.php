<?php
(defined('BASEPATH')) or exit('No direct script access allowed');

use Symfony\Contracts\EventDispatcher\Event;

class SendVerificationEmailListener
{

    public function handle(Event $event)
    {
        if ( ! $event->newsletter->email) {
            return true;
        }

        try {
            list($path, $VerifyNewsletterEmail) = Modules::find('VerifyNewsletterEmail', 'users', 'notifications/');
            Modules::load_file($VerifyNewsletterEmail, $path);

            $VerifyNewsletterEmail = new VerifyNewsletterEmail($event->newsletter->email, $event->newsletter);
            send_email($VerifyNewsletterEmail->toMailable());
        } catch (Throwable $e) {
            log_exception($e);
        }
        return true;
    }
}