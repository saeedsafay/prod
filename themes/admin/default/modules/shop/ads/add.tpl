
{add_css file='lib/cropper/cropper.min.css'}
{add_css file='lib/cropper/main.css'}
{add_js file='lib/cropper/cropper.min.js' part='footer'}
{add_js file='lib/cropper/main.js' part='footer'}
{add_js file='js/piano.js' part='footer'}

<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        افزودن آگهی 
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                {form_open_multipart($action,$attr)}
                <div data-uk-grid-margin="" class="uk-grid">
                    <div class="uk-width-medium-1-1">
                        <div class="uk-form-row">

                            <div class="uk-width-medium-1-1 uk-margin-top">
                                <label>کاربر مربوطه <span class="required">*</span></label>
                                <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                    <select name="user_id" class="data-md-selectize" data-md-selectize-bottom="">
                                        {foreach from=$users item=val}
                                            <option value="{$val.id}">{$val.first_name} {$val.last_name} ({$val.email})</option>
                                        {/foreach}
                                    </select> 
                                </div>
                            </div>
                            <div class=" uk-margin-top">
                                <label>عنوان آگهی <span class="required">*</span></label>										
                                <input type="text" class="md-input" name="title" class="md-input {if form_error('title') != NULL}md-input-danger{/if}" value="{set_value('title','')}" />
                            </div>
                            <span class="error_page_content">
                                {form_error('title')}  
                            </span>
                            <div class="uk-width-medium-1-1 uk-margin-top">
                                <label>دسته بندی  <span class="required">*</span></label>
                                <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                    <select name="ads_category_id" id="category_piano"  class="data-md-selectize  {if form_error('ads_category_id') != NULL}md-input-danger{/if}" data-md-selectize-bottom="">
                                        {foreach from=$ads_category item=parent}
                                            <optgroup style="color:red" label="{$parent.title}">
                                                {if !isset($parent.children[0]->id)}
                                                    <option value="{$parent.id}">{$parent.title}</option>
                                                {/if}
                                                {foreach from=$parent.children item=child}
                                                    <option value="{$child.id}">{$child.title}</option>
                                                {/foreach}
                                            </optgroup>  
                                        {/foreach}
                                    </select> 
                                </div>
                            </div>
                            <span class="error_page_content">
                                {form_error('ads_category_id')}  
                            </span>
                            <div class="uk-width-medium-1-1 uk-margin-top">
                                <label>نوع اگهی <span class="required">*</span></label>
                                <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                    <select name="type" id="ads_type" class="data-md-selectize" data-md-selectize-bottom="">
                                        <option value="0">رایگان</option>
                                        <option value="2">ویژه</option>
                                        <option value="3">ویترین</option>
                                    </select> 
                                </div>
                            </div>
                            <span class="error_page_content">
                                {form_error('type')}  
                            </span>
                            <div class="uk-width-medium-1-1">
                                <div class=" uk-margin-top">
                                    <label>قیمت </label>
                                    <input type="text" class="md-input {if form_error('price') != NULL}md-input-danger{/if}" name="price"  value="{set_value('price','')}"  />
                                </div>
                            </div>
                            <span class="error_page_content">
                                {form_error('price')}  
                            </span>
                            <div class="uk-width-medium-1-1 uk-margin-top">
                                <label>
                                    دوره نمایش <span class="required">*</span></label>
                                <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                    <select name="period_time" id="period_time_select" class="data-md-selectize" data-md-selectize-bottom="">
                                        <option value="1">یک ماهه</option>
                                        <option value="3">سه ماهه</option>
                                        <option value="6">شش ماهه</option>
                                        <option value="12">سالانه</option>
                                    </select>
                                </div>
                            </div>
                            <span class="error_page_content">
                                {form_error('period_time')}  
                            </span>
                            <div class="uk-width-medium-1-1">
                                <div class=" uk-margin-top">
                                    <label>شماره تماس</label>
                                    <input type="text" class="md-input {if form_error('tell') != NULL}md-input-danger{/if}" name="tell"  value="{set_value('tell','')}" />
                                </div>
                            </div>
                            <span class="error_page_content">
                                {form_error('tell')}  
                            </span>
                            <div class="uk-width-medium-1-1">
                                <div class=" uk-margin-top">
                                    <label>آدرس </label>
                                    <input type="text" class="md-input {if form_error('address') != NULL}md-input-danger{/if}" name="address"  value="{set_value('address','')}" />
                                </div>
                            </div>
                            <span class="error_page_content">
                                {form_error('address')}  
                            </span>
                            <div class="uk-width-medium-1-1 uk-margin-top">	
                                <label>شرح </label>	
                                <div class="checkout-form-list contact-form">
                                    <textarea cols="10" rows="4" name="desc" id="message" class="md-input ckeditor {if form_error('desc') != NULL}md-input-danger{/if}">{set_value('desc','')}</textarea>
                                </div>
                            </div>
                            <span class="error_page_content">
                                {form_error('desc')}  
                            </span>
                        </div>
                        <div class="uk-form-row">
                            <div class="uk-grid-width-xLarge-1-1">
                                <div class=" uk-margin-top">
                                    <label>
                                        <i class="fa fa-tags" aria-hidden="true"></i>
                                        کلمات کلیدی 
                                        <span style="color:red"> (کلمه های کلیدی را با  خط فاصله (-) جدا کنید. مثال: پیانو - خرید پیانو - پیانو آکوستیک)</span> 
                                    </label>
                                    <input type="text" class="md-input {if form_error('keywords') != NULL}md-input-danger{/if}" name="keywords"  value="{set_value('keywords','')}" />
                                </div>
                            </div>
                            <span class="error_page_content">
                                {form_error('keywords')}  
                            </span>
                            <div class="col-md-11 col-sm-12">
                                <div class=" uk-margin-top">

                                    <!-- First Avatar -->
                                    <div id="crop-adsPic-1" class="pull-right col-md-4">
                                        <div class="avatar-view" title="انتخاب تصویر آگهی">
                                            <img {if set_value('picHidden','') != ''}src="{site_url()|con:'upload/ads/pic/':set_value('picHidden')}"
                                                 {else}src="{assets_url}img/piano.png"{/if} >
                                            <input name="picHidden" type="hidden" id="picHidden1" value="{set_value('picHidden','')}">
                                            <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                            </div>
                                        </div>
                                    </div>
                                    <span class="error_page_content">
                                        {form_error('picHidden')}  
                                    </span>
                                    <!-- Second avatar -->
                                    <div id="crop-adsPic-2" class="pull-right col-md-4">
                                        <div class="avatar-view" title="انتخاب تصویر دوم آگهی">
                                            <img {if set_value('picHidden2','') != ''}src="{site_url()|con:'upload/ads/pic/':set_value('picHidden2')}"
                                                 {else}src="{assets_url}img/piano.png"{/if} >
                                            <input name="picHidden2" type="hidden" id="picHidden2" value="{set_value('picHidden2','')}">
                                            <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Third avatar -->
                                    <div id="crop-adsPic-3" class="pull-right col-md-4">
                                        <div class="avatar-view" title="انتخاب تصویر سوم آگهی">
                                            <img {if set_value('picHidden3','') != ''}src="{site_url()|con:'upload/ads/pic/':set_value('picHidden3')}"
                                                 {else}src="{assets_url}img/piano.png"{/if}>
                                            <input name="picHidden3" type="hidden"  id="picHidden3" value="{set_value('picHidden3','')}">
                                            <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>  

                        <div class="uk-margin-top">
                            <div class="uk-form-file">
                                <button class="md-btn md-btn-primary">ویدیو</button>
                                <input type="file" name="video" id="form-file">
                                فایل ویدیویی را انتخاب کنید
                            </div>
                        </div>
                        <span class="error_page_content">
                            {form_error('video')}  
                        </span>

                        <div class="uk-form-row uk-margin-top">
                            <div id="acoustic" class="col-md-12" style="display: none;">

                                <h3 style="margin-top:10px;">
                                    <i class="fa fa-info-circle" aria-hidden="true"></i>

                                    اطلاعات تکمیلی پیانو آکوستیک:
                                </h3>
                                <hr>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>برند</label>
                                        <input type="text" class="md-input"  name="ac_brand" value="{set_value('ac_brand','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>مدل</label>
                                        <input type="text" class="md-input" name="ac_model" value="{set_value('ac_model','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-1-1 uk-margin-top">
                                    <label>نوع پیانو</label>

                                    <div class="uk-width-medium-1-3 uk-width-large-1-2">
                                        <select name="ac_piano_type" id="ac_piano_type_select"   class="data-md-selectize" data-md-selectize-bottom="">
                                            <option value="گرند">گرند</option>
                                            <option value="دیواری">دیواری</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3  uk-margin-top" id="ac_piano_type_child">
                                    <div class=" uk-margin-top">
                                        <label>قطر</label>
                                        <input type="text" class="md-input" name="ac_diameter" value="{set_value('ad_diameter','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-1-1 uk-margin-top">
                                    <label>رنگ</label>
                                    <div class="uk-width-medium-1-3 uk-width-large-1-2">
                                        <select name="ac_color" class="data-md-selectize" data-md-selectize-bottom="">
                                            <option value="مشکی">مشکی</option>
                                            <option value="سفید">سفید</option>
                                            <option value="قهوه ای روشن">قهوه ای روشن</option>
                                            <option value="قهوه ای تیره">قهوه ای تیره</option>
                                            <option value="قهوه ای رزوود">قهوه ای رزوود</option>
                                            <option value="ماهاگونی روشن">ماهاگونی روشن</option>
                                            <option value="ماهاگونی تیره">ماهوگانی تیره</option>
                                            <option value="سایر">سایر</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>کشور سازنده</label>
                                        <input type="text" class="md-input" name="ac_creator_country" value="{set_value('ac_creator_country','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>تعداد پدال</label>
                                        <input type="text" class="md-input" name="ac_pedal_count" value="{set_value('ac_pedal_count','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>سال کارکرد</label>
                                        <input type="text" class="md-input" name="ac_years" value="{set_value('ac_years','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>نوع sound board</label>
                                        <input type="text" class="md-input" name="ac_sound_board" value="{set_value('ac_sound_board','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>نوع سیم</label>
                                        <input type="text" class="md-input" name="ac_wire" value="{set_value('ac_wire','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>نوع اکشن</label>
                                        <input type="text" class="md-input" name="ac_action" value="{set_value('ac_action','')}" />
                                    </div>
                                </div>
                            </div>
                            <div id="digital" class="col-md-12" style="display: none;">

                                <h3 style="margin-top:10px;">
                                    <i class="fa fa-info-circle" aria-hidden="true"></i>

                                    اطلاعات تکمیلی پیانو دیجیتال:
                                </h3>
                                <hr>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>برند</label>
                                        <input type="text" class="md-input" name="brand" value="{set_value('brand','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>مدل</label>
                                        <input type="text" class="md-input" name="model" value="{set_value('model','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3 uk-margin-top">
                                    <label>نوع پیانو</label>
                                    <div class="uk-width-medium-1-1 uk-margin-top">
                                        <select name="piano_type"  class="data-md-selectize" data-md-selectize-bottom="">
                                            <option value="گرند">گرند</option>
                                            <option value="دیواری">دیواری</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>رنگ</label>
                                        <input type="text" class="md-input"  name="color" value="{set_value('color','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>کشور سازنده</label>
                                        <input type="text" class="md-input" name="creator_country" value="{set_value('creator_country','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>سال ساخت</label>
                                        <input type="text" class="md-input"  name="years" value="{set_value('years','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>تعداد لایه های صدا</label>
                                        <input type="text" class="md-input" name="sound_layer_count" value="{set_value('sound_layer_count','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>تعداد بلندگو</label>
                                        <input type="text" class="md-input"  name="speaker_count" value="{set_value('speaker_count','')}" />
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>نوع اکشن</label>
                                        <input type="text" class="md-input"  name="action" value="{set_value('action','')}" />
                                    </div>
                                </div>
                            </div>
                            <input type="submit" name="submit_btn" class="btn readmore pull-left checkout-form-list" value="ثبت آگهی"/>
                        </div>  
                    </div>
                </div>
                {form_close()}
            </div>
        </div>
    </div>
