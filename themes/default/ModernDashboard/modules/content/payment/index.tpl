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
                                        <div class="wishlist-title col-md-12">
                                            <h2 class="rtl">تراکنش‌های مالی</h2>
                                            <p class="rtl text-primary" style="padding-top:20px; " >
                                                در این قسمت لیست تمامی تراکنش های مالی شما قابل مشاهده است.
                                            </p>
                                            {if $user->type == 1}
                                                <p class="rtl text-danger">
                                                    موجودی حساب شما از طریق فروش محصولات‌تان در سایت محاسبه می‌شود به این صورت که {$user->sale_percent}درصد از فروش برای سایت منظور شده و مابقی در حساب کاربری‌تان شارژ می‌گردد و می‌توانید در هر زمان درخواست تسویه دهید.
                                                </p>
                                                <a href="{site_url}users/withdraw" class="btn btn-green">درخواست تسویه</a>
                                                <h5 class="text-success btn btn-success">موجودی حساب شما: {$user->cash|price_format}</h5>
                                            {/if}
                                        </div>
                                        {if $transactions->isEmpty()}
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <label style="padding: 20px" class="text-warning pull-right rtl">تراکنشی موجود نیست</label>
                                                    <br>
                                                </div>
                                            </div>
                                        {else}
                                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12" >
                                                <table class="points_table" dir="rtl">
                                                    <thead>
                                                        <tr>
                                                            <th><span class="nobr">شناسه داخلی تراکنش</span></th>
                                                            <th><span class="nobr">شناسه بانکی تراکنش</span></th>
                                                            <th><span class="nobr">شناسه فاکتور</span></th>
                                                            <th><span class="nobr">نوع محصول</span></th>
                                                            <th><span class="nobr">مبلغ پرداختی</span></th>
                                                            <th><span class="nobr"> شرح </span></th>
                                                            <th><span class="nobr">تاریخ ثبت</span></th>
                                                            <th><span class="nobr">وضعیت</span></th>
                                                        </tr>
                                                    </thead>

                                                    <tbody class="points_table_scrollbar">
                                                        {foreach from=$transactions item=val}   
                                                            <tr>
                                                                <td>
                                                                    {$val.id}
                                                                </td>
                                                                <td>
                                                                    {$val.trans_id}
                                                                </td>
                                                                <td>
                                                                    {$val.invoice_id}
                                                                </td>
                                                                <td>
                                                                    {if $val.invoice_type == 1}
                                                                        محصول آماده
                                                                    {else if $val.invoice_type == 2}
                                                                        محصول شاخه‌ای
                                                                    {/if}
                                                                </td>
                                                                <td>{$val.price|price_format}</td>
                                                                <td>
                                                                    {$val.description}
                                                                </td>
                                                                <td>
                                                                    <label style="color:#8fdf82">
                                                                        {jdate format='j F Y' date=$val.created_at}
                                                                    </label>
                                                                </td>
                                                                <td>
                                                                    {if $val.transaction_states_id == 1}
                                                                        تکمیل شده
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




