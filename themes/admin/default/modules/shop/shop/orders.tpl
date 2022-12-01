<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-1-6 uk-margin-small-bottom">
            </div>
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable fuk-table-striped" id="dt_default" role="grid" aria-describedby="dt_default_info">
                <thead>
                    <tr>
                        <th class="sorting">شناسه سفارش</th>
                        <th class="sorting">خریدار</th>
                        <th class="sorting">مجموع مبلغ سفارش</th>
                        <th class="sorting">شناسه داخلی تراکنش</th>
                        <th class="sorting">وضعیت</th>
                        <th class="sorting">تاریخ ثبت پرداخت</th>
                        <th class="no-sort">عملیات</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th class="sorting">شناسه سفارش</th>
                        <th class="sorting">خریدار</th>
                        <th class="sorting">مجموع مبلغ سفارش</th>
                        <th class="sorting">شناسه داخلی تراکنش</th>
                        <th class="sorting">وضعیت</th>
                        <th class="sorting">تاریخ ثبت پرداخت</th>
                        <th class="no-sort">عملیات</th>
                    </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                    {foreach from=$Orders item=val}
                        <tr>
                            <td>
                                {$val.id}
                            </td>
                            <td>
                                <a href="{site_url({ADMIN_PATH|con:'/users/users/edit/':$val.user.id})}">{$val.user.first_name} {$val.user.last_name}</a>
                            </td>
                            <td>
                                {$val.total|price_format}
                            </td>
                            <td>
                                {$val.transaction.id}
                            </td>
                            <td>
                                {if $val.status eq 1}
                                    <label class="uk-badge uk-badge-success">پرداخت شده</label>
                                {elseif $val.status eq 2}
                                    <label class="text-success">ارسال شده</label>
                                {elseif $val.status eq 3}
                                    <label class="text-success">تحویل شده</label>
                                {/if}
                            </td>
                            <td>{jdate format='j F Y - h:i a' date=$val->pay_at}</td>
                            <td class="right">
                                <label class="uk-text-primary">
                                    <a data-uk-tooltip  title="نمایش سفارش"  class="uk-icon-button uk-icon-eye uk-text-primary" href="{site_url({ADMIN_PATH|con:'/shop/shop/view-order/' : $val->id})}"></a>
                                </label>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>