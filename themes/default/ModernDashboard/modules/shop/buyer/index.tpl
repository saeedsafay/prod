{literal}
    <style>
        div.slider-wrap ul li{
            height: 88% !important;
        }
    </style>
{/literal}
<!-- HOME SLIDER -->
<div class="slider-wrap">
    <div class="fullwidthbanner-container" >
        <div class="fullwidthbanner-2">
            <ul>
                {foreach from=$Sliders item=slider}
                    <li data-transition="random" data-slotamount="7" data-masterspeed="300"  data-saveperformance="off" >
                        <!-- MAIN IMAGE -->
                        <img src="{site_url()|con:'upload/slider/':$slider.image}" alt="{$slider.subtitle}" style='background-color:#f7eee9' data-bgposition="center top" data-bgfit="cover" data-bgrepeat="no-repeat">
                        <!-- LAYERS -->

                        {if $slider.subtitle != ''}
                            <!-- LAYER NR. 1 -->
                            <div class="tp-caption title-11 customin tp-resizeme" 
                                 data-x="1404" 
                                 data-y="200"  
                                 data-customin="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:3;scaleY:3;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" 
                                 data-speed="1000" 
                                 data-start="1500" 
                                 data-easing="easeOutExpo" 
                                 data-splitin="none" 
                                 data-splitout="none" 
                                 data-elementdelay="0.1" 
                                 data-endelementdelay="0.1" 
                                 data-endspeed="300" 

                                 style="z-index: 6; max-width: auto; max-height: auto; white-space: nowrap;">
                                <h2 style="color:#FFF; font-family:yekan; background-color: rgba(221, 153, 51, 0.8); color: rgb(255, 255, 255); padding: 10px;">{$slider.subtitle}</h2>
                            </div>


                        {/if}

                        {if $slider.describtion != ''}
                            <!-- LAYER NR. 4 -->
                            <div class="tp-caption title-11 customin tp-resizeme" 
                                 data-x="1100" 
                                 data-y="275"  
                                 data-customin="x:0;y:0;z:0;rotationX:0;rotationY:0;rotationZ:0;scaleX:3;scaleY:3;skewX:0;skewY:0;opacity:0;transformPerspective:600;transformOrigin:50% 50%;" 
                                 data-speed="1000" 
                                 data-start="2500" 
                                 data-easing="easeOutExpo" 
                                 data-splitin="none" 
                                 data-splitout="none" 
                                 data-elementdelay="0.1" 
                                 data-endelementdelay="0.1" 
                                 data-endspeed="300" 

                                 style="z-index: 6; direction:rtl;max-width: auto; max-height: auto; white-space: nowrap;color:#444;font-size:15px ;background-color: #ec4445; color: rgb(255, 255, 255); padding: 10px;">
                                <h1 style="color:#fff; font-family:yekan;">{$slider.describtion}</h1>
                            </div>
                        {/if}

                        {if $slider.link != ''}
                            <!-- LAYER NR. 5 -->
                            <div class="tp-caption sfb stb" 
                                 data-x="1428" 
                                 data-y="480"  
                                 data-speed="1200" 
                                 data-start="3000" 
                                 data-easing="Power3.easeInOut" 
                                 data-elementdelay="0.1" 
                                 data-endelementdelay="0.1" 
                                 data-endspeed="500" 

                                 style="z-index: 8;"> <a style="font-size: 25px;padding: 7px 25px 7px; border:#CCC solid 1px;" href="{$slider.link}">نمایش </a>
                            </div>
                        {/if}
                    </li>
                {/foreach}
            </ul>
        </div>
    </div>
</div>
<!-- END HOME SLIDER -->


<nav class="home-se tmhome">
    <ul class="home-section">
        {$i = 1}
        {foreach from=$Cats item=val}

            <li class="studio-home productcat{$val.id}">

                <div class="title">
                    <a class="link-abs2" href="{site_url}advertise/shop/list-category/{$val.id}">
                        <i>
                            {$val.title}
                        </i>
                    </a>
                </div>
            </li>
            {if $i == 3} <br> {/if}
            {$i = 1 + $i}
        {/foreach}
    </ul>
