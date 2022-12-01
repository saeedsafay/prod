<?php

use Illuminate\Database\Eloquent\ModelNotFoundException;
use Symfony\Contracts\EventDispatcher\Event;

class PortSessionCartToDatabaseCartListener
{


    public function handle(Event $event)
    {

        $ci = &get_instance();
        $ci->monolog->debug(self::class.' has been reached with user id = '.$event->user->id);
        $sessionCart = $ci->session->userdata('session_cart');
        try {
            // check if there is a session cart really
            if ($sessionCart === null || ! is_array($sessionCart) || count($sessionCart) < 1) {
                return true;
            }
            $sessionCartDiscount = $ci->session->userdata('session_cart_discount');
            // by the way find the open cart if already exists for the logged in user
            $cart = Cart::where([
                'user_id' => $event->user->id,
                'status' => 0
            ])->firstOrFail();
        } catch (ModelNotFoundException $e) {
            // or crate one ...
            $cart = Cart::create([
                'user_id' => $event->user->id,
                'status' => 0
            ]);
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }

        try {
            // assign the variant data to the cart
            $this->attachCartItems($cart, $sessionCart);
            // apply discount code
            if (isset($sessionCartDiscount['coupon_id'])) {
                $this->applyDiscountCode($cart, $sessionCartDiscount, $event->user->id);
            }
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
        return true;
    }

    /**
     * @param $cart
     * @param $sessionCart
     * @return bool
     * @throws \Throwable
     */
    private function attachCartItems($cart, $sessionCart)
    {

        try {
            foreach ($sessionCart as $item) {
                $cart->varients()->sync([
                    $item['diversity_data']->id => array_merge([
                        'product_id' => $item['product_id'],
                        'qty' => $item['qty'],
                        'shop_id' => $item['shop_id']
                    ], $item['variant_pivot_data'])
                ], false);
            }
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
        return true;
    }

    /**
     * @param $cart
     * @param $sessionCartDiscount
     * @param $userId
     * @return false
     * @throws \Throwable
     */
    private function applyDiscountCode($cart, $sessionCartDiscount, $userId)
    {
        try {
            $coupon = Coupon::query()->where('status', 0)->findOrFail($sessionCartDiscount['coupon_id']);
            if ($coupon->user_id && $userId != $coupon->user_id) {
                return false;
            }
            $ci = &get_instance();
            return $ci->cartConcern->applyDiscountCode($coupon, $cart);
        } catch (Throwable $e) {
            log_exception($e);
            return null;
        }
    }
}