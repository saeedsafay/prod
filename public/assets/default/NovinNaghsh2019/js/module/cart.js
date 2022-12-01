define(function (require, exports, module) {
    require('parsley_fa');

    let $ = require('jquery'),
        obj_lang = require('lang'),
        obj_ajax = require('../module/ajax'),
        obj_confirm = require('../module/jquery-confirm');


    function construct() {
        this.coupon_check = $('#have-coupon');
        this.coupon_section = $('#coupon-section');
        this.coupon_code = this.coupon_section.find('input[name="coupon_code"]')
        this.apply_code = this.coupon_section.find('.apply-code');
        this.remove_coupon = $('.remove-coupon');
        this.ajax_apply_url = '/shop/products/apply-coupon';
        this.ajax_revoke_url = '/shop/products/revoke-coupon';

    }

    construct.prototype = {
        init: function () {
            this.init_event();
        },
        init_event: function () {
            this.coupon_check.on('change', this.toggle_coupon_section);
            this.apply_code.on('click', this.coupon_ajax_init);
            this.remove_coupon.on('click', this.remove_coupon_ajax);
        },
        remove_coupon_ajax: function (event) {
            // obj_confirm.confirm_massage('تخفیف اعمال شده حذف می شود!',function (confirmed){
            //
            //     alert(confirmed);
            // });
            event.preventDefault();
            let item = {
                method: "POST",
                data: {},
                url: main_obj.ajax_revoke_url
            };

            obj_ajax.ajax_create(main_obj.coupon_done, main_obj.coupon_fail, function () {
            }, function () {
            }, item);

        },
        toggle_coupon_section: function () {
            if (main_obj.coupon_section.hasClass('hidden')) {
                main_obj.coupon_section.removeClass('hidden');
            } else {
                main_obj.coupon_section.addClass('hidden');
            }
        },
        //  init coupon ajax
        coupon_ajax_init: function (event) {
            event.preventDefault();
            let item = {
                method: "POST",
                data: {"code": main_obj.coupon_code.val()},
                url: main_obj.ajax_apply_url
            };

            obj_ajax.ajax_create(main_obj.coupon_done, main_obj.coupon_fail, main_obj.coupon_always, main_obj.coupon_before_send, item);
        },
        //  ajax's callback function
        coupon_before_send: function (xhr) {

            main_obj.enable_progress_coupon();
        },
        coupon_always: function (data, textStatus, jqXHR) {

            main_obj.disable_progress_coupon();
        },
        coupon_done: function (results, textStatus, jqXHR) {

            if (jqXHR.status == 200) {

                obj_confirm.info(results.message);
                main_obj.coupon_code.val('');
                main_obj.coupon_section.addClass('hidden');
                window.setTimeout(function () {
                    location.reload();
                }, 1800);


            } else {

                //  show error jquery alert if happened error
                obj_confirm.alert(results.error);
            }


            // console.log(result, textStatus, jqXHR)
        },
        coupon_fail: function (jqXHR, textStatus, errorThrown) {

            //  show error jquery alert if happened error
            if (textStatus == 'error') {

                //  check if ajax reached to server or not
                if (jqXHR.responseJSON !== undefined && jqXHR.responseJSON.error !== undefined) {

                    //  check if response has error message and status
                    obj_confirm.alert(jqXHR.responseJSON.error);

                } else {

                    //  show error if response doesn't reach to server
                    obj_confirm.alert(obj_lang.ajax.errno2);
                }

            } else if (textStatus == 'timeout') {

                //  show timeout error
                obj_confirm.alert(obj_lang.ajax.errno3);
            } else {

                // show general error
                obj_confirm.alert(obj_lang.ajax.errno4);
            }
        },

        //  submit shopping state function
        enable_progress_coupon: function () {
            main_obj.apply_code.attr('disabled', true);
            main_obj.apply_code.find('i').removeClass('hidden');
        },
        disable_progress_coupon: function () {
            main_obj.apply_code.removeAttr('disabled');
            main_obj.apply_code.find('i').addClass('hidden');
        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

