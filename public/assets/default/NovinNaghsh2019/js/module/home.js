define(function (require, exports, module) {
    require('freewall');

    let $ = require('jquery');


    function construct() {
        this.categories_wall = $('.js-wall-grid');
        this.categories_exist = this.categories_wall.length>0;
        this.categories_opt = {
            selector: '.js-item-nested-0',
            animate: true,
            cellW: 'auto',
            cellH: '210',
            gutterX: 10,
            gutterY: 10,
            fixSize: true,
            onResize: this.categories_freewall_resize,
        };
    }

    construct.prototype = {
        init: function () {
            //  Initialize function
            if(this.categories_exist) this.categories_freewall_init();

        },
        categories_freewall_init: function () {
            this.categories_wall_obj = new Freewall(this.categories_wall);

            this.categories_wall_obj.reset(this.categories_opt);

            this.categories_freewall_resize();
        },
        categories_freewall_resize: function () {
            main_obj.categories_wall_obj.fitWidth();
        },
    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();


    return main_obj;
});

