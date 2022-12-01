<section class="htc__product__details ptb-100">
    <div class="container">
        <div class="row">
            <h3 style="
                font-size: 27px;
                padding-bottom: 20px;
                text-align: right;
                "> صورتحساب</h3>
            <div class="col-md-12">
                <div class="product__top_wrap">
                    <!-- Start product Details -->
                    <form action="asdf">	
                        <div class="row">
                            <div class="col-md-12 col-lg-12 col-sm-12 single-profuct-thumb">
                                <table class="table listtt rtl">

                                    <tfoot>
                                        <tr class="cart-subtotal">
                                            <th style="text-align:center">عنوان</th>
                                            <th style="text-align:center">قیمت</th>
                                            <th style="text-align:center">تعداد</th>
                                            <th style="text-align:center">مجموع</th>
                                        </tr>
                                        {assign var=subTotal value=0}
                                        {foreach from=$CartItems item=Item}
                                            <tr class="cart-subtotal">
                                                <td style="color: red;text-align:center;">
                                                    {$Item.title}
                                                </td>
                                                <td style="text-align:center"> {$Item.price|price_format}</td>
                                                <td style="text-align:center">  <strong>  {$Item.pivot.qty|persian_number} ×</strong> کیلوگرم
                                                </td>
                                                <td style="text-align:center"> {($Item.price * $Item.pivot.qty)|price_format}</td>
                                            </tr>
                                            {assign var=subTotal value=$subTotal+($Item.price * $Item.pivot.qty)}
                                        {/foreach}				
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <!-- End product Details -->
                    </form>
                </div>
            </div>
        </div>
        <!-- Start Review Information -->
    </div>
</section>

<section class="htc__product__details ptb-20">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h2 class="title_align" style=" padding-bottom: 27px;
                    ">ورود به حساب</h2>

                {form_open({site_url('users/users/login')})}
                <div class="single-contact-form">
                    <div class="contact-box">
                        <input name="email" type="email" placeholder="ایمیل">
                    </div>
                </div>
                <div class="single-contact-form">
                    <div class="contact-box">
                        <input type="password" name="password" placeholder="رمز عبور">
                    </div>
                </div>
                <button class="btn btn-info btn-block login" type="submit" style="
                        width: 23%;
                        margin: 17px auto;
                        font-family: xantoxa;
                        ">ورود</button>
                {form_close()}

            </div>

            <div class="col-md-6" id="register">
                <h2 class="title_align">ساخت حساب کاربری</h2>
                <form id="register-form" action="{$register_action}" method="post">
                    <div class="single-contact-form">
                        <div class="contact-box">
                            <input type="text" name="name_family" placeholder="نام و نام خانوادگی*">
                        </div>
                    </div>
                    <div class="single-contact-form">
                        <div class="contact-box">
                            <input type="email" name="email" placeholder="ایمیل*">
                        </div>
                    </div>
                    <div class="single-contact-form">
                        <div class="contact-box">
                            <input type="text" name="address" placeholder="آدرس پستی کامل*">
                        </div>
                    </div>
                    <div class="single-contact-form">
                        <div class="contact-box">
                            <input type="text" name="mobile" placeholder="شماره تلفن*">
                        </div>
                    </div>
                    <div class="single-contact-form">
                        <p class="rtl">یک رمز عبور برای حساب جدیدتان در سایت وارد کنید. اگر از قبل در سایت عضو هستید، از قسمت ورود به سایت، لاگین کنید</p>
                        <div class="contact-box">
                            <input type="password" name="confirm_password" placeholder="تکرار رمز عبور*">
                            <input type="password" name="password" placeholder="رمز عبور*">
                        </div>
                    </div>

                    <div class="contact-btn">
                        <button id="register-form-submit" type="submit" class="fv-btn">ثبت و ادامه</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- Start Review Information -->
    </div>
</section>

