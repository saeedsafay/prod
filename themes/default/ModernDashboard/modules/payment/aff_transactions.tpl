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
                                        <div class="wishlist-title col-md-12">
                                            <h2 class="rtl">تراکنش‌های مالی</h2>
                                            <p class="rtl text-primary" style="padding-top:20px; " >
                                                در این قسمت لیست تراکنش های مالی واریز به حساب کاربری شما از طریق دریافت کارمزد از خرید زیرمجموعه‌هایتان قابل مشاهده است.
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
                                                            <th><span class="nobr">شناسه تراکنش</span></th>
                                                            <th><span class="nobr">شناسه بانکی تراکنش</span></th>
                                                            <th><span class="nobr">نوع تراکنش</span></th>
                                                            <th><span class="nobr">مبلغ</span></th>
                                                            <th style="width:330px"><span class="nobr">شرح </span></th>
                                                            <th><span class="nobr">پرداخت کننده</span></th>
                                                            <th><span class="nobr">تاریخ ثبت</span></th>
                                                            <th><span class="nobr">وضعیت</span></th>
                                                        </tr>
                                                    </thead>

                                                    <tbody class="points_table_scrollbar">
                                                        {$i = 0}
                                                        {foreach from=$transactions item=val}  
                                                            <tr class="{if $i % 2 == 0}even{else}odd{/if}">
                                                                <td>
                                                                    <p>{$val.id}</p>
                                                                </td>
                                                                <td>
                                                                    <p>{$val.trans_id}</p>
                                                                </td>
                                                                <td>
                                                                    <p>
                                                                        کارمزد معرف
                                                                    </p>
                                                                </td>
                                                                <td> <p>{$val.price|price_format}</p></td>
                                                                <td style="width:330px">
                                                                    <p>{$val.description}</p>
                                                                </td>
                                                                <td>
                                                                    <p>
                                                                        {$val.invited_user.first_name} {$val.invited_user.last_name} ({$val.invited_user.username})
                                                                    </p>
                                                                </td>
                                                                <td>
                                                                    <label style="color:#8fdf82">
                                                                        {jdate format='j F Y H:i' date=$val.created_at}
                                                                    </label>
                                                                </td>
                                                                <td>
                                                                    {if $val.transaction_states_id == 1}
                                                                        <p> تکمیل شده</p>
                                                                    {/if}
                                                                </td>
                                                            </tr>
                                                            {$i = $i + 1}
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




