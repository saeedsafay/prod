<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable uk-table-striped" id="dt_default" role="grid"
                   aria-describedby="dt_default_info">
                <thead>
                <tr>
                    <th class="sorting">شناسه داخلی تراکنش</th>
                    <th class="sorting">شناسه سفارش</th>
                    <th class="sorting">کاربر (شناسه کاربر)</th>
                    <th class="sorting">مبلغ</th>
                    <th class="sorting">تاریخ ثبت</th>
                    <th class="sorting">شرح</th>
                    <th class="sorting">شناسه تراکنش</th>
                    <th class="sorting">رهگیری پرداخت</th>
                    <th class="sorting">وضعیت</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th class="sorting">شناسه داخلی تراکنش</th>
                    <th class="sorting">شناسه سفارش</th>
                    <th class="sorting">کاربر (شناسه کاربر)</th>
                    <th class="sorting">مبلغ</th>
                    <th class="sorting">تاریخ ثبت</th>
                    <th class="sorting">شرح</th>
                    <th class="sorting">شناسه تراکنش</th>
                    <th class="sorting">رهگیری پرداخت</th>
                    <th class="sorting">وضعیت</th>
                </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                {foreach from=$transactions item=val}
                    <tr>
                        <td>
                            {$val.id}
                        </td>
                        <td>
                            {$val.order_id}
                        </td>
                        <td>
                            <a href="/{ADMIN_PATH}/users/users/edit/{$val.user.id}">
                                {$val.user.first_name} {$val.user.last_name} ({$val.user.id})
                            </a>
                        </td>
                        <td>
                            <b>{$val.amount|price_format}</b>
                        </td>
                        <td>
                            <label>
                                {jdate format='H:i:s - d F Y' date=$val.created_at}
                            </label>
                        </td>
                        <td>{$val.description}</td>
                        <td>
                            {$val.trans_id}
                        </td>
                        <td>
                            {$val.payment_track_id}
                        </td>
                        <td class="right">
                            {if $val.transaction_state_id == 1}
                                <span class="uk-badge uk-badge-success">
                                        پرداخت موفق
                                    </span>
                            {else}
                                <span class="uk-badge uk-badge-danger">
                                    پرداخت ناموفق ({$val.transaction_state_id})
                                    </span>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
