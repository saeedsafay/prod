<!-- MAIN -->
<main class="site-main site-subcategoies js-get-pages-id------" id="js-categories">
    <div class="container">
        <ol class="breadcrumb-page">
            <li><a href="/">صفحه اصلی </a></li>
            <li><a href="/product-types/{$category->product_type->slug}">{$category->product_type->title} </a></li>
            <li class="active">{$category->title}</li>
        </ol>
    </div>
    <div class="container">
        <div class="text-center mb-40 mt-40">
            <h2 class="headline-3 font-weight-medium">زیردسته های <span>{$category->title}</span></h2>
        </div>
        <div class="row row-10">
            {foreach $category->children as $subCategory}
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="upload-sizing-wrapp category-grid-wrapp">
                        <div class="image">
                            <a href="{site_url()}{$subCategory->link}">
                                <img src="{$products_pic_dir}{$subCategory->image}"
                                     alt="{$category->product_type->title} {$category->title} {$subCategory->tilte}">
                            </a>
                        </div>
                        <h4 class="title">
                            <a href="{site_url()}{$subCategory->slug}">
                                {$subCategory->title}
                            </a>
                        </h4>
                        {*                        <ul class="sizing-list">*}
                        {*                            <li>سایز ارجینال کارت ویزیت</li>*}
                        {*                            <li>همانند کارت عابر بانک</li>*}
                        {*                            <li>همانند کارت عابر بانک</li>*}
                        {*                        </ul>*}
                    </div>
                </div>
            {/foreach}

        </div>
    </div>
    <div class="background-subcategories-design mt-40 mb-40"
            {if isset($category->banner)}
        style="background-image: url('/upload/categories/{$category.banner}')"
            {/if}>
        <div class="container">
            {if isset($category->desc)}
                <div class="content">
                    <h3 class="headline-3 font-size-10">{$category.banner_title}</h3>
                    <p class="category-description font-size-6 font-weight-ultralight line-height-4 mb-15">
                        {$category.desc}
                    </p>
                    <a href="{$category.desc_uri}" class="font-size-6 font-weight-medium text-primary" title="">
                        اطلاعات بیشتر
                    </a>
                </div>
            {/if}
        </div>
    </div>
    {*    <div class="block-the-blog">*}
    {*        <div class="container">*}
    {*            <div class="title-of-section">آخرین مطالب بلاگ</div>*}
    {*            {literal}*}
    {*            <div class="owl-carousel nav-style2" data-nav="true" data-autoplay="false" data-dots="false"*}
    {*                 data-loop="true" data-margin="30"*}
    {*                 data-responsive='{"0":{"items":1},"480":{"items":2},"600":{"items":2},"992":{"items":3}}'>{/literal}*}
    {*                <div class="blog-item">*}
    {*                    <div class="post-thumb">*}
    {*                        <a href=""><img src="{assets_url}images/home3/blog1.jpg" alt="blog1"></a>*}
    {*                        <span class="date">2017<span>Jan 06</span></span>*}
    {*                    </div>*}
    {*                    <div class="post-item-info">*}
    {*                        <h3 class="post-name"><a href="">It’s all about the bread: whole grain home</a></h3>*}
    {*                        <div class="post-metas">*}
    {*                            <span class="author">توسط: <a href="#">مدیریت</a></span>*}
    {*                            <span class="comment"><i class="fa fa-comment" aria-hidden="true"></i>36 نظر</span>*}
    {*                        </div>*}
    {*                    </div>*}
    {*                </div>*}
    {*                <div class="blog-item">*}
    {*                    <div class="post-thumb">*}
    {*                        <a href=""><img src="{assets_url}images/home3/blog2.jpg" alt="blog2"></a>*}
    {*                        <span class="date">2017<span>Jan 06</span></span>*}
    {*                    </div>*}
    {*                    <div class="post-item-info">*}
    {*                        <h3 class="post-name"><a href="">It’s all about the bread: whole grain home</a></h3>*}
    {*                        <div class="post-metas">*}
    {*                            <span class="author">توسط: <a href="#">مدیریت</a></span>*}
    {*                            <span class="comment"><i class="fa fa-comment" aria-hidden="true"></i>36 نظر</span>*}
    {*                        </div>*}
    {*                    </div>*}
    {*                </div>*}
    {*                <div class="blog-item">*}
    {*                    <div class="post-thumb">*}
    {*                        <a href=""><img src="{assets_url}images/home3/blog3.jpg" alt="blog3"></a>*}
    {*                        <span class="date">2017<span>Jan 06</span></span>*}
    {*                    </div>*}
    {*                    <div class="post-item-info">*}
    {*                        <h3 class="post-name"><a href="">It’s all about the bread: whole grain home</a></h3>*}
    {*                        <div class="post-metas">*}
    {*                            <span class="author">توسط: <a href="#">مدیریت</a></span>*}
    {*                            <span class="comment"><i class="fa fa-comment" aria-hidden="true"></i>36 نظر</span>*}
    {*                        </div>*}
    {*                    </div>*}
    {*                </div>*}
    {*            </div>*}
    {*        </div>*}
    {*    </div>*}
    <div class="block-top-categori">
        <div class="container">
            <div class="row row-10">
                <h1 class="headline-3 text-center mb-20 mt-30">دیگر دسته بندی های {$category.product_type.title}</h1>
                {foreach $related as $relatedCategory}
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-20">
                        <div class="block-top-categori-item">
                            <a href="/subcategories/{$relatedCategory->slug}">
                                <img src="/upload/products/pic/{$relatedCategory->image}" alt="h3">
                            </a>
                            <div class="block-top-categori-title">{$relatedCategory->title}</div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>
</main><!-- end MAIN -->
