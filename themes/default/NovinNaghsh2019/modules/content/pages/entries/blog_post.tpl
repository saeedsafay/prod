<!-- MAIN -->
<main class="site-main blog-single">
    <div class="container">
        <ol class="breadcrumb-page">
            <li><a href="{site_url}" title="صفحه نخست نوین نقش">صفحه نخست </a></li>
            <li><a href="#" title="وبلاگ نوین نقش">
                    {$entry.contentType.name}
                </a></li>
            <li class="active" title="{$entry.title}">{$entry.title}</li>
        </ol>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-9 col-sm-8 float-none pull-left">
                <div class="main-content">
                    <div class="post-detail">
                        <div class="post-item">
                            <div class="post-thumb">
                                <img src="{site_url|con:'upload/content/entry/': $entry.image}" alt="{$entry.title}">
                                <span class="date">{jdate date=$entry.created_at format="j"}<span>{jdate date=$entry.created_at format="F"}</span></span>
                            </div>
                            <div class="post-item-info">
                                <h1 class="post-name"><a href="">{$entry.title}</a></h1>
                                <div class="post-metas">
                                    <span class="author">توسط: <span>مدیریت</span></span>
                                    <span class="time">{jdate date=$entry.created_at format="j F Y"}</span>
                                    {*                                    <span class="leave-coment">نظرت بگو</span>*}
                                    {*                            <span><i class="fa fa-comments-o"></i> <a href="#comment_section">{$entry->comments()->where('status',1)->get()->count()} نظر</a></span>*}
                                </div>
                                <div class="post-content">
                                    <p>
                                        {$entry.full_story}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="post-footer">
                            <div class="tag">
                                <span>تگ ها:</span>
                                {foreach from=explode(',',$entry.keyword) item=val}
                                    <a href="#">{$val},</a>
                                {/foreach}
                            </div>
                            {*                            <div class="post-authur">*}
                            {*                                <div class="avata"><a href=""><img src="images/blog/avata-admin.jpg" alt="avata-admin"></a>*}
                            {*                                </div>*}
                            {*                                <div class="des">*}
                            {*                                    <strong>مدیریت</strong>*}
                            {*                                    <p>این یک متن تستی می باشد و دیگر هیچ اکی !!!! این یک متن تستی می باشد و دیگر هیچ*}
                            {*                                        اکی !!!! این یک متن تستی می باشد و دیگر هیچ اکی !!!! این یک متن تستی می باشد و*}
                            {*                                        دیگر هیچ اکی !!!! این یک متن تستی می باشد و دیگر هیچ اکی !!!! این یک متن تستی می*}
                            {*                                        باشد و دیگر هیچ اکی !!!! این یک متن تستی می باشد و دیگر هیچ اکی !!!! </p>*}
                            {*                                </div>*}
                            {*                            </div>*}
                        </div>
                    </div>
                    {*                    <div class="post-comments">*}
                    {*                        <div class="block-title">یه چیزی بگو</div>*}
                    {*                        <p>ایمیل شما عمومی نخواهد شد و فیلد های واجب با این علامت * مشخص شده اند.</p>*}
                    {*                        <div class="block-content">*}
                    {*                            <form method="POST" action="">*}
                    {*                                <div class="form-group col-md-6 padding-right">*}
                    {*                                    <label class="title">نام *</label>*}
                    {*                                    <input type="text" class="form-control" id="forName">*}
                    {*                                </div>*}
                    {*                                <div class="form-group col-md-6 padding-left">*}
                    {*                                    <label class="title">ایمیل *</label>*}
                    {*                                    <input type="email" class="form-control" id="forEmail">*}
                    {*                                </div>*}
                    {*                                <div class="form-group">*}
                    {*                                    <label class="title">نظر</label>*}
                    {*                                    <textarea class="form-control" id="forContent" rows="9"></textarea>*}
                    {*                                </div>*}
                    {*                                <button type="submit" class="btn-comment">ثبت نظر</button>*}
                    {*                            </form>*}

                    {*                            *}{*                <div class="single-post-comments">*}
                    {*                            *}{*                    <div class="comments-area" id="comment_section">*}
                    {*                            *}{*                        <div class="comments-heading">*}
                    {*                            *}{*                            <h3>نظرات ({$entry->comments()->where('status',1)->get()->count()})</h3>*}
                    {*                            *}{*                        </div>*}
                    {*                            *}{*                        <div class="comments-list">*}
                    {*                            *}{*                            <ul>comment*}
                    {*                            *}{*                                {if $entry->s->isEmpty()}*}
                    {*                            *}{*                                    <label class="text-muted">تاکنون نظری برای این مطلب درج نشده است</label>*}
                    {*                            *}{*                                {else}*}
                    {*                            *}{*                                    {foreach from=$entry->comments()->where('status',1)->get() item=cm}*}
                    {*                            *}{*                                        <li>*}
                    {*                            *}{*                                            <div class="comments-details">*}
                    {*                            *}{*                                                <div class="comments-list-img">*}
                    {*                            *}{*                                                    <img src="img/blog/comments/1.png" alt="" />*}
                    {*                            *}{*                                                </div>*}
                    {*                            *}{*                                                <div class="comments-content-wrap">*}
                    {*                            *}{*                                                    <span>*}
                    {*                            *}{*                                                        <b><a href="#">{$cm.user.first_name} {$cm.user.last_name}</a></b>*}
                    {*                            *}{*                                                        نویسنده*}
                    {*                            *}{*                                                        <span class="post-time"> {jdate date=$cm.created_at format="j F Y H:i:s"}</span>*}
                    {*                            *}{*                                                    </span>*}
                    {*                            *}{*                                                    <p>{$cm.comment}</p>*}
                    {*                            *}{*                                                </div>*}
                    {*                            *}{*                                            </div>*}
                    {*                            *}{*                                        </li>*}
                    {*                            *}{*                                    {/foreach}*}
                    {*                            *}{*                                {/if}*}
                    {*                            *}{*                            </ul>*}
                    {*                            *}{*                        </div>*}
                    {*                            *}{*                    </div>*}
                    {*                            *}{*                    <div class="comment-respond">*}
                    {*                            *}{*                        <h3 class="comment-reply-title">ارسال نظر </h3>*}
                    {*                            *}{*                        {if $is_logged_in}*}
                    {*                            *}{*                            <form action="{site_url()|con:'content/content/submitComment'}" method="POST">*}
                    {*                            *}{*                                <div class="row">*}
                    {*                            *}{*                                    <div class="col-md-12 comment-form-comment">*}
                    {*                            *}{*                                        <p>نظر</p>*}
                    {*                            *}{*                                        <textarea id="message" name="comment" cols="30" rows="10"></textarea>*}
                    {*                            *}{*                                        <input name="entry" value="{$entry.id}" type="hidden"/>*}
                    {*                            *}{*                                        <input type="submit" value="ارسال نظر" />*}
                    {*                            *}{*                                    </div>*}
                    {*                            *}{*                                </div>*}
                    {*                            *}{*                            </form>*}
                    {*                            *}{*                        {else}*}
                    {*                            *}{*                            <label class="text-danger">برای ارسال نظرابتدا <a href="{site_url|con:'users/login'}">ثبت نام</a> کنید و یا <a href="{site_url|con:'users/login'}">لاگین</a>  کنید.</label>*}
                    {*                            *}{*                        {/if}*}
                    {*                            *}{*                    </div>						*}
                    {*                            *}{*                </div>*}


                    {*                        </div>*}
                    {*                    </div>*}
                </div>
            </div>
            <div class="col-md-3 col-sm-4">
                <div class="sidebar-left">
                    {*                    <div class="block-search-blog">*}
                    {*                        <form class="searchform">*}
                    {*                            <div class="control">*}
                    {*                                <input type="text" placeholder="جستجو ...." name="text" class="input-subscribe">*}
                    {*                                <button type="submit" class="btn-searchform"><i class="fa fa-search"*}
                    {*                                                                                aria-hidden="true"></i></button>*}
                    {*                            </div>*}
                    {*                        </form>*}
                    {*                    </div>*}
                    <div class="block-categories-blog">
                        <div class="block-title">آرشیو بلاگ</div>
                        <ul>
                            {foreach from=$content_type->entries item=blog}
                                <li class="categories-item">
                                    <a href="{site_url()|con:$entry.contentType.slug:'/':$blog.slug}"
                                       title="{$blog.title}">{$blog.title}
                                    </a></li>
                            {/foreach}
                        </ul>
                    </div>
                    {*                    <div class="block-categories-blog">*}
                    {*                        <div class="block-title">دسته بندی های بلاگ</div>*}
                    {*                        <ul>*}
                    {*                            <li class="categories-item"><a href="">چاپ اجسام</a></li>*}
                    {*                            <li class="categories-item"><a href="">چاپ اجسام</a></li>*}
                    {*                            <li class="categories-item"><a href="">چاپ اجسام</a></li>*}
                    {*                            <li class="categories-item"><a href="">چاپ اجسام</a></li>*}
                    {*                            <li class="categories-item"><a href="">چاپ اجسام</a></li>*}
                    {*                        </ul>*}
                    {*                    </div>*}
                    {*                    <div class="block-latest-roducts">*}
                    {*                        <div class="block-title">اخرین محصولات</div>*}
                    {*                        <div class="block-latest-roducts-content">*}
                    {*                            {literal}*}
                    {*                            <div class="owl-carousel nav-style2" data-nav="true" data-autoplay="false" data-dots="false"*}
                    {*                                 data-loop="true" data-margin="0"*}
                    {*                                 data-responsive='{"0":{"items":1},"600":{"items":1},"1000":{"items":1}}'>{/literal}*}
                    {*                                <div class="owl-ones-row">*}
                    {*                                    <div class="product-item style1">*}
                    {*                                        <div class="product-inner">*}
                    {*                                            <div class="product-thumb">*}
                    {*                                                <div class="thumb-inner">*}
                    {*                                                    <a href=""><img src="images/blog/p1.jpg" alt="p1"></a>*}
                    {*                                                </div>*}
                    {*                                            </div>*}
                    {*                                            <div class="product-innfo">*}
                    {*                                                <div class="product-name"><a href="">Leather Chelsea Boots</a></div>*}
                    {*                                                <span class="price">*}
                    {*                                                            <ins>$229.00</ins>*}
                    {*                                                            <del>$259.00</del>*}
                    {*                                                        </span>*}
                    {*                                                <span class="star-rating">*}
                    {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                    {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                    {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                    {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                    {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                    {*                                                            <span class="review">5 Review(s)</span>*}
                    {*                                                        </span>*}
                    {*                                            </div>*}
                    {*                                        </div>*}
                    {*                                    </div>*}
                    {*                                    <div class="product-item style1">*}
                    {*                                        <div class="product-inner">*}
                    {*                                            <div class="product-thumb">*}
                    {*                                                <div class="thumb-inner">*}
                    {*                                                    <a href=""><img src="images/blog/p2.jpg" alt="p2"></a>*}
                    {*                                                </div>*}
                    {*                                            </div>*}
                    {*                                            <div class="product-innfo">*}
                    {*                                                <div class="product-name"><a href="">2750 Cotu Classic Sneakers</a>*}
                    {*                                                </div>*}
                    {*                                                <span class="price">*}
                    {*                                                            <ins>$229.00</ins>*}
                    {*                                                            <del>$259.00</del>*}
                    {*                                                        </span>*}
                    {*                                                <span class="star-rating">*}
                    {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                    {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                    {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                    {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                    {*                                                            <i class="fa fa-star" aria-hidden="true"></i>*}
                    {*                                                            <span class="review">5 Review(s)</span>*}
                    {*                                                        </span>*}
                    {*                                            </div>*}
                    {*                                        </div>*}
                    {*                                    </div>*}
                    {*                                </div>*}
                    {*                            </div>*}
                    {*                        </div>*}
                    {*                    </div>*}
                </div>
            </div>
        </div>
    </div>
</main>