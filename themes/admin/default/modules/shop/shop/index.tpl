<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            {*            <div class="uk-width-medium-1-6 uk-margin-small-bottom">*}
            {*                <a class="md-btn md-btn-success" href="{site_url()|con:ADMIN_PATH}/shop/shop/add-product">*}
            {*                    <i class="uk-icon-plus-square uk-text-muted"></i> افزودن محصول </a>*}
            {*            </div>*}
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table fuk-table-striped" role="grid"
                   aria-describedby="dt_default_info">
                <thead>
                <tr>
                    <th class="sorting">تصویر</th>
                    <th class="sorting">شناسه NPI محصول</th>
                    <th class="sorting">کد طرح</th>
                    <th class="sorting">عنوان</th>
                    <th class="sorting">نوع محصول</th>
                    <th class="sorting">وضعیت</th>
                    <th class="sorting">فروشنده</th>
                    <th class="sorting">تاریخ ایجاد</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th class="sorting">تصویر</th>
                    <th class="sorting">شناسه NPI محصول</th>
                    <th class="sorting">کد طرح</th>
                    <th class="sorting">عنوان</th>
                    <th class="sorting">نوع محصول</th>
                    <th class="sorting">وضعیت</th>
                    <th class="sorting">فروشنده</th>
                    <th class="sorting">تاریخ ایجاد</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </tfoot>
                <tbody class="uk-table-striped">
                {foreach from=$Products item=val}
                    <tr>
                        <td>
                            <img src="{$products_thumbnail_dir}{$val.pic}" alt="{$val.id}" width="120">
                        </td>
                        <td>NPI-{$val->id}</td>
                        <td>{$val->internal_code}</td>
                        {*                            <td><span title="{$val->title}">{summary limit=70 text=$val->title}</span></td>*}
                        <td>
                            <strong>
                            <span title="{$val->title}">
                                {$val->title}
                            </span>
                            </strong>

                        </td>
                        <td>
                            {$val->product_type->title} > {$val->category->title} >
                            {$val->child_category->title}
                        </td>
                        <td>
                            {if $val.soft_delete eq 1}
                                <span class="uk-badge uk-badge-danger">
                                        حذف شده
                                    </span>
                            {elseif $val.status eq 0}
                                <span class="uk-badge uk-badge-notification">
                                        در حال بررسی
                                    </span>
                            {elseif $val.status == 1}
                                <span class="uk-badge uk-badge-success">
                                        تایید و انتشار
                                    </span>
                            {elseif $val.status eq 2}
                                رد شده
                            {elseif $val.status eq 3}
                                <span class="uk-badge uk-badge-warning">
                                        بازبینی مجدد
                                    </span>
                            {else}
                                انتشار
                            {/if}
                        </td>
                        <td>
                            <label class="uk-text-success">
                                <a href="/{ADMIN_PATH}/users/users/edit/{$val.user.id}" target="_blank">
                                    {$val.user.business_name}
                                </a>
                            </label>
                        </td>
                        {*<td>
                            {if  $val.stock_type == 1}
                                <label class="text-success">
                                    موجود و امکان سفارش لحظه‌ای
                                </label>
                            {elseif  $val.stock_type == 2}
                                <label class="text-info">
                                    موجود و امکان سفارش از فردا به بعد
                                </label>
                            {elseif  $val.stock_type == 3}
                                <label class="text-danger">
                                    ناموجود، نمایش بدون قیمت
                                </label>
                            {/if}
                        </td>*}
                        <td>{jdate format='j F Y - h:i a' date=$val->created_at}</td>
                        <td class="right">

                            {if $val.status == 0 OR  $val.status == 3 OR $val.status == 2}
                                <label class="uk-text-primary">
                                    <a data-uk-tooltip title="تایید و انتشار"
                                       class="uk-icon-button uk-icon-check uk-text-success"
                                       href="{site_url({ADMIN_PATH|con:'/shop/shop/publication/' : $val->id})}"></a>
                                </label>
                            {/if}
                            {if $val.status == 1 OR  $val.status == 0}
                                <label class="uk-text-primary">
                                    <a data-uk-tooltip title="بازبینی مجدد"
                                       class="uk-icon-button uk-icon-close uk-text-danger"
                                       href="{site_url({ADMIN_PATH|con:'/shop/shop/reject/' : $val->id})}"></a>
                                </label>
                            {/if}
                            {if $val.status == 4 AND 0}
                                <label class="uk-text-primary">
                                    <a class="uk-icon-button uk-icon-eye-slash uk-text-danger"
                                       href="{site_url({ADMIN_PATH|con:'/shop/shop/toggleStatus/' : $val->id})}"></a>
                                </label>
                            {/if}
                            <label class="uk-text-primary">
                                <a data-uk-tooltip title="نمایش آیتم" class="uk-icon-button uk-icon-eye uk-text-primary"
                                   href="{site_url({ADMIN_PATH|con:'/shop/shop/view-product/' : $val->id})}"></a>
                            </label>
                            <label class="uk-text-primary">

                                <a data-uk-tooltip title="حذف"
                                   class="uk-icon-button uk-icon-trash uk-text-danger delete"
                                   href="{site_url({ADMIN_PATH|con:'/shop/shop/delete/' : $val->id})}"></a>
                            </label>
                            <label class="uk-text-primary">

                                <a data-uk-tooltip title="ویرایش" class="uk-icon-button uk-icon-pencil uk-text-primary"
                                   href="{site_url({ADMIN_PATH|con:'/shop/shop/edit/' : $val->id})}"></a>
                            </label>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="md-card">
                <div class="md-card-content md-24 md-card-fullscreen">
                    <span class="uk-badge uk-notify-message-info">صفحه {$pagination['current_page']} از {$pagination['last_page']}</span>
                    <ul class="uk-pagination ">
                        {if $pagination['current_page'] != $pagination['last_page'] }
                            <li class="md-btn md-btn-flat-primary"
                                data-page="last">
                                <a class="page-link"
                                   href="{$pagination['last_page_url']}">آخرین</a>
                            </li>
                            <li class="md-btn md-btn-flat-primary"
                                data-page="next">
                                <a class="page-link"
                                   href="{$pagination['next_page_url']}">بعدی</a>
                            </li>
                            <li class="uk-pagination-left md-btn md-btn-flat-success"
                                data-page="2">
                                <a class="page-link"
                                   href="{$pagination['next_page_url']}">{($pagination['current_page']+1)}</a>
                            </li>
                            <li class="uk-button uk-active md-btn md-btn-success" data-page="1">
                                <sapn class="page-link">
                                    {$pagination['current_page']}
                                </sapn>
                            </li>
                            {if $pagination['current_page'] > 1 }
                                <li class="uk-pagination-previous md-btn md-btn-flat-primary"
                                    data-page="prev">
                                    <a class="uk-button-link"
                                       href="{$pagination['prev_page_url']}">قبلی</a>
                                </li>
                                <li class="md-btn-flat-primary md-btn"
                                    data-page="first">
                                    <a class="page-link"
                                       href="{$pagination['first_page_url']}">اولین</a>
                                </li>
                            {/if}
                        {/if}
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>