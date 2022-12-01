define(function (require, exports, module) {
    require('parsley_fa');

    let $ = require('jquery'),
        obj_city = require('../module/city');


    function construct() {
        //  Address form data
        this.address_form = $('.js-address-form');
        this.address_fields = $('.js-address-field');
        this.address_province = $('#js-address-province-field');
        this.address_city = $('#js-address-city-field');
        this.address_button = $('.js-address-button');

        this.parsley_instance = '';
    }

    construct.prototype = {
        init: function () {

        },
        init_ready: function () {

            //  load province data into html
            obj_city.load_province_values(this.address_province);

            //  initiate validate address form
            this.validate_address_form();

            //  Events function
            this.init_event();
        },
        init_event: function () {

            //  address form submit event
            this.address_form.submit(this.validate_address_fields);

            //  set province input change event
            this.address_province.change(this.get_address_city);
        },

        //  initiate validate func
        validate_address_form: function () {

            //  create parsley instance for address form
            this.parsley_instance = this.address_form.parsley();
// console.log(this.address_form, this.parsley_instance, this.address_form.parsley())
            //  submit if form was validated
            this.parsley_instance.whenValid();
        },

        //  event's function
        validate_address_fields: function (e) {

            // this.pasley_instance.validate();
            // return false;

            //  checking if all of services are chosen
            //  and make or with previous value of service's valid
            // main_obj.not_valid_item = !parsley_instance.isValid() || previous_valid;
        },

        //  province function on change event
        get_address_city: function (e) {
            let value = $(e.currentTarget).val();

            //  get city values into select html
            obj_city.load_city_values(value, main_obj.address_city);
        }


    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

