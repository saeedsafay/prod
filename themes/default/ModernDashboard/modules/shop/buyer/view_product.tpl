{add_js file='js/cart.js' part='footer'}
<!-- Start Product Details -->
<section class="htc__product__details ptb-50">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="product__top_wrap">
                    <!-- Start product Details -->
                    <div class="row">
                        <div class="col-md-4 col-lg-4 col-sm-5 single-profuct-thumb">
                            <div class="tp-portfolio-pic-show">
                                <div class="tp-portfolio-full-image tab-content">
                                    <div role="tabpanel" class="tab-pane fade in active" id="img-tab-1">
                                        <img alt="{$Product.title}" src="{site_url()|con:'upload/ads/pic/':$Product.pic}" >
                                    </div>
                                    {if $Product.pic2 != ''}
                                        <div role="tabpanel" class="tab-pane fade" id="img-tab-2">
                                            <img alt="{$Product.title}" src="{site_url()|con:'upload/ads/pic/':$Product.pic2}" >
                                        </div>
                                    {/if}
                                    {if $Product.pic3 != ''}
                                        <div role="tabpanel" class="tab-pane fade" id="img-tab-3">
                                            <img alt="{$Product.title}" src="{site_url()|con:'upload/ads/pic/':$Product.pic3}" >
                                        </div>
                                    {/if}
                                </div>
                            </div>
                            <div class="tp-portfolio-small-image nav nav-tabs" role="tablist">
                                <div class="prodict-det-small">
                                    <div role="presentation" class="pot-small-img active">
                                        <a href="#img-tab-1">
                                            <img src="{site_url()|con:'upload/ads/pic/':$Product.pic}" alt="{$Product.title}">
                                        </a>
                                    </div>

                                    {if $Product.pic2 != ''}
                                        <div class="pot-small-img" role="presentation">
                                            <a href="#img-tab-2">
                                                <img alt="{$Product.title}" src="{site_url()|con:'upload/ads/pic/':$Product.pic2}" >
                                            </a>
                                        </div>
                                    {/if}
                                    {if $Product.pic3 != ''}
                                        <div class="pot-small-img" role="presentation">
                                            <a href="#img-tab-3">
                                                <img src="{site_url()|con:'upload/ads/pic/':$Product.pic2}" alt="{$Product.title}">
                                            </a>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        </div>
                        <div class="col-md-8 col-lg-8 col-sm-7 single-profuct-content">
                            <div class="htc__product__details__area">
                                <h2><a href="#">{$Product.title}</a></h2>
                                <div class="product__price__rating">
                                    <div class="product__prize">
                                        {if $Product.old_price != NULL AND $Product.old_price > 0}
                                            <p class="new__prize text-theme">{$Product.old_price|price_format} (کیلوگرم)</p>
                                        {/if}
                                        {if $Product.price > 0}
                                            <p class="old__prize">{$Product.price|price_format}</p>
                                        {/if}
                                    </div>
                                </div>
                                <p>{$Product.desc}</p>
                                <form id="cart_form">
                                    <div class="product-action-wrap">
                                        <div class="prodict-statas">
                                            {if $Product.ads_category_id != 1 AND  $Product.ads_category_id != 2 AND $Product.stock > 0}<span>موجود</span> {else}<span>ناموجود</span>{/if}</div>
                                        <div class="product-quantity">
                                            <div class="product-quantity">
                                                <div class="cart-plus-minus">
                                                    <input class="cart-plus-minus-box" type="text" name="qty" value="1">
                                                </div> کیلوگرم
                                            </div>
                                        </div>
                                    </div>
                                    <ul class="social__icon mb-30">
                                        <form id="cart_form">
                                            <input type="hidden" name="prd_id" value="{$Product.id}">
                                            <li><a id="add_to_cart" href="#"> افزودن به سبد خرید<i class="zmdi zmdi-shopping-cart"></i> </a></li>
                                    </ul>
                                </form>
                                <!-- Start Small images -->

                                <!-- End Small images -->
                            </div>
                        </div>
                    </div>
                    <!-- End product Details -->
                </div>
            </div>
        </div>
        <!-- Start Review Information -->
        <div class="review__info__wrap mt-50">
            <div class="row">
                <div class="review__tab">
                    <div class="col-md-10 col-lg-10 col-sm-12 col-xs-12">
                        <ul class="review__info__menu" role="tablist">
                            <li role="presentation" class="description active"><a href="#description" role="tab" data-toggle="tab">توضیحات محصول</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-10 col-lg-10 col-sm-12 col-xs-12">
                    <!-- Start Tab Content -->
                    <div id="description" role="tabpanel" class="single-review-tab tab-pane fade in active">
                        <div class="review__address__inner description-inner">
                            {$Product.short_desc}
                        </div>
                    </div>
                    <!-- End Tab Content -->
                </div>
            </div>
        </div>
        <!-- End Review Information -->
    </div>
