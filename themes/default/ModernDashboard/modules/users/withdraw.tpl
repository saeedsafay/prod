{literal}
    <style>
        .form-group{
            text-align: right;
            float: left;
            width: 100%;
            padding: 21px;
        }
        .input-group{
            width: 60%;
        }
    </style>
{/literal}
<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12 col-sm-12 col-xs-12">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-lg-3 pull-right no-padding col-sm-12 col-xs-12">
                        </div>
                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left col-sm-12 col-xs-12">
                            {include file='partials/header_menu.tpl'}
                            <div class="row">
                                <div class="col-md-12">
                                    <label class="text-error text-danger">{validation_errors()}</label>
                                </div>
                                <div class="col-md-12 col-sm-12 col-lg-12 pull-left col-sm-12 col-xs-12">

                                    <h2 class="rtl" style="text-align:right; direction: rtl;">درخواست تسویه</h2>
                                     <!--<div class="right" style="width:70%;padding:10px 0 10px 30px;">
                                       <ul>
                                            <li style="text-align: right;direction: rtl">حداقل مبلغ قابل برداشت <span style="color:#fc0;">۵۰,۰۰۰ تومان</span> می باشد.</li>
                                            <li style="text-align: right;direction: rtl">مبالغ با استفاده از سیستم پایا واریز میشوند پس حتما شماره شبا حساب خود را به درستی وارد کنید.</li>
                                        </ul>
                                    </div>-->
                                    <div class="right report" style="width:50%;text-align: right">
                                        <div style="width:100%;">
                                            <span class="report-title">موجودی حساب</span>
                                            <span class="report-data"><span class="btn btn-success" style="font-weight:bold;direction: rtl;">{$cash|price_format}</span></span>
                                        </div>
                                    </div>
                                    <div class="clear">&nbsp;</div>

                                    <form action="{$action}" method="post" class="form-inline credit" style="width:65%;margin:30px auto 10px;">
                                        <div class="row">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><label for="amount">مبلغ به تومان</label>*</span>
                                                    <input name="amount" dir="ltr" autocomplete="off" class="amount form-control" value="" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12 col-lg-12">
                                                <div class="form-group" style="
    padding-right: 0;
">
                                                    <div class="input-group">
                                                        <span class="input-group-addon"><label for="amount">نام صاحب حساب</label>*</span>
                                                        <input name="account_holder" autocomplete="off" class="form-control" value="" type="text"> 
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><label for="amount">نام بانک</label>*</span>
                                                    <select class="form-control" style="padding:0;" name="bank_name">
                                                        <option value="سامان">سامان</option>
                                                        <option value="ملت">ملت</option>
                                                        <option value="سپه">سپه</option>
                                                        <option value="ملی">ملی</option>
                                                        <option value="آینده">آینده</option>
                                                        <option value="اقتصاد نوین">اقتصاد نوین</option>
                                                        <option value="انصار">انصار</option>
                                                        <option value="ایران زمین">ایران زمین</option>
                                                        <option value="پارسیان">پارسیان</option>
                                                        <option value="پاسارگاد">پاسارگاد</option>
                                                        <option value="تجارت">تجارت</option>
                                                        <option value="دی">دی</option>
                                                        <option value="رفاه">رفاه</option>
                                                        <option value="سرمایه">سرمایه</option>
                                                        <option value="سینا">سینا</option>
                                                        <option value="شهر">شهر</option>
                                                        <option value="صادرات">صادرات</option>
                                                        <option value="قوامین">قوامین</option>
                                                        <option value="کشاورزی">کشاورزی</option>
                                                        <option value="مسکن">مسکن</option>
                                                        <option value="سایر">سایر</option>
                                                    </select>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><label for="sheba">شماره شبا</label>*</span>
                                                    <input name="sheba" dir="ltr" autocomplete="off" class="form-control" value="" type="text" id="sheba" placeholder="IR00-0000-0000-0000-0000-0000-00">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="form-group">
                                                <div class="input-group">
                                                    <span class="input-group-addon"><label for="amount">شماره کارت</label></span>
                                                    <input name="card_no" dir="ltr" autocomplete="off" class="form-control" value="" type="text">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12">
                                                <div class="control-group ">
                                                    <div class="controls">
                                                        <input class="btn"  class="input_page" type="submit"  value="ثبت درخواست" class="input-xlarge">
                                                    </div>
                                                </div>
                                            </div> 
                                        </div>
                                    </form>
                                    <table class="list" id="" style="" align="center" cellpadding="0" cellspacing="0" dir="rtl">
                                        <thead>
                                            <tr><th style="width:200px;border-right:0;">شناسه درخواست</th>
                                                <th style="">تاریخ درخواست</th>
                                                <th style="width:200px;">مبلغ درخواستی</th>
                                                <th style="width:150px;">وضعیت</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            {foreach $withdrawList as $val}
                                                <tr class="odd"><td style="color:#fc0;border-right:0;">   {$val->id}</td>
                                                    <td style=""> 
                                                        {jdate format='j F Y - h:i a' date=$val->created_at}
                                                    </td>
                                                    <td style="">  
                                                        {$val->amount|price_format}
                                                    </td>
                                                    <td style=""><span class="label label-lion">
                                                            {if $val->status eq 0}
                                                                پرداخت نشده/درحال بررسی
                                                            {else if $val->status eq -1}
                                                                درخواست رد شده است
                                                            {else if $val->status eq 1}
                                                                پرداخت شده
                                                            {else if $val->status eq 2}
                                                                بررسی شده، در انتظار پرداخت
                                                            {else if $val->status eq 3}
                                                                ردشده (عدم رعایت قوانین)
                                                            {/if}

                                                        </span>
                                                    </td>
                                                </tr>
                                            {/foreach}
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>