</nav>

<!-- latest-deals-area start -->
<div class="latest-deals-area">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-4">
                <div class="section-heading-3">
                    <h3>آخرین فروش پیانویاب</h3>
                </div>
                <div class="latest-deals-curosel">
                    <!-- single-product start -->
                    {if $last_deal != null}
                    <div class="single-product">
                        <span class="sale-text">آخرین معامله</span>
                        <div class="product-img">
                            <a href="{site_url()|con:'shop/':$last_deal->slug}">
                                {if isset($last_deal->pic) AND $last_deal.pic != ''}
                                    <img class="primary-image" src="{site_url|con:'upload/ads/pic/':$last_deal.pic}" alt="{$last_deal.title}" />
                                {else}
                                    <img class="primary-image" src="{assets_url}img/ads4.jpg" alt="{$last_deal.title}"/>
                                {/if}
                            </a>
                            <div class="actions">
                                <div class="action-buttons">
                                    <div class="add-to-cart">
                                        <a href="{site_url()|con:'shop/':$last_deal->slug}">نمایش کالا</a>
                                    </div>
                                    <div class="add-to-links">
                                        <div class="compare-button">
                                            <a href="#" data-toggle="tooltip" class="compare-ads" onclick="$(this).addCompare({$last_deal.id});" title="مقایسه"><i class="fa fa-exchange"></i></a>
                                        </div>
                                    </div>
                                    <div class="quickviewbtn">
                                        <a href="{site_url()|con:'shop/':$last_deal->slug}" data-toggle="tooltip" title="نمایش آگهی"><i class="fa fa-search-plus"></i></a>
                                    </div>
                                </div>
                            </div>
                            <div class="ddd">
                                <div class="timer">
                                    <div data-countdown="2016/06/01"></div>
                                </div>								
                            </div>
                        </div>
                        <div class="product-content">
                            <h2 class="product-name"><a href="{site_url()|con:'shop/':$last_deal->slug}">{$last_deal->title}</a></h2>
                            <div class="pro-rating">
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                                <a href="#"><i class="fa fa-star"></i></a>
                            </div>
                            <div class="price-box">
                                <span class="new-price">{$last_deal->price|price_format}</span>
                            </div>
                        </div>
                    </div>		
                            {/if}
                    <!-- single-product end -->
                </div>	
            </div>
            <div class="col-lg-8 col-md-8 col-sm-8">
                <div class="section-heading-3">
                    <h3>پر فروش ترین ها</h3>
                </div>	
                <div class="row">
                    <div class="top-sellers-curosel">
                        <!-- single-product start -->
                        {foreach $most_sold as $val}
                            <div class="col-lg-3 col-md-3">
                                <div class="single-product top-sell-space">
                                    <div class="product-img">
                                        <a href="{site_url()|con:'shop/':$val->slug}">
                                            {if isset($val->pic) AND $val.pic != ''}
                                                <img class="primary-image" src="{site_url|con:'upload/ads/pic/':$val.pic}" alt="{$val.title}" />
                                            {else}
                                                <img class="primary-image" src="{assets_url}img/ads4.jpg"
                                                     alt="{$val.title}"/>
                                            {/if}
                                        </a>
                                        <div class="actions">
                                            <div class="action-buttons">
                                                <div class="add-to-cart">
                                                    <a href="{site_url()|con:'shop/':$val->slug}">نمایش کالا</a>
                                                </div>
                                                <div class="add-to-links">
                                                    <div class="compare-button">
                                                        <a href="#" data-toggle="tooltip" class="compare-ads" onclick="$(this).addCompare({$val.id});" title="مقایسه"><i class="fa fa-exchange"></i></a>
                                                    </div>									
                                                </div>
                                                <div class="quickviewbtn">
                                                    <a href="{site_url()|con:'shop/':$val->slug}" data-toggle="tooltip" title="نمایش آگهی"><i class="fa fa-search-plus"></i></a>
                                                </div>
                                            </div>
                                        </div>							
                                    </div>
                                    <div class="product-content"> 
                                        <h2 class="product-name"><a href="{site_url()|con:'shop/':$val->slug}">{$val->title}</a></h2>
                                        <div class="pro-rating">
                                            <a href="#"><i class="fa fa-star"></i></a>
                                            <a href="#"><i class="fa fa-star"></i></a>
                                            <a href="#"><i class="fa fa-star"></i></a>
                                            <a href="#"><i class="fa fa-star"></i></a>
                                            <a href="#"><i class="fa fa-star"></i></a>
                                        </div>
                                        <div class="price-box">
                                            <span class="new-price">{$val->price|price_format}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                        <!-- single-product end -->		
                    </div>				
                </div>
            </div>
        </div>
    </div>
