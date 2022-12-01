{add_js file="js/bootstrap-notify.js" part="footer"}
<!-- Diversity modal -->
<div class="modal fade" id="diversity-modal" aria-hidden="true" aria-labelledby="diversity-modal-label" role="dialog" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" style=" float: right; ">&times;</button>
                <h5 class="modal-title" id="diversity-modal-label">درج تنوع</h5>
            </div>
            <div class="modal-body">
                <form action="{site_url}seller/manage-products/add-varient/{if isset($Product)}{$Product.id}{/if}"
                      id="varient-form">
                    <div class='errors'></div>
                    <div class="form-group row pt-3">
                        <div class="col-sm-4">
                            <div class="custom-control custom-checkbox">
                                <input name="diversity[status]"  value="1" type="checkbox" class="custom-control-input" id="status" checked="">
                                <label class="custom-control-label" for="status">فعال برای فروش در سایت </label>
                            </div>
                        </div>
                    </div>

                    <div {if !isset($Product)}style="display: none;" {/if} id="diversity-wrapper">
                        <div class="col-md-6 col-lg-6 p-b-20">
                            <div class="prd-diversities">
                                {if isset($Product) AND isset($Product->child_category)}
                                    {foreach $Product->child_category->diversities as $diversity}
                                        <div class="form-group">
                                            <label class="control-label">‌انتخاب {$diversity->label} :</label>
                                            <select class="form-control select2-custom"
                                                    name="diversity[particular][{$diversity->name}"
                                                    {if $diversity->field_type eq 1}multiple{/if} >
                                                <option value="" disabled="" selected="">انتخاب کنید...</option>
                                                {foreach $diversity->values as $data}
                                                    <option value="{$data->id}" {if $Product->diversities->contains($data->id)}selected=""{/if}>
                                                        {$data->title}
                                                    </option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    {/foreach}
                                {/if}
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 col-lg-6  p-b-20">
                                <div class="control-group">
                                    <label class="control-label">‌قیمت فروش (ریال) * :</label>
                                    <input type="text" name="diversity[price]" placeholder="" class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6  p-b-20">
                                <div class="control-group">
                                    <label class="control-label">‌تعداد موجودی نزد شما :</label>
                                    <input type="text" name="diversity[stock]" class="form-control" />
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6  p-b-20">
                                <div class="control-group">
                                    <label class="control-label">‌حداکثر تعدادی که مشتریان در یک سبد بتوانند سفارش دهند :</label>
                                    <input type="text" name="diversity[max_order]"  class="form-control"/>
                                </div>
                            </div>
                            <div class="col-md-6 col-lg-6  p-b-20">
                                <div class="control-group">
                                    <label class="control-label">‌بازه زمانی ارسال:</label>
                                    <input type="text" name="diversity[lead_time]" placeholder="تعداد روز"  class="form-control"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn waves-effect waves-light btn-info" id='save-varient'>ذخیره</button>
                        <button type="button" class="btn waves-effect waves-light btn-secondary" data-dismiss="modal">بستن</button>
                    </div>
                    <input type="hidden" id="product_id" value="{$Product.id}" />
                </form>
            </div>
        </div>
    </div>
</div>