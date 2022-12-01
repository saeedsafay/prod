<style>
    .col-lg-4 {
        width: 30.333333%!important;
    }
</style>
<div class="page-top style2 blackish opc7">
    <div class="fixed-bg2" style="background:url({assets_url}images/page-top.jpg);"></div>
    <div class="container">
        <div class="page-title">
            <div class="pg-tl">
                <span>فروشگاه گل </span>
                <h1 itemprop="headline">صفحه سبد گل ها</h1>
            </div>

        </div>
        <ul class="bredcrumbs">
            <li><a href="#" title="" itemprop="url">خانه</a></li>
            <li><a href="#" title="" itemprop="url">گل ها</a></li>
            <li>رٌز</li>
        </ul>
    </div>
</div><!-- Page Top -->

<section>
    <div class="block remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-lg-2">
                            <div class="sidebar">
                                <style>
                                    .list-group.panel > .list-group-item {
                                        border-bottom-right-radius: 0px !important;
                                        border-bottom-left-radius: 0px !important;
                                        font-family: xantoxa;
                                        text-align: right;
                                        font-size: 12px;
                                        border-radius: 0px!important;
                                        direction: rtl;
                                        background: #f7f7f7;
                                        border-color: #efefef;
                                    }
                                    .list-group-submenu {
                                        margin-left:20px;
                                        font-family:xantoxa;
                                        text-align:right;
                                        direction:rtl;
                                    }
                                </style>
                                <div id="MainMenu" style="font-family: xantoxa;text-align: right;">
                                    <div class="list-group panel">
                                        <a href="#demo1" class="list-group-item list-group-item-success" data-toggle="collapse" data-parent="#MainMenu">استان
                                            <span class="arrow_bottom"><i class="fa fa-caret-down" aria-hidden="true"></i></span>
                                        </a>
                                        <div class="collapse" id="demo1">
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                        </div>

                                    </div>
                                </div>
                                <div id="MainMenu" style="font-family: xantoxa;text-align: right;">
                                    <div class="list-group panel">
                                        <a href="#demo2" class="list-group-item list-group-item-success" data-toggle="collapse" data-parent="#MainMenu">شهر 
                                            <span class="arrow_bottom"><i class="fa fa-caret-down" aria-hidden="true"></i></span>
                                        </a>
                                        <div class="collapse" id="demo2">
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                        </div>

                                    </div>
                                </div>
                                <div id="MainMenu" style="font-family: xantoxa;text-align: right;">
                                    <div class="list-group panel">
                                        <a href="#demo3" class="list-group-item list-group-item-success" data-toggle="collapse" data-parent="#MainMenu">منطقه 
                                            <span class="arrow_bottom"><i class="fa fa-caret-down" aria-hidden="true"></i></span>
                                        </a>
                                        <div class="collapse" id="demo3">
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                        </div>

                                    </div>
                                </div>
                                <div id="MainMenu" style="font-family: xantoxa;text-align: right;">
                                    <div class="list-group panel">
                                        <a href="#demo4" class="list-group-item list-group-item-success" data-toggle="collapse" data-parent="#MainMenu">محله 
                                            <span class="arrow_bottom"><i class="fa fa-caret-down" aria-hidden="true"></i></span>
                                        </a>
                                        <div class="collapse" id="demo4">
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                        </div>

                                    </div>
                                </div>
                            </div><!-- Sidebar -->
                        </div>
                        <div class="col-md-12 col-sm-12 col-lg-8">
                            {if !$Products}
                                <!-- Start Gried View -->
                                <div role="tabpanel" id="grid-view" class="single-grid-view tab-pane fade in active clearfix">
                                    <!-- Start Single product -->
                                    <div class="pro-item col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                        <label class="text-warning pull-right rtl">موردی یافت نشد</label>
                                    </div>
                                </div>
                            {else}
                                {foreach from=$Products item=val}
                                    <div class="col-md-4 col-sm-6 col-lg-4 shadow_product">
                                        <div class="product-box">
                                            <ul class="list_icon">

                                                <li><a href="#"><i class="fa fa-shopping-basket" aria-hidden="true"></i>	</a></li>
                                                <li><a href="#modal"><i class="fa fa-share-alt" aria-hidden="true"></i>	</a></li>
                                                <li><a href="#"><i class="fa fa-star-half-empty" aria-hidden="true"></i>	</a></li>
                                            </ul>
                                            <img src="{site_url()|con:'upload/ads/pic/':$val.pic}" alt="" itemprop="image" />
                                            <div class="product-inf">
                                                <h2 itemprop="headline">
                                                    <a href="{site_url()|con:'product/':$val->slug}" title="{$val.title}" itemprop="url">
                                                        {$val.title}
                                                    </a>
                                                </h2>
                                                <a class="prd-cate" href="#" title="" itemprop="url">وضعیت - ارسال</a>
                                                <span class="price">قیمت : {$val.price|price_format}</span>
                                            </div>
                                        </div>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                        <div class="col-md-12 col-sm-12 col-lg-2">
                            <div class="sidebar">

                                <div id="MainMenu" style="font-family: xantoxa;text-align: right;">
                                    <div class="list-group panel">
                                        <a href="#demo1-1" class="list-group-item list-group-item-success" data-toggle="collapse" data-parent="#MainMenu">دسته بندی 
                                            <span class="arrow_bottom"><i class="fa fa-caret-down" aria-hidden="true"></i></span>
                                        </a>
                                        <div class="collapse" id="demo1-1">
                                            {foreach $category as $cat}
                                                <a href="{site_url}cats/{$cat.slug}" class="list-group-item">{$cat.title}</a>
                                            {/foreach}
                                        </div>

                                    </div>
                                </div>
                                <div id="MainMenu" style="font-family: xantoxa;text-align: right;">
                                    <div class="list-group panel">
                                        <a href="#demo2-2" class="list-group-item list-group-item-success" data-toggle="collapse" data-parent="#MainMenu">مناسبت 

                                            <span class="arrow_bottom"><i class="fa fa-caret-down" aria-hidden="true"></i></span></a>
                                        <div class="collapse" id="demo2-2">
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                        </div>

                                    </div>
                                </div>
                                <div id="MainMenu" style="font-family: xantoxa;text-align: right;">
                                    <div class="list-group panel">
                                        <a href="#demo3-3" class="list-group-item list-group-item-success" data-toggle="collapse" data-parent="#MainMenu">نوع گل 
                                            <span class="arrow_bottom"><i class="fa fa-caret-down" aria-hidden="true"></i></span>
                                        </a>
                                        <div class="collapse" id="demo3-3">
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                        </div>

                                    </div>
                                </div>
                                <div id="MainMenu" style="font-family: xantoxa;text-align: right;">
                                    <div class="list-group panel">
                                        <a href="#demo4-4" class="list-group-item list-group-item-success" data-toggle="collapse" data-parent="#MainMenu">محله 
                                            <span class="arrow_bottom"><i class="fa fa-caret-down" aria-hidden="true"></i></span>
                                        </a>
                                        <div class="collapse" id="demo4-4">
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                            <a href="" class="list-group-item">تست</a>
                                        </div>

                                    </div>
                                </div>
                            </div><!-- Sidebar -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

