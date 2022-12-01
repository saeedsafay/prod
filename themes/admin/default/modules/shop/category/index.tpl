<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-1-6 uk-margin-small-bottom">
                <a class="md-btn md-btn-success" href="{site_url({ADMIN_PATH|con:"/shop/categories/edit"})}">افزودن دسته
                    بندی</a>
            </div>
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="collaptable uk-table dataTable uk-table-striped" id="dt_default" role="grid"
                   aria-describedby="dt_default_info">
                <thead>
                <tr>
                    <th class="sorting">عنوان دسته بندی</th>
                    <th class="sorting">دسته بندی والد</th>
                    <th class="sorting">گروه کالا</th>
                    <th class="sorting">دارای فرم سفارش</th>
                    <th class="sorting">تاریخ آخرین تغییرات</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th class="sorting">عنوان دسته بندی</th>
                    <th class="sorting">دسته بندی والد</th>
                    <th class="sorting">گروه کالا</th>
                    <th class="sorting">دارای فرم سفارش</th>
                    <th class="sorting">تاریخ آخرین تغییرات</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                {foreach from=$productCategories item=val}
                    <tr data-id="{$val->id}" data-parent="">
                        <td><strong class="uk-text-large uk-text-bold">{$val->title}</strong></td>
                        <td>
                            ---
                        </td>
                        <td>
                            {if $val->product_type_id != null}
                                <strong>{$val.product_type.title}</strong>
                            {else}
                                ---
                            {/if}
                        </td>
                        <td>
                            {if $val->has_order_form}
                                <span class="uk-icon-check uk-text-success"></span>
                            {else}
                                <span class="uk-icon-close uk-text-danger"></span>
                            {/if}
                        </td>
                        <td>
                            {if isset($val->updated_at)}
                                {jdate format='j F Y - h:i a' date=$val->updated_at}
                            {else}
                                {'بدون تغییرات'}
                            {/if}
                        </td>
                        <td class="right">
                            <a class="md-btn md-btn-primary md-btn-small"
                               href="{site_url({ADMIN_PATH|con:'/shop/categories/edit/' : $val->id})}">ویرایش</a>
                            <a href="{site_url({ADMIN_PATH|con:'/shop/categories/delete/':$val->id})}"
                               class="md-btn md-btn-small md-btn-danger delete" id="delete-btn">حذف دسته بندی</a>
                            <a class="md-btn md-btn-info md-btn-small"
                               href="{site_url({ADMIN_PATH|con:'/shop/categories/edit?parent_id=' : $val->id})}">افزودن
                                زیر-دسته بندی</a>
                        </td>
                    </tr>
                    {foreach $val->children as $child}
                        <tr data-id="{$child->id}" data-parent="{$val->id}">
                            <td><span class="uk-text-italic">{$child->title}</span></td>
                            <td>
                                {$val.title}
                            </td>
                            <td>
                                {if $child->product_type_id != null}
                                    {$val.product_type.title}
                                {else}
                                    ---
                                {/if}
                            </td>
                            <td>
                                {if $child->has_order_form}
                                    <span class="uk-icon-check uk-text-success"></span>
                                {else}
                                    <span class="uk-icon-close uk-text-danger"></span>
                                {/if}
                            </td>
                            <td>
                                {if isset($child->updated_at)}
                                    {jdate format='j F Y - h:i a' date=$child->updated_at}
                                {else}
                                    {'بدون تغییرات'}
                                {/if}
                            </td>
                            <td class="right">
                                <a class="md-btn md-btn-primary md-btn-small"
                                   href="{site_url({ADMIN_PATH|con:'/shop/categories/edit/' : $child->id})}">ویرایش</a>
                                {if $val.category.id != 1 OR $val.category.id != 2}
                                    <a href="{site_url({ADMIN_PATH|con:'/shop/categories/delete/':$child->id})}"
                                       class="md-btn md-btn-small md-btn-danger delete" id="delete-btn">حذف دسته
                                        بندی</a>
                                {/if}
                            </td>
                        </tr>
                    {/foreach}
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>