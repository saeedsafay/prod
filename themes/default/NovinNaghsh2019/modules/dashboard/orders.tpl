<main class="site-main shopping-cart js-get-pages-id" id="js-shopping-cart">
    <div class="container">
        <ol class="breadcrumb-page">
            <li>
                <a href="{site_url}">خانه</a>
            </li>
            <li class="active">
                {$title}
            </li>
        </ol>
    </div>
    <div class="container">
        <div class="row">
            <h3 style="
                font-size: 27px;
                padding-bottom: 20px;
                text-align: right;
                "> لیست {$title}</h3>
            {if count($orders) == 0}
                <label class="col-lg-12 alert alert-warning" for="">
                    در حال حاضر سفارشی ثبت نشده است.
                </label>
                <a href="/" class="btn btn-checkout">
                    ادامه خرید
                </a>
            {else}
                <div class="col-md-12">
                    <div class="order-summary">
                        <!-- Start product Details -->
                        <div class="row">
                            <div class="col-md-12 col-lg-12 col-sm-12 table-cart table-responsive">
                                <table class="table listtt rtl" dir="rtl">
                                    <tfoot>
                                    <tr class="cart-subtotal">
                                        <th style="text-align:center" colspan="2">سفارش</th>
                                        <th style="text-align:center"></th>
                                        <th style="text-align:center"></th>
                                        <th style="text-align:center"></th>
                                        <th style="text-align:center">تاریخ ثبت</th>
                                        <th style="text-align:center">آدرس تحویل</th>
                                        {*                                        <th style="text-align:center">مبلغ پرداختی</th>*}
                                    </tr>
                                    {foreach $orders as $item}
                                        {foreach $item->varients as $variant}
                                            {if $variant->id == $item->varients->first()->id}
                                                {$rowspan=true}
                                            {else}
                                                {$rowspan=false}
                                            {/if}
                                            {if ($variant->product->child_category->variants_as_package)}
                                                {$qty = 1}
                                            {else}
                                                {$qty = $variant.pivot.qty}
                                            {/if}
                                            <tr class="cart-subtotal">
                                                {if $rowspan}
                                                    <td colspan="2" rowspan="{count($item->varients)}">
                                                        شناسه سفارش {$item->id}
                                                    </td>
                                                {/if}

                                                <td>
                                                    شناسه تنوع {$variant->id}
                                                </td>
                                                <td>
                                                    <img src="{$products_pic_dir}{$variant.thumbnail}"
                                                         alt="{$variant->product->title}" width="140">
                                                </td>
                                                <td class="tb-product">
                                                    <div class="product-name">
                                                        {$count = $variant->fields->count() }
                                                        {$j = 1}
                                                        <a href="{$variant.product.link}"
                                                           target="_blank">
                                                            <b>
                                                                {$variant.product.title} |
                                                                {foreach $variant.fields as $v}
                                                                    {$v.value.title}
                                                                    {if $j != $count}|{/if} {$j = $j+1}
                                                                {/foreach}
                                                                <br>
                                                                <label>{($variant.pivot.unit_price * $qty)|price_format}</label>

                                                                {if isset($variant->pivot->files)}
                                                                    <span class="badge badge-primary">طرح دلخواه</span>
                                                                {/if}
                                                            </b>
                                                        </a>
                                                    </div>
                                                </td>
                                                <td style="text-align:left;direction: ltr">
                                                    {jdate format="Y/m/d H:i:s" date=$item.pay_at}
                                                </td>
                                                <td>
                                                    {$item->delivery->province->name} -
                                                    {$item->delivery->county->name}
                                                    ({$item->delivery->title})
                                                </td>
                                                {*                                                <td style="text-align:center">*}
                                                {*                                                    {($variant.pivot.unit_price * $qty)|price_format}*}
                                                {*                                                </td>*}
                                            </tr>
                                        {/foreach}
                                    {/foreach}
                                    </tfoot>
                                </table>
                            </div>
                        </div>
                        <!-- End product Details -->
                    </div>
                </div>
            {/if}
        </div>
        <!-- Start Review Information -->
    </div>
</main>