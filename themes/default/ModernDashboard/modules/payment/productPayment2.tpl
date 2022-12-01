
<!-- entry-header-area start -->
<div class="entry-header-area">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="entry-header">
                    <h1 class="entry-title">پرداخت صورتحساب</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- entry-header-area end -->

<!-- checkout-area start -->
<div class="checkout-area">
    <div class="container">
        <div class="row">
            <form action="{$action}">	
                <div class="col-lg-12 col-md-12 col-sm-12">
                    <div class="your-order">
                        <h3>سفارش شما</h3>
                        <div class="your-order-table table-responsive rtl">
                            <table>
                                <thead>
                                    <tr>
                                        <th class="product-name">عنوان</th>
                                        <th class="product-name">قیمت</th>
                                        <th class="product-name">تعداد</th>
                                        <th class="product-total">مجموع</th>
                                    </tr>							
                                </thead>
                                <tbody>
                                    {foreach from=$Cart.products item=val }
                                        <tr class="cart_item">
                                            <td class="product-name">
                                                {$val.title} 
                                            </td>
                                            <td class="product-name">
                                                {$val.price|price_format} 
                                            </td>
                                            <td>
                                                <strong class="product-quantity"> × {$val.pivot.qty|persian_number}</strong>
                                            </td>
                                            <td class="product-total">
                                                <span class="amount">{($val.price * $val.pivot.qty)|price_format}</span>
                                            </td>
                                        </tr>
                                    {/foreach}
                                </tbody>
                                <tfoot>
                                    <tr class="cart-subtotal">
                                        <th style="color: red">مبلغ بن تخفیف </th>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                        <td><span class="discoun" style="color: red">
                                                {$coupon|price_format}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr class="cart-subtotal" style="background-color: #ffffff">
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                        <th>مجموع سبد خرید</th>
                                        <td><span class="amount">{$amount|price_format}</span></td>
                                    </tr>
                                    <tr class="order-total" style="background-color: #c6ffc4;">
                                        <th>&nbsp;</th>
                                        <th>&nbsp;</th>
                                        <th>مجموع قابل پرداخت</th>
                                        <td><strong><span class="amount">{$amount|price_format}</span></strong>
                                        </td>
                                    </tr>								
                                </tfoot>
                            </table>
                        </div>
                        <div class="payment-method">
                            <div class="payment-accordion">
                                <!-- ACCORDION START -->
                                <h3><img src="{assets_url}img/mellat.jpg" alt="بانک ملت"/>درگاه امن بانک ملت </h3>
                                <div class="payment-content">
                                    <p style="direction: rtl">پرداخت از طریق تمامی کارت های بانکی عضو شبکه شتاب. امنیت و اطلاعات محرمانه شما توسط بانک ملت حمایت می شوند.</p>
                                </div>
                                <!-- ACCORDION END -->									
                            </div>
                            <div class="order-button-payment">
                                <input type="submit" value="پرداخت" />
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- checkout-area end -->	
