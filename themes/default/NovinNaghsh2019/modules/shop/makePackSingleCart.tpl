
<section class=" new-arrivals pb-40">
    <div class="container space_bottom">
        <ol class="breadcrumb">
            <li>
                <a href="{site_url}">خانه</a>
            </li>
            <li>
                <a href="{site_url}shop/products/single-products">محصولات شاخه‌ای</a>
            </li>
            <li class="active">
                انتخاب تزئین
            </li>
        </ol> <!-- end breadcrumbs -->
    </div>
    <div class="container-fluid">
        <!--<div class="row heading-row">
          <div class="col-md-12 text-center">
            <h2 class="heading uppercase"><small>محصول </small></h2>
          </div>
        </div>-->

        <div class="row row-10"> 
            <div class="col-lg-10 col-md-10">
                <p>
                    برای ساخت محصول خود، یک تزئین برای شاخه گل‌های انتخابی خود انتخاب نمایید.
                </p>
                <form action="{site_url}shop/products/makeSingleCartAction" method="POST">
                    <div class="col-md-3 col-lg-3 col-xs-6 pull-right">
                        <div class="product-item">
                            <div class="product-img">
                                <a href="#" onclick="$(this).checkRadio(event, 0)" >
                                    <img alt="تزئین به سلیقه فروشنده" src="{assets_url}img/decorate.png">
                                </a>
                                <div class="product-label">
                                    <span class="sale">رایگان</span>
                                </div>
                            </div>
                            <div class="product-details">
                                <h3>
                                    <a class="product-title" href="#">تزئین به سلیقه فروشنده</a>
                                </h3>
                                <p>انتخاب رنگ ربان</p>
                                <select onchange="$(this).checkRadio(event, 0)" name="ribbons_color_id" id="ribbon" class="select_rm ">
                                    <option value="0" selected="">به سلیقه فروشنده</option>
                                </select>
								
								<p class="display_flex">
                                <input type="radio" class="input-radio" name="decoration_id" id="decoration0" value="0">
                                <label for="decoration0">تزئین دسته گل</label>
								</p>

                            </div>                          
                        </div>
                    </div>
                    {foreach $decorations as $item}
                        <div class="col-md-3 col-lg-3 col-xs-6 pull-right">
                            <div class="product-item">
                                <div class="product-img">
                                    <a href="#" onclick="$(this).checkRadio(event,{$item.id})">
                                        <img alt="{$item.title}" src="{$products_thumbnail_dir}{$item.pic}">
                                    </a>
                                    {if !$item.has_deco_cost}
                                        <div class="product-label">
                                            <span class="sale">رایگان</span>
                                        </div>
                                    {/if}
                                </div>
                                <div class="product-details">
                                    <h3>
                                        <a class="product-title" href="#">{$item.title}</a>
                                    </h3>
                                    {if $item->ribbons->count() > 0}
                                        <p>انتخاب رنگ ربان</p>
                                        <select onchange="$(this).checkRadio(event,{$item.id})" name="ribbons_color_id" id="ribbon" class="select_rm ">
                                            <option value="" selected="" disabled="">انتخاب رنگ ربان</option>
                                            {foreach $item->ribbons as $ribbon}
                                                <option value="{$ribbon.id}">{$ribbon.title}</option>
                                            {/foreach}
                                        </select>
                                    {/if}
                                    <input type="radio" class="input-radio" name="decoration_id" id="decoration{$item.id}" value="{$item.id}">
                                    <label for="decoration{$item.id}">{$item.flower_count|persian_number} شاخه</label>

                                    {if $item.has_deco_cost}
                                        <span class="price">
                                            <ins>
                                                <span class="ammount">{$item.price|price_format}</span>
                                            </ins>
                                        </span>
                                    {/if}
                                </div>                          
                            </div>
                        </div>
                    {/foreach}
                    <div class="row">
                        <div class="col-md-12">
                            <button type="submit" class="btn btn-md btn-light"><span>تایید و مرحله بعد</span></button>
                        </div>
                    </div>
                </form>
            </div> <!-- end col -->
            <form action="" method="GET" class="filter-form">
                <div class="col-lg-2 col-md-2">
                    <div class="filter-wrapper">
                        <label>دسته بندی</label>
                        <ul class="scroll_check">  
                            {foreach $cats as $cat}
                                <li> 
                                    <input name='cat_id' value="{$cat.id}" type="radio" class="input-radio filter-options" id="cat{$cat.id}" >                  
                                    <label for="cat{$cat.id}" {if $cat_id eq $cat.id}checked=''{/if}>{$cat.title}</label>   
                                </li>	
                            {/foreach}  
                        </ul>

                    </div> 
                    <div class="space_both_map">
                        <hr/>
                    </div>
                </div> <!-- end row -->
            </form>
        </div>
    </div>
</section> <!-- end new arrivals -->
<section class="section-wrap partners pt-0 pb-50">
    <div class="container">
        <div class="row">

            <div id="owl-partners" class="owl-carousel owl-theme">

                <div class="item">
                    <a href="#">
                        <img src="{assets_url}img/partners/partner_logo_dark_1.png" alt="">
                    </a>
                </div>
                <div class="item">
                    <a href="#">
                        <img src="{assets_url}img/partners/partner_logo_dark_2.png" alt="">
                    </a>
                </div>
                <div class="item">
                    <a href="#">
                        <img src="{assets_url}img/partners/partner_logo_dark_3.png" alt="">
                    </a>
                </div>
                <div class="item">
                    <a href="#">
                        <img src="{assets_url}img/partners/partner_logo_dark_4.png" alt="">
                    </a>
                </div>
                <div class="item">
                    <a href="#">
                        <img src="{assets_url}img/partners/partner_logo_dark_5.png" alt="">
                    </a>
                </div>
                <div class="item">
                    <a href="#">
                        <img src="img/partners/partner_logo_dark_6.png" alt="">
                    </a>
                </div>
                <div class="item">
                    <a href="#">
                        <img src="{assets_url}img/partners/partner_logo_dark_1.png" alt="">
                    </a>
                </div>
                <div class="item">
                    <a href="#">
                        <img src="{assets_url}img/partners/partner_logo_dark_2.png" alt="">
                    </a>
                </div>

            </div> <!-- end carousel -->

        </div>
    </div>
</section> <!-- end partners -->      
