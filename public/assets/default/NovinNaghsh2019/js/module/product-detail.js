define(function (require, exports, module) {
    require('smart_wizard');

    let $ = require('jquery'),
        obj_json = require('../module/upload-json'),
        obj_global = require('../module/upload-global'),
        obj_total = require('../module/upload-subtotal'),
        obj_selectup = require('../module/product-selectup'),
        obj_data = require('../module/upload-data'),
        onj_validate = require('../module/upload-validate'),
        obj_submit = require('../module/product-submit');


    function construct() {
        //  Product detail JS

    }

    construct.prototype = {
        init: function () {
            //  Initialize function
            //  Parse json data
            obj_json.json_data_parse();

            //  set submit setting in upload data
            obj_data.shopping_opt.beforeSend = obj_submit.shopping_before_send;

            //  check if page is upload detail or product detail
            //  set status on product detail page, true
            obj_global.selected_data.product_tpl = true;

            //  update variants in product detail page
            obj_selectup.update_variants_func();

            //  get default variants in product detail page
            obj_selectup.get_default_selected();

            //  Initialize events
            this.init_event();
        },
        init_event: function () {

            // change event on variant's input on product detail page
            obj_global.size_service_select.change(this.variant_input_change);

            //  click event on button's shopping card in product page
            obj_global.product_button_shopping.click(this.add_shopping_func);

            //  change event on qty's select on product detail page
            obj_global.size_qty_select.change(this.size_change_qty);
        },

        //  event's function
        variant_input_change: function (e) {

            //  save user's selected in product global
            obj_global.save_selected_data(e);

            //  update price at subtotal
            obj_total.size_update_price(e);

            // update main image on changing inputs,
            // it's important to get image-id after getting updated price
            main_obj.update_image_main();

            //  update states of buttons
            main_obj.disable_button_shopping();
            main_obj.update_shopping_state();
        },
        add_shopping_func: function (e) {
            //  preventing from default action
            e.preventDefault();

            //  validate all variants' option in product detail
            let is_valid = onj_validate.validate_variants_product();

            // disable shopping cart button for invalid variants
            if (obj_global.json_price == 0 || obj_global.json_price == '')
                is_valid = 'not_valid';

            if( is_valid == 'valid' )
                obj_submit.submit_ajax_into_cart();
        },
        size_change_qty: function (e) {

            //  save user's selected in product global
            obj_global.save_selected_data(e);

            //  update states of buttons
            main_obj.disable_button_shopping();
            main_obj.update_shopping_state();
        },
        update_shopping_state: function () {

            //  validate all step by step
            let is_valid = onj_validate.validate_variants_product();

            // disable shopping cart button for invalid variants
            if (obj_global.json_price == 0 || obj_global.json_price == '')
                is_valid = 'not_valid';

            if( is_valid == 'valid' ) {

                //  fading out quantity for not having valid price
                obj_global.quantity_input_wrap.fadeIn();
                main_obj.enable_button_shopping();
            } else {

                //  fading in quantity for not having valid price
                obj_global.quantity_input_wrap.fadeOut();
                main_obj.disable_button_shopping();
            }
        },
        disable_button_shopping: function () {
            obj_global.product_button_shopping.addClass('disabled');
        },
        enable_button_shopping: function () {
            obj_global.product_button_shopping.removeClass('disabled');
        },

        // update image variants on changing inputs
        update_image_main: function () {
            let link = $(obj_global.product_link_image + "[data-image-id='main']");

            if (obj_global.selected_data.image_id != null) {
                link = $(obj_global.product_link_image + "[data-image-id='" + obj_global.selected_data.image_id + "']");
            }

            link.trigger("click");
        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

