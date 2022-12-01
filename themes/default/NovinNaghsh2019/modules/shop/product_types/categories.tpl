<!-- MAIN -->
<main class="site-main site-categoies js-get-pages-id------" id="js-categories">
    <div class="container">
        <ol class="breadcrumb-page">
            <li><a href="/">صفحه اصلی </a></li>
            <li class="active">{$productType->title}</li>
        </ol>
    </div>
    <div class="background-categories-top mt-10 mb-15"
            {if $productType->image != null}
        style="background-image: url('/upload/product-types/pic/{$productType->image}') !important;"
            {/if}>
        <div class="container">
            <div class="content">
                <h3 class="headline-3 font-size-10">{$title}</h3>
                <p class="font-size-6 font-weight-ultralight line-height-4 mb-15">
                    {if $productType->descriptions}
                        {$productType->descriptions}
                    {/if}
                </p>
            </div>
        </div>
    </div>
    <div class="block-top-categori">
        <div class="container">
            <div class="row row-10">
                {foreach $productType->mainCategories as $category}
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-20">
                        <div class="block-top-categori-item">
                            <a href="{site_url()}{$category->link}">
                                <img src="{$products_pic_dir}{$category->image}" alt="{$category->title}">
                            </a>
                            <div class="block-top-categori-title">{$category->title}</div>
                        </div>
                    </div>
                {/foreach}
            </div>
{*            <div class="row row-10">*}
{*                <div class="block-promotion-banner">*}
{*                    <div class="col-sm-5 col-xs-5">*}
{*                        <div class="promotion-banner style-6 mb-20 mt-0">*}
{*                            <a href="#" class="banner-img"><img src="{assets_url}images/home3/banner4.jpg"*}
{*                                                                alt="banner4"></a>*}
{*                        </div>*}
{*                    </div>*}
{*                    <div class="col-sm-7 col-xs-7">*}
{*                        <div class="promotion-banner style-6 mb-20 mt-0">*}
{*                            <a href="#" class="banner-img">*}
{*                                <img src="{assets_url}images/home3/banner3.jpg" alt="banner3">*}
{*                            </a>*}
{*                        </div>*}
{*                    </div>*}
{*                </div>*}
{*            </div>*}
        </div>
    </div>
</main><!-- end MAIN -->