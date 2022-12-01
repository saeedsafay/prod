<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش تخفیف' : 'افزودن تخفیف گروهی'}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            {form_open(null)}
            <div class="uk-width-1-1 ">
                <div data-uk-grid-margin="" class="uk-grid">
                    <div class="uk-width-medium-1-2">
                        <div class="uk-form-row">
                            <div class=" uk-margin-top">
                                <label>درصد تخفیف </label>
                                <input type="text" class="input-count md-input" name="discount" value="{set_value('discount', (isset($Discount->discount)) ? $Discount->discount : '')}">
                                <div id="input_counter_counter" class="text-count-wrapper">
                                </div><span class="md-input-bar"></span>
                            </div>
                        </div>
                    </div>
                    <div class="uk-width-medium-1-2">
                        <div class="uk-form-row">
                            <div class=" uk-margin-top">
                                <label>تعداد روز تا انقضا</label>
                                <input type="text" class="input-count md-input" name="expire" value="{set_value('expire', (isset($Discount->expire)) ? $Discount->expire : '')}">
                                <div id="input_counter_counter" class="text-count-wrapper">
                                </div><span class="md-input-bar"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="uk-margin-top">
                <label>آدرس لینک سئو</label>
                <input type="text" class="{if isset($Discount->slug)}md-input-filled {/if}input-count md-input slug" name="slug" value="{set_value('slug', (isset($Discount->slug)) ? $Discount->slug : '')}">

            </div>
            <span class="error_page_content">
                {form_error('slug')}  
            </span>


            <div class="uk-margin-top">
                <h3 class="heading_c">محصولات شامل تخفیف</h3>
                <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                    <select class="data-md-closable-selectize" data-md-selectize-bottom="" name="products[]" multiple>
                        <option value="">انتخاب محصولات تخفیفی</option>
                        {foreach $products as $prd}
                            <option value="{$prd.id}"{if isset($Discount) && $Discount->products->contains($prd.id) } selected{/if}>{$prd.title}</option>
                        {/foreach}
                    </select>         
                </div>
            </div>
            <span class="error_page_content">
                {form_error('products[]')}  
            </span>

            <div class="uk-margin-top">
                <h3 class="heading_c">وضعیت</h3>
                <div class="uk-grid" data-uk-grid-margin="">
                    <span class="icheck-inline">
                        <input type="radio" id="status1" name="status" value="1" data-md-icheck {if !(isset($Discount->status) AND $Discount->status==0)}{'checked'}{/if}>
                        <label for="status1" class="inline-label">فعال</label>
                    </span>
                    <span class="icheck-inline">
                        <input type="radio" id="status0" name="status" value="0" data-md-icheck {if (isset($Discount->status) AND $Discount->status==0)}{'checked'}{/if}>
                        <label for="status0" class="inline-label">غیرفعال</label>
                    </span>
                </div>
            </div>
            <div class="uk-width-medium-1-4">
                <input name="submit_btn" type="submit" class="md-btn md-btn-flat md-btn-success btn-list" 
                       value="ثبت" />
            </div>
            {form_close()}
        </div>
    </div>
</div>