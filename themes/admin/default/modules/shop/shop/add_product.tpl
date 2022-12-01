{add_css file='lib/cropper/cropper.min.css'}
{add_css file='lib/cropper/main.css'}
{add_js file='lib/cropper/cropper.min.js' part='footer'}
{add_js file='lib/cropper/main.js' part='footer'}
{add_js file='js/piano.js' part='footer'}

<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        افزودن محصول جدید در فروشگاه
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            {literal}
                <ul class="uk-tab" data-uk-tab="{connect:'#tabs_anim5', animation:'slide-right'}">
                    <li class="uk-active"><a href="#">اطلاعات محصول</a></li>
                    <li><a href="#">ویژگی های اضافی</a></li>
                </ul>
            {/literal}
            {form_open_multipart($action,$attr)}
            <ul id="tabs_anim5" class="uk-switcher uk-margin">
                <li>
                    <div class="uk-width-1-1 ">
                        <div data-uk-grid-margin="" class="uk-grid">
                            <div class="uk-width-medium-1-1">
                                <div class="uk-form-row">
                                    <div class=" uk-margin-top">
                                        <label>عنوان محصول <span class="required">*</span></label>
                                        <input type="text" class="md-input" name="title" class="md-input"
                                               value="{set_value('title','')}"/>
                                    </div>
                                    <div class="uk-width-medium-1-1 uk-margin-top">
                                        <label>فیلتر <span class="required">*</span></label>
                                        <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                            <select name="product_category_id" id="category_parents"
                                                    class="data-md-selectize" data-md-selectize-bottom="">
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
                                    <div class="loadings"></div>
                                    <div class="uk-width-medium-1-1 uk-margin-top">
                                        <label>دسته بندی <span class="required">*</span></label>
                                        <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                            <select name="product_category_child_id" id="category_grandson"
                                                    class="data-md-selectize" data-md-selectize-bottom="">
                                                <option value="">انتخاب دسته‌بندی مرتبط با فیلتر</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1">
                                        <div class=" uk-margin-top">
                                            <label>قیمت جدید <span class="required">*</span></label>
                                            <input type="text" class="md-input" name="price" {set_value('price','')} />
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1">
                                        <div class=" uk-margin-top">
                                            <label>قیمت قدیم </label>
                                            <input type="text" class="md-input"
                                                   name="old_price" {set_value('old_price','')}/>
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1">
                                        <div class=" uk-margin-top">
                                            <label>قیمت عمده‌فروشی </label>
                                            <input type="text" class="md-input"
                                                   name="wholesale_price" {set_value('wholesale_price','')}/>
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1">
                                        <div class=" uk-margin-top">
                                            <label> موجودی محصول <span class="required">*</span></label>
                                            <input type="text" class="md-input" name="stock" {set_value('stock','')} />
                                        </div>
                                    </div>

                                    <div class="uk-margin-top">
                                        <h3 class="heading_c">فروش ویژه</h3>
                                        <div class="uk-grid" data-uk-grid-margin="">
                                            <span class="icheck-inline">
                                                <input type="radio" id="special_sell0" name="special_sell" value="0"
                                                       data-md-icheck>
                                                <label for="special_sell0" class="inline-label">خیر</label>
                                            </span>
                                            <span class="icheck-inline">
                                                <input type="radio" id="special_sell1" name="special_sell" value="1"
                                                       data-md-icheck>
                                                <label for="special_sell1" class="inline-label">بله</label>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1 uk-margin-top">
                                        <label>شرح مختصر </label>
                                        <div class="checkout-form-list contact-form">
                                            <textarea cols="10" rows="4" name="short_desc" id="message"
                                                      class="md-input ckeditor">{set_value('short_desc','')}</textarea>
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1 uk-margin-top">
                                        <label>شرح کامل </label>
                                        <div class="checkout-form-list contact-form">
                                            <textarea cols="10" rows="4" name="desc" id="message"
                                                      class="md-input ckeditor">{set_value('desc','')}</textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="uk-form-row">
                                    <div class="uk-grid-width-xLarge-1-1">
                                        <div class=" uk-margin-top">
                                            <label>
                                                <i class="fa fa-tags" aria-hidden="true"></i>
                                                کلمات کلیدی
                                                <span style="color:red"> (کلمه های کلیدی را با  خط فاصله (-) جدا کنید. مثال: موبایل - خرید اینترنتی موبایل - خرید گوشی )</span>
                                            </label>
                                            <input type="text" class="md-input"
                                                   name="keywords" {set_value('keywords','')} />
                                        </div>
                                    </div>
                                    <div class="col-md-11 col-sm-12">
                                        <div class=" uk-margin-top">
                                            <!-- First Avatar -->
                                            <div id="crop-adsPic-1" class="pull-right col-md-4">
                                                <div class="avatar-view" title="انتخاب تصویر محصول">
                                                    <img {if set_value('picHidden','') != ''}src="{site_url()|con:'upload/ads/pic/':set_value('picHidden')}"
                                                         {else}src="{assets_url}img/prd_icon.png"{/if} >
                                                    <input name="picHidden" type="hidden" id="picHidden1"
                                                           value="{set_value('picHidden','')}">
                                                    <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Second avatar -->
                                            <div id="crop-adsPic-2" class="pull-right col-md-4">
                                                <div class="avatar-view" title="انتخاب تصویر دوم محصول">
                                                    <img {if set_value('picHidden2','') != ''}src="{site_url()|con:'upload/ads/pic/':set_value('picHidden2')}"
                                                         {else}src="{assets_url}img/prd_icon.png"{/if} >
                                                    <input name="picHidden2" type="hidden" id="picHidden2"
                                                           value="{set_value('picHidden2','')}">
                                                    <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- Third avatar -->
                                            <div id="crop-adsPic-3" class="pull-right col-md-4">
                                                <div class="avatar-view" title="انتخاب تصویر سوم محصول">
                                                    <img {if set_value('picHidden3','') != ''}src="{site_url()|con:'upload/ads/pic/':set_value('picHidden3')}"
                                                         {else}src="{assets_url}img/prd_icon.png"{/if}>
                                                    <input name="picHidden3" type="hidden" id="picHidden3"
                                                           value="{set_value('picHidden3','')}">
                                                    <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="submit" name="submit_btn"
                                                   class="btn btn-success readmore pull-left checkout-form-list"
                                                   value="ثبت"/>
                                        </div>
                                    </div>
                                </div>

                                <!-- Loading state -->
                                <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="uk-width-1-1 ">
                        <div data-uk-grid-margin="" class="uk-grid">
                            {if 0}
                                {foreach from=$features item=val}
                                    <div class="uk-width-medium-1-2">
                                        <div class="uk-form-row">
                                            <div class=" uk-margin-top">
                                                <label>{$val.title}</label>
                                                <input type="text" class="md-input" name="feature[{$val.id}]"
                                                       class="md-input"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="uk-margin-top">
                                        <div class="uk-form-file">
                                            <button class="md-btn md-btn-primary">انتخاب عکس</button>
                                            <input type="file" name="featurephoto{$val.id}" id="form-file">
                                            عکس را انتخاب کنید
                                        </div>
                                    </div>
                                {/foreach}
                            {/if}
                        </div>
                    </div>
                </li>
            </ul>
            {form_close()}
        </div>
    </div>
