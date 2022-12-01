
<div class="ht-bradcaump-area bg-1">
</div>
<section class="htc__product__details ptb-20">
    <div class="container">
        <form  action="" method="post">
            <div class="row">
                <h2 class="title_align margin-bottom-10">اطلاعات شما</h2>
                <div class="col-md-6 pull-right">
                    <div class="single-contact-form">
                        <div class="contact-box">
                            <input type="text" name="name_family" placeholder="نام و نام خانوادگی*" value="{set_value('name_family', (isset($user->name_family )) ? $user->name_family : '')}" >
                        </div>
                    </div>
                    <div class="single-contact-form">
                        <div class="contact-box">
                            <input type="text"  placeholder="آدرس" name="address" value="{set_value('address', (isset($user->address )) ? $user->address : '')}" >
                        </div>
                    </div>
                    <div class="single-contact-form">
                        <div class="contact-box">
                            <input type="text" placeholder="موبایل یا تلفن" name="mobile" value="{set_value('mobile', (isset($user->mobile )) ? $user->mobile : '')}" />
                        </div>
                    </div>

                </div>
                <div class="col-md-6">
                    <div class="single-contact-form">
                        <div class="contact-box">
                            <input type="email" placeholder="" disabled="" value="{$user->email}" />
                        </div>
                    </div>
                    <div class="single-contact-form">
                        <div class="contact-box">						
                            <input type="text" placeholder="نام کاربری" name="username" value="{set_value('username', (isset($user->username )) ? $user->username : '')}"  />
                        </div>
                    </div>
                    <div class="single-contact-form">
                        <div class="contact-box">									
                            <input type="password" placeholder=" تایید رمز عبور"  name="password_confirm"/>
                            <input type="password" placeholder="رمزعبور - برای عدم تغییر خالی بگذارید"  name="password"/>
                        </div>
                    </div>
                    <div class="contact-btn">
                        <input value="ذخیره" type="submit" name="submitbtn" class="fv-btn" />
                    </div>

                </div>
            </div>
        </form>
        <!-- Start Review Information -->
    </div>
</section>
