<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش مناسبت محصول ' : 'افزودن مناسبت محصول '}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked" enctype="multipart/form-data">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class=" uk-margin-top">
                                    <label>عنوان مناسبت </label>
                                    <input type="text" class="{if  (NULL != form_error('title'))}{' md-input-danger '}{/if}input-count md-input title" name="title" value="{set_value('title', (isset($Reason->title)) ? $Reason->title : '')}" >
                                </div>
                                <span class="error_page_content">
                                    {form_error('title')}  
                                </span>
                                <div class=" uk-margin-top">
                                    <label>آدرس لینک سئو</label>
                                    <input type="text" class="slug {if  (NULL != form_error('title'))}{' md-input-danger '}{/if}input-count md-input" name="slug" value="{set_value('slug', (isset($Reason->slug)) ? $Reason->slug : '')}" >
                                </div>
                                <span class="error_page_content">
                                    {form_error('slug')}  
                                </span>

                                <div class="uk-margin-top">
                                    {if isset($Reason->image) AND $Reason.image != ''}<img width="200"
                                                                                           src="{$products_thumbnail_dir}{$Reason.image}" />{/if}
                                    <div class="uk-form-file">
                                        <button class="md-btn md-btn-primary">انتخاب عکس</button>
                                        <input type="file" name="image" id="form-file">
                                        عکس را انتخاب کنید
                                    </div>
                                </div>
                                <span class="error_page_content">
                                    {form_error('image')}  
                                </span>

                                <div class="uk-margin-top">
                                    <label>دسته‌بندی مربوطه</label>
                                    <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                        <select class="data-md-selectize" data-md-selectize-bottom="" name="category_id[]" multiple="">
                                            <option value="">انتخاب دسته بندی</option>
                                            {foreach $cats as $val}
                                                <option value="{$val.id}" {if $edit_mode && $Reason->category->contains($val->id) == $val.id }selected{/if}>{$val.title}</option>
                                            {/foreach}
                                        </select>         
                                    </div>
                                </div>
                                <span class="error_page_content">
                                    {form_error('category_id')}  
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="uk-width-medium-1-4">
                        <button  type="submit" class="md-btn md-btn-flat md-btn-success btn-list"><span>ذخیره</span></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>