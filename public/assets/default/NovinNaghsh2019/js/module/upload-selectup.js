define(function (require, exports, module) {
    let $ = require('jquery'),
        obj_toggle = require('../module/upload-toggle'),
        obj_json = require('../module/upload-json'),
        obj_global = require('../module/upload-global'),
        obj_lang = require('lang');


    function construct() {
        // Product sizing JS

    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },

        // update size from json
        size_update_json: function (json) {

            if(json.name == obj_global.service_keys.size) {

                // update quantity after selecting size
                this.active_item(obj_global.size_wrap);

                // disable all services and active some of them
                this.disable_item(obj_global.size_delivery, obj_lang.upload.item_qty_disabled);

                this.clear_all_inputs();

                //  if qty isn't load dynamic
                if (obj_global.service_keys.qty != "static") {
                    this.operate_qty_aft_size(json);

                    this.update_quantity_size();
                }

            } else if (json.name == obj_global.service_keys.delivery) {

                //  clear all services' inputs
                this.clear_service_inputs();

                /*//  update service after service feature
                //  disabled - it was extra feature
                //  when we have separated corner feature

                // update services after selecting delivery
                // disable all services and active some of them
                this.disable_item(obj_global.size_wrap_services, obj_lang.upload.item_select_disabled);
                this.size_update_aft_delivery();*/

            }

            /* //  update service after service feature
            //  disabled - it was extra feature
            //  when we have separated corner feature
            else if {

                //  update services after selecting a service
                //  disable all services and active some of them
                this.disable_item(obj_global.size_wrap_services, obj_lang.upload.item_select_disabled);

                this.update_aft_service(false);
            }*/
        },
        size_update_qty: function () {

            //  clear all services' inputs
            this.clear_delivery_inputs();
            this.clear_service_inputs();

            // update services after selecting delivery
            // disable all services and active some of them
            this.disable_item(obj_global.size_delivery, obj_lang.upload.item_qty_disabled);

            if (obj_global.service_keys.qty != "static") {

                //  if qty isn't load dynamic
                this.size_update_aft_quantity();
            } else {

                //  if qty is static
                this.active_item(obj_global.size_delivery);
            }
        },

        //  update quantity after size
        operate_qty_aft_size: function (json) {
            let size_id = obj_global.get_category_id({ name: obj_global.service_keys.size }),
                qty_id = obj_global.get_category_id({ name: obj_global.service_keys.qty });

            obj_json.json_qty_array = [];
            obj_global.size_qty_select.find('option').remove();
            obj_global.size_qty_select.append($('<option></option>').attr('value', '').text(obj_lang.upload.chose_quantity));

            obj_json.json_variant_value_for(this.get_quantity_array, [ json, size_id, qty_id ]);

            obj_json.json_qty_array = obj_json.qty_remove_duplicate(obj_json.json_qty_array);
        },
        get_quantity_array: function (item, index, item2, index2, arg) {

            if(item2.id == arg[1] && item2.value.id == arg[0].id) {
                let value = item.fields[arg[2]].value;

                obj_json.json_qty_array.push(value);
            }
        },
        update_quantity_size: function () {
            $.each(obj_json.json_qty_array, function (index, elm) {
                //  if you want to print id of quantity just replace elm.id with elm.title in value
                obj_global.size_qty_select.append($('<option></option>').attr('value', elm.title).text(elm.title));
            });
        },

        //  update services after select quantity
        size_update_aft_quantity: function () {
            let size_id = obj_global.get_category_id({ name: obj_global.service_keys.size }),
                qty_id = obj_global.get_category_id({ name: obj_global.service_keys.qty });

            obj_json.json_variant_for(this.get_update_aft_qty, [ obj_global.selected_data, size_id, qty_id ]);
        },
        get_update_aft_qty: function (item, index, arg) {

            if(obj_json.check_size_qty(item, index, arg))
                obj_json.jquery_for_each(main_obj.disable_delivery_aft_qty, obj_global.size_radio_input_delivery, [ item ]);
        },
        disable_delivery_aft_qty: function (item, index, arg) {

            if($(item).val() == arg[0].lead_time)
                main_obj.active_item($(item).closest(obj_global.size_delivery));
        },

        //  update services after select delivery
        size_update_aft_delivery: function () {

            //  update services after select delivery
            this.disable_item(obj_global.size_wrap_services, obj_lang.upload.item_select_disabled);
            this.update_aft_service(true);
        },

        //  update services after select a service
        update_aft_service: function (service_st = false) {
            let size_id = obj_global.get_category_id({ name: obj_global.service_keys.size }),
                qty_id = obj_global.get_category_id({ name: obj_global.service_keys.qty });

            obj_json.json_variant_for(this.update_service_aft_service, [ obj_global.selected_data, size_id, qty_id, service_st ]);
        },
        update_service_aft_service: function (item, index, arg) {
            let service_array = arg[0].services_id;

            if( obj_json.check_size_qty_delivery(item, index, arg) ) {

                //  update service based on qty and delivery
                //  if there wan't any selected
                if ( arg[3] )
                    obj_json.jquery_for_each(main_obj.enable_services_aft_service, obj_global.size_wrap_services, [item]);

                //  this is the default of services' updates
                if ( service_array.length > 0 && !arg[3])
                    obj_json.jquery_for_each(main_obj.get_enable_services, service_array, [item]);
            }
        },
        get_enable_services: function (id, index, arg) {
            let service_status = arg[0].fields[id].value.title;

            if(service_status == 'بله')
                obj_json.jquery_for_each( main_obj.enable_services_aft_service, obj_global.size_wrap_services, [ arg[0], id ] );
        },
        enable_services_aft_service: function (item, index, arg) {
            let name = $(item).attr('data-name'),
                get_id_of_name = obj_global.get_category_id({ name: name });

            if(arg[0].fields[get_id_of_name].value.title == 'بله')
                main_obj.active_item($(item));
        },

        //  general function inputs

        //  clear and reset inputs
        clear_all_inputs: function () {
            this.clear_qty_input();
            this.clear_delivery_inputs();

            this.clear_service_inputs();
        },
        clear_size_inputs: function () {
            obj_global.size_only.removeClass('is-active');

            obj_global.size_only_radio_input.prop('checked', false);

            obj_global.clear_selected_size();
        },
        clear_qty_input: function () {
            obj_global.size_quantity.removeClass('is-active');

            obj_global.size_qty_select.val('');

            obj_global.clear_selected_qty();
        },
        clear_delivery_inputs: function () {
            obj_global.size_delivery.removeClass('is-active');

            obj_global.size_radio_input_delivery.prop('checked', false);

            obj_global.clear_selected_delivery();
        },
        clear_rounded_inputs: function () {
            obj_toggle.off();

            obj_global.clear_selected_rounded();
        },
        clear_service_inputs: function () {
            obj_global.size_wrap_services.removeClass('is-active');

            obj_global.size_service_select.val('');
            obj_global.size_checkbox_input_servieces.prop('checked', false);

            obj_global.clear_selected_services();
        },

        active_item: function (item) {
            let input = item.find('[type="radio"], [type="checkbox"]');

            item.removeClass('disabled');
            item.siblings('.js-disable-msg').remove();

            input.removeAttr('disabled');
        },
        disable_item: function (item, message = '') {
            let input = item.find('[type="radio"], [type="checkbox"]'),
                msg = $('<div></div>').addClass('js-disable-msg disable-msg').text(message);

            item.addClass('disabled');
            item.parent().find('.js-disable-msg').remove();
            item.parent().append(msg);

            input.attr('disabled', true);
        },

        update_image_main: function (event) {
            let item = $(event.currentTarget).closest(obj_global.size_wrap),
                json = obj_global.get_input_json(event);

            if (json.image_src != '') {
                let src = '/upload/variants/' + json.image_src;

                item.find(obj_global.size_service_image).attr('src', src);
            }
        }

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

