<?php

use Symfony\Contracts\EventDispatcher\Event;

/**
 * The session.cart.item.added event is dispatched each time an cart item is created or added
 * in the system.
 */
class SessionCartItemAddedEvent extends Event
{
    public const NAME = 'session.cart.item.added';

    public $diversityData;
    public $variantPivotData;
    public $qty;

    public function __construct($diversityData, $variantPivotData, $qty)
    {
        $this->diversityData = $diversityData;
        $this->variantPivotData = $variantPivotData;
        $this->qty = $qty;
    }
}