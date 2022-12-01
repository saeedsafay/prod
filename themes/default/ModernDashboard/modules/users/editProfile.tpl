{if $User->lat != ""}
    <script>
        shop_pos = {literal}{{/literal}latitude: {$User->lat}, longitude:{$User->long}{literal}};{/literal}
    </script>
{/if}
{literal}
    <style>
        .cover-crop{
            height: 117px!important;
            width: 376px!important;
        }
    </style>
{/literal}
{add_css file='lib/cropper/cropper.min.css'}
{add_css file='lib/cropper/main.css'}
{add_js file='lib/cropper/cropper.min.js' part='footer'}
{add_js file='lib/cropper/main_profile.js' part='footer'}
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
                                    <div class="col-md-12">
                                        <label class="text-error text-danger">{validation_errors()}</label>
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-lg-12 pull-left col-sm-12 col-xs-12">
                                        <div class="row">
                                            <h4 class="title_header"><span class="title_border">پروفایل:</span></h4>
                                            <div class="col-md-7 col-lg-7 col-md-offset-3 col-sm-12 col-xs-12">
                                                <div class="control-group ">
                                                    <label class="control-label" for="business_name">نام فروشگاه * :</label>
                                                    <div class="controls">
                                                        <input class="input_align input_page" type="text" id="business_name" name="business_name" placeholder="{$User.business_name}"  value="{set_value('business_name',(isset($User->business_name)) ? $User->business_name: set_value('business_name') )}"  class="input-xlarge">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-7 col-lg-7 col-md-offset-3 col-sm-12 col-xs-12">
                                                <div class="control-group ">
                                                    <label class="control-label" for="first_name">نام  *:</label>
                                                    <div class="controls">
                                                        <input class="input_align input_page" type="text" id="first_name" name="first_name" placeholder="{$User.first_name}"  value="{set_value('first_name',(isset($User->first_name)) ? $User->first_name: set_value('first_name') )}"  class="input-xlarge">

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-7 col-lg-7 col-md-offset-3 col-sm-12 col-xs-12">
                                                <div class="control-group ">
                                                    <label class="control-label" for="last_name">نام خانوادگی  *:</label>
                                                    <div class="controls">
                                                        <input class="input_align input_page" type="text" id="last_name" name="last_name" placeholder="{$User.last_name}"  value="{set_value('last_name',(isset($User->last_name)) ? $User->last_name: set_value('last_name') )}" class="input-xlarge">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-7 col-lg-7 col-md-offset-3 col-sm-12 col-xs-12">
                                                <div class="control-group ">
                                                    <label class="control-label" for="username">*شناسه کاربری ID:</label>
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
                                    <div class="col-md-6 col-lg-6  text_align  col-sm-12 col-xs-12">
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
                                            <label class="control-label lbl_space" for="telegram"><i class="fa fa-telegram i_field" aria-hidden="true"></i>تلگرام:</label>
                                            <div class="controls">
                                                <input class="put_width" class="input_page" type="text" id="telegram" name="telegram" value="{set_value('telegram',(isset($User->contact->telegram)) ? $User->contact->telegram: set_value('telegram') )}"  class="input-xlarge">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <h4 class="title_header"><span class="title_border">تصاویر کاور پروفایل:</span></h4>

                                    <div class="col-md-8 col-lg-8 col-md-offset-2 col-sm-12 col-xs-12">
                                        <div id="crop-profile-1" class="pull-right col-md-4">
                                            <label class="control-label" for="">بارگذاری تصویر اصلی:</label>
                                            <div class="avatar-view cover-crop" title="انتخاب تصویر اصلی پروفایل">
                                                <img {if set_value('picHidden1','') != '' OR $User->profile->image_slide1 != ""}src="{$products_thumbnail_dir}{set_value('picHidden1', (isset($User->profile->image_slide1)) ? $User->profile->image_slide1 : set_value('picHidden1'))}"
                                                     {else}src="{assets_url}img/digital-camera.png"
                                                     style=" width: 32%;margin-left: 126px;"{/if}>
                                                <input name="picHidden1" type="hidden" id="picHidden1"
                                                       value="{set_value('picHidden1',(isset($User->profile->image_slide1)) ? $User->profile->image_slide1 : '')}">
                                                <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-8 col-lg-8 col-md-offset-2 col-sm-12 col-xs-12">
                                        <div id="crop-profile-2" class="pull-right col-md-4">
                                            <label class="control-label" for="">بارگذاری تصویر دوم:</label>
                                            <div class="avatar-view cover-crop" title="انتخاب تصویر دوم">
                                                <img {if set_value('picHidden2','') != '' OR $User->profile->image_slide2 != ""}src="{$products_thumbnail_dir}{set_value('picHidden2', (isset($User->profile->image_slide2)) ? $User->profile->image_slide2 : set_value('picHidden2'))}"
                                                     {else}src="{assets_url}img/digital-camera.png"
                                                     style=" width: 32%;margin-left: 126px;" {/if} >
                                                <input name="picHidden2" type="hidden" id="picHidden2"
                                                       value="{set_value('picHidden2',(isset($User->profile->image_slide2)) ? $User->profile->image_slide2 : '')}">
                                                <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-8 col-lg-8 col-md-offset-2 col-sm-12 col-xs-12">
                                        <div id="crop-profile-3" class="pull-right col-md-4">
                                            <label class="control-label" for="">بارگذاری تصویر سوم:</label>
                                            <div class="avatar-view cover-crop" title="انتخاب تصویر سوم">
                                                <img {if set_value('picHidden3','') != '' OR $User->profile->image_slide3 != ""}src="{$products_thumbnail_dir}{set_value('picHidden3', (isset($User->profile->image_slide3)) ?$User->profile->image_slide3 : set_value('picHidden3'))}"
                                                     {else}src="{assets_url}img/digital-camera.png"
                                                     style=" width: 32%;margin-left: 126px;" {/if} >
                                                <input name="picHidden3" type="hidden" id="picHidden3"
                                                       value="{set_value('picHidden3',(isset($User->profile->image_slide3)) ? $User->profile->image_slide3 : '')}">
                                                <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <h4 class="title_header"><span class="title_border">معرفی:</span> </h4>
                                    <div class="col-md-6 col-lg-6 col-md-offset-3 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label" for="introduction">:معرفی اجمالی کسب‌و کار </label>
                                            <div class="controls">
                                                <textarea rows="4" cols="55" name="introduction">
                                                {if isset($User->profile)}{$User->profile->introduction}{/if}
                                            </textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-6 col-md-offset-3 col-sm-12 col-xs-12">
                                    <div class="control-group ">
                                        <label class="control-label" for="description">:توضیحات/تاریخچه/مشخصات مجموعه </label>
                                        <div class="controls">
                                            <textarea rows="4" cols="55" name="description">
                                                {if isset($User->profile)}
                                                    {$User->profile->description}
                                                {/if}
                                            </textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>	
                            <div class="row">
                                <h4 class="title_header"><span class="title_border">ویدیو معرفی / تیزر تبیغاتی </span></h4>
                                <div class="col-md-8 col-lg-8 col-md-offset-2 col-sm-12 col-xs-12">
                                    <div class="control-group ">
                                        <label class="control-label" for="video">توضیحات ویدیو :</label>
                                        <div class="controls">
                                            <textarea name="video_desc" rows="3" cols="60">{if isset($User->profile->logo)}{$User->profile->video_desc}{/if}</textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-8 col-lg-8 col-md-offset-2 col-sm-12 col-xs-12">
                                    <div class="control-group ">
                                        <label class="control-label" for="video">فایل ویدیو : </label>
                                        <div class="controls">
                                            <input id="video" type="file" name="video">
                                            {if $User->profile->video}
                                                <video controls>
                                                    <source src="{site_url}upload/users/{$User->profile->video}" type="video/mp4">
                                                    <source src="{site_url}upload/users/{$User->profile->video}" type="video/ogg">
                                                </video>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                                <div class="row">
                                    <h4 class="title_header"><span class="title_border">تصویر لوگوی فروشگاه:</span></h4>

                                    <div class="col-md-8 col-lg-8 col-md-offset-2 col-sm-12 col-xs-12">
                                        <div id="crop-logo-4" class="pull-right col-md-4">
                                            <label class="control-label" for="">بارگذاری تصویر لوگو:</label>
                                            <div class="avatar-view" title="انتخاب تصویر لوگو">
                                                <img {if set_value('picHidden4','') != '' OR $User->profile->logo != ""}src="{$products_thumbnail_dir}{set_value('picHidden4', (isset($User->profile->logo)) ? $User->profile->logo : set_value('picHidden4'))}"
                                                     {else}src="{assets_url}img/digital-camera.png"
                                                     style=" width: 32%;margin-left: 126px;" {/if} >
                                                <input name="picHidden4" type="hidden" id="picHidden4"
                                                       value="{set_value('picHidden4',(isset($User->profile->logo)) ? $User->profile->logo : '')}">
                                                <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    {*   <div class="col-md-8 col-lg-8 col-md-offset-2 col-sm-12 col-xs-12">
                                    <div class="control-group ">
                                    <label class="control-label">انتخاب لوگو: </label>
                                    <div class="controls">
                                    <input type="file" name="logo" accept=".jpg, .png, image/jpeg, image/png">{if isset($User->profile->logo)}<img width="70" src="{site_url}upload/users/{$User->profile->logo}" />{/if}
                                    </div>
                                    </div>
                                    <hr>
                                    </div>*}
                                {*    <div class="col-md-8 col-lg-8 col-md-offset-2 col-sm-12 col-xs-12">
                                <div class="control-group ">
                                <label class="control-label">بارگذاری تصاویر فروشگاه: </label>
                                <div class="controls" id='input-wrapper'>
                                <input type="file" name="shop_photo" accept=".jpg, .png, image/jpeg, image/png">{if isset($User->photo->image)}<img width="65" src="{site_url}upload/users/{$User->photo->image}" />{/if}
                                <input type="file" name="shop_photo2" accept=".jpg, .png, image/jpeg, image/png">{if isset($User->photo->image2)}<img width="65" src="{site_url}upload/users/{$User->photo->image2}" />{/if}
                                <input type="file" name="shop_photo3" accept=".jpg, .png, image/jpeg, image/png">{if isset($User->photo->image3)}<img width="65" src="{site_url}upload/users/{$User->photo->image3}" />{/if}
                                <input type="file" name="shop_photo4" accept=".jpg, .png, image/jpeg, image/png">{if isset($User->photo->image4)}<img width="65" src="{site_url}upload/users/{$User->photo->image4}" />{/if}
                                <input type="file" name="shop_photo5" accept=".jpg, .png, image/jpeg, image/png">{if isset($User->photo->image5)}<img width="65" src="{site_url}upload/users/{$User->photo->image5}" />{/if}
                                <input type="file" name="shop_photo6" accept=".jpg, .png, image/jpeg, image/png">{if isset($User->photo->image6)}<img width="65" src="{site_url}upload/users/{$User->photo->image6}" />{/if}
                                </div>
                                </div>
                                </div>
                                *}
                            </div>	
                            <div class="row">
                                <h4 class="title_header"><span class="title_border">آدرس:</span></h4>
                                <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                    <div class="control-group ">
                                        <label class="control-label lbl_space" for="address_title">عنوان آدرس:</label>
                                        <div class="controls">
                                            <input class="put_width" class="input_page" type="text" id="address_title" name="address_title" placeholder="" value="{set_value('address_title',(isset($User->location->title)) ? $User->location->title: set_value('address_title') )}" class="input-xlarge">
                                        </div>
                                    </div>
                                </div> 
                                <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                    <div class="control-group ">
                                        <label class="control-label lbl_space" for="province">استان:</label>
                                        <div class="controls">
                                            <select class="select_rm" name="province_id" id="province">
                                                <option value="" selected="" disabled="">انتخاب استان</option>
                                                {foreach $Provinces as $prv}
                                                    <option {if isset($User->location->province_id) AND $User->location->province_id eq $prv.id}selected=""{/if} value="{$prv.id}">{$prv.name}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                {if isset($User->location->province_id)}
                                    <input type="hidden" name="province_id_hidden" value="{$User->location->province_id}" />                         
                                    <input type="hidden" name="county_id_hidden" value="{$User->location->county_id}" />
                                    <input type="hidden" name="region_id_hidden" value="{$User->location->region_id}" />      
                                    <input type="hidden" name="neighbourhood_id_hidden" value="{$User->location->neighbourhood_id}" />      
                                {/if}
                                <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12" id="county-wrapper" style="display: none;">
                                    <div class="control-group ">
                                        <i class="fa fa-spinner fa-pulse fa-3x fa-fw" style="display:none;"></i>
                                        <label class="control-label lbl_space" for="county">شهر:</label>
                                        <div class="controls">
                                            <select class="select_rm" name="county_id" id="county">
                                                <option value="" disabled="" selected="">انتخاب شهر</option>
                                            </select>
                                        </div>
                                    </div>
                                </div> 
                                <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12" id="region-wrapper"  style="display: none;">
                                    <div class="control-group ">
                                        <i class="fa fa-spinner fa-pulse fa-3x fa-fw" style="display:none;"></i>
                                        <label class="control-label lbl_space" for="region">منطقه:</label>
                                        <div class="controls">
                                            <select class="select_rm" name="region_id" id="region">
                                                <option value="" disabled="" selected="">انتخاب منطقه</option>
                                            </select>
                                        </div>
                                    </div>
                                </div> 			
                                <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12" id="neighbourhood-wrapper" style="display: none;">
                                    <div class="control-group ">
                                        <i class="fa fa-spinner fa-pulse fa-3x fa-fw" style="display:none;"></i>
                                        <label class="control-label lbl_space" for="neighbourhood">محله:</label>
                                        <div class="controls">
                                            <select class="select_rm" name="neighbourhood_id" id="neighbourhood">
                                                <option value="" disabled="" selected="">انتخاب محله</option>
                                            </select>
                                        </div>
                                    </div>
                                </div> 			
                                <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                    <div class="control-group ">
                                        <label class="control-label lbl_space" for="full_address"><i class="fa fa-home i_field" aria-hidden="true"></i>آدرس کامل:</label>
                                        <div class="controls">
                                            <input class="put_width" class="input_page" type="text" id="full_address" name="full_address" value="{set_value('full_address',(isset($User->location->full_address)) ? $User->location->full_address: set_value('full_address') )}" placeholder="" class="input-xlarge">
                                        </div>
                                    </div>
                                </div> 
                                <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                    <div class="control-group ">

                                        <h4 class="title_header"><span class="title_border">پین گذاری موقعیت فروشگاه روی نقشه: </span></h4>
                                        <div class="controls">
                                            <div id="us2" style="width: 500px; height: 400px;"></div>
                                            <div style="display: none;">
                                                (ارتفاع جغرافیایی)Lat.: <input name="lat" type="text" id="us2-lat" />
                                                (عرض جغرافیایی)Long.: <input type="text" name="long" id="us2-lon" />
                                            </div>
                                        </div>
                                    </div>
                                </div>									 
                            </div>
                            <div class="row">
                                <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                    <div class="control-group ">
                                        <div class="controls">
                                            <input class="send" name="submitbtn" class="input_page" type="submit"  value="ثبت" class="input-xlarge">
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
</section>



