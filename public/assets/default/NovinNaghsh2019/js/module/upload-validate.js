define(function (require, exports, module) {
    require('parsley_fa');

    let $ = require('jquery'),
        obj_submit = require('../module/upload-submit'),
        obj_json = require('../module/upload-json'),
        obj_data = require('../module/upload-data'),
        obj_global = require('../module/upload-global');


    function construct() {

        //  validation option
        //  all validation's option are false except services
        this.is_valid_size = false;
        this.is_valid_qty = false;
        this.is_valid_delivery = false;
        this.is_valid_file = false;

        //  validation's option
        //  all variants must be chosen to be validated
        //  all validation's option are true
        this.not_valid_item = true;
        this.previous_valid_value = false;

    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },
        init_event: function () {},

        //  validate's functions in upload page
        //  validation step wizard
        validate_all: function () {
            //  invalidate all of sections
            //  set false boolean
            this.invalid_all();

            //  validate all of sections
            this.validate_size();


            // validate qty input or select
            this.validate_qty();

            //  validate if, delivery is exist,
            //  upload page on tShirt doesnt have delivery options
            this.validate_delivery();

            this.validate_service();
            this.validate_file();

            return this.is_valid_all();
        },

        //  validate's function in upload page,
        //  for number input quantity's like,
        //  tShirt, cloths and etc.
        validate_static_qty: function () {},

        is_valid_all: function () {

            //  if size isn't valid returns step's number
            if(!this.is_valid_size)
                return 0;

            //  if qty & delivery aren't valid return step's number
            if(!this.is_valid_qty || !this.is_valid_delivery)
                return 1;

            //  if qty & delivery aren't valid return step's number
            if(this.not_valid_item)
                return 2;

            //  if qty & delivery aren't valid return step's number
            if(!this.is_valid_file)
                return 3;

            //  validate all sec
            //  all of them are valid
            return this.check_validation();
        },

        validate_size: function () {
            let input_size = obj_global.size_radio_input;

            //  validate size section
            obj_json.jquery_for_each(this.validate_radio, input_size, []);
        },
        validate_qty: function () {

            if (obj_global.service_keys.qty == "static") {

                //  validate qty static like tShirt and cloths
                this.is_valid_qty = obj_global.size_qty_select.val() != '' && this.validate_qty_parsley();
            } else {

                //  validate qty sec
                if(obj_global.size_qty_select.val() != '')
                    this.is_valid_qty = true;
            }
        },
        validate_delivery: function () {
            let input_size = obj_global.size_radio_input;

            //  validate delivery sec
            obj_json.jquery_for_each(this.validate_radio, input_size, []);
        },
        validate_service: function () {
            let input_select = obj_global.size_service_select;

            //  validate service sec
            if (input_select.length > 0)
                obj_json.jquery_for_each(this.validate_options_each, input_select, []);
            else
                this.not_valid_item = false;

// console.log(this.not_valid_item)
        },
        validate_file: function () {

            //  check if file was uploaded or not
            this.is_valid_file = obj_data.check_data_pushed();
        },

        validate_radio: function (item, index, arg) {

            //  validate size input if they are checked
            if($(item).attr('name') == obj_global.service_keys.size  && $(item).prop('checked')) {
                main_obj.is_valid_size = true;
            }

            //  validate delivery input if they are checked
            if($(item).attr('name') == obj_global.service_keys.delivery  && $(item).prop('checked')) {
                main_obj.is_valid_delivery = true;
            }
        },
        invalid_all: function () {

            //  clear all valid upload sec
            //  all validation's option are false except services
            //  the default is false except services
            this.is_valid_size = false;
            this.is_valid_qty = false;
            this.is_valid_delivery = false;
            this.is_valid_file = false;

            //  all services must be chosen to be validated
            //  so the default is true
            this.not_valid_item = true;
            this.previous_valid_value = false;
        },
        check_validation: function () {
            let sec1 = this.is_valid_size,
                sec2 = this.is_valid_qty && this.is_valid_delivery,
                sec3 = !this.not_valid_item,
                sec4 = this.is_valid_file;

            return sec1 && sec2 && sec3 && sec4 ? 'valid' : 'not_valid';
        },

        //  validate function on static qty with parsley
        validate_qty_parsley: function () {
            let parsley_instance = $(obj_global.size_qty_select).parsley();

            //  set parsley option & validate it
            parsley_instance.options.required = true;
            parsley_instance.options.type = "number";
            parsley_instance.validate();

            return parsley_instance.isValid();
        },

        //  validate functions on variants' product in product page
        validate_variants_product: function () {

            //  invalidate variants's options in product
            main_obj.not_valid_item = true;
            main_obj.previous_valid_value = false;

            //  validate selects' input in product page
            obj_json.jquery_for_each(this.validate_options_each, obj_global.size_service_select, []);

            return main_obj.not_valid_item ? 'not_valid' : 'valid';
        },

        //  general validation for both upload & product pages
        //  validate selects' input on services or variants
        validate_options_each: function (item, index, arg) {

            //  validate services input if all of them have been chosen
            let previous_valid = main_obj.previous_valid_value,
                parsley_instance = $(item).parsley();

            //  set parsley option & validate it
            parsley_instance.options.required = true;
            parsley_instance.validate();

            //  checking if all of services are chosen
            //  and make or with previous value of service's valid
            main_obj.not_valid_item = !parsley_instance.isValid() || previous_valid;

            //  set previous value of service's value
            main_obj.previous_valid_value = main_obj.not_valid_item;
        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

