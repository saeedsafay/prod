define(function (require, exports, module) {
    require('parsley_fa');

    let $ = require('jquery'),
        obj_lang = require('lang'),
        obj_confirm = require('../module/jquery-confirm');


    function construct() {
        this.newsletter_form = $('#newsletter-footer');
        this.email_input = this.newsletter_form.find('.input-subscribe');
        this.csrf_token = $('input[name="__token"]');
        this.subscribe_submit = this.newsletter_form.find('button[type="submit"]');
        // Ajax data
        this.option = {
            data: {},

            method: 'POST',
            url: '/',

            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',

            beforeSend: this.before_send,
        }
    }

    construct.prototype = {
        init: function () {
            this.init_event();
        },
        init_event: function () {
            this.newsletter_form.on('submit', this.ajax_newsletter);
        },
        ajax_newsletter: function (event) {
            event.preventDefault();
            let options = {
                method: 'POST',
                url: main_obj.newsletter_form.attr('action'),
                data: {"email": main_obj.email_input.val(), 'csrf': main_obj.csrf_token.val()},
                dataType: 'json',
                beforeSend: main_obj.before_send,
            };
            //  send a default request to default url
            this.jqxhr = $.ajax(options);
            this.jqxhr.done(main_obj.newsletter_done);
            this.jqxhr.fail(main_obj.request_failed);
            this.jqxhr.always(main_obj.address_always);
        },
        before_send: function () {
            main_obj.subscribe_submit.attr('disabled', true);
            main_obj.subscribe_submit.find('i.fa-spin').removeClass('hidden');
        },
        newsletter_done: function (response, textStatus, jqXHR) {
            obj_confirm.info(response.message);
        },
        address_always: function (data, textStatus, jqXHR) {

            main_obj.subscribe_submit.removeAttr('disabled');
            main_obj.subscribe_submit.find('i.fa-spin').addClass('hidden');
        },
        request_failed: function (jqXHR, textStatus, errorThrown) {

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

            // console.log(jqXHR, textStatus, errorThrown, jqXHR.responseJSON.error)
        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

