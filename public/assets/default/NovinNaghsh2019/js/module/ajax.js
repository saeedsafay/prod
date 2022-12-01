define(function (require, exports, module) {
    let $ = require('jquery'),
        obj_lang = require('lang');


    function construct() {

        // Ajax data
        this.option = {
            data: {},

            method: 'POST',
            url: '/',

            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',

            beforeSend: this.before_send_default,
        }
    }

    construct.prototype = {
        init: function () {
            //  Initialize function

            //  events
        },

        //  set url of ajax option
        ajax_set_url: function (url) {

            //  change default url of ajax's options
            this.option.url = url;
        },

        //  filling data into ajax request
        ajax_put_data: function (data) {

            //  filling data into submit request FormData
            this.option.data = data;
        },

        //  create ajax opject
        ajax_create: function (ajax_done, ajax_fail, ajax_always, ajax_before_send, item) {
            this.option.method = item.method;
            this.option.data = item.data;
            this.option.url = item.url;

            //  set before send function into options
            this.option.beforeSend = ajax_before_send;


            //  send a default request to default url
            this.jqxhr = $.ajax(this.option);
            this.jqxhr.done(ajax_done);
            this.jqxhr.fail(ajax_fail);
            this.jqxhr.always(ajax_always);
        },

        //  callback response shopping cart
        before_send_default: function (xhr) {

            //  default function before send ajax request

        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});
