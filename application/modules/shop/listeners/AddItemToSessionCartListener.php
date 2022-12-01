<?php

use Symfony\Contracts\EventDispatcher\Event;

class AddItemToSessionCartListener
{

    public function handle(Event $event)
    {
        log_message("info", self::class.' has been reached');
        $ci = &get_instance();
        try {
            $sessionCart = $ci->session->userdata('session_cart')
                ? $ci->session->userdata('session_cart') : [];
            $newItem = [
                $event->diversityData->id => [
                    'product_id' => $event->diversityData->product->id,
                    'shop_id' => $event->diversityData->product->user_id,
                    'diversity_data' => $event->diversityData,
                    'qty' => $event->qty,
                    'variant_pivot_data' => $event->variantPivotData,
                ]
            ];
            $ci->session->set_userdata('session_cart', array_merge($sessionCart, $newItem));
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
        return true;
    }
}