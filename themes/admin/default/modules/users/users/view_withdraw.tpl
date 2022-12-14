<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {$title}
    </h3>
    <div class="uk-width-medium-2-3 uk-margin-top uk-margin-bottom">
        <a href="{site_url|con:ADMIN_PATH:'/users/users/withdraw'}" class="uk-button btn-breadcrumb">بازگشت</a>
        <a href="{site_url|con:ADMIN_PATH:'/users/users/withdraw-status/':$Row.id}" class="uk-button btn-{if $Row.status eq 1}danger{else}success{/if}">ثبت بعنوان {$status_label}</a>
        {if $Row.status eq 0}
            <a href="{site_url|con:ADMIN_PATH:'/users/users/withdraw-status-q/':$Row.id:'/2'}" class="uk-button btn-primary">در صف پرداخت </a>
            <a href="{site_url|con:ADMIN_PATH:'/users/users/withdraw-status-q/':$Row.id:'/3'}" class="uk-button btn-danger">رد درخواست</a>
        {/if}
    </div>

    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-overflow-container">
                <div class="uk-width-medium-1-1 uk-margin-top">
                    <p class="">
                        تاریخ ثبت
                        <label class="uk-text-primary"> {jdate form='h:i a j F Y' date=$Row.created_at}</label>
                    <hr>
                    <p>

                    <h3>
                        <i class="uk-icon-chevron-left uk-icon-small .uk-icon-justify uk-text-success"></i> اطلاعات درخواست:
                    </h3>
                    <table class="uk-table uk-table-hover">
                        <tbody>
                            <tr>
                                <td>وضعیت</td>
                                <td>   {if $Row->status eq 0}
                                                                    پرداخت نشده/درحال بررسی
                                                                {else if $Row->status eq -1}
                                                                    درخواست رد شده است
                                                                {else if $Row->status eq 1}
                                                                    پرداخت شده
                                                                {else if $Row->status eq 2}
                                                                    بررسی شده، در انتظار پرداخت
                                                                {else if $Row->status eq 3}
                                                                    ردشده (عدم رعایت قوانین)
                                                                {/if}</td>
                            </tr>
                            <tr>
                                <td>مبلغ درخواستی‌</td>
                                <td>{$Row.amount|price_format}</td>
                            </tr>
                            <tr>
                                <td>نام صاحب حساب‌</td>
                                <td>{$Row.account_holder}</td>
                            </tr>
                            <tr>
                                <td>نام کاربر</td>
                                <td>{$Row.user.first_name} {$Row.user.last_name}</td>
                            </tr>
                            <tr>
                                <td>نام بانک</td>
                                <td>{$Row.bank_name}</td>
                            </tr>
                            <tr>
                                <td>شماره حساب</td>
                                <td>{$Row.account_number}</td>
                            </tr>
                            <tr>
                                <td>شماره کارت</td>
                                <td>{$Row.card_no}</td>
                            </tr>
                            <tr>
                                <td>شماره شبا</td>
                                <td>{$Row.sheba}</td>
                            </tr>
                            <tr>
                                <td>شماره حساب وب مانی</td>
                                <td>{$Row.webmoney}</td>
                            </tr>
                        </tbody>
                    </table>

                    <hr>
                </div>
            </div>
        </div>
    </div>
</div>