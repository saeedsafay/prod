{add_js file='lib/jquery.craftpip_confirmbox/js/jquery-confirm.js' part='footer'}
<!-- wishlist-area start -->
<div class="wishlist-area">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="wishlist-content">
                    <div class="wishlist-title">
                        <h2 class="rtl" style="padding-top:20px; ">پرداختی‌های انجام شده</h2>
                        <p class="rtl text-primary" style="padding-top:20px; " >
                            در این قسمت خریدهای خود در سایت را می‌توانید مشاهده کرده و از آخرین وضعیت آن اطلاع یابید
                        </p>
                    </div>
                    {if $Items->isEmpty()}
                        <div class="col-md-12">
                            <div class="entry-header">
                                <label class="text-warning pull-right rtl">شما هنوز هیچ خریدی ثبت نکرده اید</label>
                                <br>
                            </div>
                        </div>
                    {else}
                        <div class="wishlist-table table-responsive">
                            <table>
                                <thead class="myads">
                                    <tr>
                                        <th class="product-thumbnail">تصویر</th>
                                        <th><span class="nobr">عنوان</span></th>
                                        <th class="product-stock-stauts"><span class="nobr">دسته بندی</span></th>
                                        <th class="product-price"><span class="nobr"> مبلغ فاکتور </span></th>
                                        <th class="product-stock-stauts"><span class="nobr">تاریخ پرداخت</span></th>
                                        <th class="product-stock-stauts"><span class="nobr">وضعیت</span></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach from=$Items item=cart}    
                                        {foreach from=$cart.products item=val}    
                                            <tr>
                                                <td>
                                                    {if $val.pic != ''}
                                                        <a href="{site_url()|con:'product/':$val.slug}">
                                                            <img src="{site_url()|con:'upload/ads/pic/':$val.pic}" alt="{$val.title}" style="max-height: 100px;" />
                                                        </a>
                                                    {else}
                                                        بدون تصویر
                                                    {/if}
                                                </td>
                                                <td><a href="{site_url()|con:'product/':$val.slug}">{$val.title} ({$val.pivot.qty|persian_number} * کیلوگرم)</a></td>
                                                <td>
                                                    <a href="{site_url}shop/products/list-category/{$val.category.id}">
                                                        {$val.category.title}
                                                    </a>
                                                </td>
                                                <td>
                                                    <span class="amount">{$cart.total|price_format}</span>
                                                </td>
                                                <td>
                                                    <label style="color:#8fdf82">
                                                        {jdate format='j F Y H:i' date=$cart.pay_at}
                                                    </label>
                                                </td>
                                                <td>
                                                    {if $val.status eq 1}
                                                        <label class="text-success">پرداخت شده</label>
                                                    {else if $val.status eq 2}
                                                        <label class="text-success">ارسال شده</label>
                                                    {else if $val.status eq 3}
                                                        <label class="text-success">تحویل شده</label>
                                                    {/if}
                                                </td>
                                            </tr>
                                        {/foreach}
                                    {/foreach}
                                </tbody>
                            </table>
                        </div>	
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>
<!-- wishlist-area end -->
