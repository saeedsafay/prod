define(function (require, exports, module) {
    let $ = require('jquery');


    function construct() {
        //  fa languages translation
        //  size's translation section in upload page
        this.upload = {
            item_qty_disabled: 'برای این تعداد انتخاب شده این مقدار غیرفعال می باشد',
            item_select_disabled: 'طبق موارد انتخاب شده این مقدار غیرفعال می باشد',

            info: 'پیام',
            outOfStock: 'ناموجود',

            chose_size: 'انتخاب سایز',
            chose_quantity: 'انتخاب تعداد',
            chose_service: 'انتخاب خدمات',

            squared: 'چهارگوش',
            rounded: 'دورگرد',

            work_day: ' روز کاری',
            number: ' عدد',

            currency: ' ریال',

            default_title: 'چاپ کارت ویزیت',
            go_to_cart: 'اضافه به سبد خرید',
            return_to: 'بازگشت به',
            go_to: 'رفتن به',
        };

        //  ajax translation section in upload page
        this.ajax = {
            errno1: 'در آپلود فایل مشکلی پیش آمد، لطفا دوباره تلاش کنید.',
            errno2: 'ارتباط با سرور برقرار نشد، لطفا دوباره تلاش کنید.',
            errno3: 'ارتباط اینترنت شما ضعیف می باشد، لطفا دوباره تلاش کنید.',
            errno4: 'خطای سروری، لطفا دوباره تلاش کنید.',

            success_no1: 'فایل شما با موفقیت آپلود شد.',
            success_cart: 'محصول با موفقیت به سبد خرید اضافه شد',

            empty: 'موردی یافت نشد',

            error: 'خطا',
            confirm: 'تایید',
            yes: 'بله',
            no: 'خیر',
            ok: 'باشه',
        };

        //  step wizard plugin header
        this.wizard_header = [
            {
                title: 'انتخاب سایز',
                text: 'لطفا سایز خود را انتخاب نمایید',
            },
            {
                title: 'انتخاب تعداد',
                text: 'لطفا تعداد را انتخاب نمایید',
            },
            {
                title: 'انتخاب خدمات',
                text: 'لطفا خدمات خود را انتخاب نمایید',
            },
            {
                title: 'آپلود طرح',
                text: 'لطفا فایل خود را آپلود نمایید'
            },
        ];

    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

