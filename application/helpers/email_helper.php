<?php

if ( ! function_exists('send_email')) {

    function send_email(Mailable $mailable)
    {
        $ci = &get_instance();

        if ( ! $mailable->getRoute()) {
            throw new InvalidArgumentException("no email address", 400);
        }

        $mailConfig = config_item('mailer');
        $ci->load->library('email', $mailConfig);
        $ci->email->set_newline("\r\n");

        $ci->email->initialize($mailConfig);
        $ci->email->from(
            'noreply@'.getDomain(),
            isset($_ENV['APP_NAME']) ? $_ENV['APP_NAME'] : ""
        );
        $ci->email->to($mailable->getRoute());
        $ci->email->set_header("Reply-To", "noreply@".getDomain());
        $ci->email->set_header("X-Priority", 1);
        $ci->email->set_header("'MIME-Version'", "1.0");
        $ci->email->subject($mailable->getSubject());

        $tplData = $mailable->getVariables();
        $mailViewTpl = $ci->load->theme($mailable->getView(), $tplData, true, 'views/');
        $viewLayout = $ci->load->theme(
            "emails/layout/main.php",
            ['content' => $mailViewTpl, 'user' => $tplData['user']],
            true,
            'views/'
        );
        //        print_r($viewLayout);die;
        $ci->email->message($viewLayout);
        try {
            return $ci->email->send();
        } catch (Exception $e) {
            log_message("error", $e->getMessage());
            throw $e;
        }
    }

}