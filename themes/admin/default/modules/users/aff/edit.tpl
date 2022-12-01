<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش کد پورسانت ' : 'افزودن کد پورسانت '}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">

                                <div class="uk-margin-top uk-margin-bottom">
                                    <label>کاربر لیدر</label>
                                    <select name="user_id" class="data-md-tag-selectize" data-md-selectize-bottom>
                                        <option value="">انتخاب کاربر</option>
                                        {foreach $leaders as $val}
                                            <option value="{$val.id}" {if isset($Aff->user_id) AND $Aff->user_id eq $val.id}selected=""{/if}>{$val.first_name} {$val.last_name}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <span class="error_page_content">
                                    {form_error('user_id')}  
                                </span>

                                <div class="uk-margin-top uk-margin-bottom">
                                    <label>مربوط به گروه کالایی</label>
                                    <select name="product_type_id" class="data-md-tag-selectize" data-md-selectize-bottom>
                                        <option value="">انتخاب گروه کالا</option>
                                        {foreach $product_types as $val}
                                            <option value="{$val.id}" {if isset($Aff->product_type_id) AND $Aff->product_type_id eq $val.id}selected=""{/if}>{$val.title}</option>
                                        {/foreach}
                                    </select>
                                </div>
                                <span class="error_page_content">
                                    {form_error('product_type_id')}  
                                </span>

                                <p class="alert alert-block alert-info">
                                    درصد پورسانت در بازه های قیمتی مختلف برای محصولات را انتخاب نمایید.
                                </p>
                                <div class=" uk-margin-top">
                                    <label>درصد (تا سقف {$ranges[0][1]} هزار تومان)</label>
                                    <input type="text" class="{if  (NULL != form_error('percentages[0]'))}{' md-input-danger '}{/if}input-count md-input" name="percentages[0]" value="{set_value('percentages[0]', (isset($Aff->id)) ? $percentages[0] : '')}" >
                                </div>
                                <span class="error_page_content">
                                    {form_error('percentages[0]')}  
                                </span>
                                <div class=" uk-margin-top">
                                    <label>درصد (از {$ranges[1][0]} تا {$ranges[1][1]} هزار تومان)</label>
                                    <input type="text" class="{if  (NULL != form_error('percentages[1]'))}{' md-input-danger '}{/if}input-count md-input" name="percentages[1]" value="{set_value('percentages[1]', (isset($Aff->id)) ? $percentages[1] : '')}" >
                                </div>
                                <span class="error_page_content">
                                    {form_error('percentages[1]')}  
                                </span>
                                <div class=" uk-margin-top">
                                    <label>درصد (از {$ranges[2][0]}هزار تومان به بالا)</label>
                                    <input type="text" class="{if  (NULL != form_error('percentages[2]'))}{' md-input-danger '}{/if}input-count md-input" name="percentages[2]" value="{set_value('percentages[2]', (isset($Aff->id)) ? $percentages[2] : '')}" >
                                </div>
                                <span class="error_page_content">
                                    {form_error('percentages[2]')}  
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