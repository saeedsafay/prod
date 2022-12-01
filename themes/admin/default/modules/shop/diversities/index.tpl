<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-1-6 uk-margin-small-bottom">
                <a class="md-btn md-btn-success" href="{site_url({ADMIN_PATH|con:"/shop/diversities/edit"})}">افزودن
                    تنوع</a>
            </div>
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable uk-table-striped" id="dt_default" role="grid"
                   aria-describedby="dt_default_info">
                <thead>
                <tr>
                    <th class="sorting">برچسب</th>
                    <th class="sorting">نوع محصول</th>
                    <th class="sorting">دسته‌بندی والد</th>
                    <th class="sorting">دسته‌بندی دوم</th>
                    <th class="sorting">تاریخ ایجاد</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th class="sorting">برچسب</th>
                    <th class="sorting">نوع محصول</th>
                    <th class="sorting">دسته‌بندی والد</th>
                    <th class="sorting">دسته‌بندی دوم</th>
                    <th class="sorting">تاریخ ایجاد</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                {foreach from=$Diversities item=val}
                    <tr>
                        <td>{$val->label}</td>
                        <td>{if $val->product_type}{$val->product_type->title}{/if}</td>
                        <td>{if $val->parent_category}{$val->parent_category->title}{/if}</td>
                        <td>{if $val->child_category}{$val->child_category->title}{/if}</td>
                        <td>{jdate format='j F Y - h:i a' date=$val->created_at}</td>
                        <td class="right">
                            {if $val->can_set_value_price}
                                <a class="md-btn md-btn-flat-success md-btn-small"
                                   href="{site_url({ADMIN_PATH|con:'/shop/diversities/values/' : $val->id})}">قیمت
                                    گذاری</a>
                            {/if}
                            <a class="md-btn md-btn-primary md-btn-small"
                               href="{site_url({ADMIN_PATH|con:'/shop/diversities/edit/' : $val->id})}">ویرایش</a>
                            {if $val.deleted}
                                <a href="{site_url({ADMIN_PATH|con:'/shop/diversities/restore/':$val.id})}"
                                   class="md-btn md-btn-small md-btn-flat-warning">بازگردانی</a>
                            {else}
                                <a href="{site_url({ADMIN_PATH|con:'/shop/diversities/delete/':$val.id})}"
                                   class="md-btn md-btn-small md-btn-danger delete">حذف</a>
                            {/if}

                            <a class="md-btn md-btn-flat-primary md-btn-small"
                               href="{site_url({ADMIN_PATH|con:"/shop/diversities/values/{$val->id}"})}">
                                مدیریت مقدارها
                            </a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>