<div id="page_content_inner">
    <h3 class="heading_a title-top uk-margin-small-bottom">
        {$title}
    </h3>
    <div class="uk-width-medium-2-3 uk-margin-top uk-margin-bottom">
        <a href="{site_url|con:ADMIN_PATH:'/shop/shop/orders'}" class="uk-button btn-breadcrumb">بازگشت</a>

        {*        {if $Cart.status != 0}*}
        {*            <label class="uk-text-primary">*}
        {*                <a class="md-btn md-btn-flat-success md-btn-small"*}
        {*                   href="{site_url({ADMIN_PATH|con:'/shop/shop/toggleStatus/' : $id : '/2'})}">ارسال شد</a>*}
        {*            </label>*}
        {*            <label class="uk-text-primary">*}
        {*                <a class="md-btn md-btn-flat-success md-btn-small"*}
        {*                   href="{site_url({ADMIN_PATH|con:'/shop/shop/toggleStatus/' : $id: '/3'})}">تحویل شد</a>*}
        {*            </label>*}
        {*        {/if}*}
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <div class="uk-overflow-container">
                <div data-uk-grid-margin="" class="uk-grid">
                    <div class="uk-width-1-1 uk-margin-top">
                        <p class="">
                            خریدار:
                            <label class="uk-text-primary">
                                <a href="{site_url({ADMIN_PATH|con:'/users/users/edit/':$buyer.id})}">{$buyer.first_name} {$buyer.last_name}</a>
                            </label>
                            |
                            شماره تماس خریدار:
                            <span class="uk-badge-success uk-badge"> {$buyer.mobile}</span>
                            | ایمیل خریدار
                            <label class="uk-text-primary"> {$buyer.email}</label>
                            |
                            تاریخ ثبت پرداخت
                            <label class="uk-text-primary"> {jdate form='h:i a j F Y' date=$Cart.pay_at}</label>

                        </p>
                        <span class="uk-badge uk-badge-success">
                        آدرس تحویل:
                    </span>

                        <p class="uk-alert uk-alert-large">
                            <b class="text">{$delivery->province->name}
                                {if isset($delivery->county)} - {$delivery->county->name}{/if}
                            </b>
                            |
                            <span>
                                {$delivery->delivery_address}. {if isset($delivery->postal_code)} کد پستی:
                                    ({$delivery->postal_code}){/if}
                            </span>
                        </p>
                    </div>
                    <div class="uk-width-1-1 uk-margin-top">
                        <h2 class="heading_a title-top uk-margin-small-bottom">
                            آیتم های سفارش:
                        </h2>
                    </div>
                    {foreach from=$Cart->varients item=order}
                        <div class="uk-width-2-3">
                            <img src="{$products_pic_dir}{$order->thumbnail}" width="150" alt="">
                            {if isset($order->pivot->files)}
                                <span class="uk-badge uk-badge-danger">طرح دلخواه</span>
                            {/if}
                            {$count = $order->fields->count() }
                            {$j = 1}
                            <b>
                                {$order.product.title} |
                                {foreach $order.fields as $v}
                                    {if $v.value.parentDiversity.deleted eq 1}{continue}{/if}
                                    {$v.value.title}
                                    {if $j != $count}|{/if} {$j = $j+1}
                                {/foreach}
                            </b>
                        </div>
                        <div class="uk-width-1-3">
                            <h2>
                                <label for="">تعداد:</label>
                                {$order->pivot->qty}
                            </h2>
                        </div>
                        {if $order->pivot->files != null && count(json_decode($order->pivot->files))}
                            <div class="uk-width-1-2 uk-margin-top">
                                {foreach json_decode($order->pivot->files) as $file}
                                    <h4>
                                        طرح چاپی خریدار
                                    </h4>
                                    <img width="150" src="/upload/orders/{$file}" alt="">
                                    <a class="md-btn md-btn-success" href="/upload/orders/{$file}"
                                       target="_blank">
                                        دانلود طرح
                                    </a>
                                {/foreach}
                            </div>
                            <div class="uk-width-1-2 uk-margin-top">
                                <h4 class="title mt-30 mb-30">توضیحات خریدار</h4>
                                <p class="uk-badge uk-badge-danger">{$order->pivot.printing_desc}</p>
                            </div>
                        {/if}
                        <hr>
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>