
{add_css file='lib/cropper/cropper.min.css'}
{add_css file='lib/cropper/main.css'}
{add_js file='lib/cropper/cropper.min.js' part='footer'}
{add_js file='lib/cropper/main.js' part='footer'}
{add_js file='js/piano.js' part='footer'}

<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        ویرایش آیتم 
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
                                            <option value="{$val.id}"  {if $val.id == $Ads.user_id}selected{/if}>{$val.first_name} {$val.last_name} ({$val.email})</option>
                                        {/foreach}
                                    </select> 
                                </div>
                            </div>
                            <div class=" uk-margin-top">
                                <label>عنوان <span class="required">*</span></label>										
                                <input type="text" class="md-input" name="title" class="md-input" value="{set_value('title',  (isset($Ads->title)) ? $Ads.title : '')}"  />
                            </div>
                            <div class="uk-width-medium-1-1 uk-margin-top">
                                <label>دسته بندی  <span class="required">*</span></label>
                                <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                    <select name="ads_category_id" id="category_piano"  class="data-md-selectize" data-md-selectize-bottom="">
                                        {foreach from=$ads_category item=parent}
                                            <optgroup style="color:red" label="{$parent.title}">
                                                {if !isset($parent.children[0]->id)}
                                                    <option value="{$parent.id}" {if $Ads.category.id == $parent.id}selected{/if}>{$parent.title}</option>
                                                {/if}
                                                {foreach from=$parent.children item=child}
                                                    <option value="{$child.id}" {if $Ads.category.id == $child.id}selected{/if}>{$child.title}</option>
                                                {/foreach}
                                            </optgroup>  
                                        {/foreach}
                                    </select> 
                                </div>
                            </div>
                            {if !$is_shop}
                                <div class="uk-width-medium-1-1 uk-margin-top">
                                    <label>نوع اگهی <span class="required">*</span></label>
                                    <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                        <select name="type" id="ads_type" class="data-md-selectize" data-md-selectize-bottom="">
                                            <option value="0" {if $Ads.type == 0}selected{/if}>رایگان</option>
                                            <option value="2" {if $Ads.type == 2}selected{/if}>ویژه</option>
                                            <option value="3" {if $Ads.type == 3}selected{/if}>ویترین</option>
                                        </select> 
                                    </div>
                                </div>
                            {/if}
                            <div class="uk-width-medium-1-1">
                                <div class=" uk-margin-top">
                                    <label>قیمت </label>
                                    <input type="text" class="md-input" name="price"  value="{set_value('price', (isset($Ads->price)) ? $Ads.price : '')}" />
                                </div>
                            </div>
                            <div class="uk-width-medium-1-1 uk-margin-top">
                                <label>
                                    دوره نمایش <span class="required">*</span></label>
                                <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                    <select name="period_time" id="period_time_select" class="data-md-selectize" data-md-selectize-bottom="">
                                        <option value="1" {if $Ads.period_time == 1}selected{/if}>یک ماهه</option>
                                        <option value="3" {if $Ads.period_time == 3}selected{/if}>سه ماهه</option>
                                        <option value="6" {if $Ads.period_time == 6}selected{/if}>شش ماهه</option>
                                        <option value="12" {if $Ads.period_time == 12}selected{/if}>سالانه</option>
                                    </select>
                                </div>
                            </div>
                            <div class="uk-width-medium-1-1">
                                <div class=" uk-margin-top">
                                    <label>شماره تماس</label>
                                    <input type="text" class="md-input" name="tell" value="{set_value('tell',  (isset($Ads->tell)) ? $Ads.tell : '')}"/>
                                </div>
                            </div>
                            <div class="uk-width-medium-1-1">
                                <div class=" uk-margin-top">
                                    <label>آدرس </label>
                                    <input type="text" class="md-input" name="address" value="{set_value('address',  (isset($Ads->address)) ? $Ads.address : '')}" />
                                </div>
                            </div>

                            {if $is_shop}
                                <div class="uk-width-medium-1-1 uk-margin-top">
                                    <label>شرح مختصر </label>
                                    <div class="checkout-form-list contact-form">		
                                        <textarea cols="10" rows="4" name="short_desc" id="message" class="md-input ckeditor">{set_value('short_desc',  (isset($Ads->short_desc)) ? $Ads.short_desc : '')}</textarea>
                                    </div>
                                </div>
                            {/if}
                            <div class="uk-width-medium-1-1 uk-margin-top">
                                <label>شرح کامل </label>	
                                <div class="checkout-form-list contact-form">	
                                    <textarea cols="10" rows="4" name="desc" id="message" class="md-input ckeditor">{set_value('desc',  (isset($Ads->desc)) ? $Ads.desc : '')}</textarea>
                                </div>
                            </div>
                        </div>
                        <div class="uk-form-row">
                            <div class="uk-grid-width-xLarge-1-1">
                                <div class=" uk-margin-top">
                                    <label>
                                        <i class="fa fa-tags" aria-hidden="true"></i>
                                        کلمات کلیدی 
                                        <span style="color:red"> (کلمه های کلیدی را با  خط فاصله (-) جدا کنید. مثال: پیانو - خرید پیانو - پیانو آکوستیک)</span> 
                                    </label>
                                    <input value="{foreach from=$Ads.keywords item=key }{$key.keyword|replace:'-':' '} - {/foreach}" type="text" class="md-input" name="keywords" />
                                </div>
                            </div>
                            <div class="col-md-11 col-sm-12">
                                <div class=" uk-margin-top">
                                    <!-- First Avatar -->
                                    <div id="crop-adsPic-1" class="pull-right col-md-4">
                                        <div class="avatar-view" title="انتخاب تصویر آگهی">
                                            <img {if $Ads.pic != ''}src="{site_url()|con:'upload/ads/pic/':$Ads.pic}"
                                                 {else}src="{assets_url}img/piano.png"{/if} >
                                            <input name="picHidden" type="hidden" id="picHidden1" value="{set_value('picHidden',(isset($Ads.pic)) ? $Ads.pic : '')}">
                                            <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Second Avatar -->
                                    <div id="crop-adsPic-2" class="pull-right col-md-4">
                                        <div class="avatar-view" title="انتخاب تصویر دوم آگهی">
                                            <img {if $Ads.pic2 != ''}src="{site_url()|con:'upload/ads/pic/':$Ads.pic2}"
                                                 {else}src="{assets_url}img/piano.png"{/if} >
                                            <input name="picHidden2" type="hidden" id="picHidden2" value="{set_value('picHidden2',(isset($Ads.pic2)) ? $Ads.pic2 : '')}">
                                            <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Third Avatar -->
                                    <div id="crop-adsPic-3" class="pull-right col-md-4">
                                        <div class="avatar-view" title="انتخاب تصویر سوم آگهی">
                                            <img {if $Ads.pic3 != ''}src="{site_url()|con:'upload/ads/pic/':$Ads.pic3}"
                                                 {else}src="{assets_url}img/piano.png"{/if} >
                                            <input name="picHidden3" type="hidden" id="picHidden3" value="{set_value('picHidden3',(isset($Ads.pic3)) ? $Ads.pic3 : '')}">
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
                        <!-- Loading state -->
                        <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
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
                                        <input type="text" class="md-input"  name="ac_brand" value="{set_value('ac_brand',   (isset($Ads->fields->brand)) ? $Ads->fields->brand : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>مدل</label>
                                        <input type="text" class="md-input" name="ac_model" value="{set_value('ac_model',  (isset($Ads->fields->model)) ? $Ads->fields->model : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-1-1 uk-margin-top">
                                    <label>نوع پیانو</label>

                                    <div class="uk-width-medium-1-3 uk-width-large-1-2">
                                        <select name="ac_piano_type" id="ac_piano_type_select"   class="data-md-selectize" data-md-selectize-bottom="">
                                            <option value="گرند" {if $Ads.fields.piano_type == "گرند"}selected{/if}>گرند</option>
                                            <option value="دیواری" {if $Ads.fields.piano_type == "دیواری"}selected{/if}>دیواری</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3  uk-margin-top" id="ac_piano_type_child">
                                    <div class=" uk-margin-top">
                                        <label>قطر</label>
                                        <input type="text" class="md-input" name="ac_diameter" value="{set_value('ac_diameter',   (isset($Ads->fields->diameter)) ? $Ads->fields->diameter : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-1-1 uk-margin-top">
                                    <label>رنگ</label>
                                    <div class="uk-width-medium-1-3 uk-width-large-1-2">
                                        <select name="ac_color" class="data-md-selectize" data-md-selectize-bottom="">
                                            <option value="مشکی" {if $Ads.fields.color == "مشکی"}selected{/if}>مشکی</option>
                                            <option value="سفید" {if $Ads.fields.color == "سفید"}selected{/if}>سفید</option>
                                            <option value="قهواه ای روشن" {if $Ads.fields.color == "قهواه ای روشن"}selected{/if}>قهوه ای</option>
                                            <option value="قهواه ای تیره" {if $Ads.fields.color == "قهواه ای تیره"}selected{/if}>قهوه ای</option>
                                            <option value="قهواه ای رزوود" {if $Ads.fields.color == "قهواه ای رزوود"}selected{/if}>قهوه ای</option>
                                            <option value="ماهاگونی روشن" {if $Ads.fields.color == "ماهاگونی روشن"}selected{/if}>ماهوگانی</option>
                                            <option value="ماهاگونی تیره" {if $Ads.fields.color == "ماهاگونی تیره"}selected{/if}>ماهوگانی</option>
                                            <option value="سایر" {if $Ads.fields.color == "سایر"}selected{/if}>سایر</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>کشور سازنده</label>
                                        <input type="text" class="md-input" name="ac_creator_country" value="{set_value('ac_creator_country',   (isset($Ads->fields->creator_country)) ? $Ads->fields->creator_country : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>تعداد پدال</label>
                                        <input type="text" class="md-input" name="ac_pedal_count" value="{set_value('ac_pedal_count',   (isset($Ads->fields->pedal_count)) ? $Ads->fields->pedal_count : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>سال کارکرد</label>
                                        <input type="text" class="md-input" name="ac_years" value="{set_value('ac_years',   (isset($Ads->fields->years)) ? $Ads->fields->years : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>نوع sound board</label>
                                        <input type="text" class="md-input" name="ac_sound_board" value="{set_value('ac_sound_board',   (isset($Ads->fields->sound_board)) ? $Ads->fields->sound_board : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>نوع سیم</label>
                                        <input type="text" class="md-input" name="ac_wire" value="{set_value('ac_wire',  (isset($Ads->fields->wire)) ? $Ads->fields->wire : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>نوع اکشن</label>
                                        <input type="text" class="md-input" name="ac_action" value="{set_value('ac_action',   (isset($Ads->fields->action)) ? $Ads->fields->action : '')}"/>
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
                                        <input type="text" class="md-input" name="brand" value="{set_value('brand',   (isset($Ads->fields->brand)) ? $Ads->fields->brand : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>مدل</label>
                                        <input type="text" class="md-input" name="model" value="{set_value('model',  (isset($Ads->fields->model)) ? $Ads->fields->model : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3 uk-margin-top">
                                    <label>نوع پیانو</label>
                                    <div class="uk-width-medium-1-1 uk-margin-top">
                                        <select name="piano_type"  class="data-md-selectize" data-md-selectize-bottom="">
                                            <option value="گرند" {if $Ads.fields.piano_type == "گرند"}selected{/if}>گرند</option>
                                            <option value="دیواری" {if $Ads.fields.piano_type == "دیواری"}selected{/if}>دیواری</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>رنگ</label>
                                        <input type="text"  name="color"  class="md-input" value="{set_value('color', (isset($Ads->fields->color)) ? $Ads->fields->color : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>کشور سازنده</label>
                                        <input type="text" class="md-input" name="creator_country" value="{set_value('creator_country', (isset($Ads->fields->creator_country)) ? $Ads->fields->creator_country : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>سال ساخت</label>
                                        <input type="text" class="md-input"  name="years" value="{set_value('years',    (isset($Ads->fields->years)) ? $Ads->fields->years : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>تعداد لایه های صدا</label>
                                        <input type="text" class="md-input" name="sound_layer_count" value="{set_value('sound_layer_count',  (isset($Ads->fields->sound_layer_count)) ? $Ads->fields->sound_layer_count : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>تعداد بلندگو</label>
                                        <input type="text" class="md-input"  name="speaker_count" value="{set_value('speaker_count',   (isset($Ads->fields->speaker_count)) ? $Ads->fields->speaker_count : '')}"/>
                                    </div>
                                </div>
                                <div class="uk-width-medium-2-3">
                                    <div class=" uk-margin-top">
                                        <label>نوع اکشن</label>
                                        <input type="text" class="md-input"  name="action" value="{set_value('action', (isset($Ads->fields->action)) ? $Ads->fields->action : '')}"/>
                                    </div>
                                </div>
                            </div>
                            <input type="submit" name="submit_btn" class="btn readmore pull-left checkout-form-list" value="ویرایش آیتم"/>
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
