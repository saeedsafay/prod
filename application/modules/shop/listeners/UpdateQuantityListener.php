<?php

use Symfony\Contracts\EventDispatcher\Event;

class UpdateQuantityListener
{

    public function handle(Event $event)
    {
        $ci = &get_instance();
        try {
            $ci->productConcern->updateVariantQuantity($event->invoice);
        } catch (Throwable $e) {
            log_message("error",
                "error updating quantity for Cart #{$event->invoice->id}: {$e->getMessage()}");
        }
        return true;
    }

}