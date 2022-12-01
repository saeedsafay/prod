{if isset($User->lat)}
    <script>
        shop_pos = {literal}{{/literal}latitude: {$User->lat}, longitude:{$User->long}{literal}};{/literal}
    </script>
{/if}
<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12 col-sm-12 col-xs-12">
                    <div class="row">
                    
                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left col-sm-12 col-xs-12">
                            {include file='partials/header_menu.tpl'}
                            <form method="POST" action="" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-12 col-sm-12 col-xs-12">
                                        <label class="text-error text-danger">{validation_errors()}</label>
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-lg-12 pull-left col-sm-12 col-xs-12">
                                        <div class="row">
                                            <h4 class="title_header"><span class="title_border">پروفایل:</span></h4>
                                            <div class="col-md-7 col-lg-7 col-md-offset-3 col-sm-12 col-xs-12">
                                                <div class="control-group ">
                                                    <label class="control-label" for="first_name">نام  :</label>
                                                    <div class="controls">
                                                        <input class="input_align input_page" type="text" id="first_name" name="first_name" placeholder="{$User.first_name}"  value="{set_value('first_name',(isset($User->first_name)) ? $User->first_name: set_value('first_name') )}"  class="input-xlarge">

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-7 col-lg-7 col-md-offset-3 col-sm-12 col-xs-12">
                                                <div class="control-group ">
                                                    <label class="control-label" for="last_name">نام خانوادگی  :</label>
                                                    <div class="controls">
                                                        <input class="input_align input_page" type="text" id="last_name" name="last_name" placeholder="{$User.last_name}"  value="{set_value('last_name',(isset($User->last_name)) ? $User->last_name: set_value('last_name') )}" class="input-xlarge">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-7 col-lg-7 col-md-offset-3 col-sm-12 col-xs-12">
                                                <div class="control-group ">
                                                    <label class="control-label" for="username">شناسه کاربری ID:</label>
                                                    <div class="controls">
                                                        <input style="cursor: not-allowed;"  class="input_align input_page" type="text" id="username" placeholder="{$User.username}"  value="{set_value('username',(isset($User->username)) ? $User->username: set_value('username') )}" class="input-xlarge" disabled>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <h4 class="title_header"><span class="title_border">جنسیت:</span> </h4>
                                    <div class="col-md-6 col-lg-6  text_align col-sm-12 col-xs-12">
                                        <h3>خانم</h3>
                                        <div class="control-group">
                                            <img width="30%" src="{assets_url}img/userlady.png">
                                            <div class="controls align_aa">
                                                <input type="radio" class="input-radio" id="female" name="sex"  value="2" {if $User.sex==2}checked{/if}>
                                                <label for="female">خانم</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 text_align col-sm-12 col-xs-12 ">
                                        <h3>آقا</h3>
                                        <div class="control-group  ">
                                            <img width="30%" src="{assets_url}img/usermen.png">
                                            <div class="controls align_aa">
                                                <input type="radio" class="input-radio" id="male" name="sex"  value="1" {if $User.sex==1}checked{/if}>
                                                <label for="male">آقا</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <h4 class="title_header"><span class="title_border">اطلاعات تماس:</span> </h4>
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="tell"><i class="fa fa-volume-control-phone i_field" aria-hidden="true"></i>شماره تلفن:</label>
                                            <div class="controls">
                                                <input class="put_width" class="input_page" type="text" id="tell" name="tell" value="{set_value('tell',(isset($User->contact->tell)) ? $User->contact->tell: set_value('tell') )}" placeholder="" class="input-xlarge">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="mobile"><i class="fa fa-mobile i_field" aria-hidden="true"></i>شماره همراه:</label>
                                            <div class="controls">
                                                <input class="put_width" class="input_page" type="text" id="mobile"  value="{$User->mobile}" style="cursor: not-allowed;" class="input-xlarge" disabled="">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="email"><i class="fa fa-envelope i_field" aria-hidden="true"></i>ایمیل:</label>
                                            <div class="controls">
                                                <input class="put_width" class="input_page" type="text" id="username" name="email"  value="{set_value('email',(isset($User->email)) ? $User->email: set_value('email') )}"  class="input-xlarge">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="website"><i class="fa fa-tv i_field" aria-hidden="true"></i>سایت:</label>
                                            <div class="controls">
                                                <input class="put_width" class="input_page" type="text" id="website" name="website" value="{set_value('website',(isset($User->contact->website)) ? $User->contact->website: set_value('website') )}"  class="input-xlarge">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="instagram"><i class="fa fa-instagram i_field" aria-hidden="true"></i>اینستاگرام:</label>
                                            <div class="controls">
                                                <input class="put_width" class="input_page" type="text" id="instagram" name="instagram"  value="{set_value('instagram',(isset($User->contact->instagram)) ? $User->contact->instagram: set_value('instagram') )}"  class="input-xlarge">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="telegram"><i class="fa fa-arrow-circle-o-up i_field" aria-hidden="true"></i>تلگرام:</label>
                                            <div class="controls">
                                                <input class="put_width" class="input_page" type="text" id="telegram" name="telegram" value="{set_value('telegram',(isset($User->contact->telegram)) ? $User->contact->telegram: set_value('telegram') )}"  class="input-xlarge">
                                            </div>
                                        </div>
                                    </div> 
                                    <p class="pp">نمایش اطلاعات این قسمت فقط برای ارائه به فروشندگانی که از آنها خرید انجام گرفته است می باشد.</p>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12 ">
                                        <div class="control-group ">

                                            <div class="controls">
                                                <input class="send" name="submitbtn" class="input_page" type="submit" value="ثبت" class="input-xlarge">
                                            </div>
                                        </div>
                                    </div> 
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</section>