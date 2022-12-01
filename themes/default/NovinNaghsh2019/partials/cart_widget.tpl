<div class="block-minicart dropdown style2">
    <a class="minicart" href="{site_url}shop/cart">
                            <span class="counter qty">
                                <span class="cart-icon"><i class="fa fa-shopping-cart" aria-hidden="true"></i></span>
                                <span class="counter-number js-counter-number">{$CartItems->count()}</span>
                            </span>
        <span class="counter-your-cart">
                                <span class="counter-label"></span>
                                <span class="counter-price"></span>
                            </span>
    </a>
    <div class="parent-megamenu">
        <form>
            <div class="minicart-content-wrapper js-minicart-wrapper">
                <div class="subtitle">
                    تعداد
                    <span class="js-minicart-quantity">{$CartItems->count()}</span>
                    آیتم در سبد خرید شما
                </div>
                <div class="minicart-items-wrapper">
                    <ol class="minicart-items js-minicart-lists">
                        {foreach from=$CartItems item=Item}
                            {if ($Item->product->child_category->variants_as_package)}
                                {$qty = 1}
                            {else}
                                {$qty = $Item.pivot.qty}
                            {/if}
                            <li class="product-inner js-minicart-item clearfix">
                                <div class="product-thumb style1">
                                    <div class="thumb-inner">
                                        <a href="{$Item->product->link}">
                                            <img alt="{$Item.product.title}"
                                                 src="{$products_pic_dir}{$Item.thumbnail}"
                                                 width="80">
                                        </a>
                                    </div>
                                </div>
                                <div class="product-innfo">
                                    <div class="product-name">
                                        <a href="{$Item->product->link}">
                                            {$Item.product.title}
                                        </a>
                                    </div>
                                    <a href="#" onclick="$(this).removeCartItem({$Item.id});"
                                       class="remove" title="حذف این محصول">
                                        <i class="fa fa-times" aria-hidden="true"></i>
                                    </a>
                                    <span class="price price-dark js-price">
                                        <ins>{number_format(($Item.price * $qty))}</ins>
                                        ریال
                                    </span>
                                </div>
                            </li>
                        {/foreach}
                    </ol>
                </div>
                <div class="subtotal">
                    {if $cart_total_discount}
                        <span class="label">تخفیف: {($cart_total-$cart_total_discount)|price_format}</span>
                        <span class="price">جمع کل: {$cart_total_discount|price_format}</span>
                    {else}
                        <span class="price">
                            جمع کل:
                            <strong class="js-minicart-total">{number_format($cart_total)}</strong>
                            ریال
                        </span>
                    {/if}
                </div>
                <div class="actions">
                    <a class="btn btn-viewcart" href="{site_url}shop/cart">سبد خرید</a>
                    {*                                        <a class="btn btn-checkout" href="">Checkout</a>*}
                </div>
            </div>
        </form>
    </div>
</div><!-- block mini cart -->
