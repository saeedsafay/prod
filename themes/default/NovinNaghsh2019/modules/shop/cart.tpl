<main class="site-main shopping-cart js-get-pages-id" id="js-cart">
    <div class="container">
        <ol class="breadcrumb-page">
            <li>
                <a href="{site_url}">خانه</a>
            </li>
            <li class="active">
                سبد خرید
            </li>
        </ol>
    </div>
    <div class="container">
        <div class="row">
            {if count($CartItems) == 0}
                <label class="col-lg-12 alert alert-warning" for="">
                    {if $is_logged_in}
                        سبد خرید شما خالی است
                    {else}
                        سبد خرید شما خالی است. اگر قبلا سبد خرید ساخته اید در
                        <a href="/users/login?requested_url='/shop/cart'">حساب کاربری خود
                            وارد شوید</a>
                    {/if}

                </label>
                <a href="{site_url()}" class="btn btn-checkout">
                    ادامه خرید
                </a>
            {else}
                <div class="col-md-9">
                    <form class="form-cart">
                        <div class="table-cart">
                            <table class="table">
                                <thead>
                                <tr>
                                    <th class="tb-image"></th>
                                    <th class="tb-product">شرح محصول</th>
                                    <th class="tb-price">قیمت واحد (تومان)</th>
                                    <th class="tb-qty">تعداد</th>
                                    <th class="tb-total">قیمت کل (تومان)</th>
                                    <th class="tb-remove"></th>
                                </tr>
                                </thead>
                                <tbody>
                                {foreach $CartItems as $key => $Item}
                                    {if ($Item->product->child_category->variants_as_package)}
                                        {$qty = 1}
                                    {else}
                                        {$qty = $Item.pivot.qty}
                                    {/if}
                                    <tr class="cart_item" id="cartItem{$Item.id}">
                                        <td class="tb-image">
                                            <a href="{$Item->product->link}"
                                               class="item-photo">
                                                <img src="{$products_pic_dir}{$Item.thumbnail}"
                                                     alt="{$Item.product.title}"/>
                                            </a>
                                        </td>
                                        <td class="tb-product">
                                            <div class="product-name">
                                                <a href="{$Item->product->link}">
                                                    {$count = $Item->fields->count() }
                                                    {$j = 1}
                                                    <b>
                                                        {$Item.product.title} |
                                                        {foreach $Item.fields as $v}
                                                            {if $v.value.parentDiversity.deleted eq 1}{continue}{/if}
                                                            {$v.value.title}
                                                            {if $j != $count}|{/if} {$j = $j+1}
                                                        {/foreach}
                                                    </b>
                                                    {if isset($Item->pivot->files)}
                                                        <span class="badge badge-primary">طرح دلخواه</span>
                                                    {/if}
                                                </a>
                                                <ul>
                                                    <li>
                                                        {if $Item.lead_time > 0}
                                                            ارسال از: {$Item.lead_time|persian_number} روز آینده
                                                        {else}
                                                            آماده ارسال
                                                        {/if}
                                                    </li>
                                                </ul>
                                            </div>
                                        </td>
                                        <td class="tb-price">
                                            <span class="price">{$Item.price|price_format}</span>
                                        </td>
                                        <td class="tb-qty">
                                            <div class="quantity">
                                            <span class="font-weight-medium">
                                                x {$qty|persian_number}
                                            </span>
                                            </div>
                                        </td>
                                        <td class="tb-total">
                                            {$Final_price = ($Item.price * $qty)}
                                            <span class="price">{$Final_price|price_format}</span>
                                        </td>
                                        <td class="tb-remove">
                                            <a href="#" onclick="$(this).removeCartItem({$Item.id});"
                                               class="action-remove" title="حذف این محصول">
                                                <span><i class="fa fa-times" aria-hidden="true"></i></span>
                                            </a>
                                        </td>
                                    </tr>
                                {/foreach}
                                </tbody>
                            </table>
                        </div>
                    </form>
                </div>
                <div class="col-md-3 padding-left-5">
                    <div class="order-summary">
                        <h4 class="title-shopping-cart">جمع کل فاکتور</h4>
                        <div class="checkout-element-content">
                            <span class="order-left">
                                مجموع سبد خرید :
                                <span>
                                        {$cart_total|price_format}
                                </span>
                            </span>
                            <span class="order-left text text-danger">
                                تخفیف :
                                <span class="">
                                    {if $cart_total_discount}
                                        {($cart_total - $cart_total_discount)|price_format}
                                    {else}
                                        0
                                    {/if}
                                </span>
                            </span>
                            <span class="order-left border-bottom">
                                هزینه ارسال :
                                <span>رایگان</span>
                            </span>

                            <ul>
                                {if !$cart_total_discount}
                                    <li>
                                        <label class="inline">
                                            <input type="checkbox" id="have-coupon">
                                            <span class="input"></span>
                                            کد
                                            تخفیف
                                            دارید؟
                                        </label>
                                    </li>
                                    <li class="mb-20 hidden" id="coupon-section">
                                        <input style="width: 100%;" type="text" name="coupon_code"
                                               placeholder="کد تخفیف">
                                        <p class="mt-20">
                                            <a href="#" class="btn btn-sm btn-primary apply-code">
                                                <i class="fa fa-sync fa-spin hidden"></i>
                                                <span>
                                            اعمال کد تخفیف
                                            </span>
                                            </a>
                                        </p>
                                    </li>
                                {else}
                                    <li>
                                        <span class="order-left border-bottom">
                                            کدتخفیف اعمال شده :
                                            <span>
                                                {if $is_logged_in}
                                                    %{$Cart->coupon->discount}
                                                {else}
                                                    %{$sessionCartDiscount}
                                                {/if}
                                            </span>
                                            <a class="btn-link remove-coupon"
                                               style="cursor: pointer; color:#d81313!important">
                                                <i class="fa fa-minus-circle"></i>
                                                    حذف
                                                </a>
                                        </span>
                                    </li>
                                {/if}
                            </ul>
                            <span class="order-left total">
                                جمع کل :
                                <span>
                                    {if $cart_total_discount}
                                        {$cart_total_discount|price_format}
                                    {elseif $cart_total}
                                        {$cart_total|price_format}
                                    {/if}
                                </span>
                            </span>
                            <a href="{site_url('shop/cart-address')}" class="btn-checkout"
                               style="text-align: center;">
                                <i class="fa fa-lock"></i> ادامه و پرداخت
                            </a>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
    </div>
</main><!-- end MAIN -->
