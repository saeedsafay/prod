define(function (require, exports, module) {
    let $ = require('jquery'),
        obj_search = require('../module/search');


    function construct() {
        this.header_menu = $('.header-menu-bar');

    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});