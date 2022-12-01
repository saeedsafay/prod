{add_css file='lib/cropper/cropper.min.css'}
{add_css file='lib/cropper/main.css'}
{*{add_js file='js/jquery-confirm.min.js' part='footer'}*}
{add_js file='lib/cropper/cropper.min.js' part='footer'}
{add_js file='lib/cropper/main.js' part='footer'}


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
                        <li class="breadcrumb-item"><a href="/seller/manage-products/list-products">لیست
                                محصولات</a></li>
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
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#thematic-category" role="tab"
                           aria-selected="false">
                            <span class="hidden-sm-up"><i class="ti-home"></i></span> <span class="hidden-xs-down">دسته بندی موضوعی</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#product-photos-tab" role="tab"
                           aria-selected="false">
                            <span class="hidden-sm-up"><i class="ti-user"></i></span> <span class="hidden-xs-down">بارگذاری تصویر</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" data-toggle="tab" href="#varients-tab" role="tab" aria-selected="true">
                            <span class="hidden-sm-up"><i class="ti-email"></i></span> <span class="hidden-xs-down">درج تنوع</span>
                        </a>
                    </li>
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane active" id="addproductform" role="tabpanel">
                        <div class="row">
                            <div class="col-lg-12">
                                <form method="POST" action='' enctype="multipart/form-data">
                                    <div class="form-body">
                                        <div class="card">
                                            <div class="card-header">
                                                درباره محصول
                                            </div>
                                            <div class="card-body">
                                                <label class="badge badge-danger">{$validation_errors}</label>
                                                <div class="row p-t-20">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label">نام فارسی محصول*</label>
                                                            <input type="text" id="title" class="form-control"
                                                                   name="title" placeholder="عنوان کامل و توصیفی محصول"
                                                                   value="{set_value('title',  (isset($Product->title)) ? $Product.title : '')}">
                                                        </div>
                                                    </div>
                                                    <!--/span-->
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label" for="title_en">عنوان
                                                                لاتین محصول</label>
                                                            <input name="title_en" type="text" id="title_en"
                                                                   class="form-control"
                                                                   placeholder="عنوان انگلیسی"
                                                                   value="{set_value('title_en',  (isset($Product->title_en)) ? $Product.title_en : '')}">
                                                        </div>
                                                    </div>
                                                    <!--/span-->
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label class="control-label" for="title_en">کد طرح</label>
                                                            <input name="internal_code" type="text" id="internal_code"
                                                                   class="form-control"
                                                                   placeholder="کد داخلی طرح"
                                                                   value="{set_value('internal_code',  (isset($Product->internal_code)) ? $Product.internal_code : '')}">
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <label>شرح محصول</label>
                                                            <textarea class="form-control" rows="7" spellcheck="false"
                                                                      name="desc"
                                                                      placeholder="پیشنهاد می‌شود 150 کلمه درباره محصول برای معرفی بهتر آن به مشتریان بنویسید">{set_value('desc',  (isset($Product->desc)) ? $Product.desc : '')}</textarea>
                                                        </div>
                                                    </div>
                                                    <!--/span-->
                                                </div>
                                            </div>
                                        </div>
                                        <!--/row-->
                                        <div class="card">
                                            <div class="card-header">
                                                بارگذاری تصویر اصلی محصول
                                                *
                                            </div>
                                            <div class="card-body">
                                                <h4 class="card-title">
                                                    به هنگام بارگذاری تصویر اصلی به نکات زیر توجه کنید:
                                                </h4>
                                                <div class="row">
                                                    <div class="col-md-5 col-lg-5">

                                                        <p class="text-muted font-13 alert alert-cyan"> تصویر اصلی محصول
                                                            از اهمیت بالایی
                                                            برخوردار است و بیش ترین تاثیر را در تصمیم گیری برای خرید
                                                            مشتریان خواهد داشت.
                                                        </p>
                                                        <p class="text-muted font-13 alert alert-cyan">
                                                            تصویر واضح باشد.
                                                        </p>
                                                        <p class="text-muted font-13 alert alert-cyan">
                                                            ابعاد تصویر بایستی در بازه 600*600 تا 2500*2500 باشد.
                                                        </p>
                                                        <p class="text-muted font-13 alert alert-cyan">
                                                            حجم تصویر کمتر از 6 مگابایت باشد.
                                                        </p>
                                                    </div>
                                                    <div id="crop-adsPic-1" class="pull-right col-md-6 col-lg-6">
                                                        <div class="avatar-view" title="انتخاب تصویر اصلی محصول">
                                                            <img {if set_value( 'picHidden', '') !='' OR isset($Product.pic)}src="{$products_thumbnail_dir}{set_value('picHidden', (isset($Product->pic)) ? $Product.pic : set_value('picHidden'))}"
                                                                 {else}src="{assets_url}images/digital-camera.png" {/if}>
                                                            <input name="picHidden" type="hidden" id="picHidden1"
                                                                   value="{set_value('picHidden',(isset($Product.pic)) ? $Product.pic : '')}">
                                                            <div class="loading" aria-label="Loading" role="img"
                                                                 tabindex="-1">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        {if $user.id == 189}
                                            <div class="card">
                                                <div class="card-header">
                                                    نمایش محصول در وب سایت
                                                </div>
                                                <div class="card-body">
                                                    <h4 class="card-title">
                                                        محصول منحصر به فرم سفارش و غیرقابل خرید به صورت مستقیم
                                                    </h4>
                                                    <div class="row">
                                                        <div class="col-md-5 col-lg-5">

                                                            <p class="text-muted font-13 alert alert-danger">
                                                                اگر تمایل دارید تا محصول در لیست محصولات وب سایت
                                                                نمایش داده نشود
                                                            </p>
                                                            <p class="text-muted font-13 alert alert-danger">
                                                                قابل خرید مستقیم توسط خریداران نباشد
                                                            </p>
                                                            <p class="text-muted font-13 alert alert-danger">
                                                                و به منظور استفاده در فرم اختصاصی سفارش محصول را درج
                                                                کنید و سپس با درج تنوع، خریداران می توانند از فرم
                                                                سفارش، محصول دلخواه خود را سفارش دهند.
                                                            </p>
                                                        </div>

                                                        <label class="checkbox checked">
                                                            <input name="hidden_product"
                                                                   class="check"
                                                                   value="1"
                                                                    {if isset($Product)
                                                                    && $Product->hidden != null}
                                                                        checked=""
                                                                    {/if}
                                                                   type="checkbox">
                                                            <span class="label-text">عدم نمایش</span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                        <div class="card">
                                            <div class="card-header">
                                                گروه محصول
                                            </div>
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-md-3 col-lg-3 pull-right">
                                                        <div class="form-group">
                                                            <label>انتخاب گروه</label>
                                                            <select class="select2-custom form-control "
                                                                    name="product_type_id" id='product_type'>
                                                                <option>--انتخاب گروه محصول--</option>
                                                                {foreach $product_types as $val}
                                                                    <option value="{$val.id}" {if isset($Product) and ($Product->product_type->id eq $val.id)}{'selected'}{/if}>{$val.title}</option>
                                                                {/foreach}
                                                            </select>
                                                        </div>
                                                    </div>

                                                    <div class="loading" id="loading-filters" aria-label="Loading"
                                                         role="img" tabindex="-1">
                                                    </div>
                                                    <div class="col-md-3 col-lg-3 pull-right"
                                                         {if !isset($Product) OR !isset($Product->category)}style="display: none;"{/if}
                                                         id="cats-ptype-wrapper">
                                                        <div class="form-group">
                                                            <label for="product_category_id">‌دسته‌بندی محصول :</label>
                                                            <select name="product_category_id"
                                                                    class="form-control select2-custom"
                                                                    id='product_category_id'>
                                                                <option value="" disabled="" selected="">انتخاب</option>
                                                                {if isset($Product)}
                                                                    {foreach $Product->category->product_type->categories as $val}
                                                                        {if $val.parent_id != NULL OR $val.parent_id != 0}
                                                                            {continue}
                                                                        {/if}
                                                                        <option value="{$val.id}" {if isset($Product) and ($Product->product_category_id eq $val.id)}{'selected'}{/if}>{$val.title}</option>
                                                                    {/foreach}
                                                                {/if}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-3 col-lg-3"
                                                         {if !isset($Product) OR !isset($Product->child_category)}style="display: none;"{/if}
                                                         id="child-cats-ptype-wrapper">
                                                        <div class="form-group">
                                                            <label for="product_child_category_id">‌دسته‌بندی محصول
                                                                :</label>
                                                            <select name="product_child_category_id"
                                                                    class="form-control select2-custom"
                                                                    id='product_child_category_id'>
                                                                <option value="" disabled="" selected="">انتخاب</option>
                                                                {if isset($Product)}
                                                                    {foreach $Product->child_category->parentCat->children as $childCat}
                                                                        <option value="{$childCat.id}" {if isset($Product) and ($Product->product_child_category_id eq $childCat.id)}{'selected'}{/if}>{$childCat.title}</option>
                                                                    {/foreach}
                                                                {/if}
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-12 col-lg-12"
                                                         {if !isset($Product)}style="display: none;" {/if}
                                                         id="filters-wrapper">
                                                        <div class="col-md-12 col-lg-12">
                                                            <h5 class="card-title">‌
                                                                فرم ویژگی‌های این گروه:
                                                            </h5>

                                                            <p class="alert alert-success">
                                                                تعیین مشخصات محصول، به تصمیم‌گیری بهتر مشتری برای خرید
                                                                کالا کمک می‌کند. هم‌چنین با تعیین این مشخصات، امکان سرچ
                                                                شدن محصول خود را به کاربر می‌دهید.
                                                            </p>
                                                        </div>
                                                        <div class="col-md-12 col-lg-12 prd-specifications">
                                                            {if isset($Product) AND isset($Product->child_category)}
                                                                {foreach $Product->child_category->filters as $filter}
                                                                    <div class="col-md-6 col-lg-6">
                                                                        <div class="form-group">
                                                                            <label class="control-label">‌{$filter->label}
                                                                                :</label>
                                                                            {if $filter->field_type eq 3}
                                                                                <input type="text"
                                                                                       name="filters[{$filter->name}][]"
                                                                                       value="{if $filter->values()->first() != NULL}{$filter->values()->first()->title}{/if}"
                                                                                       class="form-control"/>
                                                                            {else}
                                                                                <select class="form-control 
                                                                                        {if $filter->field_type eq 1}select2-custom{/if}"
                                                                                        name="filters[{$filter->name}][]"
                                                                                        {if $filter->field_type eq 1}multiple{/if} >
                                                                                    {foreach $filter->values as $data}
                                                                                        <option value="{$data->id}"
                                                                                                {if $Product->filters->contains($data->id)}selected=""{/if}>
                                                                                            {$data->title}
                                                                                        </option>
                                                                                    {/foreach}
                                                                                </select>
                                                                            {/if}
                                                                        </div>
                                                                    </div>
                                                                {/foreach}
                                                            {/if}
                                                        </div>
                                                    </div>
                                                    <!--/span-->
                                                </div>
                                            </div>
                                            <div class="card-footer text-muted">
                                                <h4 class="card-title">مرحله بعدی : انتخاب دسته بندی موضوعی برای
                                                    محصول</h4>
                                                <div class="form-actions float-left">
                                                    <button type="button" class="btn btn-secondary btn-red">انصراف
                                                    </button>
                                                    <button type="submit" class="btn btn-success"><i
                                                                class="fa fa-check"></i> ذخیره اطلاعات
                                                    </button>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane" id="thematic-category" role="tabpanel">
                        {if !isset($Product)}
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <label class='alert alert-danger'>
                                                توجه: فروشنده محترم ، برای دسترسی به این قسمت ابتدا باید یک محصول ثبت
                                                نمایید
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {else}
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <form action="/seller/manage-products/thematicCategories/{$Product.id}"
                                          method="post" id="thematic-cat-form">
                                        <div class="form-body">
                                            <div class="card">
                                                <div class="card-header">
                                                    دسته بندی موضوعی محصول
                                                </div>
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-md-12 col-lg-12 pull-right">
                                                            <p class="alert alert-info">
                                                                با انتخاب دسته بندی موضوعی مرتبط، سعی کنید محصول خود را
                                                                راحت
                                                                تر در دسترس کاربران قرار دهید. شما می توانید چندین دسته
                                                                بندی
                                                                موضوعی را انتخاب کنید. لطفا از انتخاب موضوعات بی ارتباط
                                                                با
                                                                محصول اجتناب نمایید.
                                                            </p>
                                                            <div class="form-group">
                                                                <label>انتخاب دسته بندی موضوعی</label>
                                                                <select multiple class="form-control select2-custom"
                                                                        name="thematic_cat_id[]">
                                                                    <option>--انتخاب دسته بندی موضوعی محصول--</option>
                                                                    {foreach $thematicCategories as $categoryId => $val}
                                                                        {$title = implode(" > ", $val)}
                                                                        <option value="{$categoryId}"
                                                                                {if isset($Product.thematicCategories)
                                                                        && $Product->thematicCategories->contains($categoryId)}
                                                                            selected="selected"
                                                                                {/if}>
                                                                            {$title}
                                                                        </option>
                                                                    {/foreach}
                                                                </select>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-footer text-muted">
                                                    <h4 class="card-title">مرحله بعدی : انتخاب تصاویر برای محصول</h4>
                                                    <div class="form-actions float-left">
                                                        <button type="button" class="btn btn-secondary btn-red">انصراف
                                                        </button>
                                                        <button type="submit" class="btn btn-success"><i
                                                                    class="fa fa-check"></i> ذخیره اطلاعات
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        {/if}
                    </div>
                    <div class="tab-pane" id="product-photos-tab" role="tabpanel">
                        {if !isset($Product)}
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <label class='alert alert-danger'>
                                                توجه: فروشنده محترم ، برای دسترسی به این قسمت ابتدا باید یک محصول ثبت
                                                نمایید
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {else}
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="card">
                                        <div class="card-header">بارگذاری تصاویر تکمیلی</div>
                                        <div class="card-body">
                                            <form method="POST"
                                                  action='{site_url}seller/manage-products/storeImages/{$Product.id}'
                                                  enctype="multipart/form-data">
                                                <div class="controls col-lg-12" id='input-wrapper'>
                                                    <input type="file" name="product_image[]"
                                                           accept=".jpg, .png, image/jpeg, image/png"
                                                           class="photo-input">

                                                    <a href="#" title="افزودن تصویر بیشتر" id="add-extra-input"><img
                                                                src="{assets_url}images/btn5.png"></a>
                                                </div>
                                                <div class='card-body col-lg-12 col-md-12'>
                                                    <button type='submit' class='btn btn-info'>
                                                        ارسال
                                                    </button>
                                                </div>
                                            </form>
                                            <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 table-responsive">
                                                <table class="table table-hover table-striped table-bordered table-condensed"
                                                       dir="rtl" id="variant-images-table">
                                                    <thead>
                                                    <tr>
                                                        <th>ردیف</th>
                                                        <th>تصویر</th>
                                                        <th>عملیات</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody class="points_table_scrollbar">
                                                    {$i = 0}
                                                    {foreach $Product->images as $val}
                                                        <tr class="{if $i % 2 == 0}even{else}odd{/if}">
                                                            <td>
                                                                <p>
                                                                    {$i+1}
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <img src='{$products_pic_dir}{$val.file_name}'
                                                                     width="170"/>
                                                            </td>
                                                            <td class="point_table_width_button">
                                                                <a href="{site_url}seller/manage-products/delete-image/{$val.id}"
                                                                   class="btn btn-secondary btn-circle btn-red delete btn-sm"
                                                                   data-idads='' title="حذف تصویر"
                                                                   data-placement="top"
                                                                   data-toggle="confirmation-popout"><span><i
                                                                                class="fa fa-trash
                                                                                text-danger"></i></span></a>


                                                                <div class="form-group">
                                                                    <label>تنوع های مربوط به عکس</label>
                                                                    <select data-image-id="{$val.id}"
                                                                            multiple
                                                                            class="form-control select2-custom stay-open
                                                                            variant-image"
                                                                            name="variants_pic[{$val.id}]">
                                                                        <option>--انتخاب تنوع محصول--</option>
                                                                        {foreach $Product->varients as $variant}
                                                                            <option value="{$variant.id}"
                                                                                    {if $variant->product_image_id ==$val.id}
                                                                                selected=""
                                                                                    {/if}>
                                                                                {$count = $variant->fields->count() }
                                                                                {$j = 1}
                                                                                {foreach $variant.fields as $v}
                                                                                    {$v.value.title}
                                                                                    {if $j != $count}|{/if} {$j = $j+1}
                                                                                {/foreach}
                                                                            </option>
                                                                        {/foreach}
                                                                    </select>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        {$i = $i+1}
                                                    {/foreach}
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}
                    </div>
                    <div class="tab-pane" id="varients-tab" role="tabpanel">
                        {if !isset($Product)}
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <label class='alert alert-danger'>
                                                توجه: فروشنده محترم ، برای دسترسی به این قسمت ابتدا باید یک محصول ثبت
                                                نمایید
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {else}
                            <div class="row">
                                <div class="col-md-12 col-lg-12">
                                    <div class="card">
                                        <div class="card-header">قیمت‌گذاری محصول</div>
                                        <div class="card-body">
                                            <div class="control-group">
                                                <a href="#" id="add-diversity"
                                                   class="btn waves-effect waves-light btn-info btntop btn-add-price">
                                                    درج تنوع
                                                </a>
                                                <lable class="card-subtitle">برای هر رنگ ، گارانتی، سایز یا وزن متفاوت
                                                    از هر محصول، یک تنوع جدید ایجاد کنید
                                                </lable>
                                            </div>
                                            <div class="row p-t-20">
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
                                                        {if isset($Product->varients)}
                                                            {$i = 0}
                                                            {foreach $Product->varients as $val}
                                                                <tr class="{if $i % 2 == 0}even{else}odd{/if} varient-row-{$val.id}">
                                                                    <td class="varient-title">
                                                                        <p>
                                                                            {$count = $val->fields->count() }
                                                                            {$j = 1}
                                                                            {$Product.title} |
                                                                            {foreach $val.fields as $v}
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
                                                                        <a href="javascript:void()"
                                                                           class="btn btn-sm btn-secondary"
                                                                           onclick="$(this).editVarientModal({$val.id})"><span>ویرایش</span></a>
                                                                    </td>
                                                                </tr>
                                                                {$i = $i+1}
                                                            {/foreach}
                                                        {else}
                                                            <label>جستجو نتیجه ای در بر نداشت</label>
                                                        {/if}
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            {include file='modules/seller/diversity_modal.tpl'}
                        {/if}
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

<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-1" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog"
     tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'seller/manage-products/crop'}"
                  enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر اصلی محصول</h4>
                </div>
                <div class="modal-body">
                    <div class="avatar-body">
                        <!-- Upload image and data -->
                        <div class="avatar-upload">
                            <input type="hidden" class="avatar-data" name="avatar_data">
                            <label for="avatarInput">انتخاب فایل</label>
                            <input type="file" class="avatar-input" id="avatarInput" name="avatar_file">
                        </div>
                        <!-- Crop and preview -->
                        <div class="row">
                            <div class="col-md-3">
                                <label class="pull-right">پیش نمایش تصویر</label>
                                <div class="avatar-preview preview-lg"></div>
                            </div>
                            <div class="col-md-9">
                                <div class="avatar-wrapper"></div>
                            </div>
                        </div>
                        <div class="row avatar-btns">
                            <div class="col-md-10">
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn waves-effect waves-light btn-info btntop avatar-save">
                                    ارسال
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                {*
                <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">بستن</button>
                </div>
                *}
            </form>
        </div>
    </div>
</div>
<!-- /.modal -->