</section>
<!-- End Product Details -->
<!-- Start Related Product -->
<section class="htc__related__product pb-100">
    <div class="container">
        <div class="row mb-40">
            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                <div class="fg-section-title">
                    <h2 class="section__title text-center">محصولات مرتبط</h2>
                </div>
            </div>
        </div>
        <div class="row">
            {foreach $related as $post}
                <!-- Start Single product -->
                <div class="col-md-3 col-lg-3 col-sm-6 col-xs-12 pull-right">
                    <div class="single__product">
                        <div class="product__inner">
                            <div class="product__thumb__inner">
                                <div class="product__thumb">
                                    <a href="#"><img src="{site_url()|con:'upload/ads/pic/':$post.pic}" alt="{$post.title}"></a>
                                </div>
                            </div>
                        </div>
                        <div class="product__details">
                            <div class="product__prize">
                                {if $post.old_price != NULL AND $post.old_price > 0}
                                    <p class="new__prize">{$post.old_price|price_format}</p>
                                {else if $post.price > 0}
                                    <p class="old__prize">{$post.price|price_format}</p>
                                {/if}
                            </div>
                        </div>
                        <div class="product__hover__information">
                            <ul class="social__icon">

                                <li><a data-toggle="modal" data-target="#productModal{$post.id}" title="نمایش سریع" class="quick-view modal-view detail-link" href="#"><i class="zmdi zmdi-eye"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- End Single product --> 

                <!-- QUICKVIEW PRODUCT -->
                <div id="quickview-wrapper">
                    <!-- Modal -->
                    <div class="modal fade" id="productModal{$post.id}" tabindex="-1" role="dialog">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                </div>
                                <div class="modal-body">
                                    <div class="modal-product">
                                        <!-- Start product images -->
                                        <div class="product-images">
                                            <div class="main-image images">
                                                <img alt="{$Product.title}" src="{site_url()|con:'upload/ads/pic/':$Product.pic}" >
                                            </div>
                                        </div>
                                        <!-- end product images -->
                                        <div class="product-info">
                                            <h1>{$post.title}</h1>
                                            <div class="price-box-3">
                                                <div class="s-price-box">
                                                    {if $post.old_price != NULL AND $post.old_price > 0}
                                                        <p class="old-price"> {$post.old_price|price_format}</p>
                                                    {else if $post.price > 0}
                                                        <p class="new-price">{$post.price|price_format}</p>
                                                    {/if}
                                                </div>
                                            </div>
                                            <a href="{site_url}products" class="see-all">نمایش همه ی محصولات</a>
                                            <div class="quick-add-to-cart">
                                                <form class="cart">
                                                    <a class="single_add_to_cart_button add_to_cart" href="{site_url()|con:'product/':$post->slug}">نمایش</a>
                                                    <div class="numbers-row">
                                                    </div>

                                                </form>
                                            </div>
                                            <div class="quick-desc">
                                                {$post.short_desc}
                                            </div>
                                        </div><!-- .product-info -->
                                    </div><!-- .modal-product -->
                                </div><!-- .modal-body -->
                            </div><!-- .modal-content -->
                        </div><!-- .modal-dialog -->
                    </div>
                    <!-- END Modal -->
                </div>
                <!-- END QUICKVIEW PRODUCT -->

            {/foreach}
        </div>
    </div>
</section>
<!-- End Related Product -->