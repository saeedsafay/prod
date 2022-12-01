<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-3-6 uk-margin-small-bottom">
                <a class="md-btn md-btn-primary md-btn-small"
                   href="{site_url({ADMIN_PATH|con:"/shop/diversities/edit/":$diversity->id})}">
                    ویرایش مولفه تنوع {$diversity->label}
                </a>
                <a class="md-btn md-btn-flat-primary md-btn-small"
                   href="{site_url({ADMIN_PATH|con:"/shop/diversities"})}">لیست
                    تنوع ها</a>
                <a class="md-btn md-btn-success md-btn-small"
                   href="{site_url({ADMIN_PATH|con:"/shop/diversities/edit"})}">افزودن
                    تنوع جدید</a>
            </div>
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable uk-table-striped" id="dt_default" role="grid"
                   aria-describedby="dt_default_info">
                <thead>
                <tr>
                    <th class="sorting">عنوان مقدار</th>
                    <th class="sorting">تصویر</th>
                    <th class="sorting">دسته‌بندی</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th class="sorting">عنوان مقدار</th>
                    <th class="sorting">تصویر</th>
                    <th class="sorting">دسته‌بندی</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                {foreach from=$diversity->values item=val}
                    <tr>
                        <td>{$diversity->label}: {$val->title}</td>
                        <td>
                            <img src="/upload/variants/{$val.image}" alt="{$val->title}" width="120">
                        </td>
                        <td>{$diversity->parent_category->title} > {$diversity->child_category->title}</td>
                        <td class="right">
                            <div class=" uk-margin-top">
                                <a class="md-btn md-btn-primary"
                                   href="{site_url({ADMIN_PATH|con:'/shop/diversities/editValue/':$val.id})}">ویرایش</a>
                            </div>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>