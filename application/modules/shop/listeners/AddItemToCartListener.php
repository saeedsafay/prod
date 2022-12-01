<?php

use Symfony\Contracts\EventDispatcher\Event;

class AddItemToCartListener
{

    public function handle(Event $event)
    {
        log_message("info", self::class.' has been reached with user id = '.$event->userId);
        try {
            $attributes = [
                'user_id' => $event->userId,
                'status' => 0
            ];
            $cart = Cart::query()->where($attributes)->firstOrCreate($attributes);
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }

        try {
            $cart->varients()->syncWithoutDetaching([
                $event->diversityData->id => array_merge([
                    'product_id' => $event->diversityData->product->id,
                    'qty' => $event->qty,
                    'shop_id' => $event->diversityData->product->user_id
                ], $event->variantPivotData)
            ]);
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
    }
}