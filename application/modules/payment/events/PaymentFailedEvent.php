<?php

use Symfony\Contracts\EventDispatcher\Event;

class PaymentFailedEvent extends Event
{

    public const NAME = 'payment.failed';

    public $status;
    public $transaction;
    public $trackId;
    public $message;

    /**
     * PaymentFailedEvent constructor.
     * @param $transaction
     * @param $trackId
     * @param $status int status of payment
     */
    public function __construct($transaction, $trackId, $status, $message)
    {
        $this->transaction = $transaction;
        $this->trackId = $trackId;
        $this->status = $status;
        $this->message = $message;
    }
}