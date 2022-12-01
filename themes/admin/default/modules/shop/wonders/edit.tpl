<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش تخفیف شگفت انگیز ' : 'افزودن تخفیف شگفت انگیز '}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">

                                <div class="uk-margin-top uk-margin-bottom">
                                    <label>دسته تخفیف</label>
                                    <select name="wonder_category_id" class="data-md-tag-selectize" data-md-selectize-bottom>
                                        <option value="">انتخاب دسته تخفیف</option>
                                        {foreach $cats as $cat}
                                            <option value="{$cat.id}" {if isset($Wonder) AND $Wonder->wonder_category_id eq $cat.id}selected=""{/if}>{$cat.title}</option>
                                        {/foreach}
                                    </select>
                                    <div id="input_counter_counter" class="text-count-wrapper">
                                    </div><span class="md-input-bar"></span>
                                </div>
                                <span class="error_page_content">
                                    {form_error('product_id')}  
                                </span>
                                <div class="uk-margin-top uk-margin-bottom">
                                    <label>مربوط به محصول (فقط تاییدشده ها)</label>
                                    <select name="product_id" class="data-md-tag-selectize" data-md-selectize-bottom>
                                        <option value="">انتخاب محصول</option>
                                        {foreach $products as $val}
                                            <option value="{$val.id}" {if isset($Wonder) AND $Wonder->product_id eq $val.id}selected=""{/if}>کد {$val.id} - {$val.title}</option>
                                        {/foreach}
                                    </select>
                                    <div id="input_counter_counter" class="text-count-wrapper">
                                    </div><span class="md-input-bar"></span>
                                </div>
                                <span class="error_page_content">
                                    {form_error('product_id')}  
                                </span>


                                <div class="uk-width-medium-1-3">
                                    <div class="uk-width-large-1-1">
                                        <div class=" uk-margin-top">
                                            <label>مبدا شمارش معکوس (سیستم unix ) </label>
                                            <input type="text" class="{if  (NULL != form_error('origin_time_counter'))}{' md-input-danger '}{/if} datepicker md-input" name="origin_time_counter" value="{set_value('origin_time_counter', (isset($Wonder->origin_time_counter)) ? {jdate format="Y-m-d H:i:s" date=date($Wonder->origin_time_counter)} : '')}" >
                                        </div>
                                        <span class="error_page_content">
                                            {form_error('origin_time_counter')}  
                                        </span>
                                    </div>

                                    <div class="uk-width-medium-1-1">
                                        <div class=" uk-margin-top">
                                            <label>فرمت انتخابی</label>
                                            <input type="text" class="{if  (NULL != form_error('origin_time_counter'))}{' md-input-danger '}{/if} datepicker-alt md-input" value="{set_value('origin_time_counter', (isset($Wonder->origin_time_counter)) ? {jdate format="Y-m-d H:i:s" date=date($Wonder->origin_time_counter)} : '')}" >
                                        </div>
                                    </div>

                                </div>

                                <div class=" uk-margin-top">
                                    <label>عنوان پانویس</label>
                                    <input type="text" class="{if  (NULL != form_error('short_title'))}{' md-input-danger '}{/if}input-count md-input title" name="short_title" value="{set_value('short_title', (isset($Wonder->short_title)) ? $Wonder->short_title : '')}" >
                                </div>
                                <span class="error_page_content">
                                    {form_error('short_title')}  
                                </span>
                                <div class=" uk-margin-top">
                                    <label>درصد تخفیف</label>
                                    <input type="text" class="{if  (NULL != form_error('discount'))}{' md-input-danger '}{/if}input-count md-input title" name="discount" value="{set_value('discount', (isset($Wonder->discount)) ? $Wonder->discount : '')}" >
                                </div>
                                <span class="error_page_content">
                                    {form_error('discount')}  
                                </span>
                                <div class=" uk-margin-top">
                                    <label>مدت اعتبار تخفیف (بر حسب ساعت)</label>
                                    <input type="text" class="{if  (NULL != form_error('expire_hour'))}{' md-input-danger '}{/if}input-count md-input" name="expire_hour" value="{set_value('expire_hour', (isset($Wonder->expire_hour)) ? $Wonder->expire_hour : '')}" >
                                </div>
                                <span class="error_page_content">
                                    {form_error('expire_hour')}  
                                </span>


                                <div class="uk-form-row">
                                    <label>وضعیت: </label>
                                    <span class="icheck-inline">
                                        <input type="radio" id="status0" name="status" value="1" data-md-icheck {if isset($Wonder->status) AND $Wonder->status eq 1}checked=""{/if}>
                                        <label for="status0" class="inline-label">فعال برای فروش</label>
                                    </span>
                                    <span class="icheck-inline">
                                        <input type="radio"  id="status1" name="status" value="0" data-md-icheck {if isset($Wonder->status) AND $Wonder->status eq 2}checked=""{/if}>
                                        <label for="status1" class="inline-label">غیر فعال</label>
                                    </span>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="uk-width-medium-1-4">
                        <button  type="submit" class="md-btn md-btn-flat md-btn-success btn-list"><span>ثبت</span></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>