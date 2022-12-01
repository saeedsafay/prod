<?php

use Symfony\Contracts\EventDispatcher\Event;

class UpdateCookieListener
{

    public function handle(Event $event)
    {
        $ci =& get_instance();
        $ci->load->helper('cookie');

        $cookie = array(
            "name" => 'id_tracker_global',
            "value" => $event->product->id,
            "expire" => 100000000,
            "secure" => false
        );
        $ci->input->set_cookie($cookie);
        return true;
    }
}