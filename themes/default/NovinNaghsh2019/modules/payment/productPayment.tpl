<main class="site-main shopping-cart js-get-pages-id" id="js-checkout">
    <div class="container">
        <ol class="breadcrumb-page">
            <li><a href="{site_url}">خانه</a></li>
            <li><a href="{site_url}shop/cart">سبد خرید</a></li>
            <li class="active"><a href="#">فاکتور و پرداخت</a></li>
        </ol>
    </div>
    <div class="container">
        <form class="mb-20" method="POST" action="{$action}">
            <h1 class="headline-3 text-center mb-30"> فاکتور خرید</h1>
            <div class="row">
                <div class="col-xs-12">
                    <div class="form-cart">
                        <div class="table-cart">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th class="tb-image"></th>
                                    <th class="tb-product">شرح محصول</th>
                                    <th class="tb-price">قیمت واحد</th>
                                    <th class="tb-qty">تعداد</th>
                                    <th class="tb-dicount">تخفیف کل</th>
                                    <th class="tb-total">قیمت کل</th>
                                </tr>
                                </thead>
                                <tbody>
                                {assign var=totalDiscount value=0}
                                {foreach $Cart.varients as $item}

                                    {if ($item->product->child_category->variants_as_package)}
                                        {$qty = 1}
                                    {else}
                                        {$qty = $item.pivot.qty}
                                    {/if}

                                    {if $item.discount_price != null}
                                        {$Discount = ($item.price - $item.discount_price)}
                                        {$Final_price = ($qty * $item.discount_price)}
                                    {else}
                                        {$Discount = 0}
                                        {$Final_price = ($item.price * $qty)}
                                    {/if}
                                    <tr>
                                        <td class="tb-image">
                                            <a class="item-photo" href="{$item->product->link}">
                                                <img src="{$products_pic_dir}{$item.thumbnail}"
                                                     alt="{$item.title}"
                                                     width="100">
                                            </a>
                                        </td>
                                        <td class="tb-product">
                                            <div class="product-name">
                                                {$count = $item->fields->count() }
                                                {$j = 1}
                                                {$item.product.title} |
                                                {foreach $item.fields as $v}
                                                    {if $v.value.parentDiversity.deleted eq 1}{continue}{/if}
                                                    {$v.value.title}
                                                    {if $j != $count}|{/if} {$j = $j+1}
                                                {/foreach}
                                                {if $item->pivot->files != "" }
                                                    <span class="badge badge-primary">طرح دلخواه</span>
                                                {/if}
                                            </div>
                                        </td>
                                        <td class="tb-price">
                                            <span class="price">{$item.price|price_format}</span>
                                        </td>
                                        <td class="tb-qty">
                                            <span class="price">{$qty|persian_number}</span>
                                        </td>
                                        <td class="tb-dicount">
                                            <span class="price">{($Discount * $qty)|price_format}</span>
                                        </td>
                                        <td class="tb-total">
                                        <span class="price">
                                            {($item.price * $qty)|price_format}
                                        </span>
                                        </td>
                                    </tr>
                                    {assign var=totalDiscount value=$totalDiscount+($Discount*$qty)}
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-md-7">
                    <div class="order-summary">
                        <h4 class="title-shopping-cart">جمع کل فاکتور</h4>
                        <div class="checkout-element-content">
                            <div class="order-left">
                                مجموع سبد خرید :
                                <span>{$cart_total|price_format}</span>
                            </div>
                            <div class="order-left">
                                مجموع تخفیف :
                                <span>
                                    {if $cart_total_discount}
                                        {($cart_total - $cart_total_discount)|price_format}
                                    {else}
                                        0
                                    {/if}
                                </span>
                            </div>
                            <div class="order-left border-bottom">
                                هزینه ارسال :
                                <span>
                                    {if $Cart->delivery_address_id && 0}
                                        {{setting name='transportation_price'}|price_format}
                                        {$shippingCost = {setting name='transportation_price'}}
                                    {else}
                                        {$shippingCost = 0}
                                        رایگان
                                    {/if}
                            </span>
                            </div>
                            <div class="order-left text-black">
                                مجموع قابل پرداخت :
                                {if $cart_total_discount}
                                    <span>
                                        <b style="font-size: 20px; color: #c02035">
                                            {($cart_total_discount+$shippingCost)|price_format}
                                        </b>
                                    </span>
                                {else}
                                    <span>
                                        <b style="font-size: 20px; color: #c02035">
                                            {($cart_total+$shippingCost)|price_format}
                                        </b>
                                    </span>
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-md-5">
                    <div class="box-style-3 p-20">
                        <h2 class="font-size-8 mb-15">مشخصات تحویل</h2>
                        <p class="mb-10">
                            آدرس:
                            <b class="text">{$delivery->province->name}
                                {if isset($delivery->county)} - {$delivery->county->name}{/if}
                            </b>
                            |
                            <span>
                                {$delivery->delivery_address}. {if isset($delivery->postal_code)} کد پستی:
                                    ({$delivery->postal_code}){/if}
                            </span>
                        </p>
                        <p class="mb-10">
                            شماره تماس:
                            <span class="text">{$delivery->mobile}</span>
                        </p>
                        <p class="mb-10">
                            توضیحات:
                            <span class="text">{$delivery.extra_desc}</span>
                        </p>
                    </div>
                    <div class="box-style-3 payment-method p-15 mt-15">
                        <img class="img" src="{assets_url}images/shopping/shetab.jpg" alt="پرداخت عضو شتاب" width="64">
                        <p class="text"> پرداخت از طریق تمامی کارت های بانکی عضو شبکه شتاب. امنیت و اطلاعات محرمانه شما
                            توسط
                            بانک حمایت می شوند.</p>
                    </div>
                </div>
                <input type="hidden" name="token" value="{$token}">
                <div class="col-xs-12">
                    <div class="text-left mt-40">
                        <button class="btn btn-primary btn-medium" type="submit">پرداخت آنلاین</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</main>