</div>

<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-1" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'advertise/ads/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر اصلی آگهی</h4>
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
                                <label class="pull-right">پیش نمایش تصویر در لیست آگهی ها</label>
                                <div class="avatar-preview preview-lg"></div>
                                <div class="avatar-preview preview-md"></div>
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-90" title="Rotate -90 degrees">چرخش به چپ</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-15">-15درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-30">-30درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-45">-45درجه</button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="90" title="Rotate 90 degrees">چرخش به راست</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="15">15درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="30">30درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="45">45درجه</button>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn readmore btn-block avatar-save">ارسال</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div> -->
            </form>
        </div>
    </div>
</div>
<!-- /.modal -->

<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-2" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'advertise/ads/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر دوم آگهی</h4>
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
                                <label class="pull-right">پیش نمایش تصویر در لیست آگهی ها</label>
                                <div class="avatar-preview preview-lg"></div>
                                <div class="avatar-preview preview-md"></div>
                            </div>
                        </div>


                        <div class="row avatar-btns">
                            <div class="col-md-10">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-90" title="Rotate -90 degrees">چرخش به چپ</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-15">-15درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-30">-30درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-45">-45درجه</button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="90" title="Rotate 90 degrees">چرخش به راست</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="15">15درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="30">30درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="45">45درجه</button>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn readmore btn-block avatar-save">ارسال</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div> -->
            </form>
        </div>
    </div>
</div>
<!-- /.modal -->

<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-3" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'advertise/ads/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر سوم آگهی</h4>
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
                                <label class="pull-right">پیش نمایش تصویر در لیست آگهی ها</label>
                                <div class="avatar-preview preview-lg"></div>
                                <div class="avatar-preview preview-md"></div>
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-90" title="Rotate -90 degrees">چرخش به چپ</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-15">-15درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-30">-30درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-45">-45درجه</button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="90" title="Rotate 90 degrees">چرخش به راست</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="15">15درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="30">30درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="45">45درجه</button>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn readmore btn-block avatar-save">ارسال</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div> -->
            </form>
        </div>
    </div>
</div>
<!-- /.modal -->
