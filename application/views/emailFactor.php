
<div id=":2wd" class="ii gt adP adO"><div id=":2wc" class="a3s aXjCH m15a00f75211b671c"><u></u>
        <div>
            <div style="font-family:tahoma;font-size:9px;background-color:#ffffff;border:1px ridge #808080;direction:rtl">
                <p style="font-size:10pt;border:none">پرداخت شما به شماره فاکتور&nbsp;

                    <label><?php echo $invoice_id; ?></label>
                    &nbsp; به شرح زير  و به شماره پيگيري <?php echo $trans_id; ?> با موفقيت انجام پذيرفت.</p>

                <table width="99%" style="font-family:tahoma;font-size:8pt">
                    <tbody><tr>
                            <td rowspan="2" style="width:25%">
                                <img id="m_8877728284907759595imgLogo" src="http://www.pianoyab.com/upload/logo2.png" class="CToWUd">
                            </td>
                            <td rowspan="2" style="text-align:center;width:50%" valign="top">
                                <span style="font-weight:bold;font-size:11pt;color:#000000;font-family: tahoma;">
                                    <br>
                                    <br>
                                    پيش فاکتور
                                    <br>
                                    <br>
                                </span>
                            </td>
                            <td valign="bottom" align="left" style="width:25%">
                                <p style="font-family: tahoma;font-weight:bold;direction:rtl;text-align:right" align="left" dir="ltr">
                                    <label style="font-family: tahoma;font-weight:bold">تاريخ صدور (تاريخ پرداخت) :</label>
                                    <label style="font-family: tahoma;font-weight:bold"><?php echo $date; ?></label>
                                </p>
                            </td>
                        </tr>
                    </tbody></table>
                <table width="99%" style="text-align:right;font-family:Tahoma;font-size:9pt">
                    <tbody>
                        <tr>
                            <td colspan="6" style="font-family: tahoma;text-align:center;background:#999999;border-radius:3px;height:20px;border:1px solid #999999">
                                <span style="font-family: tahoma;font-weight:bold;margin:0px 0px 5px 0px;height:25px">مشخصات خريدار
                                </span>
                            </td>
                        </tr>
                        <tr style="height:25px">
                            <td style="font-family: tahoma;background-color:#dbdada;border-radius:3px;font-weight:bold">
                                <label>نام شخص حقيقي/حقوقي </label>
                            </td>
                            <td style="font-family: tahoma;background-color:#f0f1f3;border-radius:3px">
                                <label> <?php echo $userName; ?></label>
                            </td>
                            <td style="font-family: tahoma;background-color:#dbdada;border-radius:3px;font-weight:bold">
                                <label>شماره ثبت / شماره ملي</label>

                            </td>
                            <td style="font-family: tahoma;background-color:#f0f1f3;border-radius:3px">
                                <label></label>
                            </td>
                        </tr>
                        <tr style="height:25px">

                            <td style="font-family: tahoma;background-color:#dbdada;border-radius:3px;font-weight:bold">
                                <label>کد پستي 10 رقمي</label>

                            </td>
                            <td style="background-color:#f0f1f3;border-radius:3px">
                                <label>---</label>
                            </td>
                        </tr>
                        <tr style="height:25px">
                            <td style="font-family: tahoma;background-color:#dbdada;border-radius:3px;font-weight:bold">
                                <label>نشاني</label>

                            </td>
                            <td colspan="3" style="font-family: tahoma;background-color:#f0f1f3;border-radius:3px">
                                <label style="font-family: tahoma;"><?php echo $address; ?></label></td>
                            <td style="background-color:#dbdada;border-radius:3px;font-weight:bold">
                                <label>شماره تلفن / نمابر</label>

                            </td>
                            <td style="font-family: tahoma;background-color:#f0f1f3;border-radius:3px">
                                <label style="font-family: tahoma;"><?php echo $mobile; ?></label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" style="font-family: tahoma;text-align:center;background:#999999;border-radius:3px;height:20px;border:1px solid #999999">
                                <span style="font-family: tahoma;font-weight:bold;margin:0px 0px 5px 0px;height:25px">مشخصات کالا يا خدمات مورد معامله
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="8">
                                <table style="font-family:tahoma;font-size:8pt;width:100%;table-layout:auto;empty-cells:show;border-collapse:separate" border="0" cellspacing="0">

                                    <thead>
                                        <tr style="text-align:center">
                                            <th scope="col" class="m_8877728284907759595rgHeader" style="font-family:tahoma;font-size:8pt;text-align:center;background-color:#dbdada;border-radius:3px;height:20px;padding:5px" valign="middle">رديف</th>
                                            <th scope="col" class="m_8877728284907759595rgHeader" style="font-family:tahoma;font-size:8pt;text-align:center;background-color:#dbdada;border-radius:3px;height:20px;padding:5px" valign="middle">عنوان کالا</th>
                                            <th scope="col" class="m_8877728284907759595rgHeader" style="font-family:tahoma;font-size:8pt;text-align:center;background-color:#dbdada;border-radius:3px;height:20px;padding:5px" valign="middle">تعداد</th>
                                            <th scope="col" class="m_8877728284907759595rgHeader" style="font-family:tahoma;font-size:8pt;text-align:center;background-color:#dbdada;border-radius:3px;height:20px;padding:5px" valign="middle">مبلغ واحد (ريال)</th>
                                            <th scope="col" class="m_8877728284907759595rgHeader" style="font-family:tahoma;font-size:8pt;text-align:center;background-color:#dbdada;border-radius:3px;height:20px;padding:5px" valign="middle">مبلغ کل (ريال)</th>

                                        </tr>
                                    </thead>
                                    <tbody> 
                                        <?php
                                        $i = 1;
                                        $total = 0;
                                        foreach ( $products as $val ) {
                                            $total += $val->price * $val->pivot->qty;
                                            ?>
                                            <tr>

                                                <td style="font-family: tahoma;background-color:white;border-radius:3px;font-size:8pt;text-align:center;padding:5px"><?php echo $i; ?></td>
                                                <td style="font-family: tahoma;background-color:white;border-radius:3px;font-size:8pt;text-align:center;padding:5px"><?php
                                                    echo $val->title;
                                                    if ( $val->pivot->color != "" ) {
                                                        echo '(' . $val->pivot->color . ')';
                                                    }
                                                    ?></td>
                                                <td style="font-family: tahoma;background-color:white;border-radius:3px;font-size:8pt;text-align:center;padding:5px"><?php echo $val->pivot->qty; ?></td>
                                                <td style="font-family: tahoma;background-color:white;border-radius:3px;font-size:8pt;text-align:center;padding:5px"><?php echo $val->price; ?></td>
                                                <td style="font-family: tahoma;background-color:white;border-radius:3px;font-size:8pt;text-align:center;padding:5px"><?php echo $val->price * $val->pivot->qty; ?></td>

                                            </tr>
                                            <?php
                                            $i++;
                                        }
                                        ?>
                                    </tbody>
                                </table>

                            </td>
                        </tr>
                        <tr style="height:30px">
                            <td style="font-family: tahoma;background-color:#dbdada;border-radius:3px">

                                <label style="font-family: tahoma;font-weight:bold">جمع کل</label>

                            </td>
                            <td style="font-family: tahoma;background-color:#f0f1f3;border-radius:3px">

                                <label><?php echo $total; ?></label>
                            </td>
                            <td style="font-family: tahoma;background-color:#dbdada;border-radius:3px">
                                <label style="font-weight:bold">شماره پيش فاکتور جهت پيگيري</label>
                            </td>
                            <td colspan="6&quot;" style="font-family: tahoma;background-color:#f0f1f3;border-radius:3px">

                                <label><?php echo $invoice_id; ?></label>
                            </td>

                        </tr>

                        <tr>
                            <td style="background-color:#dbdada;border-radius:3px;font-weight:bold">
                                <label style="font-family: tahoma;font-weight:bold">توضیحات</label>
                            </td>
                            <td colspan="3" style="font-family: tahoma;background-color:#f0f1f3;border-radius:3px;padding:5px">

                                <label>
                                    <span dir="rtl">
                                        کد تخفیف <?php echo $discount; ?> ریالی در خریدهای آتی از پیانویاب: <?php echo $coupon_code; ?>

                                    </span></label>
                            </td>

                        </tr>
                    </tbody></table>
                <div  style="margin:0 auto">
                    <img height="25px" src="https://ci3.googleusercontent.com/proxy/rOYdlN6s6GfTCZ8nMSqodKPpuEKOEQrnvxEyBbNPXTCO3wpFmRdApkqv7lhKgJTkfo4Lxme1Z88b=s0-d-e1-ft#http://1544.ir/Img/print12-icon.png" alt="چاپ فاکتور" width="25px" style="margin:0 auto" class="CToWUd">
                    <label>

                    </label></div>
            </div>
            <div class="yj6qo"></div><div class="adL">
            </div>

        </div>
        <div class="adL">
        </div>

    </div>

</div>