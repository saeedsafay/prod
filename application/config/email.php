<?php

$mailer = [
    'mailtrap' => array(
        'protocol' => 'smtp',
        'smtp_host' => 'smtp.mailtrap.io',
        'smtp_port' => 2525,
        'smtp_user' => '7758ebec67b5d2',
        'smtp_pass' => '8ad38f8cb5da54',
        'crlf' => "\r\n",
        'newline' => "\r\n",
        'mailtype' => 'html',
        'priority' => 1
    ),
    'sendmail' => array(
        'mailtype' => 'html',
        'charset' => 'utf-8',
        'protocol' => 'sendmail',
        'priority' => 1,
        'crlf' => "\r\n",
        'newline' => "\r\n",
    )
];

$config['mailer'] = isset($_ENV['MAILER']) ? $mailer[$_ENV['MAILER']] : $mailer['sendmail'];