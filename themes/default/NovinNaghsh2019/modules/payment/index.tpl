<div class="ht-bradcaump-area bg-1">
</div>

<!-- wishlist-area start -->
<div class="wishlist-area">
    <div class="container">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="wishlist-content">
                    <div class="wishlist-title">
                        <h2>
                        </h2>
                    </div>
                    {if $transactions->isEmpty()}
                        <div class="col-md-12">
                            <div class="entry-header">
                                <label class="text-warning pull-right rtl">رکوردی یافت نشد</label>
                                <br>
                                <br>
                            </div>
                        </div>
                    {else}
                        <div class="wishlist-table table-responsive">
                            <table>
                                <thead class="myads">
                                    <tr>
                                        <th class="product-name"><span class="nobr">شناسه داخلی تراکنش</span></th>
                                        <th class="product-stock-stauts"><span class="nobr">مبلغ پرداختی</span></th>
                                        <th class="product-price"><span class="nobr"> شرح </span></th>
                                        <th class="product-stock-stauts"><span class="nobr">تاریخ ثبت</span></th>
                                        <th class="product-stock-stauts"><span class="nobr">وضعیت</span></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach from=$transactions item=val}
                                        <tr id="delete_ads{$val.id}">
                                            <td class="product-name">
                                                {$val.id}
                                            </td>
                                            <td class="product-name">
                                                {$val.price|price_format}
                                            </td>
                                            <td class="product-name">
                                                {$val.description}
                                            </td>
                                            <td class="product-name">
                                                <label style="color:#8fdf82">
                                                    {jdate format='j F Y' date=$val.created_at}
                                                </label>
                                            </td>
                                            <td class="product-name">
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
<!-- wishlist-area end -->
