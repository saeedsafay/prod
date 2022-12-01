<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-1-6 uk-margin-small-bottom">
                <a class="md-btn md-btn-success" href="{site_url({ADMIN_PATH|con:"/shop/thematic-categories/edit"})}">افزودن
                    دسته
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
                    <th class="sorting">شناسه</th>
                    <th class="sorting">عنوان دسته بندی موضوعی</th>
                    <th class="sorting">دسته بندی موضوعی والد</th>
                    <th class="sorting">گروه کالا</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th class="sorting">شناسه</th>
                    <th class="sorting">عنوان دسته بندی موضوعی</th>
                    <th class="sorting">دسته بندی موضوعی والد</th>
                    <th class="sorting">گروه کالا</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                {foreach from=$productCategories item=val}
                    <tr data-id="{$val->id}" data-parent="">
                        <td><strong class="uk-text-large uk-text-bold">{$val->id}</strong></td>
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
                        <td class="right">
                            <a class="md-btn md-btn-primary md-btn-small"
                               href="{site_url({ADMIN_PATH|con:'/shop/thematic-categories/edit/' : $val->id})}">ویرایش</a>
                            <a href="{site_url({ADMIN_PATH|con:'/shop/thematic-categories/delete/':$val->id})}"
                               class="md-btn md-btn-small md-btn-danger delete" id="delete-btn">حذف دسته بندی</a>
                            <a class="md-btn md-btn-info md-btn-small"
                               href="{site_url({ADMIN_PATH|con:'/shop/thematic-categories/edit?parent_id=' : $val->id})}">افزودن
                                زیر-دسته بندی</a>
                        </td>
                    </tr>
                    {foreach $val->childrenCategories as $child}
                        {include file="modules/shop/thematic_category/recursiveChildren.tpl" parent_id=$val->id}
                    {/foreach}
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>