{add_css file="css/jquery-ui.css"}
{add_js file='js/cart.js' part='footer'}
{add_js file='js/shop_loc.js' part='footer'}
<section class=" new-arrivals pb-40">
    <div class="container space_bottom">
        <ol class="breadcrumb">
            <li>
                <a href="{site_url}">خانه</a>
            </li>
            <li class="active">
                {$title}
            </li>
        </ol> <!-- end breadcrumbs -->
    </div>
    <div class="container">
        <!--<div class="row heading-row">
          <div class="col-md-12 text-center">
            <h2 class="heading uppercase"><small>محصول </small></h2>
          </div>
        </div>-->

        <div class="row row-10">
            <form action="" method="GET" class="filter-form">
                <div class="col-lg-10 col-md-10">
                    <div class="width_sort_str">
                        <label class="lbl_sort">مرتب‌سازی بر اساس</label>
                        <select class="filter-options" name="sort">
                            <option {if $currentOrder eq 'newest'}selected{/if} value="newest">جدیدترین</option>
                            <option {if $currentOrder eq 'highPrice'}selected{/if} value="highPrice">بیشترین قیمت
                            </option>
                            <option {if $currentOrder eq 'lowPrice'}selected{/if} value="lowPrice">کمترین قیمت</option>
                            <option {if $currentOrder eq 'sold'}selected{/if} value="sold">پرفروش‌ترین</option>
                            <option {if $currentOrder eq 'mostVisted'}selected{/if} value="mostVisted">پربازدیدترین
                            </option>
                        </select>
                    </div>

                    <div class="space_both_map " style="color:black;margin-top: 13px;">
                        فیلتر بر اساس منطقه
                        <hr/>
                    </div>
                    <div class='col-md-2 col-sm-12 col-xs-12 pull-right'>
                        <label>استان</label>
                        <select class="select_rm" name="province_id" id="province">
                            <option value="" selected="" disabled="">انتخاب استان</option>
                            <option value="">همه</option>
                            {foreach $Provinces as $prv}
                                <option {if $province_id eq $prv.id}selected=""{/if}
                                        value="{$prv.id}">{$prv.name}</option>
                            {/foreach}
                        </select>
                    </div>

                    <div class='col-md-2 col-sm-12 col-xs-12 pull-right' id="county-wrapper" style="display: none;">
                        <label class="control-label lbl_space" for="county">شهر:</label>
                        <select class="select_rm" name="county_id" id="county">
                            <option value="" selected="">همه شهرها</option>
                        </select>
                    </div>
                    <div class='col-md-2 col-sm-12 col-xs-12 pull-right' id="region-wrapper" style="display: none;">
                        <label class="control-label lbl_space" for="region">منطقه:</label>
                        <select class="select_rm" name="region_id" id="region">
                            <option value="" selected="">همه منطقه‌ها</option>
                        </select>
                    </div>
                    <div class='col-md-2 col-sm-12 col-xs-12 pull-right' id="neighbourhood-wrapper"
                         style="display: none;">
                        <label class="control-label lbl_space" for="neighbourhood">محله:</label>
                        <select class="select_rm" name="neighbourhood_id" id="neighbourhood">
                            <option value="" selected="">همه محله‌ها</option>
                        </select>
                    </div>
                    <div class='col-md-4 col-sm-12 col-xs-12 pull-left'>
                        <input class="btn btn-sm  btn-light align_search" type="submit" value="جستجو کنید">
                    </div>
                    {if $Products == false}
                        <label class="text-warning">
                            محصولی یافت نشد
                        </label>
                    {else}
                        <div class="row">
                            <div id="gmap" style="with:300px;height:250px;    margin-bottom: 22px;width:100%"></div>
                            {foreach from=$Products item=val}
                                <div class="col-md-4 col-xs-6 pull-right item{$val.id}">
                                    <div class="product-item">
                                        <div class="product-img">
                                            <a href="{site_url()|con:'product/':$val->slug}">
                                                <img src="{$products_thumbnail_dir}{$val.pic}" alt="{$val.title}">
                                                <img src="{$products_thumbnail_dir}{$val.pic1}" alt="" class="back-img">
                                            </a>
                                            {if $val.is_discount}
                                                <div class="product-label">
                                                    <span class="sale">حراجی</span>
                                                </div>
                                            {/if}
                                            {if $val.stock_type eq 3}
                                                <span class="sold-out valign">موجود نیست</span>
                                            {/if}
                                            <div class="product-actions">

                                                <ul class="nav navbar-nav menu_share">
                                                    <li class="dropdown">
                                                        <a href="#" class="product-add-to-compare dropdown-toggle"
                                                           data-toggle="dropdown" data-placement="bottom"
                                                           title="اشتراک گذاری">
                                                            <i class="fa fa-share-alt"></i>
                                                        </a>

                                                        <ul class="dropdown-menu nav_inside ">
                                                            <li><a socialshare="" target="_blank"
                                                                   href="https://telegram.me/share/url?url={site_url}product/NPI-{$val.id}/{$val.slug}">تلگرام
                                                                    <span class="pull-right"><i class="fa fa-telegram"
                                                                                                aria-hidden="true"></i></span></a>
                                                            </li>
                                                            <li><a socialshare="" target="_blank"
                                                                   socialshare-provider="linkedin"
                                                                   href="https://www.linkedin.com/shareArticle?mini=true&url={site_url}product/NPI-{$val.id}/{$val.slug}&title={$val.title}&summary={$val.desc}"
                                                                   socialshare-text="">لینکدین <span class="pull-right"><i
                                                                                class="fa fa-linkedin-square"
                                                                                aria-hidden="true"></i></span></a></li>

                                                            <li><a target="_blank"
                                                                   href="https://plus.google.com/share?url={site_url}product/NPI-{$val.id}/{$val.slug}">گوگل
                                                                    پلاس <span class="pull-right"><i
                                                                                class="fa fa-google-plus-square"
                                                                                aria-hidden="true"></i></span></a></li>

                                                            <li><a target="_blank" class="twitter-share-button"
                                                                   href="https://twitter.com/home?status={site_url}product/NPI-{$val.id}/{$val.slug}">توییتر<span
                                                                            class="pull-right"><i
                                                                                class="fa fa-twitter-square"
                                                                                aria-hidden="true"></i></span></a></li>

                                                            <li><a target="_blank"
                                                                   href="https://www.facebook.com/sharer/sharer.php?u={site_url}product/NPI-{$val.id}/{$val.slug}"
                                                                   socialshare-text="">فیسبوک<span class="pull-right"><i
                                                                                class="fa fa-facebook-official"
                                                                                aria-hidden="true"></i></span></a></li>
                                                        </ul>
                                                    </li>
                                                </ul>
                                                <a href="#" onclick="$(this).addFavorite({$val.id})"
                                                   class="product-add-to-wishlist" data-toggle="tooltip"
                                                   data-placement="bottom" title="اضافه به علاقه مندی">
                                                    <i class="fa fa-heart"></i>
                                                </a>
                                                <input type="hidden" class='item-qty' value='1'/>
                                                <a href="#" onclick="$(this).addToCart({$val.id})"
                                                   class="product-add-to-wishlist" data-toggle="tooltip"
                                                   data-placement="bottom" title="اضافه به سبد خرید">
                                                    <i class="fa fa-shopping-basket"></i>
                                                </a>
                                            </div>
                                            <a href="#" class="product-quickview">نمایش محصول</a>
                                        </div>
                                        <div class="product-details">
                                            <h3>
                                                <a class="product-title"
                                                   href="{site_url()|con:'product/':$val->slug}"> {$val.title}</a>
                                            </h3>
                                            <p class="margin_botton">
                                                <a target="_blank" href="{site_url}users/profile/{$val.user.username}">
                                                    {$val.user.business_name}
                                                </a>
                                            </p>
                                            <p class="margin_botton">
                                                {if $val.stock_type eq 1}
                                                    آماده ارسال
                                                {elseif $val.stock_type eq 2}
                                                    قابل سفارش
                                                {elseif $val.stock_type eq 3}
                                                    ناموجود
                                                {/if}
                                            </p>
                                            <span class="price">
                                                <del>
                                                    {$val.price|price_format}
                                                </del>
                                                <ins>
                                                    <span class="ammount">{$val.discount_price|price_format}</span>
                                                </ins>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                        <div class="row">
                            <ul class="pagination">
                                {$paging}
                            </ul>
                        </div>
                    {/if}
                </div> <!-- end col -->
                <div class="col-lg-2 col-md-2 space_top">
                    <h1 class="title_siderbar_product"> فیلتر ها</h1>

                    <div class="filter-wrapper">
                        <label>دسته بندی</label>
                        <ul class="scroll_check">
                            <li>
                                <input value="0" type="radio" class="input-radio cat-options" id="cat0"
                                       {if $category_id == 0}checked=""{/if}>
                                <label for="cat0">همه</label>
                            </li>
                            {foreach $category as $cat}
                                <li>
                                    <input value="{$cat.id}" type="radio" class="input-radio filter-options"
                                           id="cat{$cat.id}" {if $category_id eq $cat.id}checked=""{/if}
                                           name="category_id">
                                    <label for="cat{$cat.id}">{$cat.title}</label>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                    <div class="filter-wrapper">
                        <label>مناسبت</label>
                        <ul>
                            {foreach $Reasons as $reason}
                                <li>
                                    <input value="{$reason.id}" type="radio" class="input-radio filter-options"
                                           id="reason{$reason.id}" {if in_array($reason.id,$reason_id)}checked=""{/if}
                                           name="reason_id">
                                    <label for="reason{$reason.id}">{$reason.title}</label>
                                </li>
                            {/foreach}
                        </ul>
                    </div>

                    <div class="filter-wrapper">
                        <label>نوع گل</label>
                        <ul class="scroll_check">
                            {foreach $flower_types as $type}
                                <li>
                                    <input value="{$type.id}" type="radio" class="input-radio filter-options"
                                           id="flower_type{$type.id}" {if $flower_type_id eq $type.id}checked=""{/if}
                                           name="flower_type">
                                    <label for="flower_type{$type.id}">{$type.title}</label>
                                </li>
                            {/foreach}
                        </ul>
                    </div>

                    <div class="filter-wrapper">
                        <label>وضعیت</label>
                        <ul>
                            <li>
                                <input value="1" type="radio" class="input-radio filter-options" id="stock1"
                                       {if $stock_type eq 1}checked=""{/if} name="stock_type">
                                <label for="stock1">آماده ارسال</label>
                            </li>
                            <li>
                                <input value="2" type="radio" class="input-radio filter-options" id="stock2"
                                       {if $stock_type eq 2}checked=""{/if} name="stock_type">
                                <label for="stock2">موجود قابل سفارش</label>
                            </li>
                            <li>
                                <input value="3" type="radio" class="input-radio filter-options" id="stock3"
                                       {if $stock_type eq 3}checked=""{/if} name="stock_type">
                                <label for="stock3">ناموجود</label>
                            </li>
                        </ul>
                    </div>
                    <div class="filter-wrapper">
                        <label>امکان ارسال رایگان</label>
                        <ul>
                            <li>
                                <input value="100" type="radio" class="input-radio filter-options" id="free_shipping100"
                                       {if $free_shipping eq 100 OR !isset($free_shipping)}checked=""{/if}
                                       name="free_shipping">
                                <label for="free_shipping100">همه</label>
                            </li>
                            <li>
                                <input value="1" type="radio" class="input-radio filter-options" id="free_shipping1"
                                       {if $free_shipping eq 1}checked=""{/if} name="free_shipping">
                                <label for="free_shipping1">دارد</label>
                            </li>
                            <li>
                                <input value="0" type="radio" class="input-radio filter-options" id="free_shipping0"
                                       {if $free_shipping === 0}checked=""{/if} name="free_shipping">
                                <label for="free_shipping0">ندارد</label>
                            </li>
                        </ul>
                    </div>
                    <hr/>
                    <div>
                        <label class="price_lbl">جستجو برحسب قیمت</label>
                        از <input type="text" id="amount1" name="min_price">
                        تا <input type="text" id="amount2" name="max_price"> تومان
                        <div id="slider-range"></div>
                        <input class="btn btn-sm  btn-light" type="submit" value="جستجو کنید">
                    </div>
                    <div class="space_both_map">
                        <hr/>
                    </div>
                    <div>
                        <label>استان</label>
                        <select class="select_rm" name="province_id" id="province">
                            <option value="" selected="" disabled="">انتخاب استان</option>
                            <option value="">همه</option>
                            {foreach $Provinces as $prv}
                                <option {if $province_id eq $prv.id}selected=""{/if}
                                        value="{$prv.id}">{$prv.name}</option>
                            {/foreach}
                        </select>

                    </div>
                    <div>
                        <label class="control-label lbl_space" for="county">شهر:</label>
                        <select class="select_rm" name="county_id" id="county" disabled="">
                            <option value="" disabled="" selected="">انتخاب شهر</option>
                            <option value="">همه</option>
                        </select>
                    </div>
                    <div>
                        <label class="control-label lbl_space" for="city">منطقه:</label>
                        <select class="select_rm" name="city_id" id="city" disabled="">
                            <option value="" disabled="" selected="">انتخاب منطقه</option>
                            <option value="">همه</option>
                        </select>
                    </div>
                    <input class="btn btn-sm  btn-light" type="submit" value="جستجو کنید">
                </div> <!-- end row -->
            </form>
        </div>
    </div>
