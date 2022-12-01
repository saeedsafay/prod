<div class="header-menu-nav-inner ">
    <nav class="header-menu header-menu-resize" itemscope itemtype="http://schema.org/SiteNavigationElement">
        <ul class="header-nav krystal-nav">
            <li class="btn-close hidden-md"><i class="fa fa-times" aria-hidden="true"></i></li>
            <li class="">
                <a href="/" itemprop="url"><span itemprop="name">صفحه نخست</span></a>
                <span class="toggle-submenu hidden-md"></span>
            </li>
            {foreach $menuProductTypes as $productType}
                <li class="menu-item-has-children arrow item-megamenu">
                    <a href="/product-types/{$productType->slug}" itemprop="url">
                        <span itemprop="name">{$productType->title}</span>
                    </a>
                    <span class="toggle-submenu hidden-md"></span>
                    <div class="submenu parent-megamenu megamenu">
                        <div class="submenu-banner submenu-banner-menu-2 flexmenu-wrap">
                            {foreach $productType->mainCategories as $parent}
                                <div class="dropdown-menu-info flexmenu-item">
                                    <h6 class="dropdown-menu-title">
                                        <a href="{site_url()}{$parent->link}" itemprop="url">
                                            <span itemprop="name">{$parent->title}</span>
                                        </a>
                                    </h6>
                                    <div class="dropdown-menu-content">
                                        <ul class="menu">
                                            {foreach $parent->children as $item}
                                                <li class="menu-item" itemprop="name">
                                                    <a href="{site_url()}{$item->link}"
                                                       itemprop="url">
                                                        <span itemprop="name">{$item->title}</span>
                                                    </a>
                                                </li>
                                            {/foreach}
                                        </ul>
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </li>
            {/foreach}
            <li class=""><a href="/سوالات-متداول">سوالی دارید؟</a></li>
        </ul>
    </nav>
</div>