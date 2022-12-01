<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش کد تخفیف' : 'افزودن کد تخفیف'}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            {form_open(null)}
            {if !$edit_mode}
                <div class="uk-width-1-1 ">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-1-2">
                            <div class="uk-form-row">
                                <div class=" uk-margin-top">
                                    <label>کد تخفیف (برای تولید توسط سیستم، خالی بگذارید)</label>
                                    <input type="text" class="input-count md-input" name="code" value="{set_value
                                    ('code', '')}">
                                    <div class="text-count-wrapper">
                                    </div>
                                    <span class="md-input-bar"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}


            <div class="uk-width-1-1 ">
                <div data-uk-grid-margin="" class="uk-grid">
                    <div class="uk-width-medium-1-2">
                        <div class="uk-form-row">
                            <div class="uk-margin-top uk-margin-bottom">
                                <label>نوع اعتبارسنجی کوپن</label>
                                <select name="validity_type" class="data-md-tag-selectize" data-md-selectize-bottom>
                                    <option value="">انتخاب نوع اعتبارسنجی</option>
                                    <option value="1"
                                            {if isset($Coupon) AND $Coupon->validity_type eq 1}
                                        selected=""
                                            {/if}>معتبر در اولین خرید
                                    </option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <span class="error_page_content">
                    {form_error('validity_type')}
            </span>
            <div class="uk-width-1-1 ">
                <div data-uk-grid-margin="" class="uk-grid">
                    <div class="uk-width-medium-1-2">
                        <div class="uk-form-row">
                            <div class=" uk-margin-top">
                                <label>مبلغ تخفیف (درصد)</label>
                                <input type="text" class="input-count md-input" name="discount"
                                       value="{set_value('discount', (isset($Coupon->discount)) ? $Coupon->discount : '')}">
                                <div id="input_counter_counter" class="text-count-wrapper">
                                </div>
                                <span class="md-input-bar"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="uk-width-1-1 ">
                <div data-uk-grid-margin="" class="uk-grid">
                    <div class="uk-width-medium-1-2">
                        <div class="uk-form-row">
                            <div class=" uk-margin-top">
                                <label>تخفیف خرید تا سقف (ریال)</label>
                                <input type="text" class="input-count md-input" name="max_purchase_amount"
                                       value="{set_value('max_purchase_amount', (isset($Coupon->max_purchase_amount)) ? $Coupon->max_purchase_amount : '')}">
                                <span class="md-input-bar"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="uk-width-medium-1-4">
                <input name="submit_btn" type="submit" class="md-btn md-btn-flat md-btn-success btn-list"
                       value="{if $edit_mode}ویرایش{else}تولید کن !{/if}"/>
            </div>
            {form_close()}
        </div>
    </div>
</div>