<?php


use Symfony\Contracts\EventDispatcher\Event;

class SendSupportOrderEmailListener
{

    public function handle(Event $event)
    {
        $ci =& get_instance();
        return true;
    }
}