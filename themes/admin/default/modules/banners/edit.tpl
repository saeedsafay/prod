<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش تصویر ' : 'افزودن تصویر '}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked"
                      enctype="multipart/form-data">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class="uk-width-medium-1-1 uk-margin-top">
                                    <label>موقعیت بنر <span class="required">*</span></label>
                                    <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                        <select name="position" class="data-md-selectize" data-md-selectize-bottom="">
                                            <option value="">انتخاب موقعیت بنر</option>
                                            <option value="1"
                                                    {if isset($Banner) && $Banner->position eq 1}selected=""{/if}>بنر
                                                سرصفحه
                                            </option>
                                            <option value="2"
                                                    {if isset($Banner) && $Banner->position eq 2}selected="" {/if}>
                                                بنر ماگ صفحه اصلی
                                            </option>
                                            <option value="3"
                                                    {if isset($Banner) && $Banner->position eq 3}selected=""{/if}>
                                                بنر هودی صفحه اصلی
                                            </option>
                                            <option value="4"
                                                    {if isset($Banner) && $Banner->position eq 4}selected=""{/if}>بنر
                                                پازل صفحه اصلی
                                            </option>
                                        </select>
                                    </div>
                                </div>

                                <div class="uk-margin-top">
                                    فایل تصویر
                                    <div class="uk-form-file">
                                        <button class="md-btn md-btn-primary">انتخاب تصویر</button>
                                        <input type="file" name="image"
                                               id="form-file"> {if isset($Banner->image) AND $Banner.image != ''}<img
                                            src="{site_url|con:'upload/banners/':$Banner.image}" width='150'/>{/if}
                                    </div>
                                </div>
                                <span class="error_page_content">
                                    {form_error('image')}  
                                </span>

                                <div class="uk-width-medium-1-3">
                                    <div class="uk-width-large-1-1">
                                        <div class=" uk-margin-top">
                                            <label>مبدا شمارش معکوس (سیستم unix ) </label>
                                            <input type="text"
                                                   class="{if  (NULL != form_error('origin_time_counter'))}{' md-input-danger '}{/if} datepicker md-input"
                                                   name="origin_time_counter"
                                                   value="{set_value('origin_time_counter', (isset($Banner->origin_time_counter)) ? $Banner->origin_time_counter : '')}">
                                        </div>
                                        <span class="error_page_content">
                                            {form_error('origin_time_counter')}  
                                        </span>
                                    </div>

                                    <div class="uk-width-medium-1-1">
                                        <div class=" uk-margin-top">
                                            <label>فرمت انتخابی</label>
                                            <input type="text"
                                                   class="{if  (NULL != form_error('origin_time_counter'))}{' md-input-danger '}{/if} datepicker-alt md-input"
                                                   value="{set_value('origin_time_counter', (isset($Banner->origin_time_counter)) ? $Banner->origin_time_counter : '')}">
                                        </div>
                                    </div>

                                </div>

                                <div class=" uk-margin-top">
                                    <label>زمان شمارش معکوس به ثانیه </label>
                                    <input type="text"
                                           class="{if  (NULL != form_error('duration_time_counter'))}{' md-input-danger '}{/if}input-count md-input"
                                           name="duration_time_counter"
                                           value="{set_value('duration_time_counter', (isset($Banner->duration_time_counter)) ? $Banner->duration_time_counter : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('duration_time_counter')}  
                                </span>

                                <div class=" uk-margin-top">
                                    <label>عنوان تصویر </label>
                                    <input type="text"
                                           class="{if  (NULL != form_error('title'))}{' md-input-danger '}{/if}input-count md-input"
                                           name="title"
                                           value="{set_value('title', (isset($Banner->title)) ? $Banner->title : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('title')}  
                                </span>

                                <div class=" uk-margin-top">
                                    <label>پیوند بنر</label>
                                    <input type="text"
                                           class="{if  (NULL != form_error('link'))}{' md-input-danger '}{/if} md-input"
                                           name="target"
                                           value="{set_value('target', (isset($Banner->target)) ? $Banner->target : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('target')}  
                                </span>

                            </div>
                        </div>
                    </div>
                    <div class="uk-width-medium-1-4">
                        <button type="submit" class="md-btn md-btn-flat md-btn-success btn-list"><span>ذخیره</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>