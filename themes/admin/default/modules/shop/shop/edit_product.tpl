
{add_css file='lib/cropper/cropper.min.css'}
{add_css file='lib/cropper/main.css'}
{add_js file='lib/cropper/cropper.min.js' part='footer'}
{add_js file='lib/cropper/main.js' part='footer'}
{add_js file='js/piano.js' part='footer'}

<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        ویرایش کالا 
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            {literal}
                <ul class="uk-tab" data-uk-tab="{connect:'#tabs_anim5', animation:'slide-right'}">
                    <li class="uk-active"><a href="#">اطلاعات کالا</a></li>
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
                                        <label>عنوان <span class="required">*</span></label>
                                        <input type="text" class="md-input" name="title" class="md-input" value="{set_value('title',  (isset($Product->title)) ? $Product.title : '')}"  />
                                    </div>

                                    <div class="uk-width-medium-1-1 uk-margin-top">
                                        <label>فیلتر <span class="required">*</span></label>
                                        <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                            <select name="product_category_id" id="category_parents"  class="data-md-selectize" data-md-selectize-bottom="">
                                                {foreach from=$ads_category item=parent}
                                                    <optgroup style="color:red" label="{$parent.title}">
                                                        {if !isset($parent.children[0]->id)}
                                                            <option value="{$parent.id}" {if $Product.category.id == $parent.id OR $f_level_c == $parent.id}selected{/if}>{$parent.title}</option>
                                                        {/if}
                                                        {foreach from=$parent.children item=child}
                                                            <option value="{$child.id}" {if $Product.category.id == $child.id OR $f_level_c == $child.id}selected{/if}>{$child.title}</option>
                                                        {/foreach}
                                                    </optgroup>  
                                                {/foreach}
                                            </select> 
                                        </div>
                                    </div>

                                    <div class="loadings"></div>
                                    <div class="uk-width-medium-1-1 uk-margin-top">
                                        <label>دسته بندی  <span class="required">*</span></label>
                                        <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                            <select name="product_category_child_id" id="category_grandson"  class="data-md-selectize" data-md-selectize-bottom="">
                                                <option value="">انتخاب دسته‌بندی مرتبط با فیلتر</option>
                                                {foreach $grandson_cats as $item}
                                                    <option value="{$item.id}" {if $Product.category.id == $item.id}selected{/if}>{$item.title}</option>
                                                {/foreach}
                                            </select> 
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1">
                                        <div class=" uk-margin-top">
                                            <label>قیمت جدید <span class="required">*</span></label>
                                            <input type="text" class="md-input" name="price"  value="{set_value('price', (isset($Product->price)) ? $Product.price : '')}" />
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1">
                                        <div class=" uk-margin-top">
                                            <label>قیمت قدیم </label>
                                            <input type="text" class="md-input" name="old_price"  value="{set_value('old_price', (isset($Product->old_price)) ? $Product.old_price : '')}" />
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1">
                                        <div class=" uk-margin-top">
                                            <label>موجودی <span class="required">*</span></label>
                                            <input type="text" class="md-input" name="stock"  value="{set_value('stock', (isset($Product->stock)) ? $Product.stock : '')}" />
                                        </div>
                                    </div>


                                    <div class="uk-margin-top">
                                        <h3 class="heading_c">فروش ویژه</h3>
                                        <div class="uk-grid" data-uk-grid-margin="">
                                            <span class="icheck-inline">
                                                <input type="radio" id="special_sell0" name="special_sell" value="0" data-md-icheck {if !(isset($Product->special_sell) AND $Product->special_sell==0)}{'checked'}{/if}>
                                                <label for="special_sell0" class="inline-label">خیر</label>
                                            </span>
                                            <span class="icheck-inline">
                                                <input type="radio" id="special_sell1" name="special_sell" value="1" data-md-icheck {if (isset($Product->special_sell) AND $Product->special_sell==1)}{'checked'}{/if}>
                                                <label for="special_sell1" class="inline-label">بله</label>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1 uk-margin-top">
                                        <label>شرح مختصر </label>
                                        <div class="checkout-form-list contact-form">		
                                            <textarea cols="10" rows="4" name="short_desc" id="message" class="md-input ckeditor">{set_value('short_desc',  (isset($Product->short_desc)) ? $Product.short_desc : '')}</textarea>
                                        </div>
                                    </div>
                                    <div class="uk-width-medium-1-1 uk-margin-top">
                                        <label>شرح کامل </label>	
                                        <div class="checkout-form-list contact-form">	
                                            <textarea cols="10" rows="4" name="desc" id="message" class="md-input ckeditor">{set_value('desc',  (isset($Product->desc)) ? $Product.desc : '')}</textarea>
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
                                            <input value="{foreach from=$Product.keywords item=key }{$key.keyword|replace:'-':' '} - {/foreach}"
                                                   type="text" class="md-input" name="keywords"/>
                                        </div>
                                    </div>
                                    <div class="col-md-11 col-sm-12">
                                        <div class=" uk-margin-top">
                                            <!-- First Avatar -->
                                            <div id="crop-adsPic-1" class="pull-right col-md-4">
                                                <div class="avatar-view" title="انتخاب تصویر کالا">
                                                    <img {if $Product.pic != ''}src="{$products_thumbnail_dir}{$Product.pic}"
                                                         {else}src="{assets_url}img/prd_icon.png"{/if} >
                                                    <input name="picHidden" type="hidden" id="picHidden1"
                                                           value="{set_value('picHidden',(isset($Product.pic)) ? $Product.pic : '')}">
                                                    <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Second Avatar -->
                                            <div id="crop-adsPic-2" class="pull-right col-md-4">
                                                <div class="avatar-view" title="انتخاب تصویر دوم کالا">
                                                    <img {if $Product.pic2 != ''}src="{site_url()|con:'upload/ads/pic/':$Product.pic2}"
                                                         {else}src="{assets_url}img/prd_icon.png"{/if} >
                                                    <input name="picHidden2" type="hidden" id="picHidden2" value="{set_value('picHidden2',(isset($Product.pic2)) ? $Product.pic2 : '')}">
                                                    <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Third Avatar -->
                                            <div id="crop-adsPic-3" class="pull-right col-md-4">
                                                <div class="avatar-view" title="انتخاب تصویر سوم کالا">
                                                    <img {if $Product.pic3 != ''}src="{site_url()|con:'upload/ads/pic/':$Product.pic3}"
                                                         {else}src="{assets_url}img/prd_icon.png"{/if} >
                                                    <input name="picHidden3" type="hidden" id="picHidden3" value="{set_value('picHidden3',(isset($Product.pic3)) ? $Product.pic3 : '')}">
                                                    <div class="loading" aria-label="Loading" role="img" tabindex="-1">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>  
                                <!-- Loading state -->
                                <div class="loading" aria-label="Loading" role="img" tabindex="-1"></div>
                                <div class="uk-form-row uk-margin-top">
                                    <input type="submit" name="submit_btn" class="btn readmore pull-left checkout-form-list" value="ویرایش آیتم"/>
                                </div>  
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="uk-width-1-1 ">
                        <div data-uk-grid-margin="" class="uk-grid">
                            {foreach from=$features item=val}
                                {foreach from=$val.products item=f}
                                    {if $f.id == $Product.id}
                                        {assign var="pfvalue" value=$f.pivot.valueable}
                                        {assign var="pfimg" value=$f.pivot.img}
                                    {else}
                                        {assign var="pfvalue" value=''}
                                    {/if}
                                {/foreach}
                                <div class="uk-width-medium-1-2">
                                    <div class="uk-form-row">
                                        <div class=" uk-margin-top">
                                            <label>{$val.title}</label>
                                            <input type="text" class="md-input" name="feature[{$val.id}]" class="md-input" value="{$pfvalue}" />
                                        </div>
                                    </div>
                                </div>

                                <div class="uk-margin-top">
                                    {if isset($pfimg)}<img width="200" src="{$products_thumbnail_dir}{$pfimg}" />{/if}
                                    <div class="uk-form-file">
                                        <button class="md-btn md-btn-primary">انتخاب عکس</button>
                                        <input type="file" name="featurephoto{$val.id}" id="form-file">
                                        عکس را انتخاب کنید
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </li>
            </ul>
            {form_close()}
        </div>
    </div>
</div>

<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-1" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'shop/products/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر اصلی کالا</h4>
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
                                <label class="pull-right">پیش نمایش تصویر در لیست کالا ها</label>
                                <div class="avatar-preview preview-lg"></div>
                                
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
            <form class="avatar-form" action="{site_url()|con:'shop/products/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر دوم کالا</h4>
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
                                <label class="pull-right">پیش نمایش تصویر در لیست کالا ها</label>
                                <div class="avatar-preview preview-lg"></div>
                                
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
            <form class="avatar-form" action="{site_url()|con:'shop/products/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر سوم کالا</h4>
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
                                <label class="pull-right">پیش نمایش تصویر در لیست کالا ها</label>
                                <div class="avatar-preview preview-lg"></div>
                                
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
