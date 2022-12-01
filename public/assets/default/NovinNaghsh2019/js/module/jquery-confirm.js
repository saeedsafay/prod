define(function (require, exports, module) {
    require('jquery_confirm');

    let $ = require('jquery'),
        obj_lang = require('lang');


    function construct() {

        this.info_opt = {
            rtl: true,
            theme: 'material',
            type: 'green',

            title: obj_lang.upload.info,
            closeIcon: true,

            draggable: false,
            escapeKey: true,
            backgroundDismiss: true,

            buttons: {
                ok: {
                    text: obj_lang.ajax.ok,
                    btnClass: 'btn btn-primary',
                }
            },
        };
        //  alert option
        this.alert_opt = {
            rtl: true,
            theme: 'material',
            type: 'red',

            title: obj_lang.ajax.error,
            closeIcon: true,

            draggable: false,
            escapeKey: true,
            backgroundDismiss: true,

            buttons: {
                ok: {
                    text: obj_lang.ajax.ok,
                    btnClass: 'btn btn-primary',
                }
            },
        }

    }

    construct.prototype = {
        init: function () {},

        info: function (msg) {
            let option = this.info_opt;

            option.content = msg;

            return $.alert(this.info_opt);
        },
        alert: function (msg) {
            let option = this.alert_opt;

            option.content = msg;

            return $.alert(this.alert_opt);
        },
        confirm_massage: function (msg, result_function) {
            let result = null;
            this.confirm_opt = {
                theme: 'material',
                type: 'red',
                status_confrim: null,
                confirmButton: 'بله',
                cancelButton: 'خیر',
                closeIcon: true,
                title: 'تایید',
                content: msg,
                confirm: approved_massage_click,
                cancel: not_approved_massage_click,
                onClose: status_confirm
            };
            function approved_massage_click() {
                result = true;
            }

            function not_approved_massage_click() {
                result = false;
            }

            function status_confirm() {
                result_function(result);
            }
            return $.confirm(this.confirm_opt);
        }
    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

