<nav class="section-wrap py-0">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">
            <a href="{site_url}">خانه</a>
        </li>
        <li class="breadcrumb-item">
            <a href="{site_url}prd/{$Product.product_type.slug}">{$Product.product_type.title}</a>
        </li>
        <li class="breadcrumb-item">
            <a href="{site_url}prd/{$Product.product_type.slug}/{$Product.category.slug}">{$Product.category.title}</a>
        </li>
        <li class="breadcrumb-item">
            <a href="{site_url}prd/{$Product.product_type.slug}/{$Product.child_category.slug}">{$Product.child_category.title}</a>
        </li>
        <li class="breadcrumb-item active">
            <a title="{$Product.title}">{$Product.title}</a>
        </li>
    </ol>
</nav>
<section class="section-wrap single-product bg-white rounded-custom">
    <div class="row">
        <div class="col-12 col-md-6 pl-md-65 mb-30 mb-md-0">
            <div class="royalSlider rsUni js-pr-gallery">
                <a class="rsImg" href="{$products_thumbnail_dir}{$Product.pic}"
                   data-rsbigimg="{$products_thumbnail_dir}{$Product.pic}">
                    <img class="rsTmb" src="{$products_thumbnail_dir}{$Product.pic}"
                         alt="{$Product.title}"/>
                </a>
                {foreach $Product.images as $image}
                    <a class="rsImg" href="{$products_thumbnail_dir}{$image.file_name}"
                       data-rsbigimg="{$products_thumbnail_dir}{$image.file_name}">
                        <img class="rsTmb" src="{$products_thumbnail_dir}{$image.file_name}"
                             alt="{$Product.title}"/>
                    </a>
                {/foreach}

            </div>
            <ul class="whish-list list-unstyled">
                <li>
                    <a href="#" onclick="$(this).addFavorite({$Product.id})"><i class="fa fa-heart"></i></a>
                </li>
                <li class="dropdown">
                    <a href="#" class="product-add-to-compare dropdown-toggle" data-toggle="dropdown"
                       data-placement="bottom" title="اشتراک گذاری">
                        <i class="fa fa-share-alt"></i>
                    </a>

                    <ul class="dropdown-menu nav_inside ">
                        <li><a socialshare="" target="_blank"
                               href="https://telegram.me/share/url?url={site_url}product/{$Product.slug}"> <span
                                        class="pull-right"><i class="fab fa-telegram" aria-hidden="true"></i></span>تلگرام</a>
                        </li>
                        <li><a socialshare="" target="_blank" socialshare-provider="linkedin"
                               href="https://www.linkedin.com/shareArticle?mini=true&url={site_url}product/{$Product.slug}&title={$Product.title}&summary={$Product.desc}"
                               socialshare-text=""> <span class="pull-right"><i class="fab fa-linkedin"
                                                                                aria-hidden="true"></i></span>لینکدین</a>
                        </li>

                        <li><a target="_blank"
                               href="https://plus.google.com/share?url={site_url}product/{$Product.slug}"><span
                                        class="pull-right"><i class="fab fa-google-plus-square" aria-hidden="true"></i></span>گوگل
                                پلاس </a></li>

                        <li><a target="_blank" class="twitter-share-button"
                               href="https://twitter.com/home?status={site_url}product/{$Product.slug}"><span
                                        class="pull-right"><i class="fab fa-twitter-square"
                                                              aria-hidden="true"></i></span>توییتر</a></li>

                        <li><a target="_blank"
                               href="https://www.facebook.com/sharer/sharer.php?u={site_url}product/{$Product.slug}"
                               socialshare-text=""><span class="pull-right"><i class="fab fa-facebook-square"
                                                                               aria-hidden="true"></i></span>فیسبوک</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="col-12 col-md-6 pr-md-65">
            <div class="product-content">
                <a href="{site_url}product/{$Product.slug}" title="{$Product.title}">
                    <h1 class="product-title">{$Product.title}</h1>
                </a>
                <div class="">
                    دسته‌بندی:
                    <a target="_blank" href="{site_url}prd/{$Product.product_type.slug}/{$Product.child_category.slug}">
                        {$Product.child_category.title}
                    </a>
                </div>
                {if isset($Product->wonder)}
                    <div class="product-discount">
                        <span class='w-discount-span'>پیشنهاد {$Product->wonder->wonder_category->title} - {$Product->wonder->discount}٪ تخفیف</span>
                    </div>
                {elseif $Product.discount_price != NULL}
                    <div class="product-discount">
                        <span class='w-discount-span'>حراجی  </span>
                    </div>
                {/if}
            </div>
            {if $Product.sale_status == 1 && 0}
                <div class="product-select mb-40">
                    <div class="input-group item{$Product.id}">
                        <div class="input-group-prepend">
                            <label class="input-group-text" for="js-select-product">تعداد</label>
                        </div>
                        <select id="js-select-product" name="qty" class="form-control item-qty">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                        </select>
                    </div>
                </div>
            {/if}
            <div class="product-select mb-40">
                {literal}
                    <style>

                        .center-on-page {
                            transform: translate(0%, -20%);
                        }

                        input[type="checkbox"],
                        input[type="radio"] {
                            position: absolute;
                            opacity: 0;
                            z-index: -1;
                        }

                        label {
                            position: relative;
                            display: inline-block;
                            margin-right: 11px;
                            margin-bottom: 0px !important;
                            width: 72px;
                            /* padding-left: 14px!important; */
                            /* padding-right: 3px!important; */
                            line-height: 26px !important;
                            cursor: pointer !important;
                            text-align: center;
                            border: 1px solid #ddd;
                            border-radius: 5px;
                        }

                        label::before {
                            content: " ";
                            position: absolute;
                            top: 6px;
                            left: 0;
                            display: block;
                            width: 24px;
                            height: 24px;
                            border: 2px solid #8e44ad;
                            border-radius: 4px;
                            z-index: -1;
                        }

                        input[type="radio"] + label::before {
                            border-radius: 2px;
                            border: 1px solid #ddd0;
                            background: #ddd0;
                        }

                        /* Checked */
                        input[type="checkbox"]:checked + label,
                        input[type="radio"]:checked + label {
                            padding-left: 10px;
                            color: #fff;
                        }

                        input[type="checkbox"]:checked + label::before,
                        input[type="radio"]:checked + label::before {
                            top: 0;
                            width: 100%;
                            height: 100%;
                            background: #01b8c1;
                            margin-left: 0;
                        }

                        /* Transition */
                        label,
                        label::before {
                            -webkit-transition: .25s all ease;
                            -o-transition: .25s all ease;
                            transition: .25s all ease;
                        }

                        .varient-part {
                            /* padding-right: 8px;
                             padding-left: 8px;*/

                        }

                        .most_padding {
                            padding-top: 7px
                        }
                    </style>
                {/literal}

                {if $most_varient == NULL}
                    <ul class="list-unstyled product-shipping">
                        <li>
                            <i class="fa fa-close"></i>
                            <span>
                                محصول در حال حاضر موجود نیست
                            </span>
                        </li>
                        <br>
                    </ul>
                {else}
                    {foreach $most_varient.fields as $val}
                        {if $val.value.parentDiversity.can_change != 1}
                            {continue}
                        {/if}
                        <div class="row center-on-page">
                            <span class="most_padding">انتخاب {$val.value.parentDiversity.label}: </span>
                            {foreach $diversity_data as $data}
                                {foreach $data.fields as $field}
                                    {if $field.value.parentDiversity.can_change != 1 || $val.value.parentDiversity.id != $field.value.parentDiversity.id}
                                        {continue}
                                    {/if}
                                    <span class="varient-part">
                                        <input type="hidden" class="product_id" value="{$Product.id}"/>
                                        <input type="hidden" class="varient_value_id" value="{$field.value.id}"/>
                                        <input type="radio" id="varient{$field.value.id}"
                                               name="varient[{$val.value.parentDiversity.name}]"
                                               value="{$field.value.id}"
                                               {if $val.value.id eq $field.value.id}checked{/if}>
                                        <label for="varient{$field.value.id}">{$field.value.title}</label>
                                    </span>
                                {/foreach}
                            {/foreach}
                        </div>
                    {/foreach}
                    <br>
                    <ul class="list-unstyled product-shipping product-varient-rows">
                        {foreach $most_varient.fields as $val}
                            {if $val.value.parentDiversity.can_change != 1}
                                <li class='varient-row'>
                                    <i class="fa fa-check"></i>{$val.value.parentDiversity.label}:
                                    <span>{$val.value.title}</span>
                                </li>
                            {/if}
                        {/foreach}
                        <li class="lead_time">
                            <i class="fa fa-shipping-fast"></i>
                            زمان ارسال کالا:
                            {if $most_varient.lead_time eq 0}
                                <span>آماده ارسال</span>
                            {else}
                                <span>از {$most_varient.lead_time|persian_number} روز آینده</span>
                            {/if}
                        </li>
                    </ul>
                {/if}
            </div>

            <div class="product-button mb-30">
                {if $most_varient == NULL}
                    <div class="btn-noexist mr-auto out-of-stock">ناموجود</div>
                {else}
                    <div class="product-price">
                        {if isset($Product->wonder) && 0}
                            <del>{$Product.price|price_format}</del>
                            <ins>قیمت
                                :{($Product->price - ($Product->price * $Product->wonder->discount / 100))|price_format} </ins>
                        {else}
                            <ins> قیمت : <span class="varient_price">{$most_varient.price|price_format}</span></ins>
                        {/if}
                    </div>
                    <input type='hidden' id='selected-varient-id' value='{$most_varient.id}'/>
                    <a id="add_to_cart" onclick="$(this).addToCart({$Product.id}, $('#selected-varient-id').val())"
                       href="#" class="btn-custom mr-auto">اضافه به سبد خرید</a>
                {/if}
                <div class='loading-varient'></div>
            </div>
        </div>

    </div>
