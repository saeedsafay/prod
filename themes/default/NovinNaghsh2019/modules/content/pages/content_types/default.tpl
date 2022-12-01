<main class="site-main blog-grid">
    <div class="container">
        <ol class="breadcrumb-page">
            <li><a href="{site_url}" title="صفحه نخست نوین نقش">صفحه نخست </a></li>
            <li class="active">وبلاگ</li>
        </ol>
    </div>
    <div class="container">
        <h1 class="blog-head headline-1 text-center">{$contentType.name}</h1>
        <div class="row">
            <div class="col-md-9 col-sm-8 float-none pull-left">
                <div class="main-content">
                    <div class="post-grid post-items">
                        {foreach from=$contentType.entries item=post}
                        <div class="post-grid-item col-md-6">
                            <div class="post-item">
                                <div class="post-thumb">
                                    <a href="{site_url|con:$contentType.slug:'/':$post.slug}"><img src="{site_url|con:'upload/content/entry/': $post.image}" alt="{$post.title}"></a>
                                    <span class="date">{jdate date=$post.created_at format="j"}<span>{jdate date=$post.created_at format="F"}</span></span>
                                </div>
                                <div class="post-item-info">
                                    <h3 class="post-name"><a href="{site_url|con:$contentType.slug:'/':$post.slug}">{$post.title}</a></h3>
                                    <div class="post-metas">
                                        <span class="author">توسط: <span>مدیریت</span></span>
                                        <span class="news">چاپ اجسام</span>
                                        <span class="comment"><i class="fa fa-comment" aria-hidden="true"></i>6 نظر</span>
                                    </div>
                                    <div class="post-content">
                                        <p>{$post.short_story}</p>
                                        <a href="{site_url|con:$contentType.slug:'/':$post.slug}" class="read-more">اطلاعات بیشتر</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        {/foreach}
                    </div>
                    <div class="post-grid pagination">
                        <ul class="nav-links">
                            <li class="active"><a href="">1</a></li>
                            <li><a href="">2</a></li>
                            <li><a href="">3</a></li>
                            <li class="back-next"><a href="">بعدی</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-4">
                <div class="sidebar-left">
                    <div class="block-search-blog">
                        <form class="searchform">
                            <div class="control">
                                <input type="text" placeholder="جستجو ...." name="text" class="input-subscribe">
                                <button type="submit" class="btn-searchform"><i class="fa fa-search" aria-hidden="true"></i></button>
                            </div>
                        </form>
                    </div>
                    <div class="block-categories-blog">
                        <div class="block-title">آرشیو وبلاگ</div>
                        <ul>
                            {foreach from=$contentType.entries item=blog}
                                <li class="categories-item"><a href="{site_url()|con:'وبلاگ/':$blog.slug}" title="{$blog.title}">{$blog.title}</a></li>
                            {/foreach}
                        </ul>
                    </div>
                    <div class="block-categories-blog">
                        <div class="block-title">دسته بندی های بلاگ</div>
                        <ul>
                            <li class="categories-item"><a href="">چاپ اجسام</a></li>
                            <li class="categories-item"><a href="">چاپ اجسام</a></li>
                            <li class="categories-item"><a href="">چاپ اجسام</a></li>
                            <li class="categories-item"><a href="">چاپ اجسام</a></li>
                            <li class="categories-item"><a href="">چاپ اجسام</a></li>
                        </ul>
                    </div>
                    <div class="block-latest-roducts">
                        <div class="block-title">اخرین محصولات</div>
                        <div class="block-latest-roducts-content">
                            {literal}<div class="owl-carousel nav-style2" data-nav="true" data-autoplay="false" data-dots="false" data-loop="true" data-margin="0" data-responsive='{"0":{"items":1},"600":{"items":1},"1000":{"items":1}}'>{/literal}
                                <div class="owl-ones-row">
                                    <div class="product-item style1">
                                        <div class="product-inner">
                                            <div class="product-thumb">
                                                <div class="thumb-inner">
                                                    <a href=""><img src="images/blog/p1.jpg" alt="p1"></a>
                                                </div>
                                            </div>
                                            <div class="product-innfo">
                                                <div class="product-name"><a href="">Leather Chelsea Boots</a></div>
                                                <span class="price">
                                                            <ins>$229.00</ins>
                                                            <del>$259.00</del>
                                                        </span>
                                                <span class="star-rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <span class="review">5 Review(s)</span>
                                                        </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-item style1">
                                        <div class="product-inner">
                                            <div class="product-thumb">
                                                <div class="thumb-inner">
                                                    <a href=""><img src="images/blog/p2.jpg" alt="p2"></a>
                                                </div>
                                            </div>
                                            <div class="product-innfo">
                                                <div class="product-name"><a href="">2750 Cotu Classic Sneakers</a></div>
                                                <span class="price">
                                                            <ins>$229.00</ins>
                                                            <del>$259.00</del>
                                                        </span>
                                                <span class="star-rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <span class="review">5 Review(s)</span>
                                                        </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-item style1">
                                        <div class="product-inner">
                                            <div class="product-thumb">
                                                <div class="thumb-inner">
                                                    <a href=""><img src="images/blog/p3.jpg" alt="p3"></a>
                                                </div>
                                            </div>
                                            <div class="product-innfo">
                                                <div class="product-name"><a href="">Thule Chasm Sport Duffel Bag</a></div>
                                                <span class="price price-dark">
                                                                <ins>$229.00</ins>
                                                            </span>
                                                <span class="star-rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <span class="review">5 Review(s)</span>
                                                        </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-item style1">
                                        <div class="product-inner">
                                            <div class="product-thumb">
                                                <div class="thumb-inner">
                                                    <a href=""><img src="images/blog/p4.jpg" alt="p4"></a>
                                                </div>
                                            </div>
                                            <div class="product-innfo">
                                                <div class="product-name"><a href="">Pullover Hoodie - Mens</a></div>
                                                <span class="price">
                                                            <ins>$229.00</ins>
                                                            <del>$259.00</del>
                                                        </span>
                                                <span class="star-rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <span class="review">5 Review(s)</span>
                                                        </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="owl-ones-row">
                                    <div class="product-item style1">
                                        <div class="product-inner">
                                            <div class="product-thumb">
                                                <div class="thumb-inner">
                                                    <a href=""><img src="images/blog/p1.jpg" alt="p1"></a>
                                                </div>
                                            </div>
                                            <div class="product-innfo">
                                                <div class="product-name"><a href="">Leather Chelsea Boots</a></div>
                                                <span class="price">
                                                            <ins>$229.00</ins>
                                                            <del>$259.00</del>
                                                        </span>
                                                <span class="star-rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <span class="review">5 Review(s)</span>
                                                        </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-item style1">
                                        <div class="product-inner">
                                            <div class="product-thumb">
                                                <div class="thumb-inner">
                                                    <a href=""><img src="images/blog/p2.jpg" alt="p2"></a>
                                                </div>
                                            </div>
                                            <div class="product-innfo">
                                                <div class="product-name"><a href="">2750 Cotu Classic Sneakers</a></div>
                                                <span class="price">
                                                            <ins>$229.00</ins>
                                                            <del>$259.00</del>
                                                        </span>
                                                <span class="star-rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <span class="review">5 Review(s)</span>
                                                        </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-item style1">
                                        <div class="product-inner">
                                            <div class="product-thumb">
                                                <div class="thumb-inner">
                                                    <a href=""><img src="images/blog/p3.jpg" alt="p3"></a>
                                                </div>
                                            </div>
                                            <div class="product-innfo">
                                                <div class="product-name"><a href="">Thule Chasm Sport Duffel Bag</a></div>
                                                <span class="price price-dark">
                                                                <ins>$229.00</ins>
                                                            </span>
                                                <span class="star-rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <span class="review">5 Review(s)</span>
                                                        </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-item style1">
                                        <div class="product-inner">
                                            <div class="product-thumb">
                                                <div class="thumb-inner">
                                                    <a href=""><img src="images/blog/p4.jpg" alt="p4"></a>
                                                </div>
                                            </div>
                                            <div class="product-innfo">
                                                <div class="product-name"><a href="">Pullover Hoodie - Mens</a></div>
                                                <span class="price">
                                                            <ins>$229.00</ins>
                                                            <del>$259.00</del>
                                                        </span>
                                                <span class="star-rating">
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <i class="fa fa-star" aria-hidden="true"></i>
                                                            <span class="review">5 Review(s)</span>
                                                        </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main><!-- end MAIN -->
