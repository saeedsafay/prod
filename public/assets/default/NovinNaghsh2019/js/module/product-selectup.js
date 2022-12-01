define(function (require, exports, module) {
    require('smart_wizard');

    let $ = require('jquery'),
        obj_json = require('../module/upload-json'),
        obj_global = require('../module/upload-global'),
        obj_total = require('../module/upload-subtotal');


    function construct() {

        //  Product detail JS

    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },

        //  update variants
        //  get first selected by default
        get_default_selected: function () {

            //  get default selected each of variants
            obj_json.jquery_for_each( main_obj.get_default_each, obj_global.size_service_select, [] );
        },
        get_default_each: function (item, index, arg) {
            let event = { currentTarget: item };

            //  save user's selected in product global
            obj_global.save_selected_data(event);

            //  update price at subtotal
            obj_total.size_update_price(event);
        },

        //  remove items if, variants doesn't exist
        update_variants_func: function () {

            //  set global arrays for getting new variants
            obj_global.product_variants_title = [];
            obj_global.product_variants_values = [];

            //  foreach for each of selects in product detail
            obj_json.jquery_for_each( main_obj.update_select_each, obj_global.size_service_select, [] );
        },
        update_select_each: function (item, index, arg) {
            let id = obj_global.get_category_id({ name: $(item).attr('name') });

            //  get new variant's updates
            obj_json.json_variant_for(main_obj.update_option_each, [ id ]);

            //  set global variants' product
            obj_global.product_variants_title = obj_json.remove_array_duplicate(obj_global.product_variants_title);
            obj_global.product_variants_values = obj_json.remove_array_duplicate(obj_global.product_variants_values);

            //  remove old option's select
            $(item).find('option').remove();

            //  inset data in into select html
            obj_json.jquery_for_each( main_obj.insert_variant_items, obj_global.product_variants_values, [ item, index ] );

            //  set global arrays empty after update option's select
            obj_global.product_variants_title = [];
            obj_global.product_variants_values = [];
        },
        update_option_each: function (item, index, arg) {

            if( item.fields[arg[0]] !== undefined ) {

                //  push parent name into global array
                obj_global.product_variants_title.push(item.fields[arg[0]].value.title);

                //  push variant's id into global array
                obj_global.product_variants_values.push(item.fields[arg[0]].value.id);
            }
        },
        insert_variant_items: function (item, index, arg) {
            let title = obj_global.product_variants_title[index];

            //  insert options into select's items
            $(arg[0]).append($('<option></option>').attr('value', item).text(title));
        },


    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

