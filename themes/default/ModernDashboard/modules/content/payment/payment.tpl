
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
                                        <th class="product-total">شرح</th>
                                    </tr>							
                                </thead>
                                <tbody>
                                    <tr class="cart_item">
                                        <td class="product-name">
                                            نمایش آگهی 
                                        </td>
                                        <td class="product-total">
                                            <span class="amount">{$ads_title}</span>
                                        </td>
                                    </tr>
                                    <tr class="cart_item">
                                        <td class="product-name">
                                            دوره نمایش
                                        </td>
                                        <td class="product-total">
                                            <span class="amount">{$period_time|persian_number} ماه</span>
                                        </td>
                                    </tr>
                                    <tr class="cart_item">

                                        {if isset($old_tariff)}
                                            <td  class="product-name">تعرفه پلن جدید</td>
                                        {else}
                                            <td  class="product-name">تعرفه</td>
                                        {/if}
                                        <td><span class="amount">{$tariff|price_format}</span></td>
                                    </tr>
                                    {if isset($old_tariff)}
                                        <tr class="cart_item">
                                            <td class="product-name">
                                                تعرفه پلن قدیم 
                                            </td>
                                            <td class="product-total">
                                                <span class="amount text-danger"> - {$old_tariff|price_format}</span>
                                            </td>
                                        </tr>
                                    {/if}
                                </tbody>
                                <tfoot>
                                    <tr class="order-total">
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
                                <h3>بانک ملت <img src="{assets_url}img/mellat.jpg"
                                                  alt="پیانویاب-درگاه-پرداخت-بانک-ملت"/></h3>
                                <div class="payment-content">
                                    <p>پرداخت امن درگاه اینترنتی بانک ملت</p>
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