</section> <!-- end new arrivals -->


{if isset($province_id)}
    <input type="hidden" name="province_id_hidden" value="{$province_id}"/>
{/if}
{if isset($county_id)}
    <input type="hidden" name="county_id_hidden" value="{$county_id}"/>
{/if}
{if isset($region_id)}
    <input type="hidden" name="region_id_hidden" value="{$region_id}"/>
{/if}
{if isset($neighbourhood_id)}
    <input type="hidden" name="neighbourhood_id_hidden" value="{$neighbourhood_id}"/>
{/if}

<script type="text/javascript">
    data = [
        {foreach from=$Shops item=val}
        {if $val.lat != null AND $val.long}
            {literal}{{/literal}
            lat:{$val.lat},
            lon:{$val.long},
            title: '{$val.business_name}',
            html: {if $val.profile.logo != ''}'<a style="font-family:xantoxa;display:block;text-align: right;" target="_blank" href="{site_url}users/profile/{$val.username}">{$val.business_name}</a><img width="60" src="{site_url()|con:'upload/users/':$val.profile.logo}">'
            {else}'<a target="_blank" href="{site_url}users/profile/{$val.username}">{$val.business_name}</a>'{/if},
            zoom: 14,
            {literal} },  {/literal}
        {/if}
        {/foreach}
    ];
</script>