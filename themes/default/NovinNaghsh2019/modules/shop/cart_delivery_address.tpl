<!-- MAIN -->
<main class="site-main checkout js-get-pages-id" id="js-delivery">
    <div class="container">
        <ol class="breadcrumb-page">
            <li><a href="/">صفحه اصلی </a></li>
            <li class="active"><a href="/shop/cart">سبد خرید</a></li>
            <li class="active"><a href="#">آدرس تحویل</a></li>
        </ol>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8 col-xs-offset-0 col-sm-offset-2 col-lg-offset-2">
                <h4 class="title-checkout">تعیین آدرس تحویل</h4>

                <form action="/payment" class="checkout" method="post">
                    <div class="row">
                        {if !$Cart->user->email}
                            <div class="col-xs-12 col-md-12">
                                <div class="form-group">
                                    <label class="title" for="email-address-field">
                                        آدرس ایمیل (جهت ارسال تایید سفارش)
                                    </label>
                                    <input type="text"
                                           name="email"
                                           value=""
                                           class="form-control js-address-field"
                                           placeholder="آدرس ایمیل">
                                </div>
                            </div>
                        {/if}
                        {if 0}
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4">
                                <label class="upload-sizing-wrapp js-upload-size js-upload-osize"
                                       style="min-height: 180px">
                                    <div class="adr-text">
                                        <p class="adr-text title">
                                            <i class="icon fa fa-map-marker"></i>
                                            عدم ارسال پستی

                                        </p>
                                    </div>
                                    <h4 class="title" style="position: absolute; bottom: 0">
                                        <input name="delivery_address_id" type="radio"
                                               value="0">
                                        <b class="js-input-title">
                                            دریافت حضوری سفارش
                                        </b>
                                    </h4>
                                </label>
                            </div>
                        {/if}
                        {foreach $addresses as $address}
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4">
                                <label class="upload-sizing-wrapp js-upload-size js-upload-osize"
                                       style="min-height: 180px">
                                    <div class="adr-text">
                                        <p class="adr-text title">
                                            <i class="icon fa fa-map-marker"></i>
                                            {$address.delivery_address}
                                        </p>
                                        <p class="adr-text title"><i class="icon fa fa-phone"></i>
                                            {$address.mobile}
                                        </p>
                                    </div>
                                    <h4 class="title" style="position: absolute; bottom: 0">
                                        <input name="delivery_address_id" type="radio"
                                               value="{$address.id}">
                                        <b class="js-input-title">
                                            {$address->title}
                                            {if isset($address->county)}
                                                ({$address->county->name})
                                            {/if}
{*                                            (+ {({setting name="transportation_price"})|price_format})*}
                                        </b>
                                    </h4>
                                </label>
                            </div>
                        {/foreach}
                        <div class="col-xs-12 col-lg-12 mb-20">
                                    <span class="btn-link new-address" style="cursor: pointer;">
                                        <i class="fa fa-plus"></i>
                                        افزودن آدرس جدید
                                    </span>
                        </div>
                        <div class="col-xs-12">
                            <div class="text-left mb-10">
                                <button type="submit" class="btn btn-primary btn-medium js-address-button">
                                    <span>مرحله بعد - صورتحساب نهایی</span>
                                    <i class="fa fa-sync fa-spin hidden"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
                <form class="address-form js-address-form mt-20 {if !$addresses->isEmpty()} hidden {/if}"
                      action="/dashboard/users-panel/add-address"
                      method="post">
                    <div class="row mt-15">
                        {include file="modules/dashboard/address-form.tpl"}
                        <div class="col-xs-12">
                            <div class="text-left mb-10">
                                <button type="submit" class="btn btn-primary btn-medium js-address-button">
                                    <span>ذخیره آدرس</span>
                                    <i class="fa fa-sync fa-spin hidden"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main><!-- end MAIN -->