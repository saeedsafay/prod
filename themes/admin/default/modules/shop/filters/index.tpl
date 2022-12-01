<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-1-6 uk-margin-small-bottom">
                <a class="md-btn md-btn-success" href="{site_url({ADMIN_PATH|con:"/shop/filters/edit"})}">افزودن فیلتر</a>
            </div>
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable uk-table-striped" id="dt_default" role="grid" aria-describedby="dt_default_info">
                <thead>
                    <tr>
                        <th class="sorting">برچسب</th>
                        <th class="sorting">نوع</th>
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
                        <th class="sorting">نوع</th>
                        <th class="sorting">نوع محصول</th>
                        <th class="sorting">دسته‌بندی والد</th>
                        <th class="sorting">دسته‌بندی دوم</th>
                        <th class="sorting">تاریخ ایجاد</th>
                        <th class="no-sort">عملیات</th>
                    </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                    {foreach from=$Filters item=val}
                        <tr>
                            <td>{$val->label}</td>
                            <td>{if $val->field_type eq 1}لیست چندانتخابی{elseif $val->field_type eq 2 }لیست تک انتخابی{else}فیلد متنی{/if}</td>
                            <td>{if $val->product_type}{$val->product_type->title}{/if}</td>
                            <td>{if $val->parent_category}{$val->parent_category->title}{/if}</td>
                            <td>{if $val->child_category}{$val->child_category->title}{/if}</td>
                            <td>{jdate format='j F Y - h:i a' date=$val->created_at}</td>
                            <td class="right">
                                <a class="md-btn md-btn-primary md-btn-small" href="{site_url({ADMIN_PATH|con:'/shop/filters/edit/' : $val->id})}">ویرایش</a>
                                <a href="{site_url({ADMIN_PATH|con:'/shop/filters/delete/':$val.id})}" class="md-btn md-btn-small md-btn-danger delete">حذف</a>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>