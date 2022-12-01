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
                                            <a href="{$addURL}"
                                               class="btn btn-md btn-pink btn_product"><span>اضافه کردن</span></a>
                                            <table class="points_table">
                                                <thead>
                                                <tr>
                                                    <th>عکس</th>
                                                    <th>نام</th>
                                                    <th>دسته بندی</th>
                                                    <th>چند شاخه</th>
                                                    <th>قیمت</th>
                                                    <th>تاریخ آخرین تغییرات</th>
                                                    <th>عملیات</th>
                                                </tr>
                                                </thead>

                                                <tbody class="points_table_scrollbar">
                                                {$i = 0}
                                                {foreach $products as $val}
                                                    <tr class="{if $i % 2 == 0}even{else}odd{/if}">
                                                        <td><img class="img_tbl"
                                                                 src="{site_url}upload/products/pic/{$val.pic}"></td>
                                                        <td>
                                                            <p>
                                                                <a href="{$val->link}"
                                                                   target="_blank">
                                                                    {$val.title}
                                                                </a>
                                                            </p>
                                                        </td>
                                                        <td><p>{$val.category.title}</p></td>
                                                        <td><p>{$val.flower_count}</p></td>
                                                        <td><p>{$val.price|price_format}</p></td>
                                                        <td>
                                                            <p><label style="color:#8fdf82">
                                                                    {jdate format='j F Y H:i' date=$val.edited_time}
                                                                </label></p>
                                                        </td>
                                                        <td class="point_table_width_button">
                                                            {if $val.type eq 1}
                                                                {$method = 'add-product-pack'}
                                                            {elseif $val.type eq 2}
                                                                {$method = 'add-product-single'}
                                                            {else}
                                                                {$method = 'add-decoration'}
                                                            {/if}
                                                            <a href="{site_url}seller/manage-products/{$method}/{$val.id}"
                                                               class="btn btn-md btn-yellow"><span>ویرایش</span></a>
                                                            <a href="{site_url}seller/manage-products/delete/{$val.id}"
                                                               class="btn btn-md btn-red delete"
                                                               data-idads='{$val.id}' title="حذف این محصول"
                                                               data-placement="top"
                                                               data-toggle="confirmation-popout"><span>حذف</span></a>
                                                        </td>
                                                        {if $val->type != 3}
                                                            <td style="
                                                                    margin-top: 24px;   
                                                                    color: #282828;
                                                                    ">
                                                                <div>
                                                                    <select onchange="$(this).changeStock({$val.id})"
                                                                            id="stock_change_list{$val.id}"
                                                                            class="select_rm" style="
                                                                                width: 134%;
                                                                                ">
                                                                        <option value="" disabled="" selected="">انتخاب
                                                                            وضعیت
                                                                        </option>
                                                                        <option value="1"
                                                                                {if  $val.stock_type == 1}selected{/if}>
                                                                            موجود و امکان سفارش لحظه&zwnj;ای
                                                                        </option>
                                                                        <option value="2" selected=""
                                                                                {if  $val.stock_type == 2}selected{/if}>
                                                                            موجود و امکان سفارش از فردا به بعد
                                                                        </option>
                                                                        <option value="3"
                                                                                {if  $val.stock_type == 3}selected{/if}>
                                                                            ناموجود، نمایش بدون قیمت
                                                                        </option>
                                                                    </select>
                                                                </div>
                                                            </td>
                                                        {/if}
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



