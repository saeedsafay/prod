<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {$title}
    </h3>
    <div class="uk-width-medium-2-3 uk-margin-top uk-margin-bottom">
        <a href="{site_url|con:ADMIN_PATH:'/shop/shop/product-list'}" class="uk-button btn-breadcrumb">بازگشت</a>

        {if $Product.status == 0 OR  $Product.status == 3 OR $Product.status == 2}
            <label class="uk-text-primary">
                <a class="md-btn md-btn-success md-btn-small"
                   href="{site_url({ADMIN_PATH|con:'/shop/shop/publication/' : $Product->id})}">تایید و انتشار</a>
            </label>
        {/if}
        {if $Product.status == 0 OR $Product.status == 1}
            <label class="uk-text-primary">
                <a class="md-btn md-btn-flat-danger md-btn-small"
                   href="{site_url({ADMIN_PATH|con:'/shop/shop/reject/' : $Product->id})}">رد کردن و بازبینی</a>
            </label>
        {/if}
        {*        <label class="uk-text-primary">*}
        {*            <a data-uk-tooltip title="ویرایش اطلاعات کالا" class="md-btn md-btn-flat-primary md-btn-small"*}
        {*               href="{site_url({ADMIN_PATH|con:'/shop/shop/edit/' : $Product->id})}">ویرایش کالا</a>*}
        {*        </label>*}
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-overflow-container">
                <div class="uk-width-medium-1-1 uk-margin-top">
                    <p class="">
                        فروشنده:
                        <label class="uk-text-primary">
                            <a href="{site_url({ADMIN_PATH|con:'/users/users/edit/':$Product.user.id})}">
                                {$Product.user.business_name}
                            </a>
                        </label>
                        |
                        تاریخ ثبت:
                        <label class="uk-text-primary"> {jdate form='h:i a j F Y' date=$Product.created_at}</label>
                        |
                        گروه و دسته محصول:
                        <label class="uk-text-primary"> {$Product->product_type->title} > {$Product->category->title} >
                            {$Product->child_category->title}</label>
                    </p>
                    متن توضیحات محصول:
                    <p>{$Product.desc}</p>
                    تصویر ضمیمه :
                    <br>
                    <img width="350" src="{$products_thumbnail_dir}{$Product.pic}"/>
                    <br>
                </div>
            </div>
        </div>
    </div>
</div>