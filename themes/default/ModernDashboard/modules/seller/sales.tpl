<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-lg-3 pull-right no-padding">
                        </div>
                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                            {include file='partials/header_menu.tpl'}
                            <div class="row">
                                <div class="col-md-12">
                                    <label class="text-error text-danger">{validation_errors()}</label>
                                </div>
                                <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                                    <form method="POST" action='' enctype="multipart/form-data">
                                        <div class="row">
                                            <div class="col-md-8 col-lg-8 col-md-offset-2">
                                                <label class="text-info">
                                                    برای انتخاب محصول حراجی یکی از محصولات خود را انتخاب نمایید سپس قیمت جدید را وارد کنید.
                                                    <br>
                                                    {*   اگر میخواهید محصولات را از حراجی حذف نمایید، از لیست زیر گزینه هیچ‌کدام را انتخاب نموده و ثبت را فشار دهید.*}
                                                </label>
                                                <div class="control-group ">
                                                    <label class="control-label lbl_space" for="product_id">انتخاب محصول:</label>
                                                    <div class="controls">
                                                        <select name="product_id" class="select_rm" id='product_id'>
                                                            <option value="" disabled="" selected="">انتخاب</option>
                                                            {foreach $products as $val}
                                                                <option value="{$val.id}" data-price="{$val.price}" {if isset($prv_discount) and ($prv_discount->id eq $val.id)}{'selected'}{/if}>{$val.title}</option>
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-8 col-lg-8 col-md-offset-2" id="price-discount">
                                                <div class="control-group ">
                                                    <label class="control-label lbl_space" for="price">قیمت حراجی:</label>
                                                    <div class="controls">
                                                        <input class="input_page put_width " type="text" id="discount_price" name="discount_price" placeholder="قیمت حراجی (تومان)" class="input-xlarge" value="{set_value('discount_price', (isset($prv_discount->discount_price)) ? $prv_discount.discount_price  : '')}">
                                                    </div>
                                                </div>
                                                <p id="old_price">
                                                    <label style="display: none;width:100%">
                                                        قیمت اصلی محصول: 
                                                        <span> </span>
                                                    </label>
                                                </p>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-6 col-lg-6 ">
                                                <div class="control-group ">
                                                    <div class="controls">
                                                        <input class="send" class="input_page" type="submit" name="name" value="ثبت" class="input-xlarge"/>
                                                    </div>
                                                </div>
                                            </div> 
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12 col-lg-12 ">
                                    <table class="points_table">
                                        <thead>
                                        <th>عنوان</th>
                                        <th>قیمت اصلی</th>
                                        <th>قیمت حراجی</th>
                                        <th>حذف</th>
                                        </thead>
                                        {foreach $discounts as $val}
                                            <tr>
                                                <td><a>{$val.title}</a></td>
                                                <td><p>{$val.price|price_format}</p></td>
                                                <td><p>{$val.discount_price|price_format}</p></td>
                                                <td>
                                                    <a href='{site_url}seller/manage-products/delete-discount/{$val.id}'
                                                       class="btn btn-danger">
                                                        حذف از حراجی
                                                    </a>
                                                </td>
                                            </tr>
                                        {/foreach}
                                    </table>
                                </div> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</section>


<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-1" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
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
                            <div class="col-md-9">
                                <div class="avatar-wrapper"></div>
                            </div>
                            <div class="col-md-3">
                                <label class="pull-right">پیش نمایش تصویر</label>
                                <div class="avatar-preview preview-lg"></div>
                                <div class="avatar-preview preview-md"></div>
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-90" title="Rotate -90 degrees">چرخش به چپ</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-15">-15درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-30">-30درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="-45">-45درجه</button>
                                </div>
                                <div class="btn-group">
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="90" title="Rotate 90 degrees">چرخش به راست</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="15">15درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="30">30درجه</button>
                                    <button type="button" class="btn btn-primary" data-method="rotate" data-option="45">45درجه</button>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn readmore btn-block avatar-save">ارسال</button>
                            </div>
                        </div>
                    </div>
                </div>
                {*<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">بستن</button>
                </div>*}
            </form>
        </div>
    </div>
</div>
<!-- /.modal -->


