<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-1-6 uk-margin-small-bottom">
                <a class="md-btn md-btn-success" href="{$add_link}">
                    <i class="uk-icon-plus-square uk-text-muted"></i> افزودن آگهی </a>
            </div>
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable fuk-table-striped" id="dt_default" role="grid" aria-describedby="dt_default_info">
                <thead>
                    <tr>
                        <th class="sorting">عنوان</th>
                        <th class="sorting">کاربر نویسنده</th>
                        <th class="sorting">نوع آگهی</th>
                        <th class="sorting">دوره نمایش</th>
                        <th class="sorting">وضعیت</th>
                        <th class="sorting">پرداخت</th>
                        <th class="sorting">تاریخ ایجاد</th>
                        <th class="sorting">تاریخ انقضای آگهی</th>
                        <th class="no-sort">عملیات</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th class="sorting">عنوان</th>
                        <th class="sorting">کاربر نویسنده</th>
                        <th class="sorting">نوع آگهی</th>
                        <th class="sorting">دوره نمایش</th>
                        <th class="sorting">وضعیت</th>
                        <th class="sorting">پرداخت</th>
                        <th class="sorting">تاریخ ایجاد</th>
                        <th class="sorting">تاریخ انقضای آگهی</th>
                        <th class="no-sort">عملیات</th>
                    </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                    {foreach from=$Ads item=val}
                        <tr>
                            <td>{$val->title}</td>
                            <td>{$val->user->first_name} {$val->user->last_name}</td>
                            <td>  
                                {if $val.type eq 0}
                                    رایگان
                                {else if $val.type eq 2}
                                    ویژه
                                {else if $val.type eq 3}
                                    ویترین
                                {/if}
                            </td>
                            <td>{$val->period_time} ماهه</td>
                            <td>
                                {*
                                تعیین وضعیت آگهی 
                                اول تاریخ ثبت تایید چک میشه که چند ماه ازش گذشته اگر از دوره نمایش بیشتر بود
                                آگهی منقضی شده هست
                                *}
                                {assign var="current_date" value=date('Y-m-d H:i:s')}
                                {assign var="date1" value=date_create($val->start_period_date)}
                                {assign var="date2" value=date_create($current_date)}
                                {assign var="diff" value=date_diff($date1,$date2)}
                                {assign var="month" value=$diff->format('%m')}

                                {assign var="expire" value={'+'|con:$val.period_time:' month'}}

                                {assign var="expireDate" value={jdate format='j F Y' date=$expire second_date=$val.start_period_date}}


                                {if $month >= $val.period_time}
                                    <label class="uk-text-warning"> منقضی شده</label>
                                {else if $val.status eq 0}
                                    <label class="uk-text-primary"> در حال بررسی</label>
                                {else if $val.status eq 1}
                                    <label class="uk-text-success"> تایید شده</label>
                                {else if $val.status eq 2}
                                    <label class="uk-text-danger">رد شده</label>
                                {else if $val.status eq 3}
                                    <label class="uk-text-primary">ویرایش شده درحال بررسی</label>
                                {else if $val.status eq 4}
                                    <label class="uk-text-danger">ویرایش تاییدشده</label>
                                {else if $val.status eq 5}
                                    <label class="uk-text-muted">  فروخته شده</label>
                                {/if}
                            </td>
                            <td>
                                {*
                                وضعیت پرداخت
                                *}
                                {if $val.pay_status eq 1 AND $val.type != 0 }
                                    {assign var="pay_status" value='پرداخت شده'}
                                    {assign var="pay_color" value='success'}
                                {else if $val.type != 0}
                                    {assign var="pay_status" value='پرداخت نشده'}
                                    {assign var="pay_color" value='warning'}
                                {else}
                                    {assign var="pay_status" value='رایگان'}
                                    {assign var="pay_color" value='muted'}
                                {/if}
                                <label class="uk-text-{$pay_color}">
                                    {$pay_status}
                                </label>

                            </td>
                            <td>{jdate format='j F Y - h:i a' date=$val->created_at}</td>
                            <td>
                                {if $val.start_period_date == null}
                                    <label title='تاریخ انقضای آگهی از روز تایید مدیریت محاسبه میشود'>تعیین نشده</label>
                                {else}
                                    {$expireDate}
                                {/if}
                            </td>
                            <td class="right">

                                {if $val.status == 0 OR  $val.status == 3 OR $val.status == 2}
                                    <label class="uk-text-primary">
                                        <a data-uk-tooltip title="نایید و انتشار"  class="uk-icon-button uk-icon-check uk-text-success" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/toggleStatus/' : $val->id})}"></a>
                                    </label>
                                {/if}
                                {if $val.status == 1}
                                    <label class="uk-text-primary">
                                        <a data-uk-tooltip  title="رد کردن آیتم"  class="uk-icon-button uk-icon-close uk-text-danger" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/toggleStatus/' : $val->id})}"></a>
                                    </label>
                                {/if}
                                {if $val.status == 4}
                                    <label class="uk-text-primary">
                                        <a class="uk-icon-button uk-icon-eye-slash uk-text-danger" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/toggleStatus/' : $val->id})}"></a>
                                    </label>
                                {/if}
                                <label class="uk-text-primary">
                                    <a data-uk-tooltip  title="نمایش آیتم"  class="uk-icon-button uk-icon-eye uk-text-primary" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/view-ads/' : $val->id})}"></a>
                                </label>
                                <label class="uk-text-primary">

                                    <a data-uk-tooltip title="حذف" class="uk-icon-button uk-icon-trash uk-text-danger delete" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/delete/' : $val->id})}"></a>
                                </label>
                                <label class="uk-text-primary">

                                    <a data-uk-tooltip title="ویرایش" class="uk-icon-button uk-icon-pencil uk-text-primary" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/edit/' : $val->id:'/':$is_shop})}"></a>
                                </label>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>