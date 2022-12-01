{add_js file='js/cart.js' part='footer'}
{add_js file='js/shop_loc.js' part='footer'}

<nav class="section-wrap py-0">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <a href="{site_url}">صفحه‌اصلی</a>
        </li>
        <li class="breadcrumb-item">
            {$current_product_type}
        </li>
        {if isset($currentCategory) || isset($parentCatList)}
            <li class="breadcrumb-item">
                {$currentCategory.parentCat.title}
            </li>
        {/if}
        {if isset($currentCategory) && !isset($parentCatList)}
            <li class="breadcrumb-item">
                {$currentCategory.title}
            </li>
        {/if}
    </ol>
</nav>
<section class="section-wrap section-low-margin">
    <form action="" method="GET" class="filter-form">
        <div class="row">
            <div class="col-12 col-sm-4 col-md-3 col-lg-2 d-none d-sm-block">
                {* FOR PRODUCT TYPE MAIN LIST *}
                {if isset($ProductTypeList)}
                    <div class="filter-wrapper">
                        <h5 class="filter-title">{$Product_type.title}</h5>
                        <ul class="scroll_check">
                            {foreach $p_cats as $cat}
                                <li>
                                    <input name="cat_id" value="{site_url}prd/{$cat->product_type->slug}/{$cat.slug}" type="radio" class=" cat-options input-radio" id="cat-{$cat.id}">
                                    <label for="cat-{$cat.id}">
                                        {$cat.title} [{$cat->product->count()|persian_number}]
                                    </label>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                {/if}
                {if isset($parentCatList)}
                    <div class="filter-wrapper">
                        <h5 class="filter-title">{$p_cat.title}</h5>
                        <ul class="scroll_check">
                            {foreach $p_cat->children as $cat}
                                <li>
                                    <input name="cat_id" value="{site_url}prd/{$p_cat->product_type->slug}/{$cat.slug}" type="radio" class=" cat-options input-radio" id="cat-{$cat.id}" {if $p_cat->id eq $cat->id}checked=""{/if}>
                                    <label for="cat-{$cat.id}">
                                        {$cat.title} [{$cat->child_cat_products->count()|persian_number}]
                                    </label>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                {/if}
                {if isset($currentCategory) && !isset($parentCatList)}
                    <div class="filter-wrapper">
                        <h5 class="filter-title">{$currentCategory.parentCat.title}</h5>
                        <ul class="scroll_check">
                            {foreach $currentCategory->parentCat->children as $cat}
                                <li>
                                    <input name="cat_id" value="{site_url}prd/{$currentCategory->product_type->slug}/{$cat.slug}" type="radio" class=" cat-options input-radio" id="cat-{$cat.id}" {if $currentCategory->id eq $cat->id}checked=""{/if}>
                                    <label for="cat-{$cat.id}">
                                        {$cat.title} [{$cat->child_cat_products->count()|persian_number}]
                                    </label>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                {/if}
                {$i = 0}
                {foreach $product_type_filters as $filter}
                    {if $filter->show_filter != 1}
                        {continue}
                    {/if}
                    <div class="filter-wrapper">
                        <h5 class="filter-title">{$filter->label}</h5>
                        <ul class="scroll_check">
                            {*  <li>
                            <input onchange="this.form.submit()" value="{site_url}prd/همه{'?'|con:$filters}" type="radio" class="input-radio" id="{$filter->label}{$i}" {if $slug == 'همه'}checked=""{/if}>
                            <label for="{$filter->label}{$i}">همه</label>
                            </li>*}
                            {foreach $filter->values as $val}
                                <li>
                                    <input onchange="this.form.submit()" name="dynamic_filter[{$filter->name}]" value="{$val.id}" type="radio" class="input-radio" id="{$filter->name}{$val.id}-{$i}"  {if $dynamic_filter_values AND array_key_exists($filter.name, $dynamic_filter_values)}{if $dynamic_filter_values[$filter.name] eq $val->id}checked=''{/if}{/if}>
                                    <label for="{$filter->name}{$val.id}-{$i}">
                                        {if $val->is_color}
                                            <span style='
                                                    padding: 1px 13px 0px 13px;
                                                    border-radius: 7px;
                                                    color:{$val.title};
                                                    background-color: {$val.title}'>&nbsp;</span>
                                        {else}
                                            {$val.title} [{$val->products->count()|persian_number}]
                                        {/if}
                                    </label>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                    {$i = $i + 1}
                {/foreach}
                <div>
                    <label class="price_lbl">جستجو برحسب قیمت</label>
                    از <input type="text" id="amount1" name="min_price">
                    تا <input type="text" id="amount2" name="max_price"> تومان
                    <div id="slider-range"></div>
                    <input class="btn btn-sm  btn-light" type="submit" value="جستجو کنید">
                </div>
            </div>
            <div class="col-12 col-sm-8 col-md-9 col-lg-10">
                <div class="list-product-wrapp">
                    <div class="row">
                        {if $Products == false}
                            <div class="col-12 col-md-8 col-lg-5 mx-auto mt-40 mb-50">
                                <div class="alert alert-danger text-center">
                                    <p class="text-danger mb-0">
                                        محصولی یافت نشد
                                    </p>
                                </div>
                            </div>
                        {else}
                            <div class="col-12 pt-20 mb-70 top-middle-flex">
                                <h2 class="list-title">شال و روسری</h2>
                                <div class="width_sort_str mr-auto top-middle-flex">
                                    <label class="lbl_sort">:مرتب‌سازی بر اساس</label>
                                    <select class="filter-options" name="sort">

                                        <option {if $currentOrder eq 'newest'}selected{/if}  value="newest">جدیدترین</option>
                                        <option {if $currentOrder eq 'highPrice'}selected{/if} value="highPrice">بیشترین قیمت</option>
                                        <option {if $currentOrder eq 'lowPrice'}selected{/if}  value="lowPrice">کمترین قیمت</option>
                                        <option {if $currentOrder eq 'sold'}selected{/if}  value="sold">پرفروش‌ترین</option>
                                        <option {if $currentOrder eq 'mostVisted'}selected{/if}  value="mostVisted">پربازدیدترین</option>
                                    </select>
                                </div>
                            </div>
                            {foreach from=$Products item=val}
                                <div class="col-12 col-sm-12 col-md-6 col-lg-4 col-xl-3 item{$val.id} mb-30">
                                    <div class="product-item {if $val.stock_type eq 3} sold-out-wrapp {/if}">
                                        <div class="product-img">
                                            <a href="{site_url()|con:'product/':$val->slug}">
                                                <img src="{$products_thumbnail_dir}{$val.pic}" alt="{$val.title}">
                                            </a>
                                            {if $val.is_discount}
                                                <div class="product-label">
                                                    <span class="sale">حراجی</span>
                                                </div>
                                            {/if}
                                            {if $val.stock_type eq 3}
                                                <div class="sold-out valign">موجود نیست</div>
                                            {/if}
                                            <div class="product-quickview">
                                                <div class="product-actions">
                                                    <a href="#" onclick="$(this).addFavorite({$val.id})" class="product-add-to-wishlist" data-toggle="tooltip" data-placement="bottom" title="اضافه به علاقه مندی">
                                                        <i class="fa fa-heart"></i>
                                                    </a>
                                                    <a href="#"  onclick="$(this).addToCart({$val.id})" class="product-add-to-wishlist" data-toggle="tooltip" data-placement="bottom" title="اضافه به سبد خرید">
                                                        <i class="fa fa-shopping-basket"></i>
                                                    </a>
                                                    <input type="hidden" class="item-qty" value="1" />
                                                </div>
                                                <a href="{site_url()|con:'product/':$val->slug}" class="btn-custom">نمایش محصول</a>
                                            </div>
                                        </div>
                                        <div class="product-details text-center">
                                            <h3><a class="product-title" href="{site_url()|con:'product/':$val->slug}">{summary text=$val.title limit=70}</a></h3>
                                            <div class="mb-10">
                                                <a target="_blank" href="{site_url}users/profile/{$val.user.username}">
                                                    {$val.user.business_name}
                                                </a>
                                            </div>
                                            {*  <p class="margin_botton">
                                            {if $val.stock_type eq 1}
                                            آماده ارسال
                                            {elseif $val.stock_type eq 2}
                                            قابل سفارش
                                            {elseif $val.stock_type eq 3}
                                            ناموجود
                                            {/if}
                                            </p>
                                            *}
                                            <div class="price-relative">
                                                {if $val.discount_price != null}
                                                    <div class="old-price">
                                                        <span>{$val.price|price_format}</span>
                                                    </div>
                                                    <div class="new-price">
                                                        <span>{$val.discount_price|price_format}</span>
                                                    </div>
                                                {else}
                                                    <div class="new-price">
                                                        <span class="ammount">{$val.price|price_format}</span>
                                                    </div>
                                                {/if}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                            <nav class="col-12 mb-50">
                                <ul class="pagination justify-content-center">
                                    {$paging}
                                </ul>
                            </nav>

                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </form>
</section>