<?php


use Symfony\Contracts\EventDispatcher\Event;

class PaymentSuccessEvent extends Event
{

    public const NAME = 'payment.success';

    public $transaction;
    public $trackId;
    public $message;
    public $verifyDate;

    /**
     *
     * @param $transaction
     * @param $trackId
     * @param $verifyDate
     * @param $message
     */
    public function __construct($transaction, $trackId, $verifyDate, $message)
    {
        $this->transaction = $transaction;
        $this->trackId = $trackId;
        $this->verifyDate = $verifyDate;
        $this->message = $message;
    }

}