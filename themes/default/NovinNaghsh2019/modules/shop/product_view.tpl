<main class="site-main js-get-pages-id" id="js-product-detail">
    <div class="container">
        <ol class="breadcrumb-page" itemscope itemtype="http://schema.org/BreadcrumbList">
            <li itemprop="itemListElement" itemscope
                itemtype="https://schema.org/ListItem">
                <a itemprop="item" href="{site_url}"><span itemprop="name">صفحه اصلی</span></a>
                <meta itemprop="position" content="1"/>
            </li>
            <li itemprop="itemListElement" itemscope
                itemtype="https://schema.org/ListItem">
                <a itemprop="item" href="{site_url}prd/{$product.product_type.slug}">
                    <span itemprop="name">{$product.product_type.title}</span>
                </a>
                <meta itemprop="position" content="2"/>
            </li>
            <li itemprop="itemListElement" itemscope
                itemtype="https://schema.org/ListItem">
                <a href="{site_url}{$product.category.link}" itemprop="item">
                    <span itemprop="name">{$product.category.title}</span>
                </a>
                <meta itemprop="position" content="3"/>
            </li>
            <li itemprop="itemListElement" itemscope
                itemtype="https://schema.org/ListItem">
                <a href="{site_url}{$product.child_category.link}" itemprop="item">
                    <span itemprop="name">{$product.child_category.title}</span>
                </a>
                <meta itemprop="position" content="4"/>
            </li>
            <li class="active" itemprop="itemListElement" itemscope
                itemtype="https://schema.org/ListItem">
                <a title="{$product.title}" itemprop="item"><span itemprop="name">{$product.title}</span></a>
                <meta itemprop="position" content="5"/>
            </li>
        </ol>
    </div>
    <div class="container">
        <div class="product-content-single" itemscope itemtype="https://schema.org/Product">
            <div class="row">
                <div class="col-md-4 col-sm-12 padding-right">
                    <div class="product-media">
                        <div class="image-preview-container image-thick-box image_preview_container">
                            <link itemprop="image" href="{$products_pic_dir}{$product.pic}"/>
                            <img itemprop="image" id="img_zoom" data-zoom-image="{$products_pic_dir}{$product.pic}"
                                 src="{$products_pic_dir}{$product.pic}" alt="{$product.title}">
                        </div>
                        <div class="product-preview image-small product_preview">
                            {literal}
                            <div id="thumbnails" class="thumbnails_carousel owl-carousel nav-style4" data-nav="true"
                                 data-autoplay="false" data-dots="false" data-loop="true" data-margin="10"
                                 data-responsive='{"0":{"items":3},"480":{"items":5},"600":{"items":5},"1000":{"items":5}}'>{/literal}

                                <a class="js-product-link" href="#"
                                   data-image-id="main"
                                   data-image="{$products_pic_dir}{$product.pic}"
                                   data-zoom-image="{$products_pic_dir}{$product.pic}"
                                   title="{$product.title}">
                                    <img src="{$products_pic_dir}{$product.pic}"
                                         data-large-image="{$products_pic_dir}{$product.pic}"
                                         alt="{$product.title}">
                                </a>
                                {foreach $product.images as $image}
                                    <a class="js-product-link" href="#"
                                       data-image-id="{$image.id}"
                                       data-image="{$products_pic_dir}{$image.file_name}"
                                       data-zoom-image="{$products_pic_dir}{$image.file_name}"
                                       title="{$product.title}">
                                        <link itemprop="image" href="{$products_pic_dir}{$image.file_name}"/>
                                        <img src="{$products_pic_dir}{$image.file_name}"
                                             data-large-image="{$products_pic_dir}{$image.file_name}"
                                             data-image-id="{$image.id}"
                                             alt="{$product.title}">
                                    </a>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-5 col-sm-6">
                    <div class="product-info-main">
                        <div class="product-name">
                            <meta itemprop="mpn" content="{$product.id}"/>
                            <h1 class="title">
                                <a title="{$product.title}" href="{$product->link}" itemprop="url">
                                    <span itemprop="name">{$product.title}</span>
                                </a>
                            </h1>
                            <div class="product-category" itemprop="category">
                                دسته‌بندی:
                                <a target="_blank"
                                   href="{site_url}{$product.child_category.link}">
                                    {$product.child_category.title}
                                </a>
                            </div>
                        </div>
                        <span class="star-rating hidden">
                            <i class="fa fa-star" aria-hidden="true"></i>
                            <i class="fa fa-star" aria-hidden="true"></i>
                            <i class="fa fa-star" aria-hidden="true"></i>
                            <i class="fa fa-star" aria-hidden="true"></i>
                            <i class="fa fa-star" aria-hidden="true"></i>
                            <span class="review">5 امتیاز</span>
                        </span>

                        {if $buyBoxVariant == NULL}
                            <div>
                                <span>محصول در حال حاضر موجود نیست</span>
                            </div>
                        {else}
                            {if 0}
                                <div class="product-discount">
                                    <span class='w-discount-span'>پیشنهاد {$product->wonder->wonder_category->title} - {$product->wonder->discount}٪ تخفیف</span>
                                </div>
                            {elseif $product.discount_price != NULL}
                                <div class="product-discount">
                                    <span class='w-discount-span'>حراجی  </span>
                                </div>
                            {/if}
                            <div class="product-infomation">
                                <ul class="list-unstyled product-varient clearfix">
                                    {foreach $respectiveVariants as $mainVariant}
                                        <li class="varient-item js-upload-size" data-name="{$mainVariant['name']}">
                                            <span class="title js-input-title">{$mainVariant['label']}: </span>
                                            <select class="form-control input-select js-srv-select"
                                                    name="{$mainVariant['name']}">
                                                <option value="" disabled>انتخاب {$mainVariant['label']}</option>
                                                {if false}
                                                    {foreach $mainVariant['values'] as $variantPossibleValue}
                                                        <option value="{$variantPossibleValue['id']}"
                                                                {if in_array($variantPossibleValue['id'],$buyBoxValueIds)}selected{/if} >
                                                            {$variantPossibleValue['title']}
                                                        </option>
                                                    {/foreach}
                                                {/if}
                                            </select>
                                        </li>
                                    {/foreach}
                                </ul>
                            </div>
                        {/if}
                        <div class="product-description">{$product.desc}</div>
                        <div class="group-btn-share">
                            <a socialshare="" target="_blank"
                               href="https://telegram.me/share/url?url={site_url}{$product->link}">
                                <i class="fab fa-telegram" aria-hidden="true"></i>
                            </a>
                            <a socialshare="" target="_blank" socialshare-provider="linkedin"
                               href="https://www.linkedin.com/shareArticle?mini=true&url={site_url}{$product->link}&title={$product.title}&summary={$product.desc}"
                               socialshare-text="">
                                <i class="fab fa-linkedin" aria-hidden="true"></i>
                            </a>
                            <a target="_blank"
                               href="https://plus.google.com/share?url={site_url}{$product->link}">
                                <i class="fab fa-google-plus-square" aria-hidden="true"></i>
                            </a>
                            <a target="_blank" class="twitter-share-button"
                               href="https://twitter.com/home?status={site_url}{$product->link}">
                                <i class="fab fa-twitter-square" aria-hidden="true"></i>
                            </a>
                            <a target="_blank"
                               href="https://www.facebook.com/sharer/sharer.php?u={site_url}{$product->link}"
                               socialshare-text="">
                                <i class="fab fa-facebook-square" aria-hidden="true"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6">
                    <div class="product-info-price">
                        <div class="product-info-stock-sku">
                            <meta itemprop="itemCondition" content="https://schema.org/NewCondition" />
                            <div itemprop="brand" itemtype="http://schema.org/Brand" itemscope>
                                <meta itemprop="name" content="{$product.user.business_name}" />
                            </div>
                            <div class="stock available">
                                <span class="label-stock">فروشنده : </span>
                                {$product.user.business_name}
                            </div>
                        </div>
                        {if $buyBoxVariant != NULL}
                            <div class="transportation">
                                <i class="fa fa-shipping-fast"></i>
                                زمان ارسال کالا:
                                {if $buyBoxVariant.lead_time eq 0}
                                    <span>آماده ارسال</span>
                                {else}
                                    {*<span>از {$buyBoxVariant.lead_time|persian_number} روز آینده</span>*}
                                    <span class="js-subtotal-delivery"><i class="fa fa-spinner"></i></span>
                                {/if}
                            </div>
                            <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
                                <link itemprop="url" href="{$product->link}"/>
                                <meta itemprop="priceCurrency" content="IRR"/>
                                <meta itemprop="availability" content="https://schema.org/InStock"/>
                                <span class="price" itemprop="price" content="{$buyBoxVariant->price}">
                                <ins class="js-subtotal-price"><i class="fa fa-spinner"></i></ins>
                            </span>
                            </div>
                            {if $has_qty_input}
                                <div class="quantity js-product-qty clearfix js-upload-size" data-name="qty">
                                    <h6 class="quantity-title">انتخاب تعداد:</h6>
                                    <div class="buttons-added">
                                        <input name="qty" type="text" value="1" title="انتخاب تعداد"
                                               class="input-text qty text js-qty-select" size="1">
                                        <a class="sign minus">
                                            <i class="fa fa-minus"></i>
                                        </a>
                                        <a class="sign plus">
                                            <i class="fa fa-plus"></i>
                                        </a>
                                    </div>
                                </div>
                            {/if}
                        {/if}
                        <div class="single-add-to-cart">
                            {if $buyBoxVariant != NULL}
                                <a href="#" class="btn-add-to-cart js-add-shopping">
                                    <div class="content">
                                        <i class="fa fa-shopping-basket"></i>
                                        افزودن به سبد خرید
                                    </div>
                                    <i class="loading-icon fas fa-circle-notch fa-spin"></i>
                                </a>
                            {else}
                                <span>نا موجود</span>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="tab-details-product">
            <ul class="box-tab nav-tab">
                <li class="active"><a data-toggle="tab" href="#tab-1">مشخصات</a></li>
                <li><a data-toggle="tab" href="#tab-2">توضیحات کالا</a></li>
                <li><a data-toggle="tab" href="#tab-3">نظرات کاربران</a></li>
            </ul>
            <div class="tab-container">
                <div id="tab-1" class="tab-panel active">
                    <div class="box-content">
                        <ul class="">
                            {foreach $showFilters as $filters}
                                <li>
                                    <strong class="specific-label">{$filters['title']}:&nbsp;</strong>
                                    {foreach $filters['values'] as $key => $filter}
                                        <span class="specific-value">{$filter['title']}</span>
                                        {if $key != count($filters['values']) - 1}/{/if}
                                    {/foreach}
                                </li>
                            {/foreach}
                        </ul>
                        {* {if $is_logged_in AND $user->type == 2}
                        <a  href="{site_url}contacts/tickets/new-ticket/{$product.user_id}" class="btn btn-color btn-small left"><span>ارسال پیام به فروشنده</span></a>
                        {/if}*}
                    </div>
                </div>
                <div id="tab-2" class="tab-panel">
                    <div class="box-content">
                        <h3 class="">{$product.title}</h3>
                        <p itemprop="description">{$product.desc}</p>
                    </div>
                </div>
                <div id="tab-3" class="tab-panel">
                    <div class="box-content">
                        <div class="row mb-25">
                            {foreach $product.comments as $cm}
                                <div class="col-xs-12 col-sm-10 col-lg-8 mb-25">
                                    <div class="product-comments">
                                        <div class="clearfix mb-30">
                                            <figure class="comment-img mb-sm-0">
                                                <img class="w-75" width="70"
                                                     src="{assets_url}images/static/user-icon.png"
                                                     alt="">
                                            </figure>
                                            <div class="comment-username">
                                                <div class="mb-7">
                                                    {$cm.user.first_name} {$cm.user.last_name}
                                                </div>
                                                <div>{jdate date=$cm.created_at format="Y-m-d"}</div>
                                            </div>
                                            {if 0}
                                                <div class="label-custom-light float-right float-sm-left">خریدار این
                                                    محصول
                                                </div>
                                            {/if}
                                        </div>
                                        <p class="comment-text">
                                            {$cm.comment}
                                        </p>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                        <h4 href="#" class="form-title">نظر خود را در مورد این محصول بنویسید</h4>

                        {if !isset($user->id)}
                            <p class="text">برای ثبت نظر، لازم است ابتدا وارد حساب کاربری خود شوید. اگر این محصول را
                                قبلا از
                                نوین نقش خریده باشید، نظر شما به عنوان مالک محصول ثبت خواهد شد.</p>
                        {else}
                            <form method="post" action="/shop/products/comment" class="new-review-form">
                                <div class="form-content">
                                    <p class="form-row form-row-wide">
                                        <label>متن نظر</label>
                                        <textarea class="form-control" name="comment" rows="7"
                                                  placeholder="نظر یا تجربه شما در مورد خرید یا استفاده از {$product.title}"></textarea>
                                    </p>
                                    <p class="form-row">
                                        <input type="submit" value="ثبت نظر" name="Submit" class="button-submit">
                                    </p>
                                </div>
                            </form>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="block-recent-view">
        <div class="container">
            <div class="title-of-section">محصولات مرتبط</div>
            <div class="owl-carousel nav-style2 border-background equal-container" data-nav="true" data-autoplay="false"
                 data-dots="false" data-loop="true" data-margin="0"
                 {literal}data-responsive='{"0":{"items":1},"480":{"items":2},"600":{"items":3},"1000":{"items":6}}'{/literal}>
                {foreach $related as $value}
                    <div class="product-item style1">
                        <div class="product-inner equal-elem">
                            <div class="product-thumb">
                                <div class="thumb-inner">
                                    <a href="{$value['link']}">
                                        <img src="{$products_thumbnail_dir}{$value['pic']}"
                                             alt="{$value['title']}">
                                    </a>
                                </div>
                                {*                                <span class="onsale">-50%</span>*}
                                {*                                <a href="" class="quick-view">نمایش سریع</a>*}
                            </div>
                            <div class="product-innfo">
                                <div class="product-name">
                                    <a href="{$value['link']}">
                                        <span itemprop="name">{$value['title']}</span>
                                    </a>
                                </div>

                                {if count($value['varients']) eq 0}
                                    <div class="sold-out valign">ناموجود</div>
                                {else}
                                    <span class="price">
                                                <ins>{$value['varients'][0]['price']|price_format}</ins>
                                </span>
                                {/if}
                                {*                                <span class="star-rating">*}
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
                {/foreach}
            </div>
        </div>
    </div>
</main>

<script>
    var InitFormData = '{$jsonPayLoad}';
</script>
