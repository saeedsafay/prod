<?php

use Symfony\Contracts\EventDispatcher\Event;

/**
 * after an order has been placed and verified successfully
 * in the system.
 */
class OrderPlacedEvent extends Event
{
    public const NAME = 'order.placed';

    public $invoice;

    public function __construct($invoice)
    {
        $this->invoice = $invoice;
    }
}