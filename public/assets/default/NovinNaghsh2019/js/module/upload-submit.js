define(function (require, exports, module) {

    let $ = require('jquery'),
        obj_toggle = require('../module/upload-toggle'),
        obj_global = require('../module/upload-global'),
        obj_confirm = require('../module/jquery-confirm'),
        obj_lang = require('lang'),
        obj_data = require('../module/upload-data');


    function construct() {
        //  submit shopping cart data

    }

    construct.prototype = {
        init: function () {
            //
        },

        // Export JSON cart JS in upload section
        submit_ajax_into_cart: function () {

            //  filling data into submit request FormData
            obj_data.shopping_opt.data = this.shopping_push_data();

            //  submit a request to shopping cart
            this.jqxhr = $.ajax(obj_data.shopping_opt);
            this.jqxhr.done(this.shopping_done);
            this.jqxhr.fail(this.shopping_fail);
            this.jqxhr.always(this.shopping_always);
        },
        shopping_push_data: function () {
            let id = obj_global.selected_data.product_id,
                qty = obj_global.selected_data.quantity,
                text = obj_data.detail_comment.val(),
                files = obj_data.file_pushed;

            //  return a serialized a json
            return {
                'product_varient_id': id,
                'qty': qty,
                'description': text,
                'files': files,
            };
        },

        //  callback response shopping cart
        shopping_before_send: function (xhr) {

            //  enable progress state
            //  disable submit button
            main_obj.enable_progress_shop();
        },
        shopping_always: function (data, textStatus, jqXHR) {

            //  disable progress state
            //  enable submit button
            main_obj.disable_progress_shop();
        },
        shopping_done: function (data, textStatus, jqXHR) {
            if (jqXHR.status == 200) {

                //  redirect to shopping cart if everything was success
                window.location.href = obj_data.shopping_href;
            } else {

                //  show error jquery alert if happened error
                obj_confirm.alert(data.error);
            }
        },
        shopping_fail: function (jqXHR, textStatus, errorThrown) {

            //  show error jquery alert if happened error
            if(textStatus == 'error') {

                //  check if ajax reached to server or not
                if(jqXHR.responseJSON !== undefined && jqXHR.responseJSON.error !== undefined) {

                    //  check if response has error message and status
                    obj_confirm.alert(jqXHR.responseJSON.error);

                } else {

                    //  show error if response doesn't reach to server
                    obj_confirm.alert(obj_lang.ajax.errno2);
                }

            } else if(textStatus == 'timeout') {

                //  show timeout error
                obj_confirm.alert(obj_lang.ajax.errno3);
            } else {

                // show general error
                obj_confirm.alert(obj_lang.ajax.errno4);
            }

// console.log(jqXHR, textStatus, errorThrown, jqXHR.responseJSON.error)
        },

        //  submit shopping state function
        enable_progress_shop: function () {
            obj_global.step_button_next.attr('disabled', true);
            obj_global.step_button_next.addClass('is-progress');
        },
        disable_progress_shop: function () {
            obj_global.step_button_next.removeAttr('disabled');
            obj_global.step_button_next.removeClass('is-progress');
        },
    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

