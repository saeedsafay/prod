{add_js file='lib/jquery.craftpip_confirmbox/js/jquery-confirm.js' part='footer'}
{add_css file='lib/jquery.craftpip_confirmbox/css/jquery-confirm.css'}
<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-lg-3 pull-right no-padding">
                        </div>
                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                            {include file='partials/header_menu.tpl'}
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-lg-12 pull-left" style="text-align: right;font-family: xantoxa;">
                                    <div class="row">
                                        <div class="wishlist-title">
                                            <h2 class="rtl">{$title} </h2>
                                            <p class="rtl text-primary" style="padding-top:20px; " >
                                                در این قسمت سفارش‌هایی که کاربران از فروشگاه شما به صورت اشتراکی و تقویم دار ثبت کرده‌اند قابل مشاهده است.
                                            </p>
                                            <p class="text-danger alert-block alert-danger alert-dismissable">
                                                لطفا توجه لازم را داشته باشید محصولات ثبت شده به عنوان اشتراکی که پرداخت آن‌ها انجام شده است، می‌باید در تاریخ تحویل که از سوی مشتری ثبت شده ارسال گردند.
                                            </p>
                                        </div>
                                        {if $subscribes->isEmpty()}
                                            <div class="col-md-12">
                                                <div class="entry-header">
                                                    <label class="text-warning pull-right rtl">سفارشی موجود نیست.</label>
                                                    <br>
                                                </div>
                                            </div>
                                        {else}
                                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12" >
                                                <table class="points_table" dir="rtl">
                                                    <thead>
                                                        <tr>
                                                            <th>شناسه فاکتور</th>
                                                            <th>تصویر</th>
                                                            <th><span class="nobr">عنوان(تعداد)</span></th>
                                                            <th><span class="nobr"> مبلغ واحد </span></th>
                                                            <th><span class="nobr">تاریخ ثبت</span></th>
                                                            <th><span class="nobr">تاریخ تحویل</span></th>
                                                            <th><span class="nobr">آدرس تحویل</span></th>
                                                            <th><span class="nobr">کاربر</span></th>
                                                            <th><span class="nobr">وضعیت</span></th>
                                                        </tr>
                                                    </thead>

                                                    <tbody class="points_table_scrollbar">
                                                        {foreach from=$subscribes item=item}
                                                            {if $item.cart.status eq 0}
                                                                {continue}
                                                            {/if}
                                                            {$val = $item.product}
                                                            <tr>
                                                                <td><p>{$item.cart.id}</p></td>
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
                                                                <td><a href="{site_url()|con:'product/':$val.slug}">{$val.title}</a></td>
                                                                <td>
                                                                    <span class="amount">{$val.price|price_format}</span>
                                                                </td>
                                                                <td>
                                                                    <label style="color:#c0c0c0">
                                                                        {jdate format='j F Y H:i' date=$item.created_at}
                                                                    </label>
                                                                </td>
                                                                <td>
                                                                    <label style="color:#8fdf82">
                                                                        {jdate format='j F Y' date=$item.delivery_date}
                                                                    </label>
                                                                </td>
                                                                <td>
                                                                    <label style="color:#8fdf82">
                                                                        {$item.cart.delivery_address}
                                                                    </label>
                                                                </td>
                                                                <td class="point_table_width_button">
                                                                    <p>{$item.user.first_name} {$item.user.last_name} ({$item.user.mobile})</p>
                                                                </td>
                                                                <td>
                                                                    {if $item.cart.status eq 0}
                                                                        <label class="text-danger">پرداخت نشده</label>
                                                                    {else if $item.cart.status eq 1}
                                                                        <label class="text-success">پرداخت شده</label>
                                                                    {else if $item.cart.status eq 2}
                                                                        <label class="text-success">ارسال شده</label>
                                                                    {else if $item.cart.status eq 3}
                                                                        <label class="text-success">تحویل شده</label>
                                                                    {/if}
                                                                </td>

                                                            </tr>
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




