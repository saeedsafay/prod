<form id="block-search-mobile" method="get" class="block-search-mobile">
    <div class="form-content">
        <div class="control">
            <a href="#" class="close-block-serach"><span class="icon fa fa-times"></span></a>
            <input type="text" name="search" placeholder="Search" class="input-subscribe">
            <button type="submit" class="btn search">
                <span><i class="fa fa-search" aria-hidden="true"></i></span>
            </button>
        </div>
    </div>
</form>
<!-- HEADER -->
<header class="site-header header-opt-1">
    <!-- header-content -->
    <div class="header-content">
        <div class="container">
            <div class="row">
                <div class="col-md-2 nav-left">
                    <!-- logo -->
                    <strong class="logo">
                        <a href="{site_url()}"><img src="{assets_url}images/home1/logo.jpg" alt="لوگوی نوین نقش"></a>
                    </strong><!-- logo -->
                </div>
                <div class="col-md-7 nav-mind">
                    <!-- block search -->
                    <div class="block-search">
                        <form class="form-search js-search-form" method="POST" action="">
                            <div class="box-group">
                                <input type="text" class="form-control js-search-field"
                                       placeholder="جستجوی کالا و خدمات">
                                <button class="icon" type="button"><i class="fa fa-search"></i></button>
                            </div>
                            <div class="search-result-wrap js-search-result-wrap">
                                <ul class="search-result-list list-unstyled js-search-result">
                                    <li>
                                        <a href="#">همه دسته بندی <span class="data">لیوان</span></a>
                                    </li>
                                    <li>
                                        <a href="#">همه دسته بندی <span class="data">تیشرت</span></a>
                                    </li>
                                    <li>
                                        <a href="#">تیشرت دردسته <span class="data">پوشاک</span></a>
                                    </li>
                                    <li>
                                        <a href="#">تیشرت دردسته <span class="data">پوشاک</span></a>
                                    </li>
                                </ul>
                                <ul class="search-result-list list-unstyled js-search-trend">
                                    <p class="title">بیشترین جستجوهای اخیر</p>
                                    <li>
                                        <a href="#">تیشرت</a>
                                    </li>
                                    <li>
                                        <a href="#">ماگ</a>
                                    </li>
                                    <li>
                                        <a href="#">کاغذ سابلیمیشن</a>
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div><!-- block search -->
                </div>
                <div class="col-md-3 nav-right clearfix">
                    <!-- block mini cart -->
                    <span data-action="toggle-nav" class="menu-on-mobile hidden-md style2">
                        <span class="btn-open-mobile home-page">
                            <span></span>
                            <span></span>
                            <span></span>
                        </span>
                        <span class="title-menu-mobile">منوی سایت</span>
                    </span>
                    <a href="" class="hidden-md search-hidden"><span class="fa fa-search"></span></a>
                    {if !$is_logged_in}
                        <a href="/users/login">
                            <div class="head-login">
                                <i class="fa fa-user icon visible-xs" aria-hidden="true"></i>
                                <span class="text hidden-xs">ورود / ثبت نام</span>
                            </div>
                        </a>
                    {else}
                        <div class="login-dropdown">
                            <a href="#" class="dropdown-toggle">
                                <i class="fa fa-user icon-user" aria-hidden="true"></i>
                                <span class="hidden-xs">{$user.first_name} {$user.last_name}</span>
                                <i class="fa fa-angle-down icon-angle" aria-hidden="true"></i>
                            </a>
                            <ul class="submenu parent-megamenu">
                                {if !$is_logged_in}
                                {else}
                                    {if $buyer}
                                        <li class="dropdown-list">
                                            <a href="{site_url}panel" target="_blank" class="switcher-flag icon">پنل
                                                کاربری</a>
                                        </li>
                                    {else}
                                        <li class="dropdown-list">
                                            <a href="{site_url}dashboard" target="_blank" class="switcher-flag icon">داشبورد
                                                سلر</a>
                                        </li>
                                        <li class="dropdown-list">
                                            <a href="{site_url}panel" target="_blank" class="switcher-flag icon">پنل
                                                کاربری</a>
                                        </li>
                                    {/if}
                                    <li class="dropdown-list">
                                        <a href="/orders" class="switcher-flag icon">سفارش های من</a>
                                    </li>
                                    <li class="dropdown-list">
                                        <a href="{site_url}users/logout" class="switcher-flag icon">خروج از حساب
                                            کاربری</a>
                                    </li>
                                {/if}
                            </ul>
                        </div>
                    {/if}
                    {include file="partials/cart_widget.tpl" }
                </div>

            </div>
        </div>
    </div><!-- header-content -->
    <!-- header-menu-bar -->
    <div class="header-menu-bar header-sticky">
        <div class="header-menu-nav menu-style-2">
            <div class="container position-relative">
                {include file="partials/navigation_bar.tpl"}

                <div class="header-menu-phone">
                    <a class="link" href="tel:+982166126993">
                        6993 6612
                        <i class="fa fa-phone"></i>
                    </a>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- end HEADER -->
