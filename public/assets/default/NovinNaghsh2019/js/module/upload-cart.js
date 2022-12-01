define(function (require, exports, module) {

    let $ = require('jquery'),
        obj_toggle = require('../module/upload-toggle'),
        obj_lang = require('lang');


    function construct() {
        // Cart option in product upload JS
        this.total = 0;
        this.discount = 0;
        this.subtotal = 0;
        this.size_id = 1;
        this.size_title = '';
        this.rounded = 0;
        this.round_title = obj_lang.upload.squared;
        this.extra_option = [];
    }

    construct.prototype = {
        init: function () {
            //
        },

        // Add cart JS in upload section
        upload_cart_add: function (value) {
            this.upload_cart_add_option(value);

            return this.upload_cart_get_subtotal();
        },
        upload_cart_add_option: function (value) {
            this.extra_option.push(value.title);

            this.total += value.price;
        },

        // Subtract cart JS in upload section
        upload_cart_sub: function (value) {
            this.upload_cart_sub_option(value);

            return this.upload_cart_get_subtotal();
        },
        upload_cart_sub_option: function (value) {
            let remove_index = this.extra_option.indexOf(value.title);

            if(remove_index > -1)
                this.extra_option.splice(remove_index, 1);

            this.total = 0;
        },

        // Clear cart JS in upload section
        upload_cart_clear: function () {
            this.total = 0;
            this.discount = 0;
            this.subtotal = 0;
            this.size_id = 1;
            this.size_title = '';
            this.rounded = 0;
            this.round_title = obj_lang.upload.squared;
            this.extra_option = [];

            return 1;
        },

        // Get subtotal cart JS in upload section
        upload_cart_get_subtotal: function () {
            let subtotal = this.total - this.discount;

            this.subtotal = subtotal < 0 ? 0 : subtotal;

            return this.subtotal;
        },
    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

