<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش ویژگی کالا' : 'افزودن ویژگی کالا'}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            {form_open(null)}
            <div class="uk-width-1-1 ">
                <div data-uk-grid-margin="" class="uk-grid">
                    <div class="uk-width-medium-1-2">
                        <div class="uk-form-row">
                            <div class=" uk-margin-top">
                                <label>عنوان</label>
                                <input type="text" class="input-count md-input" name="title" value="{set_value('title', (isset($Feature->title)) ? $Feature->title : '')}">
                                <div id="input_counter_counter" class="text-count-wrapper">
                                </div><span class="md-input-bar"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="uk-width-medium-1-4">
                <input name="submit_btn" type="submit" class="md-btn md-btn-flat md-btn-success btn-list" value="ثبت" />
            </div>
            {form_close()}
        </div>
    </div>
</div>