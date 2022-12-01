<!-- MAIN -->
{add_css file="css/smart_wizard.min.css"}

{if isset($hasForm) && $hasForm}
    <script>
        var InitFormData = '{$jsonData}';
    </script>
    {$payload = json_decode($jsonData)}
    <main class="site-main js-get-pages-id" id="js-upload-detail">
        <div class="container">
            <ol class="breadcrumb-page">
                <li><a href="/">صفحه اصلی </a></li>
                <li class="">
                    <a href="{site_url}prd/{$Product_type.slug}">{$current_product_type}</a>
                </li>
                {if isset($currentCategory) || isset($parentCatList)}
                    <li>
                        <a href="{site_url()}{$currentCategory.parentCat.link}">{$currentCategory.parentCat.title}</a>
                    </li>
                {/if}
                {if isset($currentCategory) && !isset($parentCatList)}
                    <li class="active">
                        {$currentCategory.title}
                    </li>
                {/if}
            </ol>
        </div>
        <div class="upload-head text-center">
            <div class="container">
                <h1 class="headline-2">
                    سفارش چاپ {$currentCategory->parentCat->title} - {$currentCategory->title}
                </h1>

            </div>
        </div>
        {include file="modules/shop/product_wizard.tpl"}
    </main>
{/if}

<main class="site-main product-list product-grid product-grid-right js-get-pages-id" id="js-product-list">
    {if !(isset($hasForm) && $hasForm)}
        <div class="container">
            <ol class="breadcrumb-page">
                <li><a href="/">صفحه اصلی </a></li>
                <li class="">
                    <a href="{site_url()}prd/{$Product_type.slug}">{$current_product_type}</a>
                </li>
                {if isset($currentCategory) || isset($parentCatList)}
                    <li>
                        <a href="{site_url()}{$currentCategory->parentCat->link}">{$currentCategory.parentCat.title}</a>
                    </li>
                {/if}
                {if isset($currentCategory) && !isset($parentCatList)}
                    <li class="active">
                        {$currentCategory.title}
                    </li>
                {/if}
            </ol>
        </div>
    {/if}
    <div class="context-category-wrap">
        <div class="container">
            <div class="context-category-form">
                <div class="row">
                    <div class="col-xs-12 col-sm-8 col-md-6 col-lg-4 col-xs-offset-0 col-sm-offset-2 col-md-offset-3 col-lg-offset-4">
                        <h2 class="title">دسته بندی موضوعی</h2>
                        <p class="text">
                            با استفاده از دسته بندی موضوعی محصولات، طرح مورد نظرتان را به راحتی پیدا کنید.
                        </p>
                        <div class="field-content text-right">
                            <form class="form-search js-context-form" method="GET" action="">
                                <div class="box-group">
                                    <input class="form-control search-field js-context-category" type="text"
                                           name="context_category"
                                           placeholder="جستجو از میان موضوعات طرح های آماده">
                                    <a class="submit" href="#"><i class="fa fa-search"></i></a>
                                </div>
                                <div class="search-result-wrap js-context-result-wrap">
                                    <ul class="search-result-list list-unstyled js-context-result">

                                    </ul>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <ul class="context-category-list list-unstyled">
                <li><a href="#">سینمایی</a></li>
                <li><a href="#">ورزشی</a></li>
                <li><a href="#">کارتونی</a></li>
                <li><a href="#">تکنولوژی</a></li>
                <li><a href="#">طبیعت</a></li>
                <li><a href="#">عزاداری</a></li>
                <li><a href="#">فوتبال</a></li>
            </ul>
        </div>
    </div>
    <div class="product-wrap">
        <div class="container">
            <div class="row">
                <form method="GET" class="filter-form js-filter-form">
                    <div class="col-md-3 col-sm-4">
                        <aside class="col-sidebar">
                            <div class="filter-options">
                                <div class="block-title">فیلتر محصولات</div>
                                <div class="block-content">
                                    {* FOR PRODUCT TYPE MAIN LIST *}
                                    {if isset($ProductTypeList)}
                                        <div class="filter-options-item filter-category">
                                            <div class="filter-options-title">{$Product_type.title}</div>
                                            <div class="filter-options-content">
                                                <ul>
                                                    {foreach $p_cats as $cat}
                                                        <li>
                                                            <label class="inline">
                                                                <a href="{site_url()}{$cat.link}">
                                                                    {$cat.title}
                                                                </a>
                                                            </label>
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                            </div>
                                        </div>
                                    {/if}
                                    {if isset($parentCatList)}
                                        <div class="filter-options-item filter-category">
                                            <div class="filter-options-title">{$p_cat.title}</div>
                                            <div class="filter-options-content">
                                                <ul>
                                                    {foreach $p_cat->children as $cat}
                                                        <li>
                                                            <label class="inline">
                                                                <a href="{site_url()}{$cat.link}">
                                                                    {$cat.title}
                                                                </a>
                                                            </label>
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                            </div>
                                        </div>
                                    {/if}
                                    {if isset($currentCategory) && !isset($parentCatList)}
                                        <div class="filter-options-item filter-category">
                                            <div class="filter-options-title">{$currentCategory.parentCat.title}</div>
                                            <div class="filter-options-content">
                                                <ul>
                                                    {foreach $currentCategory->parentCat->children as $cat}
                                                        <li>
                                                            <label class="inline">
                                                                <a href="{site_url()}{$cat.link}">
                                                                    <span class="input {if $currentCategory->id eq $cat->id} selected {/if}"></span>
                                                                    {$cat.title}
                                                                </a>
                                                            </label>
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                            </div>
                                        </div>
                                    {/if}
                                    {$i = 0}
                                    {foreach $product_type_filters as $filter}
                                        <div class="filter-options-item filter-{$filter->name}">
                                            <div class="filter-options-title">{$filter->label}</div>
                                            <div class="filter-options-content">
                                                <ul>
                                                    {foreach $filter->values as $val}
                                                        {*  <li>
                                                        <input onchange="this.form.submit()" value="{site_url}prd/همه{'?'|con:$filters}" type="radio" class="input-radio" id="{$filter->label}{$i}" {if $slug == 'همه'}checked=""{/if}>
                                                        <label for="{$filter->label}{$i}">همه</label>
                                                        </li>*}
                                                        <li>
                                                            <label class="inline" for="{$filter->name}{$val.id}-{$i}">
                                                                <input onchange="this.form.submit()"
                                                                       name="dynamic_filter[{$filter->name}]"
                                                                       value="{$val.id}" type="radio"
                                                                       class="input-radio"
                                                                       id="{$filter->name}{$val.id}-{$i}"
                                                                >
                                                                <span class="input {if $dynamic_filter_values AND array_key_exists($filter.name, $dynamic_filter_values)}
                                                                        {if $dynamic_filter_values[$filter.name] eq $val->id} selected {/if}
                                                                    {/if} ">
                                                                </span>
                                                                {if $val->is_color}
                                                                    <span style='
                                                                            padding: 1px 13px 0px 13px;
                                                                            border-radius: 7px;
                                                                            color:{$val.title};
                                                                            background-color: {$val.title}'>&nbsp;</span>
                                                                {else}
                                                                    {$val.title}
                                                                {/if}
                                                            </label>
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                            </div>
                                        </div>
                                        {$i = $i+1}
                                    {/foreach}
                                    {if 0}
                                        <div class="filter-options-item filter-price">
                                            <div class="filter-options-title">محدوده قیمت</div>
                                            <div class="filter-options-content">
                                                <div class="price_slider_wrapper">
                                                    <div data-label-reasult="قیمت:" data-min="1000" data-max="500000"
                                                         data-unit="تومان"
                                                         class="slider-range-price " data-value-min="1000"
                                                         data-value-max="500000">
                                                    </div>
                                                    <div class="price_slider_amount">
                                                        <div class="price_label">
                                                            <span class="to">1,000 تومان</span><span
                                                                    class="from">500,000 تومان</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="filter-options-item filter-size">
                                            <div class="filter-options-title">سایز ها</div>
                                            <div class="filter-options-content">
                                                <ul>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input">S</span></label></li>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input">M</span></label></li>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input">L</span></label></li>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input">XL</span></label></li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="filter-options-item filter-color">
                                            <div class="filter-options-title">رنگ ها</div>
                                            <div class="filter-options-content">
                                                <ul>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input red"></span>قرمز</label>
                                                    </li>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input black"></span>مشکی</label></li>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input gray"></span>خاکستری</label></li>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input white"></span>سفید</label></li>
                                                </ul>
                                                <ul>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input Yellow"></span>زرد</label></li>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input blue"></span>آبی</label></li>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input purple"></span>بنفش</label></li>
                                                    <li><label class="inline"><input type="checkbox"><span
                                                                    class="input green"></span>سبز</label></li>
                                                </ul>
                                            </div>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                            {if false}
                                <div class="block-banner-sidebar">
                                    <a href=""><img src="{assets_url}images/product/banner-sidebar.jpg"
                                                    alt="banner-sidebar"></a>
                                </div>
                            {/if}
                            {*                        <div class="block-latest-roducts">*}
                            {*                            <div class="block-title">اخرین محصولات</div>*}
                            {*                            <div class="block-latest-roducts-content">*}
                            {*                                {literal}*}
                            {*                                <div class="owl-carousel nav-style2" data-nav="true" data-autoplay="false"*}
                            {*                                     data-dots="false"*}
                            {*                                     data-loop="true" data-margin="0"*}
                            {*                                     data-responsive='{"0":{"items":1},"600":{"items":1},"1000":{"items":1}}'>{/literal}*}
                            {*                                    <div class="owl-ones-row">*}
                            {*                                        <div class="product-item style1">*}
                            {*                                            <div class="product-inner">*}
                            {*                                                <div class="product-thumb">*}
                            {*                                                    <div class="thumb-inner">*}
                            {*                                                        <a href=""><img src="{assets_url}images/blog/p1.jpg"*}
                            {*                                                                        alt="p1"></a>*}
                            {*                                                    </div>*}
                            {*                                                </div>*}
                            {*                                                <div class="product-innfo">*}
                            {*                                                    <div class="product-name"><a href="">Leather Chelsea Boots</a></div>*}
                            {*                                                    <span class="price">*}
                            {*                                                            <ins>$229.00</ins>*}
                            {*                                                            <del>$259.00</del>*}
                            {*                                                        </span>*}
                            {*                                                    <span class="star-rating">*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <span class="review">5 Review(s)</span>*}
                            {*                                                        </span>*}
                            {*                                                </div>*}
                            {*                                            </div>*}
                            {*                                        </div>*}
                            {*                                        <div class="product-item style1">*}
                            {*                                            <div class="product-inner">*}
                            {*                                                <div class="product-thumb">*}
                            {*                                                    <div class="thumb-inner">*}
                            {*                                                        <a href=""><img src="{assets_url}images/blog/p2.jpg"*}
                            {*                                                                        alt="p2"></a>*}
                            {*                                                    </div>*}
                            {*                                                </div>*}
                            {*                                                <div class="product-innfo">*}
                            {*                                                    <div class="product-name"><a href="">2750 Cotu Classic Sneakers</a>*}
                            {*                                                    </div>*}
                            {*                                                    <span class="price">*}
                            {*                                                            <ins>$229.00</ins>*}
                            {*                                                            <del>$259.00</del>*}
                            {*                                                        </span>*}
                            {*                                                    <span class="star-rating">*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <span class="review">5 Review(s)</span>*}
                            {*                                                        </span>*}
                            {*                                                </div>*}
                            {*                                            </div>*}
                            {*                                        </div>*}
                            {*                                        <div class="product-item style1">*}
                            {*                                            <div class="product-inner">*}
                            {*                                                <div class="product-thumb">*}
                            {*                                                    <div class="thumb-inner">*}
                            {*                                                        <a href=""><img src="{assets_url}images/blog/p3.jpg"*}
                            {*                                                                        alt="p3"></a>*}
                            {*                                                    </div>*}
                            {*                                                </div>*}
                            {*                                                <div class="product-innfo">*}
                            {*                                                    <div class="product-name"><a href="">Thule Chasm Sport Duffel*}
                            {*                                                            Bag</a>*}
                            {*                                                    </div>*}
                            {*                                                    <span class="price price-dark">*}
                            {*                                                                <ins>$229.00</ins>*}
                            {*                                                            </span>*}
                            {*                                                    <span class="star-rating">*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <span class="review">5 Review(s)</span>*}
                            {*                                                        </span>*}
                            {*                                                </div>*}
                            {*                                            </div>*}
                            {*                                        </div>*}
                            {*                                        <div class="product-item style1">*}
                            {*                                            <div class="product-inner">*}
                            {*                                                <div class="product-thumb">*}
                            {*                                                    <div class="thumb-inner">*}
                            {*                                                        <a href=""><img src="{assets_url}images/blog/p4.jpg"*}
                            {*                                                                        alt="p4"></a>*}
                            {*                                                    </div>*}
                            {*                                                </div>*}
                            {*                                                <div class="product-innfo">*}
                            {*                                                    <div class="product-name"><a href="">Pullover Hoodie - Mens</a>*}
                            {*                                                    </div>*}
                            {*                                                    <span class="price">*}
                            {*                                                            <ins>$229.00</ins>*}
                            {*                                                            <del>$259.00</del>*}
                            {*                                                        </span>*}
                            {*                                                    <span class="star-rating">*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <span class="review">5 Review(s)</span>*}
                            {*                                                        </span>*}
                            {*                                                </div>*}
                            {*                                            </div>*}
                            {*                                        </div>*}
                            {*                                    </div>*}
                            {*                                    <div class="owl-ones-row">*}
                            {*                                        <div class="product-item style1">*}
                            {*                                            <div class="product-inner">*}
                            {*                                                <div class="product-thumb">*}
                            {*                                                    <div class="thumb-inner">*}
                            {*                                                        <a href=""><img src="{assets_url}images/blog/p1.jpg"*}
                            {*                                                                        alt="p1"></a>*}
                            {*                                                    </div>*}
                            {*                                                </div>*}
                            {*                                                <div class="product-innfo">*}
                            {*                                                    <div class="product-name"><a href="">Leather Chelsea Boots</a></div>*}
                            {*                                                    <span class="price">*}
                            {*                                                            <ins>$229.00</ins>*}
                            {*                                                            <del>$259.00</del>*}
                            {*                                                        </span>*}
                            {*                                                    <span class="star-rating">*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <span class="review">5 Review(s)</span>*}
                            {*                                                        </span>*}
                            {*                                                </div>*}
                            {*                                            </div>*}
                            {*                                        </div>*}
                            {*                                        <div class="product-item style1">*}
                            {*                                            <div class="product-inner">*}
                            {*                                                <div class="product-thumb">*}
                            {*                                                    <div class="thumb-inner">*}
                            {*                                                        <a href=""><img src="{assets_url}images/blog/p2.jpg"*}
                            {*                                                                        alt="p2"></a>*}
                            {*                                                    </div>*}
                            {*                                                </div>*}
                            {*                                                <div class="product-innfo">*}
                            {*                                                    <div class="product-name"><a href="">2750 Cotu Classic Sneakers</a>*}
                            {*                                                    </div>*}
                            {*                                                    <span class="price">*}
                            {*                                                            <ins>$229.00</ins>*}
                            {*                                                            <del>$259.00</del>*}
                            {*                                                        </span>*}
                            {*                                                    <span class="star-rating">*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <span class="review">5 Review(s)</span>*}
                            {*                                                        </span>*}
                            {*                                                </div>*}
                            {*                                            </div>*}
                            {*                                        </div>*}
                            {*                                        <div class="product-item style1">*}
                            {*                                            <div class="product-inner">*}
                            {*                                                <div class="product-thumb">*}
                            {*                                                    <div class="thumb-inner">*}
                            {*                                                        <a href=""><img src="{assets_url}images/blog/p3.jpg"*}
                            {*                                                                        alt="p3"></a>*}
                            {*                                                    </div>*}
                            {*                                                </div>*}
                            {*                                                <div class="product-innfo">*}
                            {*                                                    <div class="product-name"><a href="">Thule Chasm Sport Duffel*}
                            {*                                                            Bag</a>*}
                            {*                                                    </div>*}
                            {*                                                    <span class="price price-dark">*}
                            {*                                                                <ins>$229.00</ins>*}
                            {*                                                            </span>*}
                            {*                                                    <span class="star-rating">*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <span class="review">5 Review(s)</span>*}
                            {*                                                        </span>*}
                            {*                                                </div>*}
                            {*                                            </div>*}
                            {*                                        </div>*}
                            {*                                        <div class="product-item style1">*}
                            {*                                            <div class="product-inner">*}
                            {*                                                <div class="product-thumb">*}
                            {*                                                    <div class="thumb-inner">*}
                            {*                                                        <a href=""><img src="{assets_url}images/blog/p4.jpg"*}
                            {*                                                                        alt="p4"></a>*}
                            {*                                                    </div>*}
                            {*                                                </div>*}
                            {*                                                <div class="product-innfo">*}
                            {*                                                    <div class="product-name"><a href="">Pullover Hoodie - Mens</a>*}
                            {*                                                    </div>*}
                            {*                                                    <span class="price">*}
                            {*                                                            <ins>$229.00</ins>*}
                            {*                                                            <del>$259.00</del>*}
                            {*                                                        </span>*}
                            {*                                                    <span class="star-rating">*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                            {*                                                            <span class="review">5 Review(s)</span>*}
                            {*                                                        </span>*}
                            {*                                                </div>*}
                            {*                                            </div>*}
                            {*                                        </div>*}
                            {*                                    </div>*}
                            {*                                </div>*}
                            {*                            </div>*}
                            {*                        </div>*}
                        </aside>
                    </div>
                    <div class="col-md-9 col-sm-8 padding-right-5">
                        <div class="">
                            <div class="toolbar-products">
                                <h2 class="title-product">
                                    {$currentCategory.parentCat.title} > {$currentCategory.title}
                                </h2>
                                <div class="toolbar-option">
                                    <div class="toolbar-sort">
                                        <select onchange="this.form.submit()" name="sort"
                                                class="filter-options chosen-select sorter-options form-control">
                                            <option selected="selected" disabled="">مرتب سازی براساس</option>
                                            <option {if $currentOrder eq 'newest'}selected{/if} value="newest">جدیدترین
                                            </option>
                                            <option {if $currentOrder eq 'highPrice'}selected{/if} value="highPrice">
                                                بیشترین
                                                قیمت
                                            </option>
                                            <option {if $currentOrder eq 'lowPrice'}selected{/if} value="lowPrice">
                                                کمترین
                                                قیمت
                                            </option>
                                            <option {if $currentOrder eq 'sold'}selected{/if} value="sold">پرفروش‌ترین
                                            </option>
                                            <option {if $currentOrder eq 'mostVisted'}selected{/if} value="mostVisted">
                                                پربازدیدترین
                                            </option>
                                        </select>
                                    </div>
                                    <div class="toolbar-per">
                                        <select name="per_page" onchange="this.form.submit()"
                                                class="chosen-select limiter-options form-control">
                                            <option selected="selected" value="30">30 در هر صفحه</option>
                                            <option value="15"
                                                    {if $staticFilters['per_page'] == 15}selected="selected"{/if}>
                                                در هر صفحه 15
                                            </option>
                                            <option value="20"
                                                    {if $staticFilters['per_page'] == 20}selected="selected"{/if}>
                                                در هر صفحه 20
                                            </option>
                                            <option value="30"
                                                    {if $staticFilters['per_page'] == 30}selected="selected"{/if}>
                                                در هر صفحه 30
                                            </option>
                                            <option value="50"
                                                    {if $staticFilters['per_page'] == 50}selected="selected"{/if}>
                                                در هر صفحه 50
                                            </option>
                                        </select>
                                    </div>
                                    {*                                    <div class="modes">*}
                                    {*                                        <a href="grid-product.html" class="active modes-mode mode-grid" title="Grid"><i*}
                                    {*                                                    class="flaticon-squares"></i>*}
                                    {*                                            <span>Grid</span>*}
                                    {*                                        </a>*}
                                    {*                                        <a href="list-product.html" title="List" class="modes-mode mode-list"><i*}
                                    {*                                                    class="flaticon-interface"></i>*}
                                    {*                                            <span>List</span>*}
                                    {*                                        </a>*}
                                    {*                                    </div>*}
                                </div>
                            </div>
                            {if $Products == false}
                                <div class="col-md-8 col-lg-12 mx-auto mt-40 mb-50 products-list">
                                    <div class="alert alert-danger text-center">
                                        <p class="text-danger mb-0">
                                            محصولی یافت نشد
                                        </p>
                                    </div>
                                </div>
                            {else}
                                <div class="products products-list" itemscope itemtype="https://schema.org/ItemList">
                                    {$i = 1}
                                    {foreach from=$Products item=val}
                                        {if $i ==1 || $i % 4 == 1}
                                            <div class="container">
                                        {/if}
                                        <meta itemprop="position" content="{$i}"/>
                                        <div class="product-item style1 width-33 padding-0 col-md-3 col-sm-6 col-xs-6"
                                             itemprop="itemListElement" itemscope itemtype="https://schema.org/Product">
                                            <div class="product-inner">
                                                <div class="product-thumb">
                                                    <div class="thumb-inner">
                                                        <a href="{$val->link}" itemprop="url">
                                                            <link itemprop="image" href="{$products_pic_dir}{$val.pic}" />
                                                            <img itemprop="image"
                                                                 src="{$products_thumbnail_dir}{$val.pic}"
                                                                 alt="{$val.title}">
                                                        </a>
                                                    </div>
                                                    {*                                                <span class="onsale">-50%</span>*}
                                                    {*                                                *}
                                                </div>
                                                <div class="product-innfo">
                                                    <meta itemprop="mpn" content="{$val.id}"/>
                                                    <meta itemprop="itemCondition" content="https://schema.org/NewCondition" />
                                                    <div class="product-name">
                                                        <a href="{$val->link}" >
                                                            <span itemprop="name">{$val->title}</span>
                                                        </a>
                                                    </div>
                                                    {if count($val.varients) eq 0}
                                                        <div class="sold-out valign">ناموجود</div>
                                                    {else}
                                                        <div itemprop="offers" itemscope
                                                             itemtype="https://schema.org/Offer">
                                                            <link itemprop="url" href="{$val->link}" />
                                                            <meta itemprop="priceCurrency" content="IRR"/>
                                                            <meta itemprop="availability" content="https://schema.org/InStock" />
                                                            <span class="price">
                                                <ins itemprop="price" content="{$val.varients[0].price}">
                                                    {$val.varients[0].price|price_format}
                                                </ins>
{*                                                <del>$259.00</del>*}
                                            </span>
                                                        </div>
                                                        {*                                                        <div class="info-product">*}
                                                        {*                                                            {foreach $val->varients[0]->fields as $div}*}
                                                        {*                                                                <p>{$div->value->parentDiversity->label}*}
                                                        {*                                                                    : {$div->value->title}</p>*}
                                                        {*                                                            {/foreach}*}
                                                        {*                                                        </div>*}
                                                    {/if}
                                                    {*                                                    <span class="star-rating">*}
                                                    {*                                                <i class="fa fa-star" aria-hidden="true"></i>*}
                                                    {*                                                <i class="fa fa-star" aria-hidden="true"></i>*}
                                                    {*                                                <i class="fa fa-star" aria-hidden="true"></i>*}
                                                    {*                                                <i class="fa fa-star" aria-hidden="true"></i>*}
                                                    {*                                                <i class="fa fa-star" aria-hidden="true"></i>*}
                                                    {*                                                <span class="review">5 Review(s)</span>*}
                                                    </span>
                                                    {*                                                    <div class="single-add-to-cart">*}
                                                    {*                                                        {if count($val.varients) != 0}*}
                                                    {*                                                            <a href="#" onclick="$(this).addToCart({$val.id})"*}
                                                    {*                                                               class="btn-add-to-cart" data-toggle="tooltip"*}
                                                    {*                                                               data-placement="bottom" title="اضافه به سبد خرید">*}
                                                    {*                                                                <i class="fa fa-shopping-basket"></i>*}
                                                    {*                                                            </a>*}
                                                    {*                                                        {/if}*}
                                                    {*                                                    </div>*}

                                                </div>
                                            </div>
                                        </div>
                                        {if $i % 4 == 0}
                                            </div>
                                        {/if}
                                        {$i = $i + 1}
                                    {/foreach}
                                </div>
                            {/if}
                            <div class="pagination">
                                <ul class="nav-links">
                                    {if $pagination['current_page'] > 1 }
                                        <li>
                                            <a itemprop="url" href="{$pagination['first_page_url']}">اولین</a>
                                        </li>
                                        <li>
                                            <a href="{$pagination['prev_page_url']}">قبلی</a>
                                        </li>
                                    {/if}
                                    <li>
                                        {$pagination['current_page']}
                                    </li>
                                    {if $pagination['current_page'] != $pagination['last_page'] }
                                        <li>
                                            <a href="{$pagination['next_page_url']}">{($pagination['current_page']+1)}</a>
                                        </li>
                                        <li>
                                            <a href="{$pagination['next_page_url']}">بعدی</a>
                                        </li>
                                        <li>
                                            <a itemprop="url" href="{$pagination['last_page_url']}">آخرین</a>
                                        </li>
                                    {/if}
                                </ul>
                                <span class="show-resuilt">نمایش صفحه {$pagination['current_page']} از {$pagination['last_page']} صفحه</span>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    {if false}
        <div class="block-recent-view">
            <div class="container">
                <div class="title-of-section">محصولات مشابه</div>
                {literal}
                <div class="owl-carousel nav-style2 border-background equal-container" data-nav="true"
                     data-autoplay="false"
                     itemscope itemtype="https://schema.org/ItemList"
                     data-dots="false" data-loop="true" data-margin="0"
                     data-responsive='{"0":{"items":1},"480":{"items":2},"600":{"items":3},"992":{"items":4},"1000":{"items":6}}'>{/literal}
                    <div class="product-item style1">
                        <div class="product-inner equal-elem">
                            <div class="product-thumb">
                                <div class="thumb-inner">
                                    <a href=""><img src="{assets_url}images/home1/r1.jpg" alt="r1"></a>
                                </div>
                                {*                            <span class="onsale">-50%</span>*}
                                {*                            *}
                            </div>
                            <div class="product-innfo">
                                <div class="product-name"><a href="">Women Hats</a></div>
                                <span class="price">
                                        <ins>$229.00</ins>
                                        <del>$259.00</del>
                                    </span>
                                {*                            <span class="star-rating">*}
                                {*                                        <i class="fa fa-star" aria-hidden="true"></i>*}
                                {*                                        <i class="fa fa-star" aria-hidden="true"></i>*}
                                {*                                        <i class="fa fa-star" aria-hidden="true"></i>*}
                                {*                                        <i class="fa fa-star" aria-hidden="true"></i>*}
                                {*                                        <i class="fa fa-star" aria-hidden="true"></i>*}
                                {*                                        <span class="review">5 Review(s)</span>*}
                                {*                                    </span>*}
                                {*                                <div class="group-btn-hover style2">*}
                                {*                                    <a href="" class="add-to-cart"><i class="fa fa-shopping-bag" aria-hidden="true"></i></a>*}
                                {*                                    <a href="" class="compare"><i class="flaticon-refresh-square-arrows"></i></a>*}
                                {*                                    <a href="" class="wishlist"><i class="fa fa-heart" aria-hidden="true"></i></a>*}
                                {*                                </div>*}
                            </div>
                        </div>
                    </div>
                    <div class="product-item style1">
                        <div class="product-inner equal-elem">
                            <div class="product-thumb">
                                <div class="thumb-inner">
                                    <a href=""><img src="{assets_url}images/home1/r2.jpg" alt="r2"></a>
                                </div>
                                <span class="onnew">new</span>

                            </div>
                            <div class="product-innfo">
                                <div class="product-name"><a href="">Basketball Sports Shoes</a></div>
                                <span class="price price-dark">
                                        <ins>$229.00</ins>
                                    </span>
                                <span class="star-rating">
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <i class="fa fa-star" aria-hidden="true"></i>
                                        <span class="review">5 Review(s)</span>
                                    </span>
                                <div class="group-btn-hover style2">
                                    <a href="" class="add-to-cart"><i class="fa fa-shopping-bag" aria-hidden="true"></i></a>
                                    <a href="" class="compare"><i class="flaticon-refresh-square-arrows"></i></a>
                                    <a href="" class="wishlist"><i class="fa fa-heart-o" aria-hidden="true"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/if}
    <input type="hidden" class="item-qty" value="1"/>
</main><!-- end MAIN -->


