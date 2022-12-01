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
                                    <h4 class="title_header"><span class="title_border">فرم مناسبت:</span> </h4>

                                    {validation_errors()}
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="title">عنوان مناسبت:</label>
                                            <div class="controls">
                                                <input class="put_width" class="input_page" type="text" id="title" name="title" value="{set_value('title',(isset($Reminder->title)) ? $Reminder->title: set_value('title') )}" placeholder="" class="input-xlarge">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space">نوع مناسبت:</label>
                                            <div class="controls">
                                                <select class="select_rm" name="reason_type">
                                                    <option value="" selected="" disabled="">انتخاب نوع مناسبت</option>
                                                    <option {if isset($Reminder) AND $Reminder->reason_type eq 'تولد'}selected=""{/if} value="تولد">تولد</option>
                                                    <option {if isset($Reminder) AND $Reminder->reason_type eq 'سالگرد ازدواج'}selected=""{/if} value="سالگرد ازدواج">سالگرد ازدواج</option>
                                                    <option {if isset($Reminder) AND $Reminder->reason_type eq 'آشنایی'}selected=""{/if} value="آشنایی">آشنایی</option>
                                                    <option {if isset($Reminder) AND $Reminder->reason_type eq 'ترحیم و تسلیت'}selected=""{/if} value="ترحیم و تسلیت">ترحیم و تسلیت</option>
                                                    <option {if isset($Reminder) AND $Reminder->reason_type eq 'ماهگرد'}selected=""{/if} value='ماهگرد'>ماهگرد</option>
                                                    <option {if isset($Reminder) AND $Reminder->reason_type eq 'سایر'}selected=""{/if} value="سایر">سایر</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    {if isset($Reminder->id)}
                                        <div class="row">
                                            <div class="col-lg-12 col-sm-12">
                                                <label>تاریخ انتخابی قبلی:</label>
                                                <strong class="title_header" style='float: right;
                                                        color: #3fb40e;'>
                                                    {jdate format='j F Y' date=$Reminder.date}
                                                </strong>
                                            </div>
                                        </div>
                                    {/if}
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="datepicker">تاریخ مناسبت:</label>
                                            <div class="controls">
                                                <input class="put_width datepicker" class="input_page" type="text" id="datepicker" name="date"  class="input-xlarge" value="{if isset($Reminder->id)}{$Reminder.date}{/if}" >
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-lg-6 col-md-offset-3 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label" for="description">:توضیحات </label>
                                            <div class="controls">
                                                <textarea rows="4" cols="55" name="description">{if isset($Reminder)}{$Reminder->description}{/if}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12 ">
                                        <div class="control-group ">
                                            <div class="controls">
                                                <input class="send" name="submitbtn" class="input_page" type="submit" value="ثبت" class="input-xlarge">
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
</div>
</div>
</section>
</section>