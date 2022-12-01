<!-- Start Product Grid View -->
<section class="product__grid__view bg-white ptb-100">
    <div class="container">
        <div class="row">
            <div class="col-md-3 pull-right">
                <!-- Start Blog Right Bar -->
                <div class="blog__right__sidebar">
                    <!-- Start Blog Search -->
                    <div class="category__search">
                        <form id="searchProduct" action="{site_url}shop/products/search" method="GET">

                            <input type="text" name="query_var" placeholder="جستجوی محصول">
                            <div class="btn-search">
                                <a id="submitSearchProduct" href="#"><i class="zmdi zmdi-search"></i></a>
                            </div>
                        </form>
                    </div>
                    <!-- End Blog Search -->
                    <!-- Start Category Menu -->
                    {if isset($currentCategory->grandparentCat->id)}
                        {$mainCat = $currentCategory->grandparentCat}
                    {elseif isset($currentCategory->parentCat->id)}
                        {$mainCat = $currentCategory->parentCat}
                    {else}
                        {$mainCat = $currentCategory}
                    {/if}
                    <div class="category__area">
                        <h4 class="section-title-5">فیلتر {$mainCat.title}</h4>
                        <ul class="category__menu">
                            <li><a href="{site_url()|con:'cats/':$mainCat.slug}">همه</a></li>
                                {foreach from=$mainCat->children item=parent}
                                <li><a href="{site_url()|con:'cats/':$parent.slug}">{$parent.title}</a></li>
                                {/foreach}
                        </ul>
                    </div>
                    <div class="category__area">
                        <h4 class="section-title-5">دسته‌بندی </h4>
                        <ul class="category__menu">
                            {if $currentCategory->grandparent_id != 0}
                                <li><a href="{site_url()|con:'cats/':$currentCategory.parentCat.slug}">همه</a></li>
                                {else}
                                <li><a href="{site_url()|con:'cats/':$currentCategory.slug}">همه</a></li>
                                {/if}
                                {if $currentCategory.children->count() != 0 AND $currentCategory->parent_id != 0}    
                                    {foreach from=$mainCat.grandchildren item=item}
                                    <li><a href="{site_url}cats/{$item.parentCat.slug}/{$item.slug}">{$item.title}</a></li>
                                    {/foreach}
                                {elseif $currentCategory.grandparent_id != 0}
                                    {foreach from=$currentCategory.parentCat.children item=item}
                                    <li><a href="{site_url}cats/{$item.parentCat.slug}/{$item.slug}">{$item.title}</a></li>
                                    {/foreach}
                                {/if}
                        </ul>
                    </div>
                    <!-- End Category Menu -->
                    <!-- Start Sorting Menu -->
                    <div class="category__area">
                        <h4 class="section-title-5">مرتب‌سازی بر اساس</h4>
                        <ul class="category__menu">
                            <li><a href="{site_url}cats/{$slug}?sort=highPrice">بیشترین قیمت</a></li>
                            <li><a href="{site_url}cats/{$slug}?sort=lowPrice">کمترین قیمت</a></li>
                            <li><a href="{site_url}cats/{$slug}?sort=newest">جدیدترین</a></li>
                            <li><a href="{site_url}cats/{$slug}?sort=sold">پرفروش‌ترین</a></li>
                            <li><a href="{site_url}cats/{$slug}?sort=mostVisted">پربازدیدترین</a></li>
                        </ul>
                    </div>
                    <!-- Start Leatest Post -->
                    <div class="recent__post__area">
                        <h4 class="section-title-5">پربازدید‌ترین‌ها</h4>
                        {foreach $most_visited as $popular}
                            <!-- Start Single post -->
                            <div class="recent__post__inner">
                                <div class="fresh">
                                    <div class="fresh-item-left">
                                        <div class="frs-item-thumb">
                                            <a href="{site_url()|con:'product/':$popular->slug}">
                                                <img width="130" height="100" src="{site_url()|con:'upload/ads/pic/':$popular.pic}" alt="{$popular->title}">
                                            </a>
                                        </div>
                                    </div>
                                    <div class="fresh-item-right">
                                        <div class="fresh__details">
                                            <a href="{site_url()|con:'product/':$popular->slug}">{$popular->title}</a>
                                            <p class="new__prize">{$popular.price|price_format}</p>
                                        </div>
                                    </div>
                                </div> 
                            </div>
                            <!-- End Single post -->
                        {/foreach}
                    </div>
                    <!-- End Leatest Post -->
                </div>
                <!-- End Blog right Bar -->
            </div>
            <!-- Start Right Sidebar -->
            <div class="col-md-9 smmt-50 xsmt-50">
                <!-- End Right Sidebar -->
                <!-- Start Our ProductArea -->
                <div class="product__area bg-white product__full__view__area">
                    <div class="row">
                        <div class="product-view-wrap">
                            {if !$Products}
                                <!-- Start Gried View -->
                                <div role="tabpanel" id="grid-view" class="single-grid-view tab-pane fade in active clearfix">
                                    <!-- Start Single product -->
                                    <div class="pro-item col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                        <label class="text-warning pull-right rtl">موردی یافت نشد</label>
                                    </div>
                                </div>
                            {else}  <!-- Start Gried View -->
                                <div role="tabpanel" id="grid-view" class="single-grid-view tab-pane fade in active clearfix">
                                    {foreach from=$Products item=val}
                                        <!-- Start Single product -->
                                        <div class="pro-item col-md-4 col-lg-4 col-sm-6 col-xs-12 pull-right">
                                            <div class="single__product">
                                                <div class="product__inner">
                                                    <div class="product__thumb__inner">
                                                        <div class="product__thumb">
                                                            <a href="{site_url()|con:'product/':$val->slug}"><img src="{site_url()|con:'upload/ads/pic/':$val.pic}" alt="{$val->title}"></a>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="product__details">
                                                    <div class="pro__title__rating">
                                                        <h4>{$val.title}</h4>

                                                    </div>
                                                    <div class="product__prize">
                                                        {if $val.old_price != NULL AND $val.old_price > 0}
                                                            <p class="old__prize">  {$val.old_price|price_format}</p>
                                                        {/if}
                                                        {if $val.price > 0}
                                                            <p class="new__prize">{$val.price|price_format}</p>
                                                        {/if}

                                                    </div>
                                                </div>
                                                <div class="product__hover__information">
                                                    <ul class="social__icon">
                                                        {*  <li><a href="cart.html"><i class="zmdi zmdi-shopping-cart"></i></a></li>*}
                                                        <li><a data-toggle="modal" data-target="#productModal{$val.id}" title="quick-view" class="quick-view modal-view detail-link" href="#"><i class="zmdi zmdi-eye"></i></a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- End Single product -->
                                        <!-- End Gried View -->


                                        <!-- QUICKVIEW PRODUCT -->
                                        <div id="quickview-wrapper">
                                            <!-- Modal -->
                                            <div class="modal fade" id="productModal{$val.id}" tabindex="-1" role="dialog">
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
                                                                        <img alt="{$val.title}" src="{site_url()|con:'upload/ads/pic/':$val.pic}" >
                                                                    </div>
                                                                </div>
                                                                <!-- end product images -->
                                                                <div class="product-info">
                                                                    <h1>{$val.title}</h1>
                                                                    <div class="price-box-3">
                                                                        <div class="s-price-box">
                                                                            {if $val.old_price != NULL AND $val.old_price > 0}
                                                                                <p class="old-price"> {$val.old_price|price_format}</p>
                                                                            {else if $val.price > 0}
                                                                                <p class="new-price">{$val.price|price_format}</p>
                                                                            {/if}
                                                                        </div>
                                                                    </div>
                                                                    <a href="{site_url}products" class="see-all">نمایش همه ی محصولات</a>
                                                                    <div class="quick-add-to-cart">
                                                                        <form class="cart">
                                                                            <a class="single_add_to_cart_button add_to_cart" href="{site_url()|con:'product/':$val->slug}">نمایش</a>
                                                                            <div class="numbers-row">
                                                                            </div>

                                                                        </form>
                                                                    </div>
                                                                    <div class="quick-desc">
                                                                        {$val.short_desc}
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
                            {/if}
                        </div>
                    </div>
                    <!-- start pagination -->
                    <div class="row">
                        <div class="col-md-12">
                            <ul class="htc-pagination clearfix text-center">
                                {if isset($offset)}
                                    {$paging}
                                {/if}
                                <li><a href="#"><i class="zmdi zmdi-chevron-right"></i></a></li>
                            </ul>
                        </div>
                    </div>
                    <!-- End pagination -->
                </div>
                <!-- End Our ProductArea -->
            </div>
        </div>
    </div>
</section>
<!-- End Product Grid View -->