</div>

<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-1" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog"
     tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'shop/products/crop'}" enctype="multipart/form-data"
                  method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر اصلی محصول</h4>
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
                                <label class="pull-right">پیش نمایش تصویر در لیست محصولها</label>
                                <div class="avatar-preview preview-lg"></div>
                                <div class="avatar-preview preview-md"></div>
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-90"
                                            title="Rotate -90 degrees">چرخش به چپ
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate"
                                            data-option="-15">-15درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate"
                                            data-option="-30">-30درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate"
                                            data-option="-45">-45درجه
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="90"
                                            title="Rotate 90 degrees">چرخش به راست
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="15">
                                        15درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="30">
                                        30درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="45">
                                        45درجه
                                    </button>
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
<div class="modal fade" id="avatar-modal-2" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog"
     tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'shop/products/crop'}" enctype="multipart/form-data"
                  method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر دوم محصول</h4>
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
                                <label class="pull-right">پیش نمایش تصویر در لیست محصول ها</label>
                                <div class="avatar-preview preview-lg"></div>
                                <div class="avatar-preview preview-md"></div>
                            </div>
                        </div>


                        <div class="row avatar-btns">
                            <div class="col-md-10">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-90"
                                            title="Rotate -90 degrees">چرخش به چپ
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate"
                                            data-option="-15">-15درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate"
                                            data-option="-30">-30درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate"
                                            data-option="-45">-45درجه
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="90"
                                            title="Rotate 90 degrees">چرخش به راست
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="15">
                                        15درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="30">
                                        30درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="45">
                                        45درجه
                                    </button>
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
<div class="modal fade" id="avatar-modal-3" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog"
     tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'shop/products/crop'}" enctype="multipart/form-data"
                  method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر سوم محصول</h4>
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
                                <label class="pull-right">پیش نمایش تصویر در لیست محصول ها</label>
                                <div class="avatar-preview preview-lg"></div>
                                <div class="avatar-preview preview-md"></div>
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-90"
                                            title="Rotate -90 degrees">چرخش به چپ
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate"
                                            data-option="-15">-15درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate"
                                            data-option="-30">-30درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate"
                                            data-option="-45">-45درجه
                                    </button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="90"
                                            title="Rotate 90 degrees">چرخش به راست
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="15">
                                        15درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="30">
                                        30درجه
                                    </button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="45">
                                        45درجه
                                    </button>
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
