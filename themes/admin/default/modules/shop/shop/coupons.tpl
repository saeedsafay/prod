<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-1-2 uk-margin-small-bottom">
                <a class="md-btn md-btn-success" href="{site_url()|con:ADMIN_PATH}/shop/shop/addCoupon">
                    <i class="uk-icon-plus-square uk-text-muted"></i> تولید کد جدید</a>
            </div>
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable fuk-table-striped" id="dt_default" role="grid"
                   aria-describedby="dt_default_info">
                <thead>
                <tr>
                    <th class="sorting">شناسه کوپن</th>
                    <th class="sorting">کد تخفیف</th>
                    <th class="sorting">درصد تخفیف</th>
                    <th class="sorting">تا سقف (ریال)</th>
                    <th class="sorting">وضعیت</th>
                    <th class="sorting">تاریخ ثبت</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th class="sorting">شناسه کوپن</th>
                    <th class="sorting">کد تخفیف</th>
                    <th class="sorting">درصد تخفیف</th>
                    <th class="sorting">تا سقف (ریال)</th>
                    <th class="sorting">وضعیت</th>
                    <th class="sorting">تاریخ ثبت</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                {foreach from=$Coupons item=val}
                    <tr>
                        <td>
                            {$val.id}
                        </td>
                        <td>
                            <b>{$val.code|upper}</b>
                        </td>
                        <td>
                            <b>{$val.discount} % </b>
                        </td>
                        <td>
                            {number_format($val.max_purchase_amount,0,'.',',')} ریال
                        </td>
                        <td>
                            {if $val.status eq 1}
                                <label class="uk-badge uk-badge-success">استفاده شده</label>
                            {elseif $val.status eq 0}
                                <label class="uk-badge uk-badge-muted">استفاده نشده</label>
                            {/if}
                        </td>
                        <td>{jdate format='j F Y - h:i a' date=$val->created_at}</td>
                        <td class="right">
                            <label class="uk-text-primary">
                                <a data-uk-tooltip title="ویرایش" class="uk-icon-button uk-icon-pencil uk-text-primary"
                                   href="{site_url({ADMIN_PATH|con:'/shop/shop/addCoupon/' : $val->id})}"></a>
                            </label>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>