
{add_js file='lib/jquery.craftpip_confirmbox/js/jquery-confirm.js' part='footer'}
{add_css file='lib/jquery.craftpip_confirmbox/css/jquery-confirm.css'}
<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12">
                    <div class="row">

                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                            {include file='partials/header_menu.tpl'}
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                                    <div class="row">
                                        <h4 class="title_row title-3">لیست علاقمندی‌ها</h4>
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12 table-responsive" >
                                            <table class="points_table table table-hover table-condensed table-striped" dir="rtl">
                                                <thead>
                                                    <tr>
                                                        <th>تصویر</th>
                                                        <th>عنوان</th>
                                                        <th>فروشنده</th>
                                                        <th>دسته بندی</th>
                                                        <th>کد محصول</th>
                                                        <th>قیمت محصول</th>
                                                        <th>عملیات</th>
                                                    </tr>
                                                </thead>
                                                {$i = 0}
                                                {foreach $favs as $val}
                                                    <tr>
                                                        <td>
                                                            <img class="img_tbl" src="{site_url}upload/products/pic/{$val->product.pic}">
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <a href="{site_url}product/{$val->product.slug}">
                                                                    {$val->product.title}
                                                                </a>
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                <a href="{site_url}profile/{$val->product->user->username}">
                                                                    {$val->product.user.business_name}
                                                                </a>
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <p>
                                                                {$val.category.title} 
                                                                <i class="fa fa-chevron-left"></i>
                                                                {$val.child_category.title}
                                                            </p>
                                                        </td>
                                                        <td><p>{$val->product.id}</p></td>
                                                        <td><p>{$val->product.price|price_format}</p></td>
                                                        <td class="point_table_width_button">
                                                            <a href="{site_url}seller/manage-products/delete-fav/{$val.id}"
                                                               class="btn btn-md btn-red delete"
                                                               data-idads='{$val->product.id}' title="حذف از علاقمندیها"
                                                               data-placement="top"
                                                               data-toggle="confirmation-popout"><span>حذف</span></a>
                                                        </td>
                                                    </tr>
                                                    {$i = $i + 1}
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
    </div>
</section>



