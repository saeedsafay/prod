define(function (require, exports, module) {
    require('parsley_fa');

    let $ = require('jquery'),
        obj_address = require('../module/dashboard-panel');


    function construct() {
        this.address_form = $('form.address-form');
        this.new_address_btn = $('.new-address');
        this.new_address_wrapper = $('.new-address-wrapper');

    }

    construct.prototype = {
        init: function () {
            this.init_event();
        },
        init_event: function () {
            this.new_address_btn.on('click', this.toggle_address_form);
        },
        toggle_address_form: function () {
            if (main_obj.address_form.hasClass('hidden')) {
                main_obj.address_form.removeClass('hidden');
            } else {
                main_obj.address_form.addClass('hidden');
            }
        }

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

