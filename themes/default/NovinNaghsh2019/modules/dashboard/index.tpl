<!-- MAIN -->
<main class="site-main site-login js-get-pages-id" id="js-dashboard-panel">
    <div class="container">
        <ol class="breadcrumb-page">
            <li><a href="/">صفحه اصلی </a></li>
            <li class="active"><a href="/panel">پنل کاربری</a></li>
        </ol>
    </div>
    <div class="container mt-25">
        <div class="row">
            <div class="col-md-6">
                <h2 class="headline-3 mb-15">اطلاعات شخصی</h2>
                <div class="address-form dashboard-list personal">
                    <div class="row">
                        <div class="col-xs-6 item">
                            <h4 class="title">نام :</h4>
                            <span class="text">{$user->first_name}</span>
                        </div>
                        <div class="col-xs-6 item">
                            <h4 class="title">نام خانوادگی :</h4>
                            <span class="text">{$user->last_name}</span>
                        </div>
                        <div class="col-xs-6 item">
                            <h4 class="title">شماره تلفن همراه :</h4>
                            <span class="text">{$user->mobile}</span>
                        </div>
                        <div class="col-xs-6 item">
                            <h4 class="title">آدرس ایمیل :</h4>
                            <span class="text">{$user->email}</span>
                        </div>
                        <div class="col-xs-12 item-link">
                            <a class="link" href="#">ویرایش اطلاعات شخصی</a>
                        </div>
                    </div>
                </div>
            </div>
            {if 1}
                <div class="col-md-6">
                    <h2 class="headline-3">آدرس های تحویل</h2>
                    <div class="address-form address-list dashboard-list address">
                        {if $addressList->isEmpty()}
                            <div class="item empty-address text-center">
                                <p>هیچ آدرسی یافت نشد</p>
                            </div>
                        {else}
                            {foreach $addressList as $address}
                                <div class="item">
                                    <p class="adr-text title">
                                        <i class="icon fa fa-map-marker"></i>
                                        {$address->title} ({$address->province->name}) -
                                        {if isset($address->county)}
                                            {$address->county->name}
                                        {/if}
                                        <b>(<a class="text-danger remove-address" href="#"
                                               data-address-id="{$address->id}">
                                                <i class="fa fa-trash"></i>
                                                <span>حذف آدرس</span>
                                                <i class="fa fa-sync fa-spin hidden"></i>
                                            </a>)</b>
                                    </p>
                                    <p class="adr-text">
                                        <i class="icon fa fa-map-marker"></i>
                                        {$address->delivery_address}
                                    </p>
                                    <p class="adr-text">
                                        <i class="icon fa fa-address-book"></i>
                                        {$address->postal_code}
                                    </p>
                                    <p class="adr-text">
                                        <i class="icon fa fa-phone"></i>
                                        {$address->mobile}
                                    </p>
                                </div>
                            {/foreach}
                        {/if}
                        <div class="item-link">
                            <a class="link" href="#js-add-address-modal" data-toggle="modal">اضافه کردن آدرس جدید</a>
                        </div>
                    </div>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="js-add-address-modal" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <form class="js-address-form address-form" action="/dashboard/users-panel/add-address"
                                  method="post">
                                <div class="modal-header">
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                                aria-hidden="true">&times;</span>
                                    </button>
                                    <h3 class="modal-title headline-3" id="myModalLabel">انتخاب آدرس تحویل</h3>
                                </div>
                                <div class="modal-body">
                                    <div class="row">
                                        {include file="modules/dashboard/address-form.tpl"}
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-default" data-dismiss="modal">بستن</button>
                                    <button type="submit" class="btn btn-primary btn-medium js-address-button">
                                        <span>ثبت آدرس</span>
                                        <i class="fa fa-sync fa-spin hidden"></i>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            {/if}
        </div>
    </div>
</main><!-- end MAIN -->
