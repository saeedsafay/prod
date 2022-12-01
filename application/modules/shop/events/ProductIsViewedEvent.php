<?php

use Symfony\Contracts\EventDispatcher\Event;

/**
 * The cart.item.added event is dispatched each time an cart item is created or added
 * in the system.
 */
class ProductIsViewedEvent extends Event
{
    public const NAME = 'product.is.viewed';

    public $product;

    /**
     * ProductIsViewed constructor.
     * @param  \Product  $product
     */
    public function __construct(Product $product)
    {
        $this->product = $product;
    }
}