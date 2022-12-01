define(function (require, exports, module) {
    let $ = require('jquery');


    function construct() {

        // json data
        this.json_size = {};
        this.json_service = {};
        this.json_variant = {};

    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },

        // json parse in var
        json_data_parse: function () {
            //  checking if size json is undefined
            if (JSON.parse(InitFormData).formInitData.sizes !== undefined)
                this.json_size = JSON.parse(InitFormData).formInitData.sizes.values;

            //  checking if service json is undefined
            if (JSON.parse(InitFormData).formInitData.services !== undefined)
                this.json_service = JSON.parse(InitFormData).formInitData.services;

            //  checking if variant json is undefined
            if (JSON.parse(InitFormData).variants !== undefined)
                this.json_variant = JSON.parse(InitFormData).variants;

            if(JSON.parse(InitFormData).has_qty_input !== undefined)
                this.has_qty_input = JSON.parse(InitFormData).has_qty_input;

// console.log(JSON.parse(InitFormData))
        },

        // json for each
        json_size_for: function (callback, arg) {
            let list = this.json_size;

            for(let i in list) {
                let item = list[i];

                callback(item, i, arg);
            }
        },
        json_variant_for: function (callback, arg) {
            let list = this.json_variant;

            for(let i in list) {
                let item = list[i];

                callback(item, i, arg);
            }
        },
        json_variant_value_for: function (callback, arg) {
            let list = this.json_variant;

            for(let i in list) {
                let item = list[i];

                for (let ii in item.fields) {
                    let item2 = item.fields[ii];

                    callback(item, i, item2, ii, arg);
                }
            }
        },

        // general function
        qty_remove_duplicate: function (array) {
            let unique_id = [],
                unique = [];

            $.each(array, function(index, elm){
                if($.inArray(elm.id, unique_id) === -1) {
                    unique_id.push(elm.id);

                    unique.push(array[index]);
                }
            });

            return unique;
        },
        remove_array_duplicate: function (array) {
            let unique_items = [];

            $.each(array, function(index, elm) {

                //  push data if elm in array wasn't in unique array
                if( $.inArray(elm, unique_items) === -1 ) {

                    unique_items.push(elm);
                }
            });

            return unique_items;
        },
        jquery_for_each: function (callback, array, arg) {
            for(let i=0; i < array.length; i++) {
                let list = array[i];

                callback(list, i, arg);
            }
        },
        jquery_double_for: function (callback, first_array, second_array, arg) {

            for(let index1 = 0; index1 < first_array.length; index1++) {
                let item1 = first_array[index1];

                for(let index2 = 0; index2 < second_array.length; index2++) {
                    let item2 = second_array[index2];

                    callback(index1, item1, index2, item2, arg);
                }
            }
        },
        jquery_obj_each: function (callback, array, arg) {
            for(let i in array) {
                let list = array[i];

                callback(list, i, arg);
            }
        },

        //  condition's functions
        check_size_delivery: function (item, index, arg) {
            let size_st = item.fields[arg[1]].value.id == arg[0].size,
                delivery_st = item.lead_time == arg[0].delivery;

            return size_st && delivery_st;
        },
        check_size_qty_delivery: function (item, index, arg) {
            let size_st = item.fields[arg[1]].value.id == arg[0].size,
                qty_st = item.fields[arg[2]].value.title == arg[0].quantity,
                delivery_st = item.lead_time == arg[0].delivery;

            return size_st && qty_st && delivery_st;
        },
        check_size_qty: function (item, index, arg) {
            let size_st = item.fields[arg[1]].value.id == arg[0].size,
                qty_st = item.fields[arg[2]].value.title == arg[0].quantity;

            return size_st && qty_st;
        },
        check_subtotal_service: function (json, service_keys) {
            let size_st = json.name == service_keys.size,
                qty_st = json.name == service_keys.qty,
                delivery_st = json.name == service_keys.delivery;

            return size_st || qty_st || delivery_st;
        }


    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

