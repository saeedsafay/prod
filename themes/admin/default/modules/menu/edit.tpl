<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش منو ' : 'افزودن منو '}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class=" uk-margin-top">
                                    <label>عنوان منو </label>
                                    <input type="text" maxlength="60" id="input_counter" class="{if  (NULL != form_error('title'))}{' md-input-danger '}{/if}input-count md-input" name="title" value="{set_value('title', (isset($Menu->title)) ? $Menu->title : '')}" >
                                    <div id="input_counter_counter" class="text-count-wrapper">
                                    </div><span class="md-input-bar"></span>
                                </div>
                                <span class="error_page_content">
                                    {form_error('title')}  
                                </span>

                                <div class="uk-margin-top">
                                    <label>آدرس لینک</label>
                                    <input type="text" maxlength="60" id="input_counter" class="input-count md-input{if (NULL != form_error('target'))}{' md-input-danger '}{/if}" name="target" value="{set_value('target', (isset($Menu->target)) ? $Menu->target : '')}">
                                    <div id="input_counter_counter" class="text-count-wrapper">
                                    </div><span class="md-input-bar"></span>
                                </div>
                                <span class="error_page_content">
                                    {form_error('target')}  
                                </span>

                                
                                <div class="uk-margin-top">
                                    <label>گروه منو</label>
                                    <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                        <select class="data-md-one-selectize" data-md-selectize-bottom="" name="group_id">
                                            <option value="">انتخاب گروه منو</option>
                                            {foreach from=$Menu_group item=val}
                                                <option value="{$val.id}" {if isset($Menu->id) AND $val.id eq $Menu->group_id}selected{/if}>{$val.name}</option>
                                            {/foreach}
                                        </select>         
                                    </div>
                                </div>
                                <span class="error_page_content">
                                    {form_error('group_id')}  
                                </span>
                                <div class="uk-margin-top">
                                    <label>منوی والد</label>
                                    <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                        <select class="data-md-one-selectize" data-md-selectize-bottom="" name="parent_id">
                                            <option value="">انتخاب والد</option>
                                            <option value="0" {if isset($Menu->id) AND 0 eq $Menu->parent_id}selected{/if}>منوی اصلی</option>
                                            {foreach from=$Menus item=val}
                                                <option value="{$val.id}" {if isset($Menu->id) AND $val.id eq $Menu->parent_id}selected{/if}>{$val.title}</option>
                                            {/foreach}
                                        </select>         
                                    </div>
                                </div>
                                <span class="error_page_content">
                                    {form_error('parent_id')}  
                                </span>

                                <div class=" uk-margin-top">
                                    <label>وزن(جهت ترتیب لینک ها، عدد کوچکتر = اولویت بیشتر)</label>
                                    <input type="text" class="input-count md-input{if  (NULL != form_error('weight'))}{' md-input-danger '}{/if}" name="weight" value="{set_value('weight', (isset($Menu->weight)) ? $Menu->weight: '')}">
                                   
                                    </div><span class="md-input-bar"></span>
                                </div>
                                <span class="error_page_content">
                                    {form_error('weight')}  
                                </span>

                                <div class=" uk-margin-top">
                                    <label>کلاس برای آیکون</label>
                                    <input type="text" maxlength="60" id="input_counter" class="input-count md-input{if  (NULL != form_error('icon'))}{' md-input-danger '}{/if}" name="icon" value="{set_value('icon', (isset($Menu->icon)) ? $Menu->icon : '')}">
                                    <div id="input_counter_counter" class="text-count-wrapper">
                                    </div><span class="md-input-bar"></span>
                                </div>
                                <span class="error_page_content">
                                    {form_error('icon')}  
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="uk-width-medium-1-4">
                        <button  type="submit" class="md-btn md-btn-flat md-btn-success btn-list"><span>ذخیره</span></button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>