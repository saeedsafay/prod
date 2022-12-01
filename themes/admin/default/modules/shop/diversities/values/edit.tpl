<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        ویرایش مقدار تنوع '{$value->parentDiversity->label}'
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked"
                      enctype="multipart/form-data">
                    <div class=" uk-margin-top">
                        <label>عنوان مقدار تنوع </label>
                        <input type="text"
                               class="{if  (NULL != form_error('title'))}{' md-input-danger '}{/if}md-input "
                               name="title"
                               value="{set_value('title', (isset($value->title)) ? $value->title : '')}">
                    </div>
                    <span class="error_page_content">
                                    {form_error('title')}
                                </span>

                    <div class="uk-margin-top">
                        {if isset($value->image) AND $value.image != ''}
                            <img width="200" src="/upload/variants/{$value.image}"/>
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
                    <div class="uk-width-1-2 uk-float-left">
                        <button type="submit" name="submit" class="md-btn md-btn-flat md-btn-success"><span>ذخیره</span>
                        </button>
                        <a class="md-btn md-btn-danger"
                           href="{site_url({ADMIN_PATH|con:"/shop/diversities/edit/{$value->parentDiversity->id}"})}">
                            بازگشت
                        </a>
                    </div>

                    <div class="uk-width-medium-2-4">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>