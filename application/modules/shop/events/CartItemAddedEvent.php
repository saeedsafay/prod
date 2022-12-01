<?php

use Symfony\Contracts\EventDispatcher\Event;

/**
 * The cart.item.added event is dispatched each time an cart item is created or added
 * in the system.
 */
class CartItemAddedEvent extends Event
{
    public const NAME = 'cart.item.added';

    public $userId;
    public $diversityData;
    public $variantPivotData;
    public $qty;

    public function __construct(int $userId, $diversityData, $variantPivotData, $qty)
    {
        $this->userId = $userId;
        $this->diversityData = $diversityData;
        $this->variantPivotData = $variantPivotData;
        $this->qty = $qty;
    }
}