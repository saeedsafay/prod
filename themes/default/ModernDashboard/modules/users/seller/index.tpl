<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                            {include file='partials/header_menu.tpl'}
                            <div class="row">
                                <div class="col-md-12 col-lg-12 bb">
                                    <div class="col-md-3 col-sm-12 col-xs-12 sec_f wow zoomIn" data-wow-duration="1s">
                                        <div class="box_dash_box">
                                            <a href="{site_url}users/editprofile">
                                                <div class="box_list_option">
                                                    <img src="{assets_url}img/profile.png">
                                                </div>
                                                <p class="align_dash">
                                                    <a href="{site_url}users/editprofile">ویرایش پروفایل</a>
                                                </p>
                                                <p class="align_dash"><a href="{site_url}users/changepass">تغییر رمزعبور</a></p>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-12 col-xs-12 sec_f wow zoomIn" data-wow-duration="1s">
                                        <div class="box_dash_box">
                                            <a href="{site_url}seller/manage-products/general-products">
                                                <div class="box_list_option">
                                                    <img src="{assets_url}img/productcom.png">

                                                </div>
                                            </a>
                                            <p class="align_dash"><a
                                                        href="{site_url}seller/manage-products/general-products">لیست
                                                    محصولات ({$product_count}) </a></p>
                                            <p class="align_dash"><a
                                                        href="{site_url}seller/manage-products/add-product">افزودن
                                                    محصول</a></p>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-12 col-xs-12 sec_f wow zoomIn" data-wow-duration="1s">
                                        <div class="box_dash_box">
                                            <a href="{site_url}seller/manage-products/sales">
                                                <div class="box_list_option">
                                                    <img src="{assets_url}img/sale.png">

                                                </div>
                                                <p class="align_dash"><a href="{site_url}seller/manage-products/sales">حراجی‌ها</a>
                                                </p>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-12 col-xs-12 sec_f wow zoomIn" data-wow-duration="1s">
                                        <div class="box_dash_box">
                                            <a href="{site_url}contacts/tickets/ticket-list">
                                                <div class="box_list_option">
                                                    <img src="{assets_url}img/Mail-icon.png">
                                                </div>
                                                <p class="align_dash"><a href="{site_url}contacts/tickets/ticket-list">لیست پیام‌ها</a></p>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-12 col-xs-12 sec_f wow zoomIn" data-wow-duration="1s">
                                        <div class="box_dash_box">
                                            <a href="{site_url}seller/manage-products/orders">
                                                <div class="box_list_option">
                                                    <img src="{assets_url}img/calendar.png">
                                                </div>
                                                <p class="align_dash"><a href="{site_url}seller/manage-products/orders">لیست
                                                        سفارشات({$orders_count}) </a></p>
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-md-3 col-sm-12 col-xs-12 sec_f wow zoomIn" data-wow-duration="1s">
                                        <div class="box_dash_box">
                                            <a href="#">
                                                <div class="box_list_option">
                                                    <img src="{assets_url}img/budget.png">

                                                </div>
                                                <p class="align_dash"><a href="{site_url}payment/transactions">مشاهده تراکنش‌های مالی  </a></p                                        </a>
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
</section>
