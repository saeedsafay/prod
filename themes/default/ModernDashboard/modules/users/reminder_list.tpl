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
                                <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                                    <div class="row">
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                            <a href="{$addURL}" class="btn btn-md btn-pink btn_product"><span>افزودن مناسبت</span></a>
                                            <table class="points_table">
                                                <thead>
                                                    <tr>
                                                        <th>عنوان</th>
                                                        <th>نوع مناسبت</th>
                                                        <th>تاریخ مناسبت</th>
                                                        <th>توضیحات</th>
                                                        <th>تاریخ ثبت</th>
                                                        <th>عملیات</th>
                                                    </tr>
                                                </thead>
                                                <tbody class="points_table_scrollbar">
                                                    {$i = 0}
                                                    {foreach $reminders as $val}
                                                        <tr class="{if $i % 2 == 0}even{else}odd{/if}">
                                                            <td>
                                                                <p>{$val.title}</p>
                                                            </td>
                                                            <td>
                                                                <p>{$val.reason_type}</p>
                                                            </td>
                                                            <td>
                                                                <p>  
                                                                    <label style="color:#8fdf82">
                                                                        {jdate format='j F Y' date=$val.date}
                                                                    </label>
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>{$val.description}</p>
                                                            </td>
                                                            <td>
                                                                <p>  
                                                                    <label style="color:#8fdf82">
                                                                        {jdate format='j F Y H:i' date=$val.created_at}
                                                                    </label>
                                                                </p>
                                                            </td>
                                                            <td class="point_table_width_button">
                                                                <a href="{site_url}users/reminder-edit/{$val.id}" class="btn btn-md btn-yellow"><span>ویرایش</span></a>
                                                                <a href="{site_url}users/reminder-delete/{$val.id}" class="btn btn-md btn-red delete"  data-idads='{$val.id}' title="حذف این مناسبت" data-placement="top" data-toggle="confirmation-popout" ><span>حذف</span></a>
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



