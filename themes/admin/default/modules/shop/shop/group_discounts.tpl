<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-1-2 uk-margin-small-bottom">
                <a class="md-btn md-btn-success" href="{site_url()|con:ADMIN_PATH}/shop/shop/addGroupDiscount">
                    <i class="uk-icon-plus-square uk-text-muted"></i> تخفیف گروهی جدید</a>
            </div>
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable fuk-table-striped" id="dt_default" role="grid" aria-describedby="dt_default_info">
                <thead>
                    <tr>
                        <th class="sorting">درصد تخفیف تخفیف</th>
                        <th class="sorting">آدرس لینک سئو</th>
                        <th class="sorting">تعداد روز تا انقضا</th>
                        <th class="sorting">وضعیت</th>
                        <th class="sorting">تاریخ ثبت</th>
                        <th class="no-sort">عملیات</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th class="sorting">درصد تخفیف تخفیف</th>
                        <th class="sorting">آدرس لینک سئو</th>
                        <th class="sorting">تعداد روز تا انقضا</th>
                        <th class="sorting">وضعیت</th>
                        <th class="sorting">تاریخ ثبت</th>
                        <th class="no-sort">عملیات</th>
                    </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                    {foreach from=$group_discounts item=val}
                        <tr>
                            <td>
                                {$val.discount} درصد
                            </td>
                            <td>
                                {$val.slug}
                            </td>
                            <td>
                                ({$val.expire|persian_number} روز)
                                {$dt = $val->created_at->addDays($val->expire)->diffInDays(Carbon\Carbon::now(),false)}
                                {math equation="abs(x)" x=$dt assign="dtPositive"}
                                {if $dtPositive eq $dt}
                                    <label class="text-danger">
                                        {$dtPositive|persian_number} روز گذشته
                                    </label>
                                {else}
                                    <label class="text-success">
                                        {$dtPositive|persian_number} روز باقی‌مانده
                                    </label>
                                {/if}
                            </td>
                            <td>
                                {if $val.status eq 1 AND  $dtPositive != $dt}
                                    <label class="text-success">فعال</label>
                                {else}
                                    <label class="text-danger">غیرفعال</label>
                                {/if}
                            </td>
                            <td>{jdate format='j F Y - h:i a' date=$val->created_at}</td>
                            <td class="right">
                                <label class="uk-text-primary">
                                    <a data-uk-tooltip  title="ویرایش"  class="uk-icon-button uk-icon-pencil uk-text-primary" href="{site_url({ADMIN_PATH|con:'/shop/shop/addGroupDiscount/' : $val->id})}"></a>
                                </label>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>