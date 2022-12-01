<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش دسته بندی محصول ' : 'افزودن دسته بندی محصول '}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked"
                      enctype="multipart/form-data">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">

                            <div class="uk-margin-top uk-margin-bottom">
                                <label>مربوط به گروه کالایی</label>
                                <select name="product_type_id" class="data-md-tag-selectize" data-md-selectize-bottom>
                                    <option value="">انتخاب گروه کالا</option>
                                    {foreach $product_types as $val}
                                        <option value="{$val.id}"
                                                {if isset($Category) AND $Category->product_type_id eq $val.id
                                        || $set_product_type_id eq $val.id}
                                            selected=""
                                                {/if}>
                                            {$val.title}
                                        </option>
                                    {/foreach}
                                </select>
                            </div>
                            <span class="error_page_content">
                                {form_error('product_type_id')}  
                            </span>
                            <div class="uk-form-row">
                                <div class=" uk-margin-top">
                                    <label>عنوان دسته بندی محصول </label>
                                    <input type="text"
                                           class="{if  (NULL != form_error('title'))}{' md-input-danger '}{/if}input-count md-input title"
                                           name="title"
                                           value="{set_value('title', (isset($Category->title)) ? $Category->title : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('title')}  
                                </span>
                                <div class=" uk-margin-top">
                                    <label>آدرس لینک سئو</label>
                                    <input type="text"
                                           class="slug {if  (NULL != form_error('title'))}{' md-input-danger '}{/if}input-count md-input"
                                           name="slug"
                                           value="{set_value('slug', (isset($Category->slug)) ? $Category->slug : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('slug')}  
                                </span>

                                <div class="uk-margin-top">
                                    {if isset($Category->image) AND $Category.image != ''}
                                        <img width="200" src="/upload/products/pic/{$Category.image}"/>
                                    {/if}
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
                                    {if isset($Category->banner) AND $Category.banner != ''}
                                        <img width="200" src="/upload/categories/{$Category.banner}"/>
                                    {/if}
                                    <div class="uk-form-file">
                                        <button class="md-btn md-btn-primary">انتخاب بنر</button>
                                        <input type="file" name="banner" id="form-file">
                                        بنر را انتخاب کنید
                                    </div>
                                </div>
                                <span class="error_page_content">
                                    {form_error('banner')}
                                </span>
                                <div class="uk-margin-top">
                                    <label>دسته بندی والد</label>
                                    <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                        <select class="data-md-selectize" data-md-selectize-bottom="" name="parent_id">
                                            <option value="">انتخاب دسته</option>
                                            {foreach $categories as $val}
                                                <option value="{$val.id}"
                                                        {if $edit_mode && $Category->parent_id == $val.id
                                                        || $set_parent_id == $val.id}
                                                            selected
                                                        {/if}
                                                >
                                                    {$val.title}
                                                </option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <span class="error_page_content">
                                    {form_error('parent_id')}  
                                </span>

                                <div class=" uk-margin-top">
                                    <label>عنوان بنر و توضیحات</label>
                                    <input type="text"
                                           class="{if (NULL != form_error('banner_title'))}md-input-danger{/if}md-input"
                                           name="banner_title"
                                           value="{set_value('banner_title', (isset($Category->banner_title)) ? $Category->banner_title : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('banner_title')}
                                </span>

                                <div class=" uk-margin-top">
                                    <label>لینک بنر</label>
                                    <input type="text"
                                           class="{if (NULL != form_error('desc_uri'))}md-input-danger{/if}md-input"
                                           name="desc_uri"
                                           value="{set_value('desc_uri', (isset($Category->desc_uri)) ? $Category->desc_uri : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('desc_uri')}
                                </span>

                                <div class=" uk-margin-top">
                                    <label>توضیحات دسته بندی</label>
                                    <input type="text"
                                           class="{if (NULL != form_error('desc'))}md-input-danger{/if}md-input"
                                           name="desc"
                                           value="{set_value('desc', (isset($Category->desc)) ? $Category->desc : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('desc')}
                                </span>


                                <div class="  uk-margin-top">
                                    <h3 class="heading_a">قیمت گذاری محصولات این دسته بندی بعنوان پکیج</h3>
                                    <p class="uk-alert uk-alert-warning">با فعال کردن این گزینه، تمامی تنوع ها برای
                                        قیمت
                                        گذاری
                                        محصول، به صورت پکیج در نظر
                                        گرفته شده و
                                        در محاسبه مبلغ قابل پرداخت توسط مشتری، تنها قیمت واحد ملاک خواهد بود نه
                                        تعداد
                                        سفارش.
                                    </p>
                                    <span class="icheck-inline">
                                        <input type="radio" id="variants_as_package0" name="variants_as_package"
                                               value="0"
                                               data-md-icheck
                                               {if $edit_mode && $Category->variants_as_package == 0}checked=""{/if}>
                                        <label for="variants_as_package0" class="inline-label">خیر</label>
                                    </span>
                                    <span class="icheck-inline">
                                        <input type="radio" id="variants_as_package1" name="variants_as_package"
                                               value="1"
                                               data-md-icheck
                                               {if $edit_mode && $Category->variants_as_package == 1}checked=""{/if}>
                                        <label for="variants_as_package1" class="inline-label">بله</label>
                                    </span>
                                </div>
                                <div class="uk-margin-top">
                                    <h3 class="heading_a">دارای فرم اختصاصی سفارش آنلاین</h3>
                                    <p class="uk-alert uk-alert-warning">با فعال کردن این گزینه، فرم سفارش آنلاین در
                                        سایت برای این دسته بندی فعال می شود
                                    </p>
                                    <span class="icheck-inline">
                                        <input type="radio" id="has_order_form0" name="has_order_form" value="0"
                                               data-md-icheck
                                               {if $edit_mode && $Category->has_order_form == 0}checked=""{/if}>
                                        <label for="has_order_form0" class="inline-label">خیر</label>
                                    </span>
                                    <span class="icheck-inline">
                                        <input type="radio" id="has_order_form1" name="has_order_form"
                                               value="1"
                                               data-md-icheck
                                               {if $edit_mode && $Category->has_order_form == 1}checked=""{/if}>
                                        <label for="has_order_form1" class="inline-label">بله</label>
                                    </span>
                                </div>
                            </div>
                        </div>
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