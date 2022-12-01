<?php

use Monolog\Handler\StreamHandler;
use Monolog\Logger as MonologLogger;

/**
 * Class Logger
 * @author Saeid Tavakoli
 */
class Logger
{

    public $logger;

    public function __construct($handler = null)
    {
        $this->logger = new MonologLogger($_ENV['APP_NAME'].'-logger');
        if ($handler) {
            $this->logger->pushHandler($handler);
            return $this->logger;
        }
        $handlers = config('log_handlers');
        foreach ($handlers as $channelName => $handler) {
            if ( ! $handler['enabled']) {
                continue;
            }
            $this->logger = $this->initHandler($channelName, $handler);
        }
    }

    private function initHandler($handler, $data, $logger = null)
    {
        if ( ! $logger) {
            $logger = $this->logger;
        }

        $logFile = '/log-'.date('Y-m-d').'.log';
        $logPath = config('monolog_log_path').$logFile;
        switch ($handler) {
            case 'slack':
                $slack = new \Monolog\Handler\SlackWebhookHandler(
                    $data['url'],
                    $data['channel'],
                    $data['username'],
                    true,
                    $data['emoji'],
                    false,
                    true,
                    $data['level']
                );
                $formatter = new \Monolog\Formatter\LineFormatter(
                    "[%datetime%]: %message% \n %context% %extra%\n",
                    "Y-m-d H:i:s"
                );
                return $logger->pushHandler($slack->setFormatter($formatter));
            case 'daily':
                $strem = new StreamHandler($logPath, $data['level']);
                $formatter = new \Monolog\Formatter\LineFormatter(
                    "[%datetime%]-%level_name%: %message% \n %context% %extra%\n",
                    "Y-m-d H:i:s"
                );
                return $logger->pushHandler($strem->setFormatter($formatter));
            case 'telegram':
                $telegram = new \Monolog\Handler\TelegramBotHandler(
                    $data['token'],
                    $data['channel'],
                    $data['level'],
                    true,
                    null,
                    false,
                    false
                );
                $telegram->setFormatter(new \Monolog\Formatter\LineFormatter(
                    "%message% \n",
                    "Y-m-d H:i"
                ));
                return $logger->pushHandler($telegram);
        }
    }

    public function channel(string $channel)
    {
        return $this->initHandler($channel, config('log_handlers')[$channel], new MonologLogger($channel));
    }

}