</section>
<section class="section-wrap single-product bg-white rounded-custom">
    <ul class="nav nav-tabs" id="myTab" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#js-product-specific" aria-selected="true">مشخصات</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#js-product-description" aria-selected="false">توضیحات کالا</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#js-product-comments" aria-selected="false">نظرات کاربران</a>
        </li>
    </ul>
    <div class="tab-content" id="myTabContent">
        <div class="tab-pane fade show active" id="js-product-specific">
            <ul class="detail_product_sec">
                {foreach $Product.filters as $filter}
                    <li>
                        <strong class="specific-label">{$filter.parentFilter.label}:&nbsp;</strong>
                        <span class="specific-value">{$filter.title}</span>
                    </li>
                {/foreach}
            </ul>
            {* {if $is_logged_in AND $user->type == 2}
            <a  href="{site_url}contacts/tickets/new-ticket/{$Product.user_id}" class="btn btn-color btn-small left"><span>ارسال پیام به فروشنده</span></a>
            {/if}*}
        </div>
        <div class="tab-pane fade" id="js-product-description">
            <h3 class="product-title">{$Product.title}</h3>
            <p class="product-description">{$Product.desc}</p>
        </div>
        <div class="tab-pane fade" id="js-product-comments">
            {if ture}
                <div class="row justify-content-center mb-20">
                    {foreach $Product.comments as $cm}
                        <div class="col-12 col-sm-10 col-lg-8 mb-20">
                            <div class="product-comments">
                                <div class="clearfix mb-30">
                                    <figure class="comment-img mb-15 mb-sm-0">
                                        <img class="w-100" src="{assets_url}img/usermen.png" alt="">
                                    </figure>
                                    <div class="comment-username">
                                        <div class="mb-7">
                                            {$cm.user.first_name} {$cm.user.last_name}
                                        </div>
                                        <div>{jdate date=$cm.created_at format="Y-m-d"}</div>
                                    </div>
                                    <div class="label-custom-light float-right float-sm-left">خریدار این محصول</div>
                                </div>

                                <p class="comment-text">
                                    {$cm.comment}
                                </p>
                            </div>
                        </div>
                    {/foreach}
                </div>
                <div class="row justify-content-center mb-30 js-comment-wrapp">
                    <div class="col-12 col-sm-10 col-lg-8">
                        <div class="comment-add">
                            <h6 class="title">شما هم می‌توانید در مورد این کالا نظر بدهید.</h6>
                            <p class="text">برای ثبت نظر، لازم است ابتدا وارد حساب کاربری خود شوید. اگر این محصول را
                                قبلا از دیجی‌کالا خریده باشید، نظر شما به عنوان مالک محصول ثبت خواهد شد.</p>
                        </div>
                        <a class="btn-custom d-inline-block float-sm-left js-add-comments" href="#">افزودن نظر جدید</a>
                    </div>
                </div>
            {/if}
            <div class="row justify-content-center mb-30 comment-form-container js-comment-container {if !$is_logged_in}is-hidden{/if}">
                <div class="col-12 col-sm-10 col-lg-6">
                    <div class="comment-form">
                        <h4 class="title">شما هم می‌توانید در مورد این کالا نظر بدهید.</h4>
                        <p class="text">برای ثبت نظر، لازم است ابتدا وارد حساب کاربری خود شوید. اگر این محصول را قبلا از
                            دیجی‌کالا خریده باشید، نظر شما به عنوان مالک محصول ثبت خواهد شد.</p>
                        <form action="" method="POST">
                            <textarea class="form-control" name="comment" rows="7"
                                      placeholder="لطفا متن نظر خود را بنویسید"></textarea>
                            <button class="btn-custom" type="submit">ثبت نظر</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<section class="section-wrap single-product bg-white product-invite clearfix">
    <p class="d-inline-block mb-0">آیا این کالا را برای فروش دارید؟ <small>با سریع‌ترین و راحت‌ترین روش ممکن کالاهای خود
            را در سایت بفروشید</small></p>
    <a href="{site_url}users/login" target="_blank" class="btn-custom-light mr-auto d-inline-block mt-20 mt-sm-0">به جمع
        فروشندگان این کالا بپیوندید</a>
