define(function (require, exports, module) {
    require('parsley_fa');

    let $ = require('jquery');


    function construct() {
        //  parsley data
        this.parsley_instance = null;
    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },
        init_event: function () {},

        //  general validation function parsley
        create_instance_validate: function (item) {

            //  created instance of parsley validation
            main_obj.parsley_instance = $(item).parsley();

            //  return created instance
            return main_obj.parsley_instance;
        },
        set_required_field: function () {

            //  set required option for parsley instance
            main_obj.parsley_instance.options.required = true;
        },
        clear_instance_validate: function () {
            main_obj.parsley_instance = null;
        }


    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

