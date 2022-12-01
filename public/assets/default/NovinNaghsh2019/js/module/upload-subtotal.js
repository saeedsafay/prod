define(function (require, exports, module) {
    let $ = require('jquery'),
        obj_toggle = require('../module/upload-toggle'),
        obj_cart = require('../module/upload-cart'),
        obj_json = require('../module/upload-json'),
        obj_global = require('../module/upload-global'),
        obj_lang = require('lang');


    function construct() {
        //  upload's variable
        //  Product fix subtotal in left
        this.subtotal = $('.js-upload-fixtotal');
        this.subtotal_side = $('.js-subtotal-side');
        this.subtotal_exist = this.subtotal.length > 0;
        this.subtotal_price = $('.js-subtotal-price');
        this.subtotal_list = $('.js-subtotal-list');
        this.subtotal_item = $('.js-subtotal-item');
        this.subtotal_services = $('.js-subtotal-service');
        this.subtotal_quantity = $('.js-subtotal-quantity');
        this.subtotal_delivery = $('.js-subtotal-delivery');
        this.subtotal_price_wrap = $('.js-subtotal-price-w');
        this.subtotal_width = 0;
        this.subtotal_opt = {
            topSpacing: 75,
            bottomSpacing: 30,
            widthFromWrapper: false
        };
    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },
        init_ready: function (e) {
            // subtotal initialize JS product sizing
            if (main_obj.subtotal_exist) this.subtotal_init();

        },
        init_event: function () {
        },

        // subtotal initialize JS product sizing
        subtotal_init: function () {
            this.subtotal.addClass('is-show');

            this.subtotal_width = this.subtotal.outerWidth(true);

            //  make subtotal sticky
            // this.subtotal.sticky(this.subtotal_opt);
            // this.subtotal.on('sticky-start', this.subtotal_sticky_start);
            // this.subtotal.on('sticky-bottom-unreached', this.subtotal_sticky_unreached);
        },
        subtotal_sticky_start: function (event, sticky) {
            sticky.stickyElement.outerWidth(main_obj.subtotal_width);
        },
        subtotal_sticky_unreached: function (event, sticky, a, b, c) {
            console.log(event, sticky, a, b, c)
        },

        // get subtotal price in JS product sizing
        size_update_price: function (event) {
            let input = $(event.currentTarget),
                id = input.val();

            let json = obj_global.get_input_json(event);

            //  get service title, values & price from json
            json.srv_title = obj_global.get_persian_title(json);
            json.srv_value = obj_global.get_persian_value(json, id);
            json.price = obj_global.get_price_update(json);

            this.subtotal_update(input, json);
        },
        subtotal_update: function (input, json) {
            if (json.name == obj_global.service_keys.size) {

                //  clear all services in subtotal
                this.subtotal_clear();

                this.subtotal_item.find('.title').html(json.title);
                this.subtotal_item.find('.price').remove();

            } else if (json.name == obj_global.service_keys.qty) {

                //  clear all delivery, corner, services' inputs
                this.subtotal_remove_aft_qty();

                //  update quantity into subtotal
                let val = input.val().length > 0 ? input.val() : 0;

                this.subtotal_quantity.find('.price').html(val + obj_lang.upload.number);

            } else if (json.name == obj_global.service_keys.delivery) {

                //  clear all services in subtotal
                this.subtotal_remove_service();

                //  update delivery into subtotal
                this.subtotal_delivery.find('.price').html(input.val() + obj_lang.upload.work_day);

                // if there aren't any extra services like pixels
                if (!obj_global.selected_data.service_status) {
                    this.subtotal_add(json);
                }
            } else {

                //  update service into subtotal
                //  set service value 0 if non-selected
                if (input.val().length == 0)
                    json.srv_value = '0';

                //  sub service if it was duplicated
                if (input.attr('name') == json.name)
                    this.subtotal_sub(json);

                //  set delivery in subtotal if, it's product detail page
                if (obj_global.selected_data.product_tpl)
                    this.subtotal_delivery.html(obj_global.selected_data.delivery + obj_lang.upload.work_day);

                //  remove default service
                this.subtotal_list.find('[data-name="services"]').remove();

                //  add service into subtotal
                this.subtotal_add(json, 'js-subtotal-service', json.name);
            }
        },

        subtotal_add: function (json, class_name, data_name) {
            let elm = '';

            if (class_name !== undefined) {
                // checked if services were changing
                if (obj_json.check_subtotal_service(json, obj_global.service_keys))
                    elm = this.subtotal_add_elm(json.title, json.price, class_name, data_name);
                else
                    elm = this.subtotal_add_elm(json.srv_title, json.srv_value, class_name, data_name);


                //  add elm into cart
                this.subtotal_price_wrap.before(elm);
            }

            //  element size and subtotal has prices
            if (json.price > 0) {
                let subtotal = obj_cart.upload_cart_add(json);

                subtotal = subtotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                this.subtotal_price.html(subtotal + obj_lang.upload.currency);
            } else {

                // write out of stock if, price is zero
                this.subtotal_price.html(obj_lang.upload.outOfStock);
            }
        },
        subtotal_sub: function (json) {
            let subtotal = obj_cart.upload_cart_sub(json);

            this.subtotal_list.find('[data-name="' + json.name + '"]').remove();

            subtotal = subtotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            this.subtotal_price.html(subtotal + obj_lang.upload.currency);
        },

        subtotal_add_elm: function (title, price, class_name, data_name) {
            let elm = $('<li></li>').addClass(class_name).attr('data-name', data_name);

            elm.append($('<span></span>').addClass('title').text(title));

            //  element size and subtotal has prices
            price = price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            elm.append($('<span></span>').addClass('price').text(price));

            return elm;
        },

        subtotal_clear: function () {
            obj_cart.upload_cart_clear();

            //  it was for round input that we had
            // obj_toggle.off();

            this.subtotal_item.find('.title').html(obj_lang.upload.chose_size);
            this.subtotal_item.find('.price').html('0');

            this.subtotal_quantity.find('.price').html('0');
            this.subtotal_delivery.find('.price').html('0');

            this.subtotal_remove_service();
        },
        subtotal_remove_aft_qty: function () {
            this.subtotal_delivery.find('.price').html('0');

            this.subtotal_remove_service();
        },
        subtotal_remove_service: function () {
            this.subtotal_list.find('.js-subtotal-service').remove();

            //  add elm into cart
            let elm = this.subtotal_add_elm(obj_lang.upload.chose_service, 0, 'js-subtotal-service', 'services');

            this.subtotal_price_wrap.before(elm);

            this.subtotal_clear_price();
        },
        subtotal_clear_price: function () {
            obj_cart.upload_cart_clear();

            this.subtotal_price.html('0' + obj_lang.upload.currency);
        }

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

