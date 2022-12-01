<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12 col-sm-12 col-xs-12">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left col-sm-12 col-xs-12">
                            {include file='partials/header_menu.tpl'}
                            <form method="POST" action="" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-12">
                                        <label class="text-error text-danger">{validation_errors()}</label>
                                    </div>
                                    <div class="col-md-12 col-sm-12 col-lg-12 pull-left col-sm-12 col-xs-12">
                                        <div class="row">
                                            <h4 class="title_header"><span class="title_border">تغییر رمزعبور:</span></h4>
                                            <div class="col-md-7 col-lg-7 col-md-offset-3 col-sm-12 col-xs-12">
                                                <div class="control-group ">
                                                    <label class="control-label" for="newpass">رمز عبورجدید  :</label>
                                                    <div class="controls">
                                                        <input class="input_align input_page" type="password" id="newpass" name="newpass" placeholder="رمزعبور جدید"  class="input-xlarge">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-7 col-lg-7 col-md-offset-3 col-sm-12 col-xs-12">
                                                <div class="control-group ">
                                                    <label class="control-label" for="password_confirm">تکرار رمز عبور  :</label>
                                                    <div class="controls">
                                                        <input class="input_align input_page" type="password" id="password_confirm" name="password_confirm" placeholder="تکرار رمزعبور"  class="input-xlarge">

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <div class="controls">
                                                <input class="send" name="submitbtn" class="input_page" type="submit"  value="ثبت" class="input-xlarge">
                                            </div>
                                        </div>
                                    </div> 
                                </div>
                            </form>
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
            <form class="avatar-form" action="{site_url()|con:'users/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر اصلی پروفایل</h4>
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
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
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



<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-2" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'users/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر دوم</h4>
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
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
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



<!-- Cropping modal -->
<div class="modal fade" id="avatar-modal-3" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'users/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر سوم</h4>
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
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
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



<!-- Cropping modal -->
<div class="modal fade" id="crop-logo-4" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form class="avatar-form" action="{site_url()|con:'users/crop'}" enctype="multipart/form-data" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="avatar-modal-label">افزودن تصویر لوگو</h4>
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
                            </div>
                        </div>

                        <div class="row avatar-btns">
                            <div class="col-md-10">
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