</section>
<section class="section-wrap single-product bg-white related-products">
    <div class="top-middle-flex mb-50">
        <h2 class="title-spec mb-0">محصولات مرتبط</h2>
        <a href="#" class="blog-buttonmore">مشاهده محصولات بیشتر</a>
    </div>
    <div id="owl-related-products" class="owl-carousel owl-theme custom-navigation">
        {foreach $related as $val}
            <div class="product-item">
                <div class="product-img">
                    <a href="{site_url}product/{$val.slug}">
                        <img src="{$products_thumbnail_dir}{$val.pic}" alt="">
                    </a>
                    <div class="product-quickview">
                        <div class="product-actions">
                            <a href="#" onclick="$(this).addToCart({$val.id})" class="product-add-to-wishlist"
                               data-toggle="tooltip" data-placement="bottom" title="اضافه به سبد خرید">
                                <i class="fa fa-shopping-basket"></i>
                            </a>
                            <a href="#" onclick="$(this).addFavorite({$val.id})" class="product-add-to-wishlist"
                               data-toggle="tooltip" data-placement="bottom" title="افزودن به علاقمندی‌ها">
                                <i class="fa fa-heart"></i>
                            </a>
                        </div>
                        <a class="btn-custom" href="{site_url}product/{$val.slug}">نمایش محصول</a>
                    </div>
                </div>
                <div class="product-details text-center">
                    <h3><a class="product-title" href="{site_url}product/{$val.slug}">{$val.title}</a></h3>
                    <div class="price-relative">
                        {if $val.discount_price != null}
                            <div class="old-price">
                                <span>{$val.discount_price|price_format}</span>
                            </div>
                            <div class="new-price">
                                <span>{$val.price|price_format}</span>
                            </div>
                        {else}
                            <div class="new-price">
                                <span>{$val.price|price_format}</span>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        {/foreach}
    </div>
</section>
