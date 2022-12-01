<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12">
                    <div class="row">

                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                            {include file='partials/header_menu.tpl'}
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                                    <div class="row"> 
                                        <div class="col-md-12 col-sm-12 col-lg-12" style="padding: 20px 62px 3px;">
                                            <p>
                                                لینک اختصاصی شما برای معرفی وب‌سایت:
                                            </p>
                                            <p id="reagent-url" style="
                                               background: #00ca00;
                                               width: 50%;
                                               margin: auto;
                                               text-align: center;
                                               font-family: sans-serif!important;
                                               color: #fdfcfd;
                                               padding: 9px;
                                               font-size: 16px;
                                               letter-spacing: 0.75px;
                                               ">
                                                {site_url}users/login/{$user->username}
                                            </p>
                                            <p>
                                                هر کاربری که با استفاده از لینک معرفی شما که در بالا ذکر شده است در وب سایت خرده ریز ثبت نام انجام دهد، به عنوان زیرمجموعه شما در سیستم ثبت شده و از هر خریدی که در سایت به اتمام برساند 1/5 درصد از مبلغ سفارش به عنوان کارمزد در حساب شما شارژ خواهد شد و می‌توانید از این مبلغ جهت خرید در وب‌سایت استفاده نمایید.
                                            </p>
                                            <h5 class="text-success btn btn-success">
                                                موجودی حساب: {$user->cash|price_format}
                                            </h5>

                                        </div>
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                            <table class="points_table">
                                                <thead>
                                                    <tr>
                                                        <th>نام و نام خانوادگی</th>
                                                        <th>نام کاربری</th>
                                                        <th>تاریخ ثبت</th>
                                                    </tr>
                                                </thead>

                                                <tbody class="points_table_scrollbar">
                                                    {$i = 0}
                                                    {foreach $subset as $val}
                                                        <tr class="{if $i % 2 == 0}even{else}odd{/if}">
                                                            <td>
                                                                <p>
                                                                    {$val.subset_member->first_name} {$val.subset_member->last_name}
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    {$val.subset_member->username}
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>  
                                                                    <label style="color:#8fdf82">
                                                                        {jdate format='j F Y H:i' date=$val.created_at}
                                                                    </label>
                                                                </p>
                                                            </td>
                                                        </tr>
                                                        {$i = $i + 1}
                                                    {/foreach}
                                                </tbody>
                                            </table>
                                        </div>
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



