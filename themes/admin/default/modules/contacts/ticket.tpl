<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {$title}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="{$action}" id="form_validation" class="uk-form-stacked" enctype="multipart/form-data">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class="uk-margin-top">
                                    <label>عنوان پیام  <span class="text-danger"> *</span></label>
                                    <input type="text" maxlength="150" id="input_counter" class="{if  (NULL != form_error('subject'))}{' md-input-danger '}{/if}input-count md-input title" name="subject" value="{set_value('subject')}" >
                                    <div id="input_counter_counter" class="text-count-wrapper">
                                    </div><span class="md-input-bar"></span>
                                </div>
                                <span class="error_page_content">
                                    {form_error('subject')}  
                                </span>

                                <div class="uk-margin-top uk-width-medium-1-1">
                                    <h3 class="heading_c">متن پیام<span class="text-danger"> *</span></h3>
                                    <textarea type="text" class="ckeditor" name="content">{set_value('content')}</textarea>                                
                                    <div id="input_counter_counter" class="text-count-wrapper">
                                    </div><span class="md-input-bar"></span>
                                </div>
                                <span class="error_page_content">
                                    {form_error('content')}  
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="uk-width-medium-1-4">
                        {if isset($user_id)}
                            <input type="hidden" name="to" value="{$user_id}"/>
                        {/if}
                        <button  type="submit" class="md-btn md-btn-flat md-btn-success btn-list"><span>ارسال</span></button>
                        <a  href="{site_url()|con:ADMIN_PATH}" class="md-btn md-btn-flat md-btn-danger btn-list"><span>انصراف</span></a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>