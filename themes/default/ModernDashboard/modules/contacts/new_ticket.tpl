<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12 col-sm-12 col-xs-12">
                    <div class="row">
                       
                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left col-sm-12 col-xs-12">
                            {include file='partials/header_menu.tpl'}

                            <form method="POST" action="{$action}" enctype="multipart/form-data">
                                <div class="row">
                                    <h4 class="title_header"><span class="title_border">تیکت جدید</span> </h4>
                                    <div class="row">
                                        <div class="col-lg-12 " dir="rtl">
                                            <label class="rtl">{if $user->type == 1}فرستنده{else}دریافت‌کننده{/if}: {$shop_name}</label>
                                        </div>
                                    </div>
                                    {if $Ticket}
                                        <div class="row">
                                            <div class="col-lg-12 col-md-12 col-sm-12">
                                                {foreach $Ticket->replies as $val}
                                                    <div style="
                                                         padding: 33px 15px 22px;
                                                         margin: 22px;
                                                         background: {if $user->id eq $val->user_id}#f4eded{else}#d8f6cc{/if};
                                                         width: 50%;
                                                         float:{if $user->id eq $val->user_id}right{else}left{/if};
                                                         direction: rtl;
                                                         text-align: right;
                                                         border-radius: 14px;
                                                         ">
                                                        <p>
                                                            {$val->content}
                                                            {if $val->attach}
                                                                کاربر یک فایل ضمیمه کرده است
                                                                <a href="{site_url}upload/users/{$val->attach}">دانلود فایل</a>
                                                            {/if}
                                                        </p>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        </div>
                                    {/if}
                                    {if !$Ticket}
                                        <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                            <div class="control-group ">
                                                <label class="control-label lbl_space" for="subject">عنوان تیکت*:</label>
                                                <div class="controls">
                                                    <input class="put_width" class="input_page" type="text" id="subject" name="subject" placeholder="" class="input-xlarge">
                                                </div>
                                            </div>
                                        </div>
                                    {/if}
                                    <div class="col-md-8 col-lg-8 col-md-offset-2">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="content">متن پیام:</label>
                                            <div class="controls">
                                                <textarea name="content" rows="4" cols="70"></textarea>
                                                <input type="hidden" value="{$recipient_id}" name="recipient_id" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-8 col-lg-8 col-md-offset-2">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="content">متن پیام:</label>
                                            <div class="controls">
                                                <input type="file" name="attach" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 col-lg-6 col-sm-12 col-xs-12 ">
                                        <div class="control-group ">
                                            <div class="controls">
                                                <input class="send" name="submitbtn" class="input_page" type="submit" value="ارسال" class="input-xlarge">
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