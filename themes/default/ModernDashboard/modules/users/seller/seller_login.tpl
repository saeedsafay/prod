
<!-- ============================================================== -->
<!-- Main wrapper - style you can find in pages.scss -->
<!-- ============================================================== -->
<section id="wrapper" class="login-register login-sidebar" style="background-image:url({assets_url}images/background/login-register.jpg);">
    <div class="login-box card">
        <div class="card-body">
            <form class="form-horizontal form-material text-center" id="loginform" action="" method="post">
                <a href="javascript:void(0)" class="db"><img width="100" src="{assets_url}images/logo-vertical.png" alt="Home" /></a>
                <div class="form-group m-t-40">
                    <div class="col-xs-12">
                        <input class="form-control" name="username" type="text" required="" placeholder="نام کاربری">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-xs-12">
                        <input class="form-control" name="password" type="password" required="" placeholder="رمز عبور">
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-12">
                        <div class="d-flex no-block align-items-center">
                            <div class="custom-control custom-checkbox">
                                <input name="remember_me" type="checkbox" class="custom-control-input" id="customCheck1" value="1">
                                <label class="custom-control-label" for="customCheck1">مرا بخاطر بسپار</label>
                            </div>
                            <div class="mr-auto">
                                <a href="javascript:void(0)" id="to-recover" class="text-muted"><i class="fas fa-lock m-r-5"></i> فراموشی رمز عبور</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group text-center m-t-20">
                    <div class="col-xs-12">
                        <button class="btn btn-info btn-lg btn-block text-uppercase btn-rounded" type="submit">ورود</button>
                    </div>
                </div>
                <div class="form-group m-b-0">
                    <div class="col-sm-12 text-center">
                        حساب کاربری ندارید؟ <a href="users/register/seller" class="text-primary m-l-5"><b>ثبت‌نام کنید</b></a>
                    </div>
                </div>
            </form>
            <form class="form-horizontal" id="recoverform" action="index.html">
                <div class="form-group ">
                    <div class="col-xs-12">
                        <h3>بازیابی رمز عبور</h3>
                        <p class="text-muted">لطفا برای بازیابی رمز عبور ایمیل خود را وارد نمایید</p>
                    </div>
                </div>
                <div class="form-group ">
                    <div class="col-xs-12">
                        <input class="form-control" type="text" required="" placeholder="ایمیل">
                    </div>
                </div>
                <div class="form-group text-center m-t-20">
                    <div class="col-xs-12">
                        <button class="btn btn-primary btn-lg btn-block text-uppercase waves-effect waves-light" type="submit">ارسال</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>
<!-- ============================================================== -->
<!-- End Wrapper -->
<!-- ============================================================== -->