<?php
(defined('BASEPATH')) or exit('No direct script access allowed');

class VerifyNewsletterEmail
{

    public $route;
    public $subject;
    public $view;
    public $data;

    public function __construct($route, $newsletter, $subject = null, $view = null)
    {
        try {
            $ci = &get_instance();
            $this->route = $route;
            $this->data = $newsletter->toArray();
            $this->data['user'] = $newsletter['user'];
            $this->data['action'] = true;
            $this->data['actionUrl'] = site_url('users/newsletters/verify/'.$newsletter->token);
            $this->data['actionTitle'] = $ci->lang->line("notifications")['users']["verify_email_title"];
            $this->subject = $subject == null ? $ci->lang->line("notifications")['users']['verify_email_subject'] :
                $subject;
            $this->view = $view == null ? "emails/verify_email.php" : $view;
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
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