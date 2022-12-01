define(function (require, exports, module) {
    require('fileupload');

    let $ = require('jquery'),
        obj_json = require('../module/upload-json'),
        obj_preview = require('../module/upload-preview'),
        obj_input = require('../module/upload-input');


    function construct() {
        // Product upload JS
    }

    construct.prototype = {
        init: function () {
            //  Initialize function
            this.ajax_global_opt = {
                timeout: 4000
            };
        },

        // global ajax for timeout setting
        set_global_option: function () {
            $.ajaxSetup(this.ajax_global_opt);
        },

        // Product JS upload section
        upload_init: function () {

            //  begin preview setup
            //  change the title in preview
            obj_preview.preview_setup();

            //  initialize input ajax function
            obj_input.input_init();

            //  call the events in upload's preview
            obj_preview.init_event();

            //  call the events for ajax plugin
            obj_input.input_events();
        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