<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-1" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'users/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر اصلی پروفایل</h4>
                </div>
                <div class="modal-body">
                    <div class="avatar-body">

                        <!-- Upload image and data -->
                        <div class="avatar-upload">
                            <input type="hidden" class="avatar-data" name="avatar_data">
                            <label for="avatarInput">انتخاب فایل</label>
                            <input type="file" class="avatar-input" id="avatarInput" name="avatar_file">
                        </div>

                        <!-- Crop and preview -->
                        <div class="row">
                            <div class="col-md-9">
                                <div class="avatar-wrapper"></div>
                            </div>
                            <div class="col-md-3">
                                <label class="pull-right">پیش نمایش تصویر</label>
                                <div class="avatar-preview preview-lg"></div>
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn readmore btn-block avatar-save">ارسال</button>
                            </div>
                        </div>
                    </div>
                </div>
                {*<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">بستن</button>
                </div>*}
            </form>
        </div>
    </div>
</div>
<!-- /.modal -->



<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-2" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'users/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر دوم</h4>
                </div>
                <div class="modal-body">
                    <div class="avatar-body">

                        <!-- Upload image and data -->
                        <div class="avatar-upload">
                            <input type="hidden" class="avatar-data" name="avatar_data">
                            <label for="avatarInput">انتخاب فایل</label>
                            <input type="file" class="avatar-input" id="avatarInput" name="avatar_file">
                        </div>

                        <!-- Crop and preview -->
                        <div class="row">
                            <div class="col-md-9">
                                <div class="avatar-wrapper"></div>
                            </div>
                            <div class="col-md-3">
                                <label class="pull-right">پیش نمایش تصویر</label>
                                <div class="avatar-preview preview-lg"></div>
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn readmore btn-block avatar-save">ارسال</button>
                            </div>
                        </div>
                    </div>
                </div>
                {*<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">بستن</button>
                </div>*}
            </form>
        </div>
    </div>
