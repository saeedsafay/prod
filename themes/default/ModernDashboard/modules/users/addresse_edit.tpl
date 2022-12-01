{if isset($User->location->lat)}
    <script>
        shop_pos = {literal}{{/literal}latitude: {$User->location->lat}, longitude:{$User->location->long}{literal}}{/literal}
    </script>
{/if}
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
                                    <h4 class="title_header"><span class="title_border">اطلاعات آدرس:</span> </h4>
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="title">عنوان آدرس*:</label>
                                            <div class="controls">
                                                <input class="put_width" class="input_page" type="text" id="title" name="title" value="{set_value('title',(isset($address->title)) ? $address->title: set_value('title') )}" placeholder="" class="input-xlarge">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="province">استان:</label>
                                            <div class="controls">
                                                <select class="select_rm" name="province_id" id="province">
                                                    <option value="" selected="" disabled="">انتخاب استان</option>
                                                    {foreach $Provinces as $prv}
                                                        <option {if isset($User->location->province_id) AND $User->location->province_id eq $prv.id}selected=""{/if} value="{$prv.id}">{$prv.name}</option>
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    {if isset($User->location->province_id)}
                                        <input type="hidden" name="province_id_hidden" value="{$User->location->province_id}" />                         
                                        <input type="hidden" name="county_id_hidden" value="{$User->location->county_id}" />
                                        <input type="hidden" name="region_id_hidden" value="{$User->location->region_id}" />      
                                        <input type="hidden" name="neighbourhood_id_hidden" value="{$User->location->neighbourhood_id}" />      
                                    {/if}
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12" id="county-wrapper" style="display: none;">
                                        <div class="control-group ">
                                            <i class="fa fa-spinner fa-pulse fa-3x fa-fw" style="display:none;"></i>
                                            <label class="control-label lbl_space" for="county">شهر:</label>
                                            <div class="controls">
                                                <select class="select_rm" name="county_id" id="county">
                                                    <option value="" disabled="" selected="">انتخاب شهر</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div> 
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12" id="region-wrapper"  style="display: none;">
                                        <div class="control-group ">
                                            <i class="fa fa-spinner fa-pulse fa-3x fa-fw" style="display:none;"></i>
                                            <label class="control-label lbl_space" for="region">منطقه:</label>
                                            <div class="controls">
                                                <select class="select_rm" name="region_id" id="region">
                                                    <option value="" disabled="" selected="">انتخاب منطقه</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div> 			
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12" id="neighbourhood-wrapper" style="display: none;">
                                        <div class="control-group ">
                                            <i class="fa fa-spinner fa-pulse fa-3x fa-fw" style="display:none;"></i>
                                            <label class="control-label lbl_space" for="neighbourhood">محله:</label>
                                            <div class="controls">
                                                <select class="select_rm" name="neighbourhood_id" id="neighbourhood">
                                                    <option value="" disabled="" selected="">انتخاب محله</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div> 
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="full_address">آدرس کامل پستی*:</label>
                                            <div class="controls">
                                                <input class="put_width" class="input_page" type="text" id="full_address" name="full_address" value="{set_value('full_address',(isset($address->full_address)) ? $address->full_address: set_value('full_address') )}" placeholder="" class="input-xlarge">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">
                                            <label class="control-label lbl_space" for="postal_code">کدپستی:</label>
                                            <div class="controls">
                                                <input name="postal_code" class="put_width" class="input_page" type="text" id="postal_code"   value="{set_value('postal_code',(isset($address->postal_code)) ? $address->postal_code: set_value('postal_code') )}" class="input-xlarge">
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-6 col-lg-6 col-md-offset-6 col-sm-12 col-xs-12">
                                        <div class="control-group ">

                                            <h4 class="title_header"><span class="title_border">پین گذاری موقعیت خریدار روی نقشه:</span></h4>
                                            <div class="controls">
                                                <div id="us2" style="width: 500px; height: 400px;"></div>
                                                <div style="display: none;">
                                                    (ارتفاع جغرافیایی)Lat.: <input name="lat" type="text" id="us2-lat" />
                                                    (عرض جغرافیایی)Long.: <input type="text" name="long" id="us2-lon" />
                                                </div>
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
</section>
