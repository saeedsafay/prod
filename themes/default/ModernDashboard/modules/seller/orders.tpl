<div class="page-wrapper">
    <!-- ============================================================== -->
    <!-- Container fluid  -->
    <!-- ============================================================== -->
    <div class="container-fluid">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="row page-titles">
            <div class="col-md-5 align-self-center">
                <h4 class="text-themecolor">{$title}</h4>
            </div>
            <div class="col-md-7 align-self-center text-right">
                <div class="d-flex justify-content-end align-items-center">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="{site_url}dashboard">داشبورد</a></li>
                        <li class="breadcrumb-item active">{$title}</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->


        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                    </div>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Start Page Content -->
        <!-- ============================================================== -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            {if $Items->isEmpty()}
                                <div class="col-md-12">
                                    <div class="entry-header">
                                        <label class="text-warning pull-right rtl">سفارشی موجود نیست.</label>
                                        <br>
                                    </div>
                                </div>
                            {else}
                                <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 table-responsive">
                                    <table class="table table-hover table-striped table-bordered table-condensed"
                                           dir="rtl">
                                        <thead>
                                        <tr>
                                            <th>ردیف</th>
                                            <th>تصویر</th>
                                            <th>عنوان</th>
                                            <th>شناسه محصول</th>
                                            <th>شناسه تنوع</th>
                                            <th>شناسه فروشنده</th>
                                            <th>تعداد سفارش</th>
                                            <th>جزئیات</th>
                                        </tr>
                                        </thead>
                                        {$row = 1}
                                        {foreach from=$Items item=order}
                                            <tr>
                                                <td>{$row|persian_number}</td>
                                                <td>
                                                    <img src="{$products_pic_dir}{$order.diversity.thumbnail}"
                                                         alt="{$order.product.title}" style="max-height: 100px;"/>
                                                </td>
                                                <td>
                                                    {$count = $order->diversity->fields->count() }
                                                    {$j = 1}
                                                    {$order.product.title} |
                                                    {foreach $order.diversity.fields as $v}
                                                        {if $v.value.parentDiversity.deleted eq 1}{continue}{/if}
                                                        {$v.value.title}
                                                        {if $j != $count}|{/if} {$j = $j+1}
                                                    {/foreach}
                                                    {if $order->files != "" && count($order->files)}
                                                        <a href="#" data-toggle="modal"
                                                           data-target="#order-details-{$order.id}"
                                                           class="btn">
                                                            <strong class="badge badge-danger">طرح دلخواه</strong>
                                                        </a>
                                                    {/if}
                                                </td>
                                                <td>
                                                    <a href="{$order->product->link}"
                                                       target="_blank">
                                                        {$order.product_id}
                                                    </a>
                                                </td>
                                                <td>
                                                    {$order.diversity.id}
                                                </td>
                                                <td>
                                                    {$order.diversity.seller_id}
                                                </td>
                                                <td>
                                                    {$order.qty|persian_number}
                                                </td>
                                                <td>
                                                    <a href="#" data-toggle="modal"
                                                       data-target="#order-details-{$order.id}"
                                                       class="btn btn-secondary btn-sm">...</a>
                                                </td>
                                            </tr>
                                            {$row = $row + 1}
                                        {/foreach}
                                    </table>
                                </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- End PAge Content -->
        <!-- ============================================================== -->  </div>
    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->
</div>

{$row = 1}
{foreach from=$Items item=order}
    <div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
         id="order-details-{$order.id}" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">

                    <img src="{$products_pic_dir}{$order.diversity.thumbnail}" alt="{$order.product.title}"
                         style="max-height: 100px;"/>

                    <h4 class="modal-title" id="myLargeModalLabel">
                        {$count = $order->diversity->fields->count() }
                        {$j = 1}
                        {$order.product.title} |
                        {foreach $order.diversity.fields as $v}
                            {if $v.value.parentDiversity.deleted eq 1}{continue}{/if}
                            {$v.value.title}
                            {if $j != $count}|{/if} {$j = $j+1}
                        {/foreach}
                    </h4>
                    <button type="button" class="close float-left" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body">
                    <table class="table table-hover table-striped table-bordered table-condensed" dir="rtl">
                        <thead>
                        <tr>
                            <th>ردیف</th>
                            <th>شناسه فروشنده</th>
                            <th>شناسه سفارش</th>
                            <th>تاریخ ثبت سفارش</th>
                            <th>تاریخ نهایی شدن سفارش</th>
                            <th>تعداد سفارش</th>
                            <th>تاریخ تعهد ارسال</th>
                            <th>قیمت فروش (ریال)</th>
                            <th>تخفیف شگفت‌انگیز</th>
                            <th>تخفیف مدیر</th>
                            <th>قیمت کل</th>
                        </tr>
                        </thead>
                        <tr>
                            <td>{$row|persian_number}</td>
                            <td>
                                {$order.diversity.seller_id}
                            </td>
                            <td>
                                {$order.cart.id}
                            </td>
                            <td>
                                {jdate date=$order->cart->created_at}
                            </td>
                            <td>
                                {jdate date=$order->cart->pay_at}
                            </td>
                            <td>
                                {$order.qty|persian_number}
                            </td>
                            <td>

                            </td>
                            <td>
                                {($order.qty*$order.unit_price)|price_format}
                            </td>
                            <td>

                            </td>
                            <td>

                            </td>
                            <td>
                                {($order.qty*$order.unit_price)|price_format}
                            </td>
                        </tr>
                    </table>
                    {if $order->files != null && count($order->files)}
                        <div class="row">
                            <div class="col-md-6 col-sm-12">
                                {foreach $order->files as $file}
                                    <div class="box-group">
                                        <h4 class="mt-30 mb-30">
                                            طرح چاپی
                                        </h4>
                                        <img width="150" src="/upload/orders/{$file}" alt="">
                                        <a class="btn btn-success" href="/upload/orders/{$file}" target="_blank">
                                            دانلود طرح
                                        </a>
                                    </div>
                                {/foreach}
                                <br>
                            </div>
                            <div class="col-md-6 col-sm-12 pull-left">
                                <h4 class="title mt-30 mb-30">توضیحات کاربر</h4>
                                <p class="badge badge-success text-lg-right">{$order.printing_desc}</p>
                            </div>
                        </div>
                    {/if}
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary waves-effect text-left" data-dismiss="modal">بستن
                    </button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
{/foreach}

{*

<section>
<div class="remove-bottom">
<div class="container-fluid">
<div class="row">
<div class="col-md-12 col-sm-12 col-lg-12">
<div class="row">
<div class="col-md-12 col-sm-12 col-lg-12 pull-left">
<div class="row">
<div class="col-md-12 col-sm-12 col-lg-12 pull-left" style="text-align: right;font-family: xantoxa;">
<div class="row">
<div class="wishlist-title">
<h2 class="rtl">سفارشات کاربران</h2>
<p class="rtl text-primary" style="padding-top:20px; " >
در این قسمت سفارش‌هایی که کاربران از فروشگاه شما ثبت کرده‌اند قابل مشاهده است.
</p>
</div>
{if $Items->isEmpty()}
<div class="col-md-12">
<div class="entry-header">
<label class="text-warning pull-right rtl">سفارشی موجود نیست.</label>
<br>
</div>
</div>
{else}
<div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 table-responsive" >
<table class="table table-hover table-striped table-bordered table-condensed" dir="rtl">
<thead>
<tr>
<th>شناسه فاکتور</th>
<th>تصویر</th>
<th>کد محصول</th>
<th><span class="nobr">عنوان(تعداد)</span></th>
<th><span class="nobr">دسته بندی</span></th>
<th><span class="nobr">قیمت فروش</span></th>
<th><span class="nobr">تاریخ سفارش</span></th>
<th><span class="nobr">آدرس تحویل</span></th>
<th><span class="nobr">خریدار</span></th>
<th><span class="nobr">وضعیت</span></th>
</tr>
</thead>
{foreach from=$Items item=order}    
{if $order.cart.status eq 0}
{continue}
{/if}
<tr>
<td><p>{$order.cart.id}</p></td>
<td>
{if $order.product.pic != ''}
<a href="{site_url()|con:'product/':$order.product.slug}">
<img src="{$products_thumbnail_dir}{$order.product.pic}" alt="{$order.product.title}" style="max-height: 100px;" />
</a>
{else}
بدون تصویر
{/if}
</td>
<td>
<a href="{site_url}seller/manage-products/add-product/{$order.product_id}" style="color:blue;font-family:tahoma;"><span>{$order.product_id}</span></a>
</td>
<td><a href="{site_url()|con:'product/':$order.product.slug}">{summary text=$order.product.title limit=35}</a><br> ({$order.qty|persian_number}*)</td>
<td>
<p>
{$order.product.category.title} 
<i class="fa fa-chevron-left"></i>
{$order.product.child_category.title}
</p>
</td>
<td>
<span class="amount">
{$order.unit_price|price_format}
</span>
</td>
<td>
{jdate format='j F Y H:i' date=$order.cart.pay_at}
</td>
<td>
{$order.cart.delivery_address}
</td>
<td class="point_table_width_button">
<p>{$order->cart->user->first_name} {$order.cart.user.last_name} ({$order.cart.user.mobile})</p>
</td>
<td>
{if $order.cart.status eq 0}
<label class="text-danger">پرداخت نشده</label>
{else if $order.cart.status eq 1}
<label class="text-success">پرداخت شده</label>
{else if $order.cart.status eq 2}
<label class="text-success">ارسال شده</label>
{else if $order.cart.status eq 3}
<label class="text-success">پرداخت در محل</label>
{/if}
</td>
</tr>
{/foreach}
</table>
</div>
{/if}
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</section>*}




