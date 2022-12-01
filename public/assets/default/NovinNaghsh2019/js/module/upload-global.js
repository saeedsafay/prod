define(function (require, exports, module) {
    let $ = require('jquery'),
        obj_toggle = require('../module/upload-toggle'),
        obj_json = require('../module/upload-json');


    function construct() {
        //  wizard plugin JS
        //  container wizard
        this.step_wrap = $('.js-step-upload-wrap');
        this.step_exist = this.step_wrap.length>0;
        this.step_content = $('.js-step-content');

        //  wizard top header
        this.step_head = $('.js-step-headline');
        this.step_headtext = $('.js-step-headtext');
        this.step_link = $('.js-step-link');

        //  buttons wizard
        this.step_button_next = $('.js-step-wizard-next');
        this.step_button_prev = $('.js-step-wizard-prev');
        this.step_size_previous = $('.js-step-size-previous');
        this.step_size_next = $('.js-step-size-next');

        //  Product sizing JS
        //  wrap & containers selector
        this.size_wrap = $('.js-upload-size');
        this.size_only = $('.js-upload-osize');
        this.size_wrap_services = $('.js-upload-services');
        this.size_quantity = $('.js-upload-qty');
        this.size_delivery = $('.js-upload-delivery');

        this.size_input_title = $('.js-upload-size .js-input-title');

        //  input selectors
        this.size_only_radio_input = $('.js-upload-osize input[type="radio"]');
        this.size_radio_input = $('.js-upload-size input[type="radio"]');
        this.size_checkbox_input = $('.js-upload-size input[type="checkbox"]');
        this.size_radio_input_delivery = $('.js-upload-delivery input[type="radio"]');
        this.size_checkbox_input_servieces = $('.js-upload-services input[type="checkbox"]');
        this.size_qty_select = $('.js-qty-select');
        this.size_service_select = $('.js-srv-select');
        this.size_service_image = '.js-service-image img';

        //  Product detail page
        //  Custom selectors
        this.product_button_shopping = $('.js-add-shopping');
        this.quantity_input_wrap = $('.js-product-qty');
        this.product_link_image = '.js-product-link';

        // json of user's selected
        this.selected_data = {
            product_tpl: false,
            product_id: 0,
            image_id: null,
            size: 0,
            quantity: 0,
            delivery: 0,
            service_status: obj_json.json_service.length > 0,
            services: [],
            services_id: [],
            services_value: [],
        };

        //  json of dynamic quantity, services' keys
        this.service_keys = {
            size: this.size_only.attr('data-name') !== undefined ? this.size_only.attr('data-name') : 'size',
            qty: this.size_quantity.attr('data-name') !== undefined ? this.size_quantity.attr('data-name') : 'qty',
            delivery: 'delivery',
        };

    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },

        // get json from input
        get_input_json: function (event) {
            let item = $(event.currentTarget).closest(this.size_wrap),
                title = item.find(this.size_input_title).text(),
                service_id = item.find(this.size_service_select).val(),
                image_src = '';

            item.find('option').each(function (index, value) {
                if ($(value).attr('data-img') !== undefined && $(value).val() == service_id) {
                    image_src = $(value).attr('data-img');
                }
            })

            return json = {
                'id': item.attr('data-id'),
                'name': item.attr('data-name'),
                'image_src': image_src,
                'price': 0,
                'title': title,
                'srv_id': service_id,
                'srv_title': '',
                'srv_value': '',
                'checkbox_status': $(event.currentTarget).attr('type')
            };
        },
        get_data_name: function (event) {
            let item = $(event.currentTarget).closest(this.size_wrap);

            return item.attr('data-name');
        },


        // get category id
        get_category_id: function(json) {
            obj_json.json_category_id = 0;

            obj_json.json_variant_value_for(this.get_category_service, [ json ]);

            return obj_json.json_category_id;
        },
        get_category_service: function (item, index, item2, index2, arg) {
            if(item2.name == arg[0].name) {
                obj_json.json_category_id = item2.id;
            }
        },

        // get persian title
        // used to get services' title
        get_persian_title: function(json) {
            obj_json.json_serice_title = '';

            obj_json.json_variant_value_for(this.get_service_title_each, [ json ]);

            return obj_json.json_serice_title;
        },
        get_service_title_each: function(item, index, item2, index2, arg) {
            if(item2.name == arg[0].name) {
                obj_json.json_serice_title = item2.label;
            }
        },

        //  get persian services' value
        //  used to get services' value
        get_persian_value: function(json, id) {
            obj_json.json_service_value = '';

            obj_json.json_variant_value_for(this.get_service_value_each, [ json, id ]);

            return obj_json.json_service_value;
        },
        get_service_value_each: function(item, index, item2, index2, arg) {

            //  checking if id matches with item's id
            if(item2.value.id == arg[1]) {
                obj_json.json_service_value = item2.value.title;
            }
        },

        // get price from json
        get_price_update: function (json) {
            let size_id = main_obj.get_category_id({ name: this.service_keys.size }),
                qty_id = main_obj.get_category_id({ name: this.service_keys.qty });

            this.json_price = 0;

            if( this.selected_data.product_tpl || this.check_price_update(json, this.selected_data) ) {
                obj_json.json_variant_for(this.get_price_service, [this.selected_data, size_id, qty_id, json]);
            }

            return this.json_price;
        },
        get_price_service: function (item, index, arg) {
            let service_array = arg[0].services_id,
                service_values = arg[0].services_value;

            main_obj.items_is_valid = true;

            // if there aren't any services to get price
            if (main_obj.size_service_select.length == 0 && arg[3].name == main_obj.service_keys.delivery) {

                // set this for each size and then qty into variants of this item
                obj_json.jquery_obj_each(main_obj.get_price_non_srv_size, item.fields, [ item, index ]);

            } else {

                if (main_obj.service_keys.qty != "static") {

                    //  if qty isn't load dynamic
                    if (main_obj.selected_data.product_tpl || obj_json.check_size_qty_delivery(item, index, arg))
                        obj_json.jquery_for_each(main_obj.get_price_service_each, service_array, [item, index, service_values]);

                } else {

                    //  if qty is static
                    if (obj_json.check_size_delivery(item, index, arg))
                        obj_json.jquery_for_each(main_obj.get_price_service_each, service_array, [item, index, service_values]);
                }
            }

        },
        get_price_non_srv_size: function (item, index, arg) {

            // check if size selected equals to variant's size
            if (item.value.id == main_obj.selected_data.size) {
                obj_json.jquery_obj_each(main_obj.get_price_non_srv_qty, arg[0].fields, arg);
            }
        },
        get_price_non_srv_qty: function (item, index, arg) {

            // check if quantity selected equals to variant's qty
            if (item.value.title == main_obj.selected_data.quantity) {

                if (main_obj.service_keys.qty != "static") {

                    //  calculate price without multiply qty
                    main_obj.json_price = arg[0].price;

                } else {

                    //  calculate price with qty
                    main_obj.json_price = arg[0].price * main_obj.selected_data.quantity;
                }

                main_obj.selected_data.product_id = arg[1];
            }
        },
        get_price_service_each: function (id, index, arg) {

            //  checking if, user's selected is in variants' array
            if( arg[0].fields[id] !== undefined ) {
                let service_status = arg[0].fields[id].value.id.toString();

                //  checking if, user's selected is in variants' array
                //  And checking if all of user's selected are in variants' array
                if (arg[2].indexOf(service_status) !== -1 && main_obj.items_is_valid) {

                    //  checking if, this is last of user's selected
                    if (index + 1 == arg[2].length) {

                        if (main_obj.service_keys.qty != "static") {

                            //  calculate price without multiply qty
                            main_obj.json_price = arg[0].price;

                        } else {

                            //  calculate price with qty
                            main_obj.json_price = arg[0].price * main_obj.selected_data.quantity;
                        }

                        main_obj.selected_data.product_id = arg[1];

                        // set delivery time if, it's product page,
                        // and set image-id of product detail, if it was specified
                        if(main_obj.selected_data.product_tpl) {
                            main_obj.selected_data.delivery = arg[0].lead_time;

                            main_obj.selected_data.image_id = arg[0].product_image_id;
                        }

                    }
                } else {

                    //  set status false, if one of user's selected was false
                    main_obj.items_is_valid = false;
                }
            }
        },


        //  write and save json after user select something
        save_selected_data: function (event) {
            let item = $(event.currentTarget).closest(this.size_wrap);

            this.save_selected_switch(item.attr('data-name'), $(event.currentTarget));
        },
        save_selected_switch: function (name, input) {
            switch (name) {
                case this.service_keys.size:
                    this.clear_selected_data();
                    this.selected_data.size = input.val();
                    break;

                case this.service_keys.qty:
                    this.selected_data.quantity = input.val();
                    break;

                case this.service_keys.delivery:
                    this.selected_data.delivery = input.val();
                    break;

                default:
                    this.save_selected_services(name, input);
            }

            return this.selected_data;
        },
        save_selected_services: function (name, input) {
            let index_of_array = this.selected_data.services.indexOf(name),
                id = this.get_category_id({ name: name }),
                value = input.val();

            //  remove data from services' array
            if(index_of_array !== -1) {
                this.selected_data.services.splice(index_of_array, 1);
                this.selected_data.services_id.splice(index_of_array, 1);
                this.selected_data.services_value.splice(index_of_array, 1);
            }

            //  search in array again after remove previous value
            index_of_array = this.selected_data.services.indexOf(name);

            if(index_of_array === -1 && value.length > 0) {

                //  save parent_name for searching in array
                this.selected_data.services.push(name);

                //  save parent_id for getting price
                this.selected_data.services_id.push(id);

                //  save value for checking price
                this.selected_data.services_value.push(value);
            }
        },
        clear_selected_data: function () {
            this.clear_selected_size();

            this.clear_selected_qty();

            this.clear_selected_delivery();

            this.clear_selected_services();
        },
        clear_selected_size: function () {
            this.selected_data.size = 0;
        },
        clear_selected_qty: function () {
            this.selected_data.quantity = 0;
        },
        clear_selected_delivery: function () {
            this.selected_data.delivery = 0;
        },
        clear_selected_rounded: function () {
            this.selected_data.rounded = 0;
        },
        clear_selected_services: function () {
            this.selected_data.services = [];
            this.selected_data.services_id = [];
            this.selected_data.services_value = [];
        },


        //  condition's functions
        check_price_update: function (json, data) {
            let json_st =  json.name != this.service_keys.size &&
                json.name != this.service_keys.qty &&
                json.name != this.service_keys.delivery;

            let data_st =  data.size > 0 &&
                    data.quantity > 0 &&
                    data.delivery > 0 &&
                    data.services.length > 0;

            let srv_st = main_obj.size_service_select.length == 0 && json.name == this.service_keys.delivery;

            return srv_st || (json_st && data_st);
        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

