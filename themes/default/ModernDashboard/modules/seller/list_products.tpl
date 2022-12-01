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
                    <a href="{$addURL}" class="btn btn-info d-none d-lg-block m-l-15"><i class="fa fa-plus-circle"></i>
                        درج محصول</a>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->

        <div class="row">
            <div class="col-md-12 col-xs-12 col-lg-12">
                <div class="card">
                    <div class="card-header">
                        فیلتر کردن نتایج
                    </div>
                    <div class="card-body">
                        <form action="">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="control-label">بر اساس نام محصول</label>
                                        <input type="text" id="title" class="form-control"
                                               name="title" placeholder="نام فارسی محصول"
                                               value="{set_value('title',  (isset($filter_params['title'])) ? $filter_params['title'] : '')}">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="control-label">بر اساس شناسه NPI</label>
                                        <input type="text" id="title" class="form-control"
                                               name="npi" placeholder="شناسه منحصر بفرد محصول یا NPI"
                                               value="{set_value('npi',  (isset($filter_params['id'])) ?
                                               $filter_params['id'] : '')}">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="control-label">بر اساس گروه کالایی</label>
                                        <input type="text" id="title" class="form-control"
                                               name="product_type"
                                               placeholder="مانند پوشاک یا چاپ افست"
                                               value="{set_value('product_type',  (isset($filter_params['product_type'])) ? $filter_params['product_type'] : '')}">
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <label class="control-label">بر اساس دسته بندی</label>
                                        <input type="text" id="title" class="form-control"
                                               name="category"
                                               placeholder="مانند تیشرت نخی یا کارت ویزیت"
                                               value="{set_value('category',  (isset($filter_params['category'])) ? $filter_params['category'] : '')}">
                                    </div>
                                </div>
                                <div class="col-md-12">
                                    <div class="form-group">
                                        {if $has_filter}
                                            <a href="/seller/manage-products/list-products" class="btn btn-warning">حذف
                                                فیلتر</a>
                                        {/if}
                                        <button type="submit" class="btn btn-primary pt-10">
                                            <i class="fa fa-spin hidden"></i>
                                            <span>جستجو</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
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
                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 table-responsive">
                                <table class=" table table-hover table-condensed points_table table-striped">
                                    <thead>
                                    <tr>
                                        <th>تصویر</th>
                                        <th>شناسه محصول (NPI)</th>
                                        <th>گروه اصلی</th>
                                        <th>عنوان محصول</th>
                                        <th>وضعیت</th>
                                        <th>تعداد بازدید</th>
                                        <th>عملیات</th>
                                    </tr>
                                    </thead>

                                    <tbody class="points_table_scrollbar">
                                    {$i = 0}
                                    {foreach $products as $val}
                                        <tr class="{if $i % 2 == 0}even{else}odd{/if}">
                                            <td><img width="100" class="img_tbl"
                                                     src="{$products_thumbnail_dir}{$val.pic}"></td>
                                            <td>
                                                <p>
                                                    <a href="{$val->link}"
                                                       target="_blank">
                                                        NPI-{$val.id}
                                                    </a>
                                                </p>
                                            </td>
                                            <td>
                                                {$val.product_type.title}
                                                <i class="fa fa-chevron-left"></i>
                                                {$val.category.title}
                                                <i class="fa fa-chevron-left"></i>
                                                {$val.child_category.title}
                                            </td>
                                            <td>{$val.title}</td>
                                            <td>
                                                {if $val.status eq 0}
                                                    <span class="badge badge-primary">
                                                            در حال بررسی
                                                        </span>
                                                {elseif $val.status eq 1}
                                                    <span class="badge badge-success">
                                                            تایید و انتشار
                                                        </span>
                                                {elseif $val.status eq 2}
                                                    <span class="badge badge-danger">
                                                            رد شده
                                                        </span>
                                                {elseif $val.status eq 3}
                                                    <span class="badge badge-danger">
                                                            بازبینی مجدد
                                                        </span>
                                                {/if}
                                            </td>
                                            <td><p>{$val.visit_counts|persian_number}</p></td>
                                            <td>
                                                <a href="{site_url}seller/manage-products/add-product/{$val.id}"
                                                   class="btn waves-effect waves-light btn-sm btn-secondary">ویرایش
                                                    محصول</a>
                                                {*  <a href="{site_url}seller/manage-products/delete/{$val.id}" class="btn btn-md btn-red delete"  data-idads='{$val.id}' title="حذف این محصول" data-placement="top" data-toggle="confirmation-popout" ><span>حذف</span></a>*}
                                            </td>
                                        </tr>
                                        {$i = $i + 1}
                                    {/foreach}
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




