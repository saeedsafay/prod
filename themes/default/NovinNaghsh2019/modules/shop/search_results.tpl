{add_css file="css/jquery-ui.css"}
{add_js file='js/cart.js' part='footer'}
{add_js file='js/shop_loc.js' part='footer'}


<nav class="section-wrap py-0">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <a href="{site_url}">خانه</a>
        </li>
        <li class="breadcrumb-item active">
            جستجوی عبارت: {$q}
        </li>
    </ol>
</nav>

{add_js file='js/jquery.hideseek.min.js' part='footer'}
{add_js file='js/cart.js' part='footer'}
{add_js file='js/shop_loc.js' part='footer'}

<section class="section-wrap section-low-margin">
    <form action="" method="GET" class="filter-form js-filter-form">
        <div class="row">
            <div class="col-12 col-sm-8 col-md-12 col-lg-12">
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
                                            <h3><a class="product-title" href="{site_url()|con:'product/':$val->slug}">{$val.title}</a></h3>
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
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </form>
</section>


{*

<section class="section-wrap section-low-margin">
<div class="container">
<div class="row row-10">    
<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
<div class="width_sort_str"> 
<label class="lbl_sort">جستجوی عبارت: <strong>{$q}</strong></label>
</div>
{if $Products == false}
<div class="col-md-12 col-lg-12 col-sm-12 alert alert-danger">
<label class="text-warning"> 
محصولی یافت نشد
</label>
</div>
{else}
<div class="row">
{foreach from=$Products item=val}
<div class="col-md-3 col-sm-12 col-xs-12 pull-right item{$val.id}">
<div class="list-product-wrapp">
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
<span class="sold-out valign">موجود نیست</span>
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
<div class="product-details">
<h3>
<a class="product-title" href="{site_url()|con:'product/':$val->slug}">{summary text=$val.title limit=70}</a>
</h3>
<p class="margin_botton">
<a target="_blank" href="{site_url}users/profile/{$val.user.username}">
{$val.user.business_name}
</a>
</p>
<span class="price">
{if $val.discount_price != null}
<del>
<span>{$val.price|price_format}</span>
</del>
<ins>
<span class="ammount">{$val.discount_price|price_format}</span>
</ins>
{else}
<ins>
<span class="ammount">{$val.price|price_format}</span>
</ins>
{/if}
</span>
</div>                          
</div>
</div>
{/foreach}
</div> 
{/if}
</div> <!-- end col -->
</div>
</div>
</section> <!-- end new arrivals -->

*}

