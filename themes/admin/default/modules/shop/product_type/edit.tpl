<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش گروه کالا ' : 'افزودن گروه کالا '}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked"
                      enctype="multipart/form-data">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class=" uk-margin-top">
                                    <label>عنوان گروه کالا </label>
                                    <input type="text"
                                           class="{if  (NULL != form_error('title'))}{' md-input-danger '}{/if}input-count md-input title"
                                           name="title"
                                           value="{set_value('title', (isset($Product_type->title)) ? $Product_type->title : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('title')}  
                                </span>
                                <div class=" uk-margin-top">
                                    <label>آدرس لینک سئو</label>
                                    <input type="text"
                                           class="slug {if  (NULL != form_error('title'))}{' md-input-danger '}{/if}input-count md-input"
                                           name="slug"
                                           value="{set_value('slug', (isset($Product_type->slug)) ? $Product_type->slug : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('slug')}  
                                </span>

                                <div class="uk-margin-top">
                                    {if isset($Product_type->image) AND $Product_type.image != ''}
                                        <img width="200"
                                             src="/upload/product-types/pic/{$Product_type.image}"/>
                                    {/if}
                                    <div class="uk-form-file">
                                        <button class="md-btn md-btn-primary">انتخاب تصویر</button>
                                        <input type="file" name="image" id="form-file">
                                        فایل تصویر را انتخاب کنید
                                    </div>
                                </div>

                                <div class=" uk-margin-top">
                                    <label>اولویت نمایش در منو </label>
                                    <input type="text"
                                           class="{if  (NULL != form_error('order_in_menu'))}md-input-danger{/if}
                                           input-count md-input"
                                           name="order_in_menu"
                                           value="{set_value('order_in_menu', (isset($Product_type->order_in_menu)) ? $Product_type->order_in_menu : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('order_in_menu')}
                                </span>

                                <div class=" uk-margin-top">
                                    <label>توضیحات </label>
                                    <input type="text"
                                           class="
{if  (NULL != form_error('descriptions'))}{' md-input-danger '}{/if}input-count md-input title"
                                           name="descriptions"
                                           value="{set_value('descriptions', (isset($Product_type->descriptions)) ? $Product_type->descriptions : '')}">
                                </div>
                                <span class="error_page_content">
                                    {form_error('descriptions')}
                                </span>

                                <div class=" uk-margin-top">
                                    <label>عدم نمایش در منوی اصلی</label>
                                    <span class="icheck-inline">
                                        <input type="radio" id="hidden_from_nav0" name="hidden_from_nav" value="0"
                                               data-md-icheck {if !isset($Product_type) OR (isset($Product_type) AND !$Product_type->hidden_from_nav)}{'checked'}{/if}>
                                        <label for="hidden_from_nav0" class="inline-label">خیر</label>
                                    </span>
                                    <span class="icheck-inline">
                                        <input type="radio" id="hidden_from_nav1" name="hidden_from_nav" value="1"
                                               data-md-icheck {if (isset($Product_type) AND $Product_type->hidden_from_nav==1)}{'checked'}{/if}>
                                        <label for="hidden_from_nav1" class="inline-label">بله</label>
                                    </span>
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
    </div>
</div>