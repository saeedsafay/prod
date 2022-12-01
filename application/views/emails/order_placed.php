<p>
    با سپاس از خرید شما، سفارش شما در فروشگاه نوین نقش به ثبت رسید و با موفقیت پرداخت شد. اطلاعات
    خرید شما:
</p>
<table border="0" cellpadding="0" cellspacing="0" width="100%"
       class="mcnDividerBlock" style="min-width:100%;">
    <tbody class="mcnDividerBlockOuter">
    <tr>
        <td class="mcnDividerBlockInner"
            style="min-width: 100%; padding: 9px 18px 0px;">
            <table class="mcnDividerContent" border="0" cellpadding="0"
                   cellspacing="0" width="100%" style="min-width:100%;">
                <thead>
                <tr>
                    <th>
                        تصویر محصول
                    </th>
                    <th>عنوان</th>
                    <th>تعداد</th>
                    <th>قیمت نهایی</th>
                </tr>
                </thead>
                <tbody>
                <?php $sum = 0; ?>
                <?php foreach ($varients as $variantData) {
                    ?>
                    <tr>
                        <td>
                            <img width="80"
                                 src="<?php echo site_url('upload/orders/'.$variantData['product']['pic']); ?>">
                        </td>
                        <td><span><?php echo $variantData['product']['title']; ?></span></td>
                        <td><span>x<?php echo $variantData['pivot']['qty']; ?></span></td>
                        <td><span><?php
                                $price = $variantData['pivot']['unit_price'] * $variantData['pivot']['qty'];
                                echo number_format($price, 0, '.', ','); ?>
                                ریال</span></td>
                    </tr>
                    <?php
                    $sum += $price;
                } ?>
                <tr>
                    <td colspan="3">
                        <strong>مجموع</strong>
                    </td>
                    <td><?php echo number_format($sum, 0, '.', ','); ?> ریال</td>
                </tr>
                </tbody>
            </table>
            <!--
              <td class="mcnDividerBlockInner" style="padding: 18px;">
              <hr class="mcnDividerContent" style="border-bottom-color:none; border-left-color:none; border-right-color:none; border-bottom-width:0; border-left-width:0; border-right-width:0; margin-top:0; margin-right:0; margin-bottom:0; margin-left:0;" />
              -->
        </td>
    </tr>
    </tbody>
</table>