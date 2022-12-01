define(function (require, exports, module) {
    let $ = require('jquery'),
        obj_lang = require('lang');


    function construct() {
        // Switch toggle JS
        this.input = '';
        this.title = '';
    }

    construct.prototype = {
        init: function () {
            //  Initialize function
            //

            //  Initialize events
            //
        },

        // Put Value of switch toggle JS
        create: function (item, title) {
            this.input = item;
            this.title = title;
        },

        // Turning toggle on
        on: function () {
            this.input.prop('checked', true);

            this.update();
        },

        //  Turning toggle off
        off: function () {
            this.input.prop('checked', false);

            this.update();
        },

        // Get status of toggle
        get_status: function () {
            let status = this.input.prop('checked');

            return status;
        },
        get_title: function () {
            let corner_text = this.get_status() ? obj_lang.upload.rounded : obj_lang.upload.squared;

            return corner_text;
        },
        update: function () {
            let corner_text = this.get_title();

            this.title.stop().hide().text(corner_text).fadeIn(600);
        }
    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