</div>
<!-- /.modal -->



<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-3" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'users/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر سوم</h4>
                </div>
                <div class="modal-body">
                    <div class="avatar-body">

                        <!-- Upload image and data -->
                        <div class="avatar-upload">
                            <input type="hidden" class="avatar-data" name="avatar_data">
                            <label for="avatarInput">انتخاب فایل</label>
                            <input type="file" class="avatar-input" id="avatarInput" name="avatar_file">
                        </div>

                        <!-- Crop and preview -->
                        <div class="row">
                            <div class="col-md-9">
                                <div class="avatar-wrapper"></div>
                            </div>
                            <div class="col-md-3">
                                <label class="pull-right">پیش نمایش تصویر</label>
                                <div class="avatar-preview preview-lg"></div>
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn readmore btn-block avatar-save">ارسال</button>
                            </div>
                        </div>
                    </div>
                </div>
                {*<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">بستن</button>
                </div>*}
            </form>
        </div>
    </div>
</div>
<!-- /.modal -->



<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-4" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'users/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر لوگو</h4>
                </div>
                <div class="modal-body">
                    <div class="avatar-body">

                        <!-- Upload image and data -->
                        <div class="avatar-upload">
                            <input type="hidden" class="avatar-data" name="avatar_data">
                            <label for="avatarInput">انتخاب فایل</label>
                            <input type="file" class="avatar-input" id="avatarInput" name="avatar_file">
                        </div>

                        <!-- Crop and preview -->
                        <div class="row">
                            <div class="col-md-9">
                                <div class="avatar-wrapper"></div>
                            </div>
                            <div class="col-md-3">
                                <label class="pull-right">پیش نمایش تصویر</label>
                                <div class="avatar-preview preview-lg"></div>
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn readmore btn-block avatar-save">ارسال</button>
                            </div>
                        </div>
                    </div>
                </div>
                {*<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">بستن</button>
                </div>*}
            </form>
        </div>
    </div>
</div>
<!-- /.modal -->
