define(function (require, exports, module) {
    let $ = require('jquery'),
        obj_toggle = require('../module/upload-toggle'),
        obj_total = require('../module/upload-subtotal'),
        obj_global = require('../module/upload-global'),
        obj_selectup = require('../module/upload-selectup'),
        obj_plugin = require('../module/upload-plugin');


    function construct() {
        // Product sizing JS
        this.toggle_switch = $('.js-input-switch input');
        this.toggle_input_title = $('.js-input-toggle');
    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },
        init_ready: function (e) {
            //  Switch toggle init
            main_obj.switch_toggle_create();

            // clear selected inputs before loading properly scripts
            obj_selectup.clear_all_inputs();

            obj_selectup.clear_size_inputs();
        },
        init_event: function () {
            // product sizing js
            this.hover_size_init();

            // activation input js in product size
            obj_global.size_radio_input.change(this.size_input_change);
            obj_global.size_checkbox_input.change(this.size_input_change);
            obj_global.size_qty_select.change(this.size_change_qty);
            obj_global.size_service_select.change(this.size_change_srv);

            // product sizing toggle switch js
            this.toggle_switch.change(this.switch_toggle_event);
        },

        // Product Sizing animation JS
        hover_size_init: function () {
            obj_global.size_wrap.mouseenter(this.hover_mouseenter).mouseleave(this.hover_mouseleave);
        },
        hover_mouseenter: function () {
            if(!$(this).hasClass('disabled')) {
                obj_global.size_wrap.find('img').css('opacity', 1);

                $(this).find('img').addClass('is-hover');
            }
        },
        hover_mouseleave: function () {
            if(!$(this).hasClass('disabled'))
                $(this).find('img').removeClass('is-hover');
        },

        // Switch toggle JS
        switch_toggle_create: function () {
            obj_toggle.create(this.toggle_switch, this.toggle_input_title);
        },
        switch_toggle_event: function (e) {
            obj_toggle.update();
        },

        // Activation input JS in product size
        size_input_change: function (e) {

            //  get json saved user's select
            let json = obj_global.get_input_json(e);

            //  hover's func on size boxes
            main_obj.size_input_activation_each(obj_global.size_wrap);

            //  save user's selected in upload global
            obj_global.save_selected_data(e);

            //  initiate size's function
            obj_selectup.size_update_json(json);

            //  update price at subtotal
            obj_total.size_update_price(e);

            //  update states of buttons
            obj_plugin.disable_button_next();
            obj_plugin.update_next_state();

            //  change wizard plugin if user was on size, delivery section
            if(json.name == obj_global.service_keys.size ||
                json.name == obj_global.service_keys.delivery) {
                obj_plugin.step_wizard_direct({ data: { direction: 'next' } });
            }
        },
        size_input_activation_each:function (list) {
            let length = list.length, i;

            for(i=0; i < length; i++) {
                let item = list[i];

                if(!$(item).hasClass('disabled')) {

                    $(item).removeClass('is-active');

                    if ($(item).find('[type="radio"], [type="checkbox"]').prop('checked'))
                        $(item).addClass('is-active');
                }
            }
        },

        // update services on select changes
        // update delivery on quantity changes
        size_change_qty: function (e) {

            //  save user's selected in product global
            obj_global.save_selected_data(e);

            //  update price at subtotal
            obj_total.size_update_price(e);

            obj_selectup.size_update_qty();

            //  update states of buttons
            obj_plugin.disable_button_next();
            obj_plugin.update_next_state();
        },

        //  update subtotal on select services change
        size_change_srv: function (e) {

            //  save user's selected in product global
            obj_global.save_selected_data(e);

            //  update price at subtotal
            obj_total.size_update_price(e);

            // update main image on changing inputs,
            // it's important to get image-id after getting updated price
            obj_selectup.update_image_main(e);

            //  update states of buttons
            obj_plugin.disable_button_next();
            obj_plugin.update_next_state();
        }


    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

