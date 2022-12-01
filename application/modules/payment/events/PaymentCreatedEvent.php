<?php

use Symfony\Contracts\EventDispatcher\Event;

/**
 * The cart.item.added event is dispatched each time an cart item is created or added
 * in the system.
 */
class PaymentCreatedEvent extends Event
{
    public const NAME = 'payment.created';
    public $transId;
    public $userCart;
    public $amount;
    /**
     * @var mixed|string
     */
    public $description;

    /**
     * ProductIsViewed constructor.
     * @param $transId
     * @param $userCart
     * @param $amount
     * @param  string  $description
     */
    public function __construct($transId, $userCart, $amount, $description = '')
    {
        $this->transId = $transId;
        $this->userCart = $userCart;
        $this->amount = $amount;
        $this->description = $description;
    }
}