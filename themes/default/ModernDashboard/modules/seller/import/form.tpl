{add_js file="js/import.js" part="footer"}
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

        <!-- ============================================================== -->
        <!-- Start Page Content -->
        <!-- ============================================================== -->
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-body p-b-20 p-t-20">
                        <h6 class="card-subtitle">محتوای محصول به همراه تصاویر آن را درج کنید یا از نوین نقش درخواست
                            کنید برایتان محتوا را درج نماید و یا از محصولات عکاسی کند.
                        </h6>
                    </div>
                </div>
                <!-- Nav tabs -->
                <ul class="nav nav-tabs customtab2" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" data-toggle="tab" href="#addproductform" role="tab"
                           aria-selected="false">
                            <span class="hidden-sm-up"><i class="ti-home"></i></span> <span class="hidden-xs-down">اطلاعات محصول</span>
                        </a>
                    </li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="addproductform" role="tabpanel">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="form-body">
                                    <div class="card">
                                        <div class="card-header">
                                            وارد سازی محصولات
                                        </div>
                                        <div class="card-body">
                                            <form method="POST" action='/seller/imports/handle'
                                                  enctype="multipart/form-data"
                                                  id="import-form">
                                                <div class="row p-t-20">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label">فایل فشرده طرح ها*</label>
                                                            <input type="file" id="title" class="dropify form-control"
                                                                   name="file"
                                                                   data-allowed-file-extensions="zip rar">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label">
                                                                ساخت موکاپ
                                                            </label>
                                                            <p>
                                                                <label class="checkbox checked">
                                                                    <input name="creat_mockups"
                                                                           class="check"
                                                                           value="1" checked=""
                                                                           type="checkbox">
                                                                    <span class="label-text">بله</span>
                                                                </label>
                                                                <br>
                                                            </p>
                                                        </div>
                                                        <div class="form-group">
                                                            <label class="control-label">
                                                                ساخت موکاپ و درج محصول
                                                                برای:</label>
                                                            <p>
                                                                {foreach $mockups as $name => $value}
                                                                    <label class="checkbox checked">
                                                                        <input name="mockup_types[{$name}]"
                                                                               class="check"
                                                                               value="1"
                                                                               type="checkbox">
                                                                        <span class="label-text">{$value.label}</span>
                                                                    </label>
                                                                    <br>
                                                                {/foreach}
                                                            </p>
                                                        </div>
                                                    </div>

                                                    <div class="spinner-border text-success" style="width: 3rem; height: 3rem;
                                                         display: none;"
                                                         role="status">
                                                        <span class="sr-only">در حال ساخت موکاپ محصولات</span>
                                                    </div>
                                                </div>
                                            </form>
                                            <form action="/seller/imports/importData" id="insert-form">
                                                <div id="import-data-wrapper" style="display: none;">
                                                    <p class="alert alert-info">
                                                        اطلاعات اولیه که برای درج محصول لازم است را در فرم زیر وارد
                                                        نمایید.
                                                    </p>
                                                    <p class="alert alert-warning">
                                                        در صورت عدم تمایل به ثبت هر کدام از موکاپ های نمایش داده
                                                        شده، فیلد عنوان محصول در همان سطر را خالی بگذارید. در این صورت
                                                        آن محصول
                                                        درج نخواهد شد.
                                                    </p>
                                                    <p class="alert alert-warning">
                                                        در صورت نیاز به وارد کردن بیش از یک شناسه دسته بندی موضوعی،
                                                        هر شناسه را با خط فاصله معمولی (-) جدا کنید
                                                    </p>
                                                    <p class="alert alert-info">
                                                        <b>شناسه دسته بندی های مورد نیاز در فرم:</b>
                                                        <br>
                                                        {foreach $mockups as $mockup}
                                                            <span>{$mockup['label']}: {$mockup['category_id']}</span>
                                                        {/foreach}
                                                    </p>
                                                    <div class="row p-t-20 generated-form-row">
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <input class="hidden-pic-input" type="hidden" value=""
                                                                       name="productImport[0][pic]"/>
                                                                <img class="mockup-img" src="" alt="" width="120">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label class="control-label">عنوان محصول</label>
                                                                <input type="text" id="title" class="form-control"
                                                                       name="productImport[0][title]"
                                                                       placeholder="عنوان کامل محصول"
                                                                       value="">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label class="control-label">توضیحات محصول</label>
                                                                <input type="text" id="title" class="form-control"
                                                                       name="productImport[0][description]" value="">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label class="control-label">کد طرح</label>
                                                                <input type="text" value="" class="form-control
                                                                import-internal-code"
                                                                       name="productImport[0][internal_code]"
                                                                       placeholder="کد داخلی طرح">
                                                            </div>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label class="control-label">شناسه دسته بندی</label>
                                                                <input type="text" value="" class="form-control
                                                                import-category-id"
                                                                       name="productImport[0][category_id]"
                                                                >
                                                            </div>
                                                        </div>
                                                        <div class="col-md-2">
                                                            <div class="form-group">
                                                                <label class="control-label">شناسه های دسته بندی موضوعی
                                                                </label>
                                                                <input type="text" id="title" class="form-control"
                                                                       name="productImport[0][thematic_category_ids]"
                                                                       placeholder="هرشناسه را با - جدا کنید"
                                                                       value="">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 import-data-action">
                                                        <span class="spinner-border text-success"
                                                              style="display:none;">
                                                        </span>
                                                        <span class="btn btn-success form-actions float-left
                                                        insert-data"><i class="fa fa-cloud-upload-alt"></i>
                                                            درج یک جا</span>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!--/row-->
                                <div class="card">
                                    <div class="card-footer text-muted">
                                        <h4 class="card-title">
                                            پس از ارسال، یک فرم حاوی پیش نمایش موکاپ های ساخته شده از طرح های شما
                                            تولید می
                                            شود تا بتوانید اطلاعات محصول را درج نمایید.
                                        </h4>
                                        <div class="form-actions float-left">
                                            <button type="button" class="btn btn-secondary btn-red">انصراف
                                            </button>
                                            <button id="submit-mockup" type="submit" class="btn btn-success"><i
                                                        class="fa fa-check"></i> ساخت موکاپ ها
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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