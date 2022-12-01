<div class="col-xs-12 col-md-12">
    <div class="form-group">
        <label class="title" for="js-address-phone-field">
            عنوان آدرس
            <span class="form-required">*</span>
        </label>
        <input type="text"
               name="title"
               class="form-control address-field"
               placeholder="مثال: خانه، یا محل کار">
    </div>
</div>
<div class="col-xs-12 col-md-6">
    <div class="form-group">
        <label class="title" for="address-province-field">
            استان
            <span class="form-required">*</span>
        </label>
        <select class="form-control js-address-field province"
                name="province_id"
                id="address-province-field">
            <option value="" selected disabled>انتخاب استان</option>
            {foreach $provinces as $province}
                <option value="{$province->id}">
                    {$province->name}
                </option>
            {/foreach}
        </select>
    </div>
</div>
<div class="col-xs-12 col-md-6">
    <div class="form-group">
        <label class="title" for="address-city-field">
            شهر
            <span class="form-required">*</span>
        </label>
        <select class="form-control county" name="county_id">
            <option value="">انتخاب شهر</option>
        </select>
    </div>
</div>
<div class="col-xs-12 col-md-6">
    <div class="form-group">
        <label class="title" for="js-address-phone-field">
            شماره موبایل گیرنده
            <span class="form-required">*</span>
        </label>
        <input type="text" id="js-address-phone-field"
               data-parsley-type="number"
               name="mobile"
               class="form-control js-address-field"
               placeholder="09000000000"
               >
    </div>
</div>
<div class="col-xs-12 col-md-6">
    <div class="form-group">
        <label class="title" for="js-address-post-field">کد پستی</label>
        <input type="text" id="js-address-post-field" data-parsley-type="number"
               name="postal_code"
               class="form-control js-address-field"
               placeholder="شامل 10 رقم">
    </div>
</div>
<div class="col-xs-12">
    <div class="form-group">
        <label class="title" for="js-address-delivery-field">
            آدرس پستی
            <span class="form-required">*</span>
        </label>
        <input type="text" id="js-address-delivery-field"
               name="delivery_address"
               class="form-control js-address-field"
               placeholder="میدان یا خیابان - کوچه - پلاک - طبقه یا شماره واحد">
    </div>
</div>
<div class="col-xs-12">
    <div class="form-group">
        <label class="title" for="js-address-comment-field">توضیحات</label>
        <textarea id="js-address-comment-field" name="extra_desc" type="text"
                  class="form-control js-address-field"
                  placeholder="توضیحات تکمیلی" rows="5"
                  minlength="3"></textarea>
    </div>
</div>
<div class="col-xs-12">
    <div class="text-left mb-10">
    </div>
</div>