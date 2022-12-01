{literal}<style>
        video {
            width: 100%;
            height: auto;
        }</style>
    {/literal}
    {add_js file='js/cart.js' part='footer'}
    {add_js file='js/jquery.mask.min.js' part='header'}
<!-- breadcrumb-area start -->
<div class="breadcrumb-area">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="breadcrumb">
                    <ul>
                        <li><a href="{site_url()}">صفحه نخست</a> <i class="fa fa-angle-left"></i></li>
                        <li><a href="{site_url()|con:'shop'}">فروشگاه پیانویاب</a> <i class="fa fa-angle-left"></i></li>
                        <li>
                            <a href="{site_url()|con:'advertise/ads/list-category/':$Product.category.id}">
                                {$Product.category.title}
                            </a> <i class="fa fa-angle-left"></i></li>
                        <li>{$Product.title}</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- breadcrumb-area end -->
<!-- product-simple-area start -->
<div class="product-simple-area">
    <div class="container">
        <div class="row">
            <div class="col-lg-7 col-md-7 col-sm-12 col-xs-12">
                <div class="single-product-image">
                    <div class="single-product-tab">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">
                                    {if $Product.pic != ''}
                                        <img alt="{$Product.title}" src="{site_url()|con:'upload/ads/pic/':$Product.pic}" >
                                    {else}
                                        <img alt="{$Product.title}" src="{assets_url}img/ads2.jpg"
                                             alt="{$Product.title}"/>
                                    {/if}
                                </a>
                            </li>

                            {if $Product.pic2 != ''}
                                <li role="presentation"><a href="#profile" aria-controls="profile" role="tab" data-toggle="tab"><img alt="" src="{site_url()|con:'upload/ads/pic/':$Product.pic2}"></a></li>
                                    {/if}
                                    {if $Product.pic3 != ''}
                                <li role="presentation"><a href="#messages" aria-controls="messages" role="tab" data-toggle="tab"><img alt="" src="{site_url()|con:'upload/ads/pic/':$Product.pic3}"></a></li>
                                    {/if}
                        </ul>

                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="home">
                                {if $Product.pic != ''}
                                    <img alt="{$Product.title}" src="{site_url()|con:'upload/ads/pic/':$Product.pic}" >
                                {else}
                                    <img alt="{$Product.title}" src="{assets_url}img/ads.jpg" alt="{$Product.title}"/>
                                {/if}
                            </div>
                            <div role="tabpanel" class="tab-pane" id="profile"><img alt="{$Product.title}" src="{site_url()|con:'upload/ads/pic/':$Product.pic2}"></div>
                            <div role="tabpanel" class="tab-pane" id="messages"><img alt="{$Product.title}" src="{site_url()|con:'upload/ads/pic/':$Product.pic3}"></div>
                        </div>
                    </div>
                </div>
                <div class="row pull-right">
                    <div class="col-md-12 single-product-info" id="product-actions">
                        <div class="stock-status" style="padding-bottom: 20px;">
                            <div class="price-box" style="    padding-bottom: 24px;">

                                {if $Product.old_price != NULL AND $Product.old_price > 0}
                                    <span class="new-price"> {$Product.price|price_format}</span>  <i class="fa fa-money"></i>
                                    <span class="old-price">{$Product.old_price|price_format}</span>
                                {else if $Product.price > 0}
                                    <span class="new-price"> {$Product.price|price_format}</span>  <i class="fa fa-money"></i>
                                {else}
                                    <i class="fa fa-money"></i> <span class="muted mute">تماس بگیرید</span>
                                {/if}
                            </div>

                            <label>وضعیت موجودی</label>:

                            {if $Product.ads_category_id != 1 AND  $Product.ads_category_id != 2 AND $Product.stock > 0}
                                <strong class="text-success" > <i class="fa fa-check" aria-hidden="true"></i> موجود</strong>
                            {else if $Product.ads_category_id != 1 AND  $Product.ads_category_id != 2 AND $Product.stock == 0}
                                <strong class="text-danger" > <i class="fa fa-close" aria-hidden="true"></i> نا موجود</strong>
                            {else}
                                {if $Product.ads_category_id == 1 OR $Product.ads_category_id == 2 }
                                    {$i = 0}
                                    {foreach $Product.colors as $color}
                                        {if $color.qty > 0}
                                            {$i = 1}
                                        {/if}
                                    {/foreach}
                                    {if $i ==1}  
                                        <strong class="text-success" > <i class="fa fa-check" aria-hidden="true"></i> موجود</strong>
                                    {else}
                                        <strong class="text-danger" > <i class="fa fa-close" aria-hidden="true"></i> نا موجود</strong>
                                    {/if}
                                {/if}
                            {/if}
                            {if $Product.category.id == 1 OR $Product.category.id == 2}
                                <br>
                                <label class="color-label-selecttion">انتخاب رنگ پیانو:</label><br><br>
                                {foreach $Product.colors as $color}
                                    <div class='my-stock'>
                                        <i style="vertical-align: middle;cursor: pointer" class="fa fa-check-square fa-2x" aria-hidden="true"></i>
                                        <img style="cursor: pointer"
                                             src="{assets_url}img/colors/{$color.color_key}.png">

                                        <span class="color-stock" style="padding-left: 25px;">{$color.color}</span>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                        <form id="cart_form">
                            <div class="quantity">

                                {if $Product.ads_category_id == 1 OR $Product.ads_category_id == 2 }
                                    {$i = 0}
                                    {foreach $Product.colors as $color}
                                        {if $color.qty > 0}
                                            {$i = 1}
                                        {/if}
                                    {/foreach}
                                    {if $i ==1}  
                                        <input type="number" name="qty" value="1">
                                        <input type="hidden" name="prd_id" value="{$Product.id}">
                                        <input type="hidden" name="color_qty" value=''>
                                        <button type="submit" id="add_to_cart">افزودن به سبد خرید</button>
                                        <i class="fa fa-refresh fa-spin fa-3x pull-right" style="display:none;"></i>
                                    {else}
                                        <label class="btn btn-social btn-warning" style="padding:10px;">اتمام موجودی</label>
                                    {/if}
                                {else if $Product.stock >0}
                                    <input type="number" name="qty" value="1">
                                    <input type="hidden" name="prd_id" value="{$Product.id}">
                                    <input type="hidden" name="color_qty" value=''>
                                    <button type="submit" id="add_to_cart">افزودن به سبد خرید</button>
                                    <i class="fa fa-refresh fa-spin fa-3x pull-right" style="display:none;"></i>
                                {else}
                                    <label class="btn btn-social btn-warning" style="padding:10px;">اتمام موجودی</label>
                                {/if}
                            </div>
                        </form>
                        <div class="add-to-wishlist">
                            <a href="#" class="compare-ads" onclick="$(this).addCompare({$Product.id});" data-toggle="tooltip" title="افزودن به لیست مقایسه" data-original-title="این محصول را به لیست مقایسه اضافه کن"><i class="fa fa-exchange"></i></a>
                            <span class="selected-color">رنگ انتخابی: 
                                <label></label>
                            </span>
                        </div>

                        <div class="wishlist-table table-responsive">
                            <table style="border:none!important">
                                <tbody>
                                    {if !$features->isEmpty() }
                                        <tr>
                                            <th colspan="3" style="border: #ccc solid 1px;">
                                                اشانتیون و هدایا  
                                            </th>
                                        </tr>
                                        {foreach from=$features item=feature}
                                            {if $feature.pivot.valueable == null OR $feature.pivot.valueable == ''}
                                                {continue}
                                            {/if}
                                            <tr>
                                                <td style="border:none!important">
                                                    {if $feature.pivot.img}
                                                        <img width="135" src="{site_url}upload/ads/pic/{$feature.pivot.img}"/>
                                                    {/if}
                                                </td>
                                                <td class="product-remove" style="border:none!important">{$feature.title}</td>
                                                <td class="product_weight" style="border:none!important">{$feature.pivot.valueable}</td>
                                            </tr>

                                        {/foreach}
                                    {/if}
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">


                <div class="single-product-info">
                    <div class="product-nav">
                        <a href="#"><i class="fa fa-angle-right"></i></a>
                    </div>
                    <h1 class="product_title">{$Product.title}
                        {if $Product.status == 5}  
                            <label style="color:red;font-family:nestedbold;">
                                (فروخته شد)
                            </label>
                        {/if}
                    </h1>
                    <div class="price-box">

                        {if $Product.old_price != NULL AND $Product.old_price > 0}
                            <span class="new-price"> {$Product.price|price_format}</span>  <i class="fa fa-money"></i>
                            <span class="old-price">{$Product.old_price|price_format}</span>
                        {else if $Product.price > 0}
                            <span class="new-price"> {$Product.price|price_format}</span>  <i class="fa fa-money"></i>
                        {else}
                            <i class="fa fa-money"></i> <span class="muted mute">تماس بگیرید</span>
                        {/if}
                    </div>
                    <div class="wishlist-table table-responsive">
                        <table>
                            <tbody>
                                <tr>
                                    <th colspan="3">
                                        مشخصات محصول  
                                    </th>
                                </tr>
                                <tr>
                                    <td class="product-remove"><i class="fa fa-shield" aria-hidden="true"></i></td>
                                    <td class="product-remove" style="width:130px;">توضیحات کلی </td>
                                    <td  >{$Product.short_desc}</td>
                                </tr>
                                {if $has_fields}
                                    <tr>
                                        <td class="product-remove"><i class="fa fa-shield" aria-hidden="true"></i></td>
                                        <td class="product-remove" style="width:130px;">برند </td>
                                        <td  >{$Product.fields.brand}</td>
                                    </tr>
                                    <tr>
                                        <td class="product-remove"><i class="fa fa-tag" aria-hidden="true"></i></td>
                                        <td class="product-remove">مدل</td>
                                        <td  >{$Product.fields.model}</td>
                                    </tr>
                                    <tr>
                                        <td class="product-remove"><i class="fa fa-folder-o" aria-hidden="true"></i></td>
                                        <td class="product-remove">نوع پیانو</td>
                                        <td  >{$Product.fields.piano_type}</td>
                                    </tr>
                                {/if}
                                <tr>
                                    <td class="product-remove"><i class="fa fa-money" aria-hidden="true"></i></td>
                                    <td class="product-remove" style="width:101px;">قیمت</td>
                                    <td>
                                        {if $Product.price > 0}
                                            <span class="new-price"> {$Product.price|price_format}</span>  <i class="fa fa-money"></i>
                                        {else}
                                            <i class="fa fa-money"></i> <span class="muted mute">تماس بگیرید</span>
                                        {/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td class="product-remove"><i class="fa fa-list-alt" aria-hidden="true"></i></td>
                                    <td class="product-remove">دسته بندی</td>
                                    <td  >{$Product.category.title}</td>
                                </tr>

                                {if $Product.category.id == 1 OR $Product.category.id == 2}
                                    {if $Product.category.id eq 2}
                                        <tr>
                                            <td class="product-remove"><i class="fa fa-sort" aria-hidden="true"></i></td>
                                            <td class="product-remove">تعداد لایه های صدا</td>
                                            <td  >{$Product.fields.sound_layer_count}</td>
                                        </tr>
                                        <tr>
                                            <td class="product-remove"><i class="fa fa-calendar" aria-hidden="true"></i></td>
                                            <td class="product-remove">سال ساخت</td>
                                            <td  >{$Product.fields.years}</td>
                                        </tr>
                                        <tr>
                                            <td class="product-remove"><i class="fa fa-volume-up" aria-hidden="true"></i></td>
                                            <td class="product-remove">تعداد بلندگو</td>
                                            <td  >{$Product.fields.speaker_count}</td>
                                        </tr>
                                    {/if}
                                    {if $Product.category.id eq 1}
                                        <tr>
                                            <td class="product-remove"><i class="fa fa-globe" aria-hidden="true"></i></td>
                                            <td class="product-remove">کشور سازنده </td>
                                            <td  >{$Product.fields.creator_country}</td>
                                        </tr>
                                        <tr>
                                            <td class="product-remove"><i class="fa fa-paw" aria-hidden="true"></i></td>
                                            <td class="product-remove">تعداد پدال</td>
                                            <td  >{$Product.fields.pedal_count}</td>
                                        </tr>
                                        <tr>
                                            <td class="product-remove"><i class="fa fa-calendar" aria-hidden="true"></i></td>
                                            <td class="product-remove">سال کارکرد</td>
                                            <td  >{$Product.fields.years}</td>
                                        </tr>
                                        <tr>
                                            <td class="product-remove"><i class="fa fa-file-sound-o" aria-hidden="true"></i></td>
                                            <td class="product-remove">نوع Sound Board</td>
                                            <td  >{$Product.fields.sound_board}</td>
                                        </tr>
                                        <tr>
                                            <td class="product-remove"><i class="fa fa-circle-o-notch" aria-hidden="true"></i></td>
                                            <td class="product-remove">نوع سیم</td>
                                            <td  >{$Product.fields.wire}</td>
                                        </tr>

                                        {if $Product.fields.piano_type eq 'دیواری'}
                                            <tr>
                                                <td class="product-remove"><i class="fa fa-ellipsis-v" aria-hidden="true"></i></td>
                                                <td class="product-remove">ارتفاع</td>
                                                <td  >{$Product.fields.height}</td>
                                            </tr>
                                        {else if  $Product.fields.piano_type eq 'گرند'}
                                            <tr>
                                                <td class="product-remove"><i class="fa fa-circle-thin" aria-hidden="true"></i></td>
                                                <td class="product-remove">قطر</td>
                                                <td  >{$Product.fields.diameter}</td>
                                            </tr>
                                        {/if}
                                    {/if}
                                    <tr>
                                        <td class="product-remove"><i class="fa fa-folder-open-o" aria-hidden="true"></i></td>
                                        <td class="product-remove">نوع اکشن</td>
                                        <td  >{$Product.fields.action}</td>
                                    </tr>

                                    <tr>
                                        <td class="product-remove"><i class="fa fa-tags" aria-hidden="true"></i></td>
                                        <td class="product-remove">کلمات کلیدی</td>
                                        <td>
                                            {foreach from=$keywords item=keyword}
                                                <label>
                                                    <a href="{site_url()|con:'advertise/ads/keywords/':$keyword.keyword}" class="tag-btn">{$keyword.keyword}</a>
                                                </label>
                                            {/foreach}
                                        </td>
                                    </tr>
                                    {if $Product.video != ''}
                                    <label class="text-black">    فایل ویدئو بارگذاری شده از طرف محصول دهنده</label>
                                    <video  height="370" controls class="pull-left">
                                        <source src="{site_url|con:'upload/ads/video/':$Product.video}" type="video/mp4">
                                        Your browser does not support the video tag.
                                    </video>
                                {/if}
                        </div>	
                    {/if}
                    </tbody>
                    </table>
                    {if $Product.type == 2 OR $Product.type == 3}
                        <a href="{site_url()}advertise/ads/relatedAds/{$Product.user_id}" class="btn btn-success">دیگر محصول های این کاربر</a>
                    {/if}
                </div>	
            </div>
        </div>
    </div>
</div>
</div>
<!-- product-simple-area end -->
<div class="product-tab-area">
    <div class="container">
        <div class="row">
            <div class="col-lg-9 col-md-9 pull-right">
                <div class="product-tabs">
                    <div>
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active"><a href="#tab-desc" aria-controls="tab-desc" role="tab" data-toggle="tab">توضیحات تکمیلی</a></li>
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content nes-content">
                            <div role="tabpanel" class="tab-pane active" id="tab-desc">
                                <div class="product-tab-desc">
                                    <p>
                                        {$Product.desc}
                                    </p>
                                </div>
                            </div>

                        </div>
                    </div>						
                </div>
                <div class="clear"></div>
                <div class="upsells_products_widget">
                    <div class="section-heading">
                        <h3>محبوب‌ترین‌های فروشگاه</h3>
                    </div>
                    <div class="row">
                        <!-- single-product start -->
                        {foreach from=$most_visited item=popular}
                            <div class="col-lg-3 col-md-4 col-sm-4">
                                <div class="single-product">
                                    {if $popular.type == 2}
                                        <span class="sale-text">ویژه</span>
                                    {else if $popular.type ==3}
                                        <span class="sale-text">ویترین</span>
                                    {/if}
                                    <div class="product-img">
                                        <a href="{site_url()|con:'shop/':$popular.slug}">
                                            {if $popular.pic != ''}
                                                <img class="primary-image" src="{site_url()|con:'upload/ads/pic/':$popular.pic}" alt="{$popular.title}" />
                                            {else}
                                                <img class="primary-image" src="{assets_url}img/ads.jpg"
                                                     alt="{$popular.title}"/>
                                            {/if}
                                        </a>
                                        <div class="actions">
                                            <div class="action-buttons">
                                                <div class="add-to-cart">
                                                    <a href="{site_url()|con:'shop/':$popular.slug}">{$popular.title}({$popular.visit_counts} بازدید)</a>
                                                </div>
                                                <div class="add-to-links">
                                                    <div class="compare-button">
                                                        <a href="#" class="compare-ads" onclick="$(this).addCompare({$popular.id});" data-toggle="tooltip" title="مقایسه"><i class="fa fa-exchange"></i></a>
                                                    </div>
                                                </div>
                                                <div class="quickviewbtn">
                                                    <a href="{site_url()|con:'shop/':$popular.slug}" data-toggle="tooltip" title="نمایش"><i class="fa fa-search-plus"></i></a>
                                                </div>
                                            </div>
                                        </div>							
                                    </div>
                                    <div class="product-content">
                                        <h2 class="product-name"><a href="#">{$popular.title}({$popular.visit_counts} بازدید)</a></h2>
                                        {if $popular.type == 2}
                                            <div class="pro-rating">
                                                <a href="#"><i class="fa fa-star"></i></a>
                                                <a href="#"><i class="fa fa-star"></i></a>
                                                <a href="#"><i class="fa fa-star"></i></a>
                                            </div>
                                        {else if $popular.type == 3}
                                            <div class="pro-rating">
                                                <a href="#"><i class="fa fa-star"></i></a>
                                                <a href="#"><i class="fa fa-star"></i></a>
                                                <a href="#"><i class="fa fa-star"></i></a>
                                                <a href="#"><i class="fa fa-star"></i></a>
                                                <a href="#"><i class="fa fa-star"></i></a>
                                            </div>
                                        {/if}
                                        <div class="price-box">
                                            <span class="new-price">{$popular.price|price_format}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                        <!-- single-product end -->								
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-3">
                <!-- widget-recent start -->
                <aside class="widget top-product-widget">
                    <h3 class="sidebar-title">جدیدترین‌های فروشگاه</h3>
                    <ul>
                        {foreach from=$last_ads item=newAds}
                            <li>
                                <div class="single-product">
                                    <div class="product-img">
                                        <a href="{site_url()|con:'shop/':$newAds.slug}">
                                            {if $newAds.pic != ''}
                                                <img class="primary-image" src="{site_url()|con:'upload/ads/pic/':$newAds.pic}" alt="{$newAds.title}" /> {else}
                                                <img class="primary-image" src="{assets_url}img/ads2.jpg"
                                                     alt="{$newAds.title}"/>
                                            {/if}
                                        </a>						
                                    </div>
                                    <div class="product-content">
                                        <div class="pro-info">
                                            <h2 class="product-name"><a href="{site_url()|con:'shop/':$newAds.slug}">{$newAds.title}</a></h2>
                                                {if $newAds.type == 2}
                                                <div class="pro-rating">
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                </div>
                                            {else if $newAds.type == 3}
                                                <div class="pro-rating">
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                    <a href="#"><i class="fa fa-star"></i></a>
                                                </div>
                                            {/if}
                                            <div class="price-box">
                                                {if $newAds.price != 0}
                                                    <span class="new-price">{$newAds.price|price_format}</span>
                                                {else}
                                                    <span class="new-price">تماس بگیرید</span>
                                                {/if}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        {/foreach}
                    </ul>
                </aside>
                <!-- widget-recent end -->				
            </div>
        </div>
    </div>
</div>
<script>
    $(".single-product-image img").elevateZoom();
</script>