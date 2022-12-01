<?php

use Symfony\Contracts\EventDispatcher\Event;

class AddProductViewCountListener
{

    public function handle(Event $event)
    {
        $ci =& get_instance();
        $ci->load->helper('cookie');
        $check_visitor = $ci->input->cookie('PRD'.$event->product->id, false);
        $ip = $ci->input->ip_address();
        if ($check_visitor == false) {
            $cookie = array(
                "name" => 'PRD'.$event->product->id,
                "value" => "$ip",
                "expire" => 300,
                "secure" => false
            );
            $ci->input->set_cookie($cookie);
            //update counter
            $event->product->visit_counts += 1;
            $event->product->save();
        }
        return true;
    }
}