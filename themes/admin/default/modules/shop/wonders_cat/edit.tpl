<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش تخفیف ' : 'افزودن تخفیف '}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class=" uk-margin-top">
                                    <label>عنوان جشنواره، تخفیف گروهی، شگفت انگیز و ...</label>
                                    <input type="text" class="{if  (NULL != form_error('title'))}{' md-input-danger '}{/if}input-count md-input title" name="title" value="{set_value('title', (isset($Wonder_category->discount)) ? $Wonder_category->title : '')}" >
                                </div>
                                <span class="error_page_content">
                                    {form_error('title')}  
                                </span>


                                <div class=" uk-margin-top">
                                    <label>آدرس صفحه</label>
                                    <input type="text" class="{if  (NULL != form_error('slug'))}{' md-input-danger '}{/if} md-input slug" name="slug" value="{set_value('slug', (isset($Wonder_category->slug)) ? $Wonder_category->slug : '')}" >
                                </div>
                                <span class="error_page_content">
                                    {form_error('slug')}  
                                </span>
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