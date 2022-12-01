<!-- MAIN -->
<main class="site-main site-login js-get-pages-id" id="js-register">
    <div class="container">
        <ol class="breadcrumb-page">
            <li><a href="/">صفحه اصلی </a></li>
            <li class="active"><a href="#">ورود / ثبت نام</a></li>
        </ol>
    </div>
    <div class="customer-login">
        <div class="container">
            <div class="row">
                <div class="login-content">
                    <ul class="login-tab list-unstyled">
                        <li class="tab-item active">
                            <a class="tab-link right" href="#js-register-tab"
                               data-toggle="tab" aria-selected="true">ثبت نام</a>
                        </li>
                        <li class="tab-item">
                            <a class="tab-link left" href="#js-login-tab" data-toggle="tab">ورود</a>
                        </li>
                    </ul>
                    <div class="alert alert-danger errors" style="display: none;">
                        <p></p>
                    </div>
                    <div class="tab-content p-0 clearfix" id="myTabContent">
                        <div class="tab-pane fade active in" id="js-register-tab">
                            <div id="verification-wrapper" style="display: none">
                                <form class="register" method="post" action="/users/activateMobile">
                                    <div class="form-group">
                                        <label for="js-register-fcode">
                                            کد تایید حساب کاربری ارسال شده به شماره همراه شما
                                            <span class="form-required">*</span>
                                        </label>
                                        <input type="text" class="form-control" name="code" id="js-register-fcode"
                                               placeholder="لطفا کد فعالسازی را وارد نمایید" required>
                                    </div>
                                    <input type="hidden" name="__verificationUserToken" value="">
                                    <div class="form-row">
                                        <button class="btn btn-primary">تایید</button>
                                    </div>
                                </form>
                            </div>
                            <form class="register js-register-form" method="post" action="/users/register">
                                <div class="form-group row row-10">
                                    <div class="col-xs-6 col-sm-6">
                                        <label class="label-animation">
                                            <input type="text" class="form-control" name="first_name"
                                                   placeholder=" " required>
                                            <span class="text">
                                                <span class="form-required">*</span>
                                                نام
                                            </span>
                                        </label>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <label class="label-animation">
                                            <input type="text" class="form-control" name="last_name"
                                                   id="js-register-lname"
                                                   placeholder=" " required>
                                            <span class="text">
                                                <span class="form-required">*</span>
                                                نام خانوادگی
                                            </span>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group row row-10">
                                    <div class="col-xs-12 col-sm-12">
                                        <label class="label-animation">
                                            <input type="text" name="mobile" class="form-control"
                                                   id="js-register-email-mobile"
                                                   placeholder="بعنوان مثال (091200000000)" required>
                                            <span class="text">
                                            <span class="form-required">*</span>
                                            شماره موبایل
                                        </span>
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group row row-10">
                                    <div class="col-xs-6 col-sm-6">
                                        <label class="label-animation">
                                            <input type="password" name="password" class="form-control"
                                                   id="js-register-password" placeholder=" "
                                                   required="">
                                            <span class="text">
                                                <span class="form-required">*</span>
                                                رمز عبور
                                            </span>
                                        </label>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <label class="label-animation">
                                            <input type="password" name="password" class="form-control"
                                                   id="js-register-confirm"
                                                   placeholder=" " required
                                                   data-parsley-equalto="#js-register-password">
                                            <span class="text">
                                                <span class="form-required">*</span>
                                                تکرار رمز عبور
                                            </span>
                                        </label>
                                    </div>
                                </div>
                                <ul class="list-unstyled">
                                    <li>
                                        <label class="inline">
                                            <input name="policy" type="checkbox" required>
                                            <span class="input"></span>
                                            <a href="/قوانین-و-مقررات" target="_blank">قوانین و شرایط استفاده از نوین نقش</a> را خوانده ام
                                            و می پذیرم
                                        </label>
                                    </li>
                                </ul>
                                <div class="form-row">
                                    <button class="btn btn-primary btn-register">ثبت نام</button>
                                </div>
                            </form>
                        </div>
                        <div class="tab-pane fade" id="js-login-tab">
                            <div id="forgot-sms-form" style="display: none">
                                <form class="register" method="post" action="">
                                    <div class="form-group form-addon">
                                        <label class="label-animation form-input">
                                            <input type="text" class="form-control" name="forgotMobile"
                                                   id="js-register-fpass"
                                                   placeholder="لطفا مقدار را وارد نمایید" required>
                                            <span class="text">
                                                <span class="form-required">*</span>
                                                شماره موبایل
                                            </span>
                                        </label>
                                        <button id="SendForgotSMS" class="btn btn-primary">ارسال</button>
                                        <a href="#" id="login-form-link" class="forgot-password">بازگشت به فرم ورود</a>
                                    </div>
                                </form>
                            </div>
                            <div id="forgot-code-form" style="display: none">
                                <form class="register" method="post" action="">
                                    <div class="form-group">
                                        <label for="js-register-fpass">
                                            کد تایید ارسال شده به شماره موبایل شما:
                                            <span class="form-required">*</span>
                                        </label>
                                        <input type="hidden" name="__forgotVerificationUserToken" value="">
                                        <input type="text" class="form-control" name="forgotMobileCode"
                                               id="js-register-fcode"
                                               placeholder="کد تایید" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="js-register-new-fpass">
                                            رمز عبور جدید
                                            <span class="form-required">*</span>
                                        </label>
                                        <input type="password" class="form-control" name="newPassword"
                                               id="js-register-new-fpass"
                                               placeholder="رمز عبور جدید" required>
                                    </div>
                                    <a href="#" id="forgot-edit-mobile" class="forgot-password">ویرایش شماره
                                        موبایل</a>
                                    <div class="form-row">
                                        <button id="forgotSetNewPassword" class="btn btn-primary">تایید</button>
                                    </div>
                                </form>
                            </div>
                            <form class="login js-login-form" method="post" action="">
                                <div class="form-group row row-10">
                                    <div class="col-xs-6 col-sm-6">
                                        <label class="label-animation">
                                            <input type="text" name="username" class="form-control" id="js-login-mobile"
                                                   placeholder=" " required>
                                            <span class="text">شماره موبایل</span>
                                        </label>
                                    </div>
                                    <div class="col-xs-6 col-sm-6">
                                        <label class="label-animation">
                                            <input type="password" class="form-control" name="password"
                                                   id="js-login-password"
                                                   placeholder=" " required>
                                            <span class="text">رمز عبور</span>
                                        </label>
                                    </div>
                                </div>
                                <ul class="inline-block">
                                    <li>
                                        <label class="inline">
                                            <input type="checkbox">
                                            <span class="input"></span>
                                            مرا به یاد بسپار
                                        </label>
                                    </li>
                                </ul>
                                <a href="#" id="forgot-password-link" class="forgot-password">بازیابی رمز عبور</a>
                                <div class="form-row">
                                    <button class="btn btn-primary">ورود</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="login-img hidden-xs"></div>
                </div>
            </div>
        </div>
    </div>

</main><!-- end MAIN -->


