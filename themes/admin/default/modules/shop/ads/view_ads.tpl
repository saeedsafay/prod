<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {$title}
    </h3>
    <div class="uk-width-medium-2-3 uk-margin-top uk-margin-bottom">
        <a href="{site_url|con:ADMIN_PATH:'/advertise/advertises'}" class="uk-button btn-breadcrumb">بازگشت</a>

        {if $Ads.status == 0 OR  $Ads.status == 3 OR $Ads.status == 2}
            <label class="uk-text-primary">
                <a class="md-btn md-btn-success md-btn-small" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/toggleStatus/' : $Ads->id})}">تایید و انتشار</a>
            </label>
        {/if}
        {if $Ads.status == 1}
            <label class="uk-text-primary">
                <a class="md-btn md-btn-flat-danger md-btn-small" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/toggleStatus/' : $Ads->id})}">رد کردن</a>
            </label>
        {/if}
        {if $Ads.status == 4}
            <label class="uk-text-primary">
                <a class="md-btn md-btn-flat-danger md-btn-small" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/toggleStatus/' : $Ads->id})}">عدم انتشار</a>
            </label>
        {/if}

        <label class="uk-text-primary">
            <a data-uk-tooltip title="نمایش بالاتر از سایر آگهی ها" class="md-btn md-btn-flat-success md-btn-small" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/update-position/' : $Ads->id})}">بالا اندازی آگهی</a>
        </label>

        <label class="uk-text-primary">
            <a data-uk-tooltip title="ویرایش اطلاعات آگهی" class="md-btn md-btn-flat-primary md-btn-small" href="{site_url({ADMIN_PATH|con:'/advertise/advertises/edit/' : $Ads->id})}">ویرایش آگهی</a>
        </label>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-overflow-container">
                <div class="uk-width-medium-1-1 uk-margin-top">
                    <p class="">
                        ارسال کننده: 
                        <label class="uk-text-primary"> 
                            <a href="{site_url({ADMIN_PATH|con:'/users/users/edit/':$Ads.user.id})}">{$Ads.user.first_name} {$Ads.user.last_name}</a>
                        </label>
                        | 
                        تاریخ ثبت:
                        <label class="uk-text-primary"> {jdate form='h:i a j F Y' date=$Ads.created_at}</label>

                    </p>

                    <p>{$Ads.desc}</p>
                    {if $Ads.pic != ''}
                        تصویر ضمیمه : <br>
                        <img width="350" src="{site_url|con:'upload/ads/pic/':$Ads.pic}" />
                        <br>
                    {/if}
                    {if $Ads.pic2 != ''}
                        تصویر ضمیمه دوم: <br>
                        <img width="350" src="{site_url|con:'upload/ads/pic/':$Ads.pic2}" />
                        <br>
                    {/if}
                    {if $Ads.pic3 != ''}
                        تصویر ضمیمه سوم: <br>
                        <img width="350" src="{site_url|con:'upload/ads/pic/':$Ads.pic3}" />
                        <br>
                    {/if}
                    {if $Ads.audio != '' }
                        فایل صوتی: <br>
                        <a href="{site_url|con:'upload/ads/audio/':$Ads.audio}" >دریافت</a>
                    {/if}

                </div>
            </div>
        </div>
    </div>
</div>