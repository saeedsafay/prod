<?php

(defined('BASEPATH')) or exit('No direct script access allowed');

use Illuminate\Database\Eloquent\Model;

require_once APPPATH."modules/shop/models/Product.php";

class CartConcerns
{

    private $ci;

    public function __construct($CI)
    {
        $this->ci = $CI;
    }


    /**
     * @param  \Illuminate\Database\Eloquent\Model  $cart
     * @param  bool  $onlyTotal
     * @return int
     * @throws \Exception
     */
    public function getCartTotal(Model $cart, $onlyTotal = false)
    {
        $result['total_with_discount'] = 0;
        $result['total'] = 0;
        try {
            foreach ($cart->varients as $variant) {
                if ($variant->status != 1 || $variant->stock == 0) {
                    log_message("info", "Variant ID #$variant->id is out of stock or deactivated.");
                    continue;
                }

                if ($variant->product->child_category->variants_as_package) {
                    $qty = 1;
                } else {
                    $qty = $variant->pivot->qty;
                }

                $result['total'] += $variant->price * $qty;
            }
            if ($cart->product_coupons_id) {
                $result['total_with_discount'] = $result['total'] - (($cart->coupon->discount / 100) * $result['total']);
            }
            if ($onlyTotal) {
                return $result['total_with_discount'] > 0 ? $result['total_with_discount'] : $result['total'];
            }
            return $result;
        } catch (Throwable $e) {
            log_exception($e);
            throw new Exception($e->getMessage());
        }
    }

    /**
     * @param  array  $cart
     * @param  bool  $onlyTotal
     * @return float|int
     * @throws \Exception
     */
    public function getSessionCartTotal(array $cart, $onlyTotal = false)
    {
        $result['total_with_discount'] = 0;
        $result['total'] = 0;
        try {
            foreach ($cart as $item) {
                $item['diversity_data']->fill(['pivot' => ['qty' => $item['qty']]]);
                $cartItems[] = $item['diversity_data'];

                if ($item['diversity_data']->status != 1 || $item['diversity_data']->stock == 0) {
                    log_message("info", "Variant ID #{$item['diversity_data']->id} is out of stock or deactivated.");
                    continue;
                }

                if ($item['diversity_data']->product->child_category->variants_as_package) {
                    $qty = 1;
                } else {
                    $qty = $item['qty'];
                }

                $result['total'] += $item['diversity_data']->price * $qty;
            }
            $cartDiscount = $this->ci->session->userdata('session_cart_discount');
            if (isset($cartDiscount['discount']) && $cartDiscount['discount'] > 0) {
                $result['total_with_discount'] = $result['total'] - (($cartDiscount['discount'] / 100) * $result['total']);
            }
            if ($onlyTotal) {
                return $result['total_with_discount'] > 0 ? $result['total_with_discount'] : $result['total'];
            }
            return $result;
        } catch (Throwable $e) {
            log_exception($e);
            throw new Exception($e->getMessage());
        }

    }

