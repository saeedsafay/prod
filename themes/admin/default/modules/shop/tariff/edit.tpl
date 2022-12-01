<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {($edit_mode) ? 'ویرایش تعرفه آگهی ' : 'افزودن تعرفه آگهی '}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked">
                    <div data-uk-grid-margin="" class="uk-grid">
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">

                                <div class="uk-margin-top">
                                    <label>دوره نمایش</label>
                                    <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                        <select class="data-md-one-selectize" data-md-selectize-bottom="" name="time_period">
                                            <option value="">انتخاب دوره نمایش</option>
                                            <option value="1" {if isset($Ads_tariff->id) AND $Ads_tariff.time_period eq 1}selected{/if}>یک ماهه</option>
                                            <option value="3" {if isset($Ads_tariff->id) AND $Ads_tariff.time_period eq 3}selected{/if}>سه ماهه</option>
                                            <option value="6" {if isset($Ads_tariff->id) AND $Ads_tariff.time_period eq 6}selected{/if}>شش ماهه</option>
                                            <option value="12" {if isset($Ads_tariff->id) AND $Ads_tariff.time_period eq 12}selected{/if}>سالانه</option>
                                        </select>         
                                    </div>
                                </div>
                                <span class="error_page_content">
                                    {form_error('time_period')}  
                                </span>

                                <div class=" uk-margin-top">
                                    <label>میزان تعرفه به ريال </label>
                                    <input type="text" maxlength="60" id="input_counter" class="{if  (NULL != form_error('price'))}{' md-input-danger '}{/if}input-count md-input" name="price" value="{set_value('price', (isset($Ads_tariff->price)) ? $Ads_tariff->price : '')}" >
                                    <div id="input_counter_counter" class="text-count-wrapper">
                                    </div><span class="md-input-bar"></span>
                                </div>
                                <span class="error_page_content">
                                    {form_error('price')}  
                                </span>


                                <div class="uk-margin-top">
                                    <label>نوع آگهی</label>
                                    <div class="uk-width-medium-1-1" data-uk-grid-margin="">
                                        <select class="data-md-one-selectize" data-md-selectize-bottom="" name="ads_type">
                                            <option value="">انتخاب نوع آگهی </option>

                                            <option value="2" {if isset($Ads_tariff->id) AND $Ads_tariff.ads_type eq 2}selected{/if}>ویژه</option>
                                            <option value="3" {if isset($Ads_tariff->id) AND $Ads_tariff.ads_type eq 3}selected{/if}>ویترین</option>
                                        </select>         
                                    </div>
                                </div>
                                <span class="error_page_content">
                                    {form_error('time_period')}  
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