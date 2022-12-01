<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        تنظیمات فیلد فیلتر
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked">

                    <div class="uk-margin-top uk-margin-bottom">
                        <label>مربوط به گروه کالایی</label>
                        <select name="product_type_id" class="data-md-tag-selectize" id='product_type_id' data-md-selectize-bottom>
                            <option value="">انتخاب گروه کالا</option>
                            {foreach $product_types as $val}
                                <option value="{$val.id}" {if isset($Filter->product_type_id) AND $Filter->product_type_id eq $val.id}selected=""{/if}>{$val.title}</option>
                            {/foreach}
                        </select>
                        <div id="input_counter_counter" class="text-count-wrapper">
                        </div><span class="md-input-bar"></span>
                    </div>
                    <span class="error_page_content">
                        {form_error('product_type_id')}  
                    </span>


                    <div class="uk-margin-top uk-margin-bottom">
                        <label>مربوط به دسته‌بندی</label>
                        <select name="product_category_id" class="data-md-tag-selectize" id='category_parents' data-md-selectize-bottom>
                            <option value="">انتخاب دسته‌بندی محصول</option>
                            {if isset($Filter)}
                                {foreach $Filter->product_type->categories()->where('parent_id',null)->get() as $cat}
                                    <option value="{$cat.id}" {if $cat.id eq $Filter->product_category_id}selected=""{/if}>{$cat.title}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                    <span class="error_page_content">
                        {form_error('product_category_id')}  
                    </span>


                    <div class="uk-margin-top uk-margin-bottom" {if !isset($Filter)}style='display:none;'{/if} id="child-cat-wrapper">
                        <label>مربوط به دسته‌بندی</label>
                        <select name="product_childCategory_id" class="data-md-tag-selectize" id='product_childCategory_id' data-md-selectize-bottom>
                            <option value="">انتخاب دسته‌بندی محصول</option>
                            {if isset($Filter)}
                                {foreach $Filter->parent_category->children as $cat}
                                    <option value="{$cat.id}" {if $cat.id eq $Filter->product_child_category_id}selected=""{/if}>{$cat.title}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                    <div class="uk-form-row" id="filter-type">
                        <p class="alert alert-block alert-info">
                            در صورت انتخاب لیست چندانتخابی، مقادیر در سایت به صورت چک باکس Combo قابل انتخاب و تیک خوردن هستند.
                            لیست تک انتخابی نیز یک لیست کشویی را در اختیار قرار می دهد.
                        </p>
                        <label>نوع فیلد*: </label>
                        <span class="icheck-inline">
                            <input type="radio" id="field_type0" name="field_type" value="1" data-md-icheck {if isset($Filter->field_type) AND $Filter->field_type eq 1}checked=""{/if}>
                            <label for="field_type0" class="inline-label">لیست چند انتخابی</label>
                        </span>
                        <span class="icheck-inline">
                            <input type="radio"  id="field_type1" name="field_type" value="2" data-md-icheck {if isset($Filter->field_type) AND $Filter->field_type eq 2}checked=""{/if}>
                            <label for="field_type1" class="inline-label">لیست تک انتخابی</label>
                        </span>
                        <span class="icheck-inline">
                            <input type="radio"  id="field_type2" name="field_type" value="3" data-md-icheck {if isset($Filter->field_type) AND $Filter->field_type eq 3}checked=""{/if}>
                            <label for="field_type2" class="inline-label">فیلد متنی</label>
                        </span>

                    </div>
                    <div class=" uk-margin-top">
                        <label>برچسب فیلتر* </label>
                        <input type="text" class="{if  (NULL != form_error('label'))}{' md-input-danger '}{/if}input-count md-input" name="label" value="{set_value('label', (isset($Filter->label)) ? $Filter->label : '')}" >
                    </div>
                    <span class="error_page_content">
                        {form_error('label')}  
                    </span>

                    <div class="uk-form-row">
                        <p class="alert alert-block alert-info">
                            نمایش در لیست کالاها و امکان فیلتر توسط کاربر
                        </p>
                        <label>نمایش در لیست کالا*: </label>
                        <span class="icheck-inline">
                            <input type="radio" id="show_filter1" name="show_filter" value="1" data-md-icheck {if !isset($Filter->show_filter) OR (isset($Filter->show_filter) AND $Filter->show_filter eq 1)}checked=""{/if}>
                            <label for="show_filter1" class="inline-label">بله</label>
                        </span>
                        <span class="icheck-inline">
                            <input type="radio"  id="show_filter0" name="show_filter" value="0" data-md-icheck {if isset($Filter->show_filter) AND $Filter->show_filter eq 0}checked=""{/if}>
                            <label for="show_filter0" class="inline-label">خیر</label>
                        </span>

                    </div>
                    <div class=" uk-margin-top">
                        <p class="alert alert-block alert-info">
                            نام لاتین برای استفاده در قالب سایت ذخیره می‌شود . توجه داشته باشید که تنها حروف لاتین مجاز است و به جای خط فاصله از خط زیر (_)  استفاده کنید.
                        </p>
                        <label>نام لاتین*(بدون فاصله و فقط حروف انگلیسی) </label>
                        <input type="text" class="{if  (NULL != form_error('input_name'))}{' md-input-danger '}{/if}input-count md-input" name="input_name" value="{set_value('input_name', (isset($Filter->name)) ? $Filter->name : '')}" >
                    </div>
                    <span class="error_page_content">
                        {form_error('input_name')}  
                    </span>



                    <div class="uk-margin-top" style="display: none;" id="filter_value_wrapper">
                        <label>مقادیر لیست*(با , جدا کنید یا دکمه Enter را بزنید)</label>
                        <p class="alert alert-block alert-info">
                            برای نمایش رنگ، از کد رنگ که با علامت شارپ (#) شروع می‌شود استفاده کنید.
                            مثال: <span style='float:left'>#8b5e9c</span>
                        </p>
                        <select name="values[]" class="data-md-tag-selectize" data-md-selectize-bottom multiple>
                            {if $Filter->values}
                                {foreach $Filter->values as $option}
                                    <option value="{$option.title}" selected="">
                                        {$option.title}
                                    </option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                    <span class="error_page_content">
                        {form_error('values')}  
                    </span>
                    <div class="uk-width-medium-1-4">
                        <button type="submit" class="md-btn md-btn-flat md-btn-success btn-list"><span>ذخیره</span></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>