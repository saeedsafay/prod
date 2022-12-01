{add_js file='lib/jquery.craftpip_confirmbox/js/jquery-confirm.js' part='footer'}
{add_css file='lib/jquery.craftpip_confirmbox/css/jquery-confirm.css'}
<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12">
                    <div class="row">

                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                            {include file='partials/header_menu.tpl'}
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-lg-12 pull-left" style="text-align: right;font-family: xantoxa;">
                                    <div class="row">
                                        <h4 class="title_row title-3">لیست سفارشات</h4>
                                        <div class="wishlist-title">
                                            <h2 class="rtl">سفارشات تاییدشده</h2>
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
                                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 table-responsive" >
                                                <table class="table table-condensed table-hover table-bordered table-striped" dir="rtl">
                                                    <thead>
                                                        <tr>
                                                            <th>شناسه فاکتور</th>
                                                            <th>کد محصول</th>
                                                            <th>تصویر</th>
                                                            <th><span class="nobr">عنوان(تعداد)</span></th>
                                                            <th><span class="nobr">دسته بندی</span></th>
                                                            <th><span class="nobr">قیمت فروش</span></th>
                                                            <th><span class="nobr">فروشنده</span></th>
                                                            <th><span class="nobr">تاریخ سفارش</span></th>
                                                            <th><span class="nobr">وضعیت</span></th>
                                                        </tr>
                                                    </thead>

                                                    <tbody class="points_table_scrollbar">
                                                        {foreach from=$Items item=cart}    
                                                            {foreach from=$cart.products item=val}   
                                                                <tr>
                                                                    <td>
                                                                        <p>
                                                                            {$cart.id}
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <p>
                                                                            {$val.id}
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        {if $val.pic != ''}
                                                                            <a href="{site_url()|con:'product/':$val.slug}">
                                                                                <img src="{$products_thumbnail_dir}{$val.pic}"
                                                                                     alt="{$val.title}"
                                                                                     style="max-height: 100px;"/>
                                                                            </a>
                                                                        {else}
                                                                            بدون تصویر
                                                                        {/if}
                                                                    </td>
                                                                    <td><a href="{site_url()|con:'product/':$val.slug}">{summary text=$val.title limit=35}</a><br> ({$val.pivot.qty|persian_number}*)</td>
                                                                    <td>
                                                                        <p>
                                                                            {$val.category.title} 
                                                                            <i class="fa fa-chevron-left"></i>
                                                                            {$val.child_category.title}
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <span class="amount text-success">
                                                                            {$val.pivot.unit_price|price_format}
                                                                        </span>
                                                                    </td>
                                                                    <td>
                                                                        <span class="amount">{$val.user.business_name}</span>
                                                                    </td>
                                                                    <td>
                                                                        {jdate format='j F Y H:i' date=$cart.pay_at}
                                                                    </td>
                                                                    <td>
                                                                        {if $cart.status eq 1}
                                                                            <label class="text-success">پرداخت شده</label>
                                                                        {else if $cart.status eq 2}
                                                                            <label class="text-success">ارسال شده</label>
                                                                        {else if $cart.status eq 3}
                                                                            <label class="text-success">پرداخت در محل</label>
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
                </div>
            </div>
        </div>
    </div>
</section>