    /**
     * @param  \Cart  $cart
     * @return float|int
     * @throws \Exception|\Throwable
     */
    public function assessOrderBeforePayment(Cart $cart)
    {
        $amount = $this->getCartTotal($cart, true);
        if ($amount / 10 < 1000) {
            show_flash_message("مبلغ تراکنش باید بیشتر از 1000 تومان باشد."
                , "fail"
                , "/shop/cart"
            );
        }
        // submit the unit prices that should be paid and log in orders
        try {
            foreach ($cart->varients as $varient) {
                if ($varient->stock < $varient->pivot->qty) {
                    $this->ci->monolog->warning("QTY out of stock variant ID #{$varient->id} at cart #{$cart->id}");
                    throw new InvalidArgumentException("تنوع با شناسه {$varient->id} به تعداد درخواستی موجود نیست");
                }
                if ( ! $varient->status) {
                    $this->ci->monolog->warning("Inactive shopping cart variant ID #{$varient->id} at cart #{$cart->id}");
                    throw new InvalidArgumentException("تنوع با شناسه {$varient->id} غیر فعال است ");
                }
                $varient->pivot->unit_price = $varient->price;
                $varient->pivot->save();
            }
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
        return $amount;
    }


    /**
     * @param $sessionCart
     * @return \Illuminate\Support\Collection
     */
    public function prepareSessionCart($sessionCart)
    {

        $cartItems = collect([]);
        foreach ($sessionCart as $item) {
            $item['diversity_data']->fill([
                    'pivot' => array_merge(['qty' => $item['qty']], $item['variant_pivot_data'])
                ]
            );
            $cartItems[] = $item['diversity_data'];
        }
        return $cartItems;
    }

    /**
     * @return \Illuminate\Database\Eloquent\Builder|\Illuminate\Database\Eloquent\Model|object|null
     * @throws \Throwable
     */
    public function getCart()
    {
        try {
            return Cart::query()->where('user_id', $this->ci->user->id)->where('status', 0)
                ->with('varients.fields.value', 'varients.product.child_category')
                ->first();
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
    }

    public function getSessionCart()
    {
        try {
            return $this->ci->session->userdata('session_cart');
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
    }

    /**
     * @throws \Throwable
     */
    public function checkDiscountMaxPurchase()
    {
        $redirect = false;
        if (isset($this->ci->user->id)) {
            $cart = $this->getCart();
            if ($cart->coupon) {
                if ($cart->coupon->max_purchase_amount < $this->getCartTotal($cart)['total']) {
                    $this->ci->monolog->info("max purchase amount overflow for cart id #{$cart->id}. coupon_id: {$cart->coupon->id}");
                    $cart->product_coupons_id = null;
                    $cart->save();
                    $this->ci->message->set_message(
                        "کد تخفیف برای خرید تا سقف {$cart->coupon->max_purchase_amount} ریال معتبر است. اما می توانید مجدد از آن استفاده کنید.",
                        'warning',
                        'تخفیف اعمال شده برداشته شد',
                        '/shop/cart'
                    )->redirect();
                }
            }
        } else {
            if ($sessionDiscount = $this->ci->session->userdata('session_cart_discount')) {
                $cart = $this->getSessionCart();
                if ($this->getSessionCartTotal($cart)['total'] > $sessionDiscount['max_purchase_amount']) {
                    $this->ci->monolog->info("max purchase amount overflow for session cart. coupon_id: {$sessionDiscount['coupon_id']}");
                    $this->ci->session->unset_userdata('session_cart_discount');
                    $this->ci->message->set_message(
                        "کد تخفیف برای خرید تا سقف {$sessionDiscount['max_purchase_amount']} ریال معتبر است. اما می توانید مجدد از آن استفاده کنید.",
                        'warning',
                        'تخفیف اعمال شده برداشته شد',
                        '/shop/cart'
                    )->redirect();
                }
            }
        }
    }


    /**
     * @param $cart
     * @param $date
     * @return bool|int
     * @throws \Exception|\Throwable
     */
    public function verifyOrder($cart, $date)
    {
        try {
            // update cart and settle the order
            $this->ci->monolog->info("verify order at {$date}", $cart->toArray());
            if ($cart->update([
                "pay_at" => date("Y-m-d H:i:s", $date),
                "status" => 1,
            ])) {
                $this->redeemDiscountCode($cart);
                $this->ci->session->unset_userdata("session_cart");
                load_events('shop', 'OrderPlacedEvent');
                event(new OrderPlacedEvent($cart));
                return true;
            }
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
        $exception = new Exception("Verifying order operation failed for the cart id {$cart->id}", 500);
        log_exception($exception);
        throw $exception;
    }

    /**
     * @param $cart
     * @return bool
     * @throws \Throwable
     */
    private function redeemDiscountCode($cart)
    {
        try {
            // exclusive codes redeem for the cart
            if ($cart->coupon && $cart->coupon->user_id == $cart->user_id) {
                $this->ci->monolog->info('redeem exclusive discount:', $cart->toArray());
                $cart->coupon->status = 1;
                $cart->coupon->use_date = date('Y-m-d H:i:s');
                return $cart->coupon->saveOrFail();
            }

            // public codes redeem for the cart
            if ($cart->coupon && ! $cart->coupon->user_id) {
                $this->ci->monolog->info('redeem public discount:', $cart->toArray());
                $cart->coupon->redeemed()->syncWithoutDetaching([
                    $cart->coupon->id => [
                        'cart_id' => $cart->id,
                        'status' => 1,
                        'user_id' => $cart->user_id
                    ]
                ]);
            }
        } catch (Throwable $e) {
            log_exception($e);
            throw $e;
        }
        return true;

    }

    /**
     * @param $coupon
     * @param  null  $cart
     * @return bool
     * @throws \Throwable
     */
    public function applyDiscountCode($coupon, $cart = null)
    {

        try {
            if (isset($this->ci->user->id)) {
                $cart = $cart ? $cart : Cart::activeCart($this->ci->user->id)->first();
                if ($coupon->max_purchase_amount < $this->getCartTotal($cart)['total']) {
                    throw new InvalidArgumentException(
                        "کد تخفیف برای خرید تا سقف {$coupon->max_purchase_amount} ریال معتبر است",
                        422
                    );
                }
                $this->ci->monolog->info("validating discount for cart id #{$cart->id}");
                $this->validateCouponForUser($coupon, $cart);

                $this->ci->monolog->info("validating discount passed. applying the code");
                $cart->update(['product_coupons_id' => $coupon->id]);
            } else {
                $sessionCart = $this->getSessionCart();
                if ($coupon->max_purchase_amount < $this->getSessionCartTotal($sessionCart)['total']) {
                    throw new InvalidArgumentException(
                        "کد تخفیف برای خرید تا سقف {$coupon->max_purchase_amount} ریال معتبر است",
                        422
                    );
                }
                if ($sessionCart) {
                    $this->ci->session->set_userdata('session_cart_discount', [
                        'coupon_id' => $coupon->id,
                        'discount' => $coupon->discount,
                        'max_purchase_amount' => $coupon->max_purchase_amount,
                    ]);
                }
            }
        } catch (Throwable $e) {
            throw $e;
        }
        return true;
    }


    /**
     *
     * @param $coupon
     * @param $cart
     */
    private function validateCouponForUser($coupon, $cart)
    {

        try {
            $this->ci->monolog->info('validating discount for coupon:', $coupon->toArray());
            if ($coupon->validity_type == Coupon::FIRST_ORDER_VALIDITY_TYPE) {

                $oldOrderCount = Cart::query()->where('user_id', $cart->user_id)
                    ->where('status', '>', 0)->count('id');

                if ($cart->redeemed->isNotEmpty() || $oldOrderCount) {

                    $this->ci->monolog->warning("Invalid discount code for cart #{$cart->id} and coupon #{$coupon->id}");
                    throw new InvalidArgumentException(
                        "کد تخفیف قبلا استفاده شده و یا فقط برای اولین خرید معتبر است", 422
                    );
                }
            }
            if ($coupon->validity_type == Coupon::TIME_VALIDITY_TYPE) {
                // TODO to be implemented
            }
        } catch (Throwable $e) {
            throw $e;
        }
        return true;
    }
}
