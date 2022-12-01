<div class="container">
    <div class="step-wizard-wrap js-step-upload-wrap sw-main">
        <ul class="container nav nav-tabs step-tabs">
            <div class="step-head hidden">
                <h3 class="title js-step-headline">انتخاب سایز</h3>
                <p class="text js-step-headtext">لطفا سایز خود را انتخاب نمایید</p>
            </div>
            <li>
                <a class="js-step-link nav-link" href="#js-upload-size-wrapp">
                    <h3 class="title">
                        <small>1</small>
                        سایز
                    </h3>
                </a>
            </li>
            <li>
                <a class="js-step-link nav-link" href="#js-upload-size-service">
                    <h3 class="title">
                        <small>2</small>
                        تعداد
                    </h3>
                </a>
            </li>
            <li>
                <a class="js-step-link nav-link" href="#js-upload-size-extra">
                    <h3 class="title">
                        <small>3</small>
                        خدمات
                    </h3>
                </a>
            </li>
            <li class="hidden">
                <a class="js-step-link nav-link" href="#js-upload-sec">
                    <h3 class="title">
                        <small>4</small>
                        آپلود طرح
                    </h3>
                </a>
            </li>
            <div class="step-submit">
                <a class="btn btn-primary link-item next disabled js-step-wizard-next"
                   title="فرم اختصاصی سفارش چاپ طرح دلخواه">
                    <svg class="shape" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 124.59 45.26">
                        <path d="M-84.12,309.76c-4.62-.43-17.8-3.26-17.8-10.68,0-2.52.64-3.85,3-7.12l.08-.11c.11-.17.22-.34.32-.51a15.65,15.65,0,0,0,2.61-8.87,15.81,15.81,0,0,0-.09-1.69,16.07,16.07,0,0,0-8.32-12.67l-.34-.2-.79-.37c-.25-.12-.49-.24-.75-.34l-.48-.18q-.52-.19-1-.36l-.34-.08c-.39-.11-.79-.21-1.19-.29l-.47-.07c-.36-.06-.72-.13-1.08-.16-.53-.05-1.07-.08-1.6-.08s-1,0-1.58.08a16.46,16.46,0,0,0-10.9,5.64l0,0c-.26.3-.5.62-.74.93-.11.15-.23.3-.33.45s-.26.39-.38.59-.36.57-.53.86l-.14.28c-.21.39-.4.8-.58,1.21a.14.14,0,0,0,0,.06,15.24,15.24,0,0,0-.94,3,2.17,2.17,0,0,0,0,.25,12.39,12.39,0,0,0-.21,1.38,16,16,0,0,0-.09,1.71,16.06,16.06,0,0,0,1.31,6.63c2.47,6.25,1.75,9.95.31,12.33s-5.45,4.94-13.3,6-53.16,2.34-54.07,2.34a17.49,17.49,0,0,0-7.06,1.48H-77.17C-79.21,310.29-80.37,310.11-84.12,309.76Z"
                              transform="translate(201.76 -265.98)"/>
                    </svg>
                    <span class="content">ثبت و مرحله بعد</span>
                    <i class="fas fa-circle-notch fa-spin"></i>
                </a>
            </div>
        </ul>
        <div class="step-wizard step-container tab-content">
            <div class="js-step-content tab-pane step-content" id="js-upload-size-wrapp" style="display: block">
                <div class="container">
                    <div class="step-button-wrapp">
                        <div class="row">
                            {foreach $payload->formInitData->sizes->values as $size }
                                <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4">
                                    <label class="upload-sizing-wrapp js-upload-size js-upload-osize"
                                           data-id="{$size->diversity_value_id}"
                                           data-name="{$payload->formInitData->sizes->name}">
                                        <div class="image js-sizing-image">
                                            {if isset($size->image)}
                                                <img src="/upload/variants/{$size->image}"
                                                     alt="{$size->title}">
                                            {else}
                                                <img src="{assets_url}images/card-size/novinnaghsh-business_card-standard.jpg"
                                                     alt="{$size->title}">
                                            {/if}
                                        </div>
                                        <h4 class="title">
                                            <input name="{$payload->formInitData->sizes->name}" type="radio"
                                                   value="{$size->diversity_value_id}">
                                            <span class="js-input-title">{$size->title}</span>
                                        </h4>
                                    </label>
                                </div>
                            {/foreach}
                        </div>
                        <div class="step-buttons">
                            <a class="previous js-step-size-previous disabled" href="#" title="مرحله قبلی"><i
                                        class="fa fa-chevron-right"></i></a>
                            <a class="next js-step-size-next disabled" href="#" title="مرحله بعدی"><i
                                        class="fa fa-chevron-left"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="js-step-content tab-pane step-content" id="js-upload-size-service">
                <div class="container">
                    <div class="step-button-wrapp">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4">
                                {if isset($payload->formInitData->qty) && $payload->formInitData->qty != null}
                                    <label class="upload-sizing-wrapp js-upload-size js-upload-qty" data-id="4"
                                           data-name="{$payload->formInitData->qty->name}">
                                        <h4 class="title medium-title">
                                            <span class="js-input-title">تعداد</span>
                                            <select name="qty" class="form-control input-select js-qty-select">
                                                <option value="">انتخاب تعداد</option>
                                                {foreach $payload->formInitData->qty->values as $qty }
                                                    <option value="{$qty->diversity_value_id}">{$qty->title}</option>
                                                {/foreach}
                                            </select>
                                        </h4>
                                    </label>
                                {else}
                                    <label class="upload-sizing-wrapp js-upload-size js-upload-qty" data-id=""
                                           data-name="static">
                                        <h4 class="title medium-title">
                                            <span class="js-input-title">تعداد</span>
                                            <select name="qty" class="form-control input-select js-qty-select">
                                                <option value="">انتخاب تعداد</option>
                                                {for $i = 1; $i <= 10; $i++}
                                                    <option value="{$i}">{$i}</option>
                                                {/for}
                                            </select>
                                        </h4>
                                    </label>
                                {/if}
                            </div>
                            {foreach $payload->formInitData->available_lead_times as $lead_time}
                                <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4">
                                    <label class="upload-sizing-wrapp js-upload-size js-upload-delivery" data-id=""
                                           data-name="delivery">
                                        <h4 class="title medium-title">
                                            <input name="delivery" type="radio" value="{$lead_time}">
                                            <span class="js-input-title">{$lead_time} روز کاری</span>
                                        </h4>
                                    </label>
                                </div>
                            {/foreach}
                        </div>
                        <div class="step-buttons">
                            <a class="previous js-step-size-previous disabled" href="#" title="مرحله قبلی"><i
                                        class="fa fa-chevron-right"></i></a>
                            <a class="next js-step-size-next disabled" href="#" title="مرحله بعدی"><i
                                        class="fa fa-chevron-left"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="js-step-content tab-pane step-content" id="js-upload-size-extra">
                <div class="container">
                    <div class="step-button-wrapp">
                        <div class="row">
                            {foreach $payload->formInitData->services as $key => $service}
                                <div class="col-xs-6 col-sm-6 col-md-4 col-lg-4">
                                    <label class="upload-sizing-wrapp js-upload-size js-upload-services"
                                           data-id=""
                                           data-name="{$key}">
                                        <div class="image js-service-image" id="serivce-image-{$key}">
                                            {if isset($service->values[0]->image)}
                                                <img src="/upload/variants/{$service->values[0]->image}"
                                                     alt="{$service->values[0]->title}">
                                            {else}
                                                <img src="{assets_url}/images/card-size/novinnaghsh-business_card-standard.jpg"
                                                     alt="{$service->label}">
                                            {/if}
                                        </div>
                                        <h4 class="title">
                                            <span class="js-input-title">{$service->label}</span>
                                        </h4>
                                        <div class="sizing-srv-select">
                                            <select name="{$key}" class="form-control input-select js-srv-select">
                                                <option selected disabled value="">{$service->label}</option>
                                                {foreach $service->values as $value}
                                                    <option value="{$value->diversity_value_id}"
                                                            data-img="{$value->image}">
                                                        {$value->title}
                                                    </option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </label>
                                </div>
                            {/foreach}
                        </div>
                        <div class="step-buttons">
                            <a class="previous js-step-size-previous disabled" href="#" title="مرحله قبلی"><i
                                        class="fa fa-chevron-right"></i></a>
                            <a class="next js-step-size-next disabled" href="#" title="مرحله بعدی"><i
                                        class="fa fa-chevron-left"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            <div class="js-step-content tab-pane step-content" id="js-upload-sec">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12 col-xs-12">
                            <div class="preview-wrapp">
                                <ul class="list-unstyled preview-side">
                                    <li class="is-active">
                                        <a class="js-preview-link"
                                           title="آپلود طرح روی {$currentCategory->parentCat->title} - {$currentCategory->title}"
                                           data-layer-id="0"
                                           href="#">
                                            <i class="fa fa-layer-group"></i> طرح یک
                                        </a>
                                    </li>
                                    <li>
                                        <a class="js-preview-link"
                                           title="آپلود طرح پشت {$currentCategory->parentCat->title} - {$currentCategory->title}"
                                           data-layer-id="1"
                                           href="#">
                                            <i class="fa fa-layer-group"></i> طرح دو
                                        </a>
                                    </li>
                                </ul>
                                <div class="row">
                                    <div class="col-md-9 col-sm-12 col-xs-12">
                                        <div class="preview-dropzone js-preview-dropzone" data-layer-id="0">
                                            <h3 class="title js-dropzone-title">آپلود طرح
                                                {$currentCategory->parentCat->title} - {$currentCategory->title}</h3>
                                            <a class="droplink" href="#"
                                               title="آپلود طرح {$currentCategory->parentCat->title} - {$currentCategory->title}"><i
                                                        class="fa fa-cloud-upload-alt"></i> آپلود تصویر</a>
                                        </div>
                                        <div class="preview-dropzone preview-response is-hide js-preview-response">
                                            <div class="edit-bar">
                                                <a class="link" href="#" id="js-edit-download">
                                                    <i class="fa fa-cloud-download-alt"></i>
                                                    مشاهده فایل
                                                </a>
                                                <a class="link" href="#" id="js-edit-remove">
                                                    <i class="fa fa-trash"></i>
                                                    حذف فایل
                                                </a>
                                            </div>
                                            <i class="icon far fa-file-image"></i>
                                            <div class="name js-file-name"></div>
                                            <div class="size js-file-size"></div>
                                        </div>
                                        <div class="preview-dropzone preview-progress is-hide"
                                             id="js-preview-progress"></div>
                                        <div class="preview-messages is-hide" id="js-preview-messages"></div>
                                    </div>
                                    <div class="col-md-3 col-sm-12 col-xs-12">
                                        <div class="preview-detail-file">
                                            <h5 class="title">جزییات فایل</h5>
                                            <p>می توانید توضیحات اختیاری خود را درباره طرح بارگذاری شده بنویسید</p>
                                            <textarea class="form-control" name="printing_desc" rows="3"
                                                      placeholder="توضیحات" id="js-detail-comment"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <input id="js-preivew-input-0" type="file" name="upload-input-0" class="hidden"
                                   data-layer-id="0">
                            <input id="js-preivew-input-1" type="file" name="upload-input-1" class="hidden"
                                   data-layer-id="1">
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container">
            <div class="upload-fixtotal-wrap js-upload-fixtotal">
                <ul class="upload-fixtotal-detail list-unstyled js-subtotal-list">
                    <li class="js-subtotal-item">
                        <span class="title">سایز</span>
                        <span class="price">0</span>
                    </li>
                    <li class="js-subtotal-quantity">
                        <span class="title">تعداد</span>
                        <span class="price">0</span>
                    </li>
                    <li class="js-subtotal-delivery">
                        <span class="title">زمان تحویل</span>
                        <span class="price">0</span>
                    </li>
                    <li class="js-subtotal-service" data-name="services">
                        <span class="title">خدمات</span>
                        <span class="price">0</span>
                    </li>
                    <li class="total js-subtotal-price-w">
                        <span class="title">جمع کل</span>
                        <span class="price js-subtotal-price">0 ریال</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
