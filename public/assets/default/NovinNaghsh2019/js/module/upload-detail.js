define(function (require, exports, module) {
    require('smart_wizard');

    let $ = require('jquery'),
        obj_ajax = require('../module/upload-ajax'),
        obj_size = require('../module/upload-size'),
        obj_global = require('../module/upload-global'),
        obj_plugin = require('../module/upload-plugin'),
        obj_total = require('../module/upload-subtotal'),
        obj_submit = require('../module/upload-submit'),
        obj_context = require('../module/category-context'),
        obj_data = require('../module/upload-data'),
        obj_json = require('../module/upload-json');


    function construct() {
        // Product JS section

    }

    construct.prototype = {
        init: function () {
            //  Initialize function
            //  Parse json data
            obj_json.json_data_parse();

            //  Upload subtotal file
            //  Initialize function
            obj_total.init_ready();

            //  Main Upload file
            // Product step wizard
            if(obj_global.step_exist) obj_plugin.step_wizard_init();

            //  upload size file
            //  Initialize functions
            obj_size.init_ready();

            //  define global Ajax
            //  default setting in all ajax in upload page
            obj_ajax.set_global_option();

            //  set submit setting in upload data
            obj_data.shopping_opt.beforeSend = obj_submit.shopping_before_send;

            //  Ajax upload file
            // Product file upload JS
            obj_ajax.upload_init();

            //  Initialize events
            this.init_event();
        },
        init_event: function () {

            //  upload size file
            //  Initialize events
            obj_size.init_event();
        },


    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

