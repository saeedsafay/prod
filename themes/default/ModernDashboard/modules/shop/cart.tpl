
{add_js file='js/cart.js' part='footer'}
<!-- cart-main-area start -->
<div class="cart-main-area pt-30">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <form action="#">               
                    <div class="table-content table-responsive">
                        {if $CartItems->isEmpty()}
                            <div class="cart-img-details">                                                                                    <div class="cart-img-contaent">
                                    <h4 style="padding: 20px;">سبد خرید شما خالی است</h4>
                                    <div class="col-md-12 col-lg-12 col-sm-12">
                                        <img width="50%" style="margin-right: 27%;"
                                             src="{assets_url}images/cart-abandonment.png"/>
                                    </div>
                                </div>
                            </div>
                        {else}
                            <h4 class="title_row">سبد خرید شما</h4><br><hr><br>
                            <table>
                                <thead>
                                    <tr>
                                        <th class="">تصویر</th>
                                        <th class="">عنوان کالا</th>
                                        <th class="">قیمت</th>
                                        <th class="">تعداد</th>
                                        <th class="">مجموع</th>
                                        <th class="">حذف از سبد خرید</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {assign var=subTotal value=0}
                                    {foreach from=$CartItems item=Item}
                                        <tr id="cartItem{$Item.id}">
                                            <td class="product-thumbnail">
                                                <a href="/product/npi-{$Item.id}/{$Item.slug}">
                                                    <img src="{site_url()|con:'upload/ads/pic/':$Item.pic}" alt="{$Item.title}" />
                                                </a>
                                            </td>
                                            <td class="">
                                                <a href="{site_url()}product/{$Item.slug}">
                                                    {$Item.title}
                                                    {*  {if $Item.pivot.color != ""}
                                                    ( {$Item.pivot.color})
                                                    {/if}*}
                                                </a>
                                            </td>
                                            <td class=""><span class="amount">{$Item.price|price_format}</span></td>
                                            <td class="">{$Item.pivot.qty|persian_number} (کیلوگرم)</td>
                                            <td class="">{($Item.price * $Item.pivot.qty)|price_format}</td>
                                            <td class="product-remove"><a href="#" onclick="$(this).removeCartItem({$Item.id});">X</a></td>
                                        </tr>
                                        {assign var=subTotal value=$subTotal+($Item.price * $Item.pivot.qty)}
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>
                        <div class="row">
                            <div class="col-md-8 col-sm-7 col-xs-12 pull-right rtl">
                                <div class="buttons-cart rtl">
                                    {*                                    <input type="submit" value="Update Cart" />*}
                                    <a class="pull-right" href="{site_url()}cats/آجیل">ادامه خرید</a>
                                </div>
                                <div class="coupon pull-right">
                                    <h3>کوپن تخفیف</h3>
                                    <p>اگر کد تخفیف یا هدیه دارید، در این قسمت وارد کنید.</p>
                                    <input id="coupon_code" type="text" placeholder="کد تخفیف یا هدیه" />
                                    <div class="buttons-cart rtl">
                                        <a id="do_coupon" href="#">اعمال کوپن</a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-5 col-xs-12 table-content table-responsive">
                                <div class="">
                                    <h3>مجموع</h3>
                                    <table>
                                        <tbody>
                                            <tr class="cart-subtotal">
                                                <th>مجموع سفارش</th>
                                                <td><span class="amount">{$subTotal|price_format}</span></td>
                                            </tr>
                                            <tr class="shipping">
                                                <th>حمل و نقل</th>
                                                <td>
                                                    <ul id="shipping_method">

                                                        {foreach from=$shippings item=shipping}
                                                            <li>
                                                                <input id="shipping{$shipping.id}" type="radio" name="shipping"/> 
                                                                <label for="shipping{$shipping.id}">
                                                                    {$shipping.shipping} <span class="amount">{$shipping.price}</span>
                                                                </label>
                                                            </li>
                                                        {/foreach}
                                                    </ul>
                                                </td>
                                            </tr>
                                            <tr class="order-total">
                                                <th>مجموع فاکتور</th>
                                                <td>
                                                    <strong>
                                                        <span class="amount">
                                                            {$subTotal|price_format}
                                                        </span>
                                                    </strong>
                                                </td>
                                            </tr>											
                                        </tbody>
                                    </table>
                                    <div class="wc-proceed-to-checkout">
                                        {if !$is_logged_in}
                                            <a href="{site_url()}shop/checkout">نهایی کردن خرید</a>
                                        {else}
                                            <a href="{site_url()}shop/payment">بازبینی و پرداخت</a>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/if}
                </form> 
            </div>
        </div>
    </div>
</div>
<!-- cart-main-area end -->
