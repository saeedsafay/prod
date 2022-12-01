<!-- End Bradcaump area -->
<!-- Start Product Details -->
<section class="htc__product__details ptb-100">
    <div class="container">
        <div class="row">
            <h3 style="
                font-size: 27px;
                padding-bottom: 20px;
                text-align: right;
                "> فاکتور خرید</h3>
            <div class="col-md-12">
                <div class="product__top_wrap">
                    <!-- Start product Details -->
                    <form action="{$action}">	
                        <div class="row">
                            <div class="col-md-12 col-lg-12 col-sm-12 single-profuct-thumb">
                                <table class="table listtt rtl">

                                    <tfoot>
                                        <tr class="cart-subtotal">
                                            <th style="text-align:center">عنوان</th>
                                            <th style="text-align:center">قیمت</th>
                                            <th style="text-align:center">تعداد</th>
                                            <th style="text-align:center">مجموع</th>
                                        </tr>
                                        {foreach from=$Cart.products item=Item }
                                            <tr class="cart-subtotal">
                                                <td style="color: red;text-align:center;">
                                                    {$Item.title}
                                                </td>
                                                <td style="text-align:center"> {$Item.price|price_format} </td>
                                                <td style="text-align:center">  <strong>  {$Item.pivot.qty|persian_number} ×</strong> کیلوگرم
                                                </td>
                                                <td style="text-align:center"> {($Item.price * $Item.pivot.qty)|price_format}</td>
                                            </tr>
                                        {/foreach}
                                        <tr class="cart-subtotal">
                                            <th style="color: red;text-align:center;">مبلغ بن تخفیف </th>
                                            <td style="color: red;text-align:center;">
                                                {$coupon|price_format}
                                            </td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr class="cart-subtotal" style="background-color: #ffffff">
                                            <th style="text-align:center">مجموع سبد خرید</th>
                                            <td style="text-align:center">{$amount|price_format}</td>
                                            <th>&nbsp;</th>
                                            <th>&nbsp;</th>
                                        </tr>
                                        <tr class="order-total" style="background-color: #c6ffc4;">
                                            <th style="text-align:center">مجموع قابل پرداخت</th>
                                            <td style="text-align:center"><strong>{$amount|price_format}</strong>
                                            </td>
                                            <th>&nbsp;</th>
                                            <th>&nbsp;</th>

                                        </tr>								

                                    </tfoot>

                                </table>
                                <div class="payment-method">
                                    <div class="payment-accordion">
                                        <!-- ACCORDION START -->

                                        <div class="payment-content">
                                            <h3 style="text-align: right;direction: rtl;"><img width="100"
                                                                                               src="{assets_url}images/mellat.jpg"
                                                                                               alt="بانک ملت"/> پرداخت
                                                از طریق تمامی کارت های بانکی عضو شبکه شتاب. امنیت و اطلاعات محرمانه شما
                                                توسط بانک ملت حمایت می شوند.</h3>

                                        </div>
                                        <!-- ACCORDION END -->									
                                    </div>
                                </div>
                                <div class="col-md-2 col-lg-2 col-sm-4 col-xs-12">
                                    <div class="subs-btn">
                                        <input type="submit" class="fv-btn" value="پرداخت"/>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!-- End product Details -->
                    </form>
                </div>
            </div>
        </div>
        <!-- Start Review Information -->
    </div>
</section>
