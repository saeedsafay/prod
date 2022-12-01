<?php
(defined('BASEPATH')) or exit('No direct script access allowed');

class OrderEmail
{

    public $route;
    public $subject;
    public $view;
    public $data;

    public function __construct($route, $invoice, $subject = null, $view = null)
    {
        $ci = &get_instance();
        $this->route = $route;
        $this->data = $invoice;
        $this->data['user'] = $invoice['user'];
        $this->data['action'] = true;
        $this->data['actionUrl'] = site_url('orders');
        $this->data['actionTitle'] = $ci->lang->line("notifications")['users']["orders_action_title"];
        $this->subject = $subject == null ? $ci->lang->line("notifications")['users']['order_placed_subject'] : $subject;
        $this->view = $view == null ? "emails/order_placed.php" : $view;
    }

    public function toMailable()
    {
        return (new Mailable())
            ->route($this->route)
            ->subject($this->subject)
            ->view($this->view)
            ->variables($this->data);
    }
}