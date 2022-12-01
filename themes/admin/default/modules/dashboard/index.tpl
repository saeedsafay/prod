{add_js part="footer" file="bower_components/d3/d3.min.js"}
{add_js part="footer" file="bower_components/c3js-chart/c3.min.js"}
{add_js part="footer" file="bower_components/peity/jquery.peity.min.js"}
{add_js part="footer" file="bower_components/jquery.easy-pie-chart/dist/jquery.easypiechart.min.js"}
{add_js part="footer" file="js/pages/dashboard.min.js"}
<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-bottom">{$title}</h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <p>به دشبورد مدیریتی {setting name="site_name"} خوش آمدید</p>
        </div>
    </div>
    {literal}
    <div class="uk-grid uk-grid-medium" data-uk-grid-margin data-uk-grid-match="{target:'.md-card'}">
        {/literal}
        <div class="uk-width-medium-1-3">
            <div class="md-card">
                <div class="md-card-content">
                    <h4>
                        <i class="uk-icon-money uk-icon-large uk-text-success .uk-icon-justify"></i>
                        فروش هفته گذشته
                    </h4>
                    <span>{$saleThisWeek|price_format}</span>
                </div>
            </div>
        </div>
        <div class="uk-width-medium-1-3">
            <div class="md-card">
                <div class="md-card-content">
                    <h4>
                        <i class="uk-icon-money uk-icon-large uk-text-success .uk-icon-justify"></i>
                        فروش امروز
                    </h4>
                    <span>{$saleToday|price_format}</span>
                </div>
            </div>
        </div>
        <div class="uk-width-medium-1-3">
            <div class="md-card">
                <div class="md-card-content">
                    <h4>
                        <i class="uk-icon-cart-plus uk-icon-small uk-text-success .uk-icon-justify"></i>
                        ({$notif.orders|persian_number}) سفارشات ثبت شده
                    </h4>
                    <a class="btn btn-info" style="margin: 32px 12px 0 0;"
                       href="{site_url()|con:ADMIN_PATH}/shop/shop/orders">لیست سفارشات</a>
                    <a class="btn btn-info" style="margin: 32px 12px 0 0;"
                       href="{site_url()|con:ADMIN_PATH}/shop/shop/product-list">لیست کالاها</a>
                </div>
            </div>
        </div>
        <div class="uk-width-medium-1-3">
            <div class="md-card">
                <div class="md-card-content">
                    <h4>
                        <i class="uk-icon-user-times uk-icon-small uk-text-danger .uk-icon-justify"></i>
                        ({$notif.non_activate|persian_number}) کاربر جدید تایید نشده
                    </h4>
                    <h4>
                        <i class="uk-icon-users uk-icon-small .uk-icon-justify uk-text-success"></i>
                        ({$notif.users|persian_number}) مجموع کاربران
                    </h4>
                    <a class="btn btn-info" style="margin: 32px 12px 0 0;" href="{site_url()|con:ADMIN_PATH}/users">مشاهده
                        لیست کاربران</a>
                </div>
            </div>
        </div>
        <div class="uk-width-medium-1-3">
            <div class="md-card">
                <div class="md-card-content">
                    <h4>
                        <i class="uk-icon-comment-o uk-icon-small uk-text-danger .uk-icon-justify"></i>
                        {$notif.unverify_comments|persian_number} کامنت جدید تایید نشده
                    </h4>
                    <h4>
                        <i class="uk-icon-comments uk-icon-small .uk-icon-justify uk-text-success"></i>
                        ({$notif.true_comments|persian_number}) مجموع نظرات تایید شده
                    </h4>
                    <a class="btn btn-info" href="{site_url()|con:ADMIN_PATH}/content/comments">مشاهده لیست نظرات</a>
                </div>
            </div>
        </div>
        <div class="uk-width-medium-1-3">
            <div class="md-card">
                <div class="md-card-content">
                    <h4>
                        <i class="uk-icon-comments uk-icon-small .uk-icon-justify uk-text-success"></i>
                        {$notif.contacts|persian_number} تماس جدید از سایت
                    </h4>
                    {*<h4>
                    <i class="uk-icon-comments uk-icon-small .uk-icon-justify uk-text-success"></i>
                    ({$notif.true_comments|persian_number}) مجموع نظرات تایید شده
                    </h4>*}
                    <a class="btn btn-info" style="margin: 32px 12px 0 0;"
                       href="{site_url()|con:ADMIN_PATH}/contacts/contact-us">مشاهده لیست تماس ها</a>
                </div>
            </div>
        </div>
    </div>

    <div class="uk-grid uk-grid-medium">
        <div class="md-card uk-width-medium-1-3">
            <div class="md-card-head">
                <h3 class="md-card-head-text">مشخصات سرور ابرک<span id="ch_memory_usage_server"></span></h3>
                <div id="c3_server_load" class="head_chart"></div>
            </div>
            <div class="md-card-content">
                <ul class="md-list" style="text-align:left">
                    {foreach $server_info as $server}
                        <li class="{if $server['status'] == "ACTIVE"}md-list-item-active{/if}">
                            <div class="md-list-content" style="text-align:left">
                            <span class="uk-badge {if $server['status'] ==
                            "ACTIVE"}uk-badge-success{else}uk-badge-danger{/if}">آنلاین</span>
                                <span class="md-list-heading">{$server['name']} (ir-thr-at1)</span>
                                <span class="uk-text-small
                            uk-text-bold">IP: {$server['addresses']['public1'][0]['addr']}</span>
                                <span class="uk-text-small uk-text-bold">{$server['flavor']['disk']} GB SSD</span>
                                <span class="uk-text-small uk-text-bold">{$server['flavor']['ram']} MB RAM</span>
                                <span class="uk-text-small uk-text-bold">{$server['flavor']['vcpus']} CPU</span>
                                <span class="uk-text-small uk-text-bold">{jdate formate="Y-m-d H:i:s"
                                    date=$server['created']}</span>
                            </div>
                        </li>
                    {/foreach}
                </ul>
            </div>
        </div>
        <div class="md-card uk-width-medium-1-3">
            <div class="md-card-head">
                <h3 class="md-card-head-text"> ایمیج های سرور<span id="ch_memory_usage_server"></span></h3>
                <div id="c3_server_load" class="head_chart"></div>
            </div>
            <div class="md-card-content">
                <ul class="md-list" style="text-align:left">
                    {foreach $server_images as $image}
                        <li class="{if $image['status'] == "active"}md-list-item-active{/if}">
                            <div class="md-list-content" style="text-align:left">
                            <span class="uk-badge {if $image['status'] ==
                            "active"}uk-badge-success{else}uk-badge-danger{/if}">{$image['status']}</span>
                                <span class="md-list-heading">{$image['name']}</span>
                                <span class="uk-text-small uk-text-bold">Cloud: {$image['abrak']}</span>
                                <span class="uk-text-small uk-text-bold">Size: {$image['real_size']}</span>
                                <span class="uk-text-small uk-text-bold">{jdate formate="Y-m-d H:i:s"
                                    date=$image['created_at']}</span>
                            </div>
                        </li>
                    {/foreach}
                </ul>
            </div>
        </div>
    </div>
</div>
