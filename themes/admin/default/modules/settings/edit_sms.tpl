<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {$title}
    </h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-width-1-1 ">
                <form method="POST" action="" id="form_validation" class="uk-form-stacked">

                    <div data-uk-grid-margin="" class="uk-grid">
                        <p>
                            در متن پیامک می‌توانید از برچسب‌های زیر استفاده نمایید:<br>
                            [title] : عنوان مناسبت<br>
                            [user_name] : نام کاربر
                        </p>
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class="uk-margin-top uk-width-medium-1-1">
                                    <h3 class="heading_c">متن پیامک تولد </h3>
                                    <textarea type="text" cols="100" rows="5" name="birthday">{set_value('birthday', (isset($birthday)) ? $birthday : '')}</textarea>
                                </div>
                                <span class="error_page_content">
                                    {form_error('birthday')}  
                                </span>
                            </div>
                        </div>
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class="uk-margin-top uk-width-medium-1-1">
                                    <h3 class="heading_c">متن پیامک ماهگرد </h3>
                                    <textarea type="text" cols="100" rows="5" name="monthly">{set_value('monthly', (isset($monthly)) ? $monthly : '')}</textarea>
                                </div>
                                <span class="error_page_content">
                                    {form_error('monthly')}  
                                </span>
                            </div>
                        </div>
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class="uk-margin-top uk-width-medium-1-1">
                                    <h3 class="heading_c">متن پیامک سالگرد ازدواج </h3>
                                    <textarea type="text" cols="100" rows="5" name="marriage">{set_value('marriage', (isset($marriage)) ? $marriage : '')}</textarea>
                                </div>
                                <span class="error_page_content">
                                    {form_error('marriage')}  
                                </span>
                            </div>
                        </div>
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class="uk-margin-top uk-width-medium-1-1">
                                    <h3 class="heading_c">متن پیامک آشنایی </h3>
                                    <textarea type="text" cols="100" rows="5" name="dating">{set_value('dating', (isset($dating)) ? $dating : '')}</textarea>
                                </div>
                                <span class="error_page_content">
                                    {form_error('dating')}  
                                </span>
                            </div>
                        </div>
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class="uk-margin-top uk-width-medium-1-1">
                                    <h3 class="heading_c">متن پیامک ترحیم و تسلیت </h3>
                                    <textarea type="text" cols="100" rows="5" name="death">{set_value('death', (isset($death)) ? $death : '')}</textarea>
                                </div>
                                <span class="error_page_content">
                                    {form_error('death')}  
                                </span>
                            </div>
                        </div>
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class="uk-margin-top uk-width-medium-1-1">
                                    <h3 class="heading_c">متن پیامک مراسمات و افتتاحیه </h3>
                                    <textarea type="text" cols="100" rows="5" name="anniversary">{set_value('anniversary', (isset($anniversary)) ? $anniversary : '')}</textarea>
                                </div>
                                <span class="error_page_content">
                                    {form_error('anniversary')}  
                                </span>
                            </div>
                        </div>
                        <div class="uk-width-medium-2-3">
                            <div class="uk-form-row">
                                <div class="uk-margin-top uk-width-medium-1-1">
                                    <h3 class="heading_c">متن پیامک دریافت اپلیکیشن در صفحه اصلی </h3>
                                    <textarea type="text" cols="100" rows="5" name="app">{set_value('app', (isset($app)) ? $app : '')}</textarea>
                                </div>
                                <span class="error_page_content">
                                    {form_error('app')}  
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