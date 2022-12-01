<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        تنظیمات فیلد تنوع محصولات
    </h3>
    {if isset($Diversity->id)}
        <div class="md-card">
            <div class="md-card-content">
                <div class="uk-width-medium-1-6 uk-margin-small-bottom">
                    <a class="md-btn md-btn-primary md-btn-small"
                       href="{site_url({ADMIN_PATH|con:"/shop/diversities/values/{$Diversity->id}"})}">
                        مدیریت مقدارها
                    </a>
                </div>
            </div>
        </div>
    {/if}
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked">

                    <div class="uk-margin-top uk-margin-bottom">
                        <label>مربوط به گروه کالایی</label>
                        <select name="product_type_id" class="data-md-tag-selectize" id='product_type_id'
                                data-md-selectize-bottom>
                            <option value="">انتخاب گروه کالا</option>
                            {foreach $product_types as $val}
                                <option value="{$val.id}"
                                        {if isset($Diversity->product_type_id) AND $Diversity->product_type_id eq $val.id}selected=""{/if}>{$val.title}</option>
                            {/foreach}
                        </select>
                        <div id="input_counter_counter" class="text-count-wrapper">
                        </div>
                        <span class="md-input-bar"></span>
                    </div>
                    <span class="error_page_content">
                        {form_error('product_type_id')}  
                    </span>


                    <div class="uk-margin-top uk-margin-bottom">
                        <label>مربوط به دسته‌بندی</label>
                        <select name="product_category_id" class="data-md-tag-selectize" id='category_parents'
                                data-md-selectize-bottom>
                            <option value="">انتخاب دسته‌بندی محصول</option>
                            {if isset($Diversity)}
                                {foreach $Diversity->product_type->categories()->where('parent_id',null)->get() as $cat}
                                    <option value="{$cat.id}"
                                            {if $cat.id eq $Diversity->product_category_id}selected=""{/if}>{$cat.title}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                    <span class="error_page_content">
                        {form_error('product_category_id')}  
                    </span>


                    <div class="uk-margin-top uk-margin-bottom" {if !isset($Diversity)}style='display:none;'{/if}
                         id="child-cat-wrapper">
                        <label>مربوط به دسته‌بندی</label>
                        <select name="product_childCategory_id" class="data-md-tag-selectize"
                                id='product_childCategory_id' data-md-selectize-bottom>
                            <option value="">انتخاب دسته‌بندی محصول</option>
                            {if isset($Diversity)}
                                {foreach $Diversity->parent_category->children as $cat}
                                    <option value="{$cat.id}"
                                            {if $cat.id eq $Diversity->product_child_category_id}selected=""{/if}>{$cat.title}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>

                    <div class="uk-margin-top uk-margin-bottom" id="diversity-type-wrapper">
                        <label>نوع مولفه</label>
                        <select name="diversity_type" class="data-md-tag-selectize"
                                id='product_diversity_type' data-md-selectize-bottom>
                            <option value="">انتخاب نوع مولفه تنوع</option>
                            <option value="1" {if isset($Diversity) && $Diversity->diversity_type == 1}selected=""{/if}>
                                سایز

                            </option>
                            <option value="2" {if isset($Diversity) && $Diversity->diversity_type ==
                            2}selected=""{/if}>انواع
                                دیگر خدمات
                            </option>
                            <option value="3" {if isset($Diversity) && $Diversity->diversity_type == 3}selected=""{/if}>
                                تعداد
                            </option>
                        </select>
                    </div>
                    <div class=" uk-margin-top">
                        <p class="alert alert-block alert-info">
                            برای ترتیب بندی فیلدها استفاده می شود. فیلد با عدد اولویت بزرگتر، ترتیب بالاتری برای نمایش
                            دارد.
                        </p>
                        <label>اولویت نمایش(عددی بزرگتر از صفر) </label>
                        <input type="text"
                               class="{if  (NULL != form_error('input_name'))}{' md-input-danger '}{/if}input-count md-input"
                               name="priority"
                               value="{set_value('priority', (isset($Diversity->priority)) ? $Diversity->priority : '')}">
                    </div>
                    <span class="error_page_content">
                        {form_error('priority')}
                    </span>

                    <div class=" uk-margin-top">
                        <label>برچسب تنوع محصول* </label>
                        <input type="text"
                               class="{if  (NULL != form_error('label'))}{' md-input-danger '}{/if}input-count md-input"
                               name="label"
                               value="{set_value('label', (isset($Diversity->label)) ? $Diversity->label : '')}">
                    </div>
                    <span class="error_page_content">
                        {form_error('label')}  
                    </span>

                    <div class=" uk-margin-top">
                        <p class="alert alert-block alert-info">
                            نام لاتین برای استفاده در قالب سایت ذخیره می‌شود . توجه داشته باشید که تنها حروف لاتین مجاز
                            است و به جای خط فاصله از خط زیر (_) استفاده کنید.
                        </p>
                        <label>نام لاتین*(بدون فاصله و فقط حروف انگلیسی) </label>
                        <input type="text"
                               class="{if  (NULL != form_error('input_name'))}{' md-input-danger '}{/if}input-count md-input"
                               name="input_name"
                               value="{set_value('input_name', (isset($Diversity->name)) ? $Diversity->name : '')}">
                    </div>
                    <span class="error_page_content">
                        {form_error('input_name')}  
                    </span>

                    <div class="uk-margin-top" id="filter_value_wrapper">
                        <label>مقادیر لیست*(با , جدا کنید یا دکمه Enter را بزنید)</label>
                        <p class="alert alert-block alert-info">
                            برای نمایش رنگ، از کد رنگ که با علامت شارپ (#) شروع می‌شود استفاده کنید.
                            مثال: <span style='float:left'>#8b5e9c</span>
                        </p>
                        <select name="values[]" class="data-md-tag-selectize" data-md-selectize-bottom multiple>
                            {if $Diversity->values}
                                {foreach $Diversity->values as $option}
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
                        <button type="submit" class="md-btn md-btn-flat md-btn-success btn-list"><span>ذخیره</span>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>