</div>
<!-- latest-deals-area end -->
<!-- new-product-area start -->
<div class="product-blog-area">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-6 col-sm-6">
                <div class="section-heading-3">
                    <h3>محصولات جدید</h3>
                </div>
                <div class="row">
                    <div class="new-product-curosel">
                        <!-- single-product start -->
                        {foreach from=$Latest item=val}
                            <div class="col-lg-3 col-md-3">
                                <div class="single-product first-sells">
                                    <div class="product-img">
                                        <a href="{site_url()|con:'shop/':$val->slug}">
                                            {if isset($val->pic) AND $val.pic != ''}
                                                <img class="primary-image" src="{site_url|con:'upload/ads/pic/':$val.pic}" alt="{$val.title}" />
                                            {else}
                                                <img class="primary-image" src="{assets_url}img/ads4.jpg"
                                                     alt="{$val.title}"/>
                                            {/if} 
                                        </a>						
                                    </div>
                                    <div class="product-content">
                                        <div class="pro-info">
                                            <h2 class="product-name">  <a href="{site_url()|con:'shop/':$val->slug}">{$val->title}</a></h2>
                                            <div class="pro-rating">
                                                <a href="#"><i class="fa fa-star"></i></a>
                                                <a href="#"><i class="fa fa-star"></i></a>
                                                <a href="#"><i class="fa fa-star"></i></a>
                                                <a href="#"><i class="fa fa-star"></i></a>
                                                <a href="#"><i class="fa fa-star"></i></a>
                                            </div>
                                            <div class="price-box">
                                                <span class="new-price">{$val->price|price_format}</span>
                                                {* <span class="old-price">£120.00</span>*}
                                            </div>								
                                        </div>
                                        <div class="actions">
                                            <div class="action-buttons">
                                                <div class="add-to-cart">
                                                    <a href="{site_url()|con:'shop/':$val->slug}">نمایش کالا</a>
                                                </div>
                                            </div>
                                        </div>									
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                        <!-- single-product end -->	
                    </div>
                </div>				
            </div>
            <div class="col-lg-6 col-md-6 col-sm-6">
                <div class="section-heading-3">
                    <h3>آخرین مطالب وبلاگ</h3>
                </div>	
                <div class="row">
                    <div class="blog-curosel-home-3">
                        <!-- single-latest-blog start -->

                        {content_block
                content_type="وبلاگ"
                start=""
                limit="8"
                sort="id"
                text_limit="200"
                        }
                        <div class="col-lg-3 col-md-3">
                            <div class="single-latest-blog">
                                <div class="post-thumb">
                                    <a href="<($item.link)>">
                                        <img src="{site_url()|con:'upload/content/entry/'}<($item.image)>" alt=" <($item.title)>" />
                                        <span class="moretag"></span>
                                    </a>
                                </div>
                                <div class="latest-blog-info">
                                    <h3><a href="<($item.link)>"> <($item.title)></a></h3>
                                    <div class="post-excerpt">
                                        <($item.short_story)>
                                    </div>								
                                </div>
                            </div>
                        </div>
                        {/content_block}
                        <!-- single-latest-blog end -->
                    </div>
                </div>					
            </div>
        </div>
    </div>
</div>
<!-- new-product-area end -->