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
                            {if $items->isEmpty()}
                                <div class="col-md-12">
                                    <div class="entry-header">
                                        <label class="text-warning pull-right rtl">تنوع یافت نشد.</label>
                                        <br>
                                    </div>
                                </div>
                            {else}
                                <div class="row">
                                    <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 table-responsive">
                                        <table class="table table-hover table-striped table-bordered table-condensed"
                                               dir="rtl" id="varient-table">
                                            <thead>
                                            <tr>
                                                <th>عنوان تنوع کالا</th>
                                                <th>شناسه تنوع</th>
                                                <th>فعال</th>
                                                <th>وضعیت</th>
                                                <th>قیمت فروش (ریال)</th>
                                                <th>موجودی نزد شما</th>
                                                <th>حداکثر سفارش مشتریان در سبد</th>
                                                <th>بازه زمانی ارسال</th>
                                                <th>عملیات</th>
                                            </tr>
                                            </thead>
                                            <tbody class="points_table_scrollbar">
                                            {if isset($items)}
                                                {$i = 0}
                                                {foreach $items as $val}
                                                    <tr class="{if $i % 2 == 0}even{else}odd{/if} varient-row-{$val.id}">
                                                        <td class="varient-title">
                                                            <p>
                                                                {$count = $val->fields->count()}
                                                                {$j = 1}
                                                                {$val.product.title} |
                                                                {foreach $val->fields as $v}
                                                                    {$v.value.title}
                                                                    {if $j != $count}|{/if} {$j = $j+1}
                                                                {/foreach}
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p>{$val.id} </p>
                                                        </td>
                                                        <td class="varient-active">
                                                            <p>{if $val.status}
                                                                    <i class="fa fa-check"></i>
                                                                {else}
                                                                    <i class="fa fa-times"></i>
                                                                {/if}</p>
                                                        </td>
                                                        <td class="varient-status">
                                                            <p>
                                                                {if $val.stock > 0} قابل فروش {else} اتمام موجودی {/if}
                                                            </p>
                                                        </td>
                                                        <td class="varient-price">
                                                            <p>{number_format($val.price)}</p>
                                                        </td>
                                                        <td class="varient-stock">
                                                            <p>{$val.stock}</p>
                                                        </td>
                                                        <td class="varient-max-order">
                                                            <p>{$val.max_order}</p>
                                                        </td>
                                                        <td class="varient-lead-time">
                                                            <p>{$val.lead_time}</p>
                                                        </td>
                                                        <td class="point_table_width_button">
                                                            <a href="javascript:void()" class="btn btn-sm btn-secondary"
                                                               onclick="$(this).editVarientModal({$val.id})"><span>ویرایش</span></a>
                                                        </td>
                                                    </tr>
                                                    {$i = $i+1}
                                                    {$Product = $val.product}
                                                {/foreach}
                                            {else}
                                                <label>جستجو نتیجه ای در بر نداشت</label>
                                            {/if}
                                            </tbody>
                                            <tfoot>
                                            <tr class="footable-paging">
                                                <td colspan="8">
                                                    <div class="footable-pagination-wrapper">
                                                        <ul class="pagination justify-content-center">
                                                            {if $pagination['current_page'] > 1 }
                                                                <li class="page-item"
                                                                    data-page="first">
                                                                    <a class="page-link"
                                                                       href="{$pagination['first_page_url']}">اولین</a>
                                                                </li>
                                                                <li class="page-item"
                                                                    data-page="prev">
                                                                    <a class="page-link"
                                                                       href="{$pagination['prev_page_url']}">قبلی</a>
                                                                </li>
                                                            {/if}
                                                            <li class="page-item active" data-page="1">
                                                                <sapn class="page-link">
                                                                    {$pagination['current_page']}
                                                                </sapn>
                                                            </li>
                                                            {if $pagination['current_page'] != $pagination['last_page'] }
                                                                <li class="page-item"
                                                                    data-page="2">
                                                                    <a class="page-link"
                                                                       href="{$pagination['next_page_url']}">{($pagination['current_page']+1)}</a>
                                                                </li>
                                                                <li class="page-item"
                                                                    data-page="next">
                                                                    <a class="page-link"
                                                                       href="{$pagination['next_page_url']}">بعدی</a>
                                                                </li>
                                                                <li class="page-item"
                                                                    data-page="last">
                                                                    <a class="page-link"
                                                                       href="{$pagination['last_page_url']}">آخرین</a>
                                                                </li>
                                                            {/if}
                                                        </ul>
                                                        <div class="divider"></div>
                                                        <span class="label label-primary">صفحه {$pagination['current_page']} از {$pagination['last_page']}</span>
                                                    </div>
                                                </td>
                                            </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                                {include file='modules/seller/diversity_modal.tpl'}
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- End PAge Content -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->
</div>




