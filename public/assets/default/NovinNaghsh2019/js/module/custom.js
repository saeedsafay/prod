(function ($) {

    "use strict";

    // Index Home JS
    function HomeJs() {
        // Home JS section
        this.categories_wall = $('.js-wall-grid');
        this.categories_exist = this.categories_wall.length>0;
        this.categories_opt = {
            selector: '.js-item-nested-0',
            animate: true,
            cellW: 'auto',
            cellH: 'auto',
            gutterX: 15,
            gutterY: 15,
            fixSize: false,
            onResize: this.categories_freewall_resize,
        };

        // Product JS section
        this.step_wrap = $('.js-step-upload-wrap');
        this.step_exist = this.step_wrap.length>0;
        this.step_content = $('.js-step-content');
        this.step_link = $('.js-step-link');
        this.step_button_next = $('.js-step-wizard-next');
        this.step_button_prev = $('.js-step-wizard-prev');
        this.step_opt = {
            selected: 0,
            keyNavigation: false,
            autoAdjustHeight: false,

            useURLhash: false,
            showStepURLhash: false,

            toolbarSettings: {
                showNextButton: false,
                showPreviousButton: false,
            },

            anchorSettings: {
                enableAllAnchors: false,
            },

            transitionEffect: 'fade',
        };

        // Product sizing JS
        this.size_wrap = $('.js-upload-size');
        this.size_radio_input = $('.js-upload-size input[type="radio"]');
        this.size_checkbox_input = $('.js-upload-size input[type="checkbox"]');
        this.toggle_switch = $('.js-input-switch input');
        this.toggle_input_title = $('.js-input-title');

        // Product quantity JS
        this.scroll = $('.js-nice-scroll');
        this.scroll_wrapp = $('.js-quantity-wrap');
        this.scroll_button = $('.js-quantity-scroll');
        this.scroll_label = $('.js-quantity-label');
        this.scroll_input = $('.js-quantity-label [type="radio"]');
        this.scroll_option = {
            autohidemode: 'leave',
            railalign: 'left',
            scrollspeed: 150,
        };
        this.scroll_exist = this.scroll.length>0;
        this.scroll_mouseenter_opt = [
            { bottom: 25, opacity: 1 }, 300
        ];
        this.scroll_mouseleave_opt = [
            { bottom: -25, opacity: 0 }, 50, 'easeOutCirc'
        ];

        // Product upload JS
        this.upload_opt = {
            uploadUrl: 'http://omdex.local:8888/shop/products/uploadImage',

            theme: 'fa',
            language: 'fa',

            showRemove: false,
            browseOnZoneClick: true,
            hideThumbnailContent: true,
        };
        this.upload_input_array = [
            '#js-upload-input-front-0',
            '#js-upload-input-back-0',
        ];
        this.upload_exist = this.upload_exist_func();

        // initializing Home JS
        this.init();
    }

    HomeJs.prototype = {
        init: function() {
            //  Initialize function
            $(document).ready(this.init_ready);

            //  Initialize events
            this.init_event();
        },
        init_ready: function () {
            // Home JS section
            if(home_obj.categories_exist) home_obj.categories_freewall_init();

            // Product step wizard
            if(home_obj.step_exist) home_obj.step_wizard_init();

            // Product file upload JS
            if(home_obj.upload_exist) home_obj.upload_image_init();

            // Nice scroll JS in quantity product
            if(home_obj.scroll_exist) home_obj.scroll_init();
        },
        init_event: function () {
            // product sizing js
            this.hover_size_init();

            // activation input js in product size
            this.size_radio_input.change(this.size_input_change);
            this.size_checkbox_input.change(this.size_input_change);

            // product sizing toggle switch js
            this.toggle_switch.change(this.switch_toggle_event);

            // nice scroll js in quantity product
            this.scroll_init_event();
        },

        // Home categories Freewall JS
        categories_freewall_init: function () {
            this.categories_wall_obj = new Freewall(this.categories_wall);

            this.categories_wall_obj.reset(this.categories_opt);

            this.categories_freewall_resize();
        },
        categories_freewall_resize: function () {
            this.categories_wall_obj.fitWidth();
        },


        // Initialize step wizard in product
        step_wizard_init: function () {

            // Initialize plugin
            this.wizard = this.step_wrap.smartWizard(this.step_opt);

            // Initialize events
            this.step_wizard_event();
        },
        step_wizard_event: function () {
            this.step_button_prev.on('click', {direction: 'prev' }, this.step_wizard_next_prev_func);

            this.step_button_next.on('click', {direction: 'next'}, this.step_wizard_next_prev_func);

            this.step_wrap.on('showStep', this.step_wizard_shown_check);

            // toggle tab upload product JS
            this.step_wrap.on('shown.wizard', this.step_wizard_shown);
        },
        step_wizard_next_prev_func: function (e) {
            e.preventDefault();

            home_obj.step_wrap.smartWizard(e.data.direction);
        },
        step_wizard_shown: function () {
            home_obj.scroll_resize();
        },
        step_wizard_shown_check: function (e, anchor_object, step_number, step_direction) {
            clearInterval(home_obj.wizard_interval);

            home_obj.wizard_interval = setInterval(home_obj.step_wizard_shown_interval, 400, anchor_object);
        },
        step_wizard_shown_interval: function (anchor_object) {
            var id = $(anchor_object).attr('href');

            if($(id).height()>0) {

                home_obj.step_wrap.trigger('shown.wizard');

                clearInterval(home_obj.wizard_interval)
            }
        },

        // Scrolling for quantity JS
        scroll_mouseleave: function () {
            var property = home_obj.scroll_mouseleave_opt[0],
                duration = home_obj.scroll_mouseleave_opt[1],
                easing = home_obj.scroll_mouseleave_opt[2];

            home_obj.scroll_button.animate(property, duration, easing)
        },
        scroll_mouseenter: function () {
            var property = home_obj.scroll_mouseenter_opt[0],
                duration = home_obj.scroll_mouseenter_opt[1];

            home_obj.scroll_button.animate(property, duration)
        },
        scroll_click: function(e) {
            var postion = home_obj.scroll.getNiceScroll(0).getScrollTop() + 100;

            e.preventDefault();

            home_obj.scroll.getNiceScroll(0).doScrollTop(postion)
        },
        scroll_init: function () {
            this.scroll.niceScroll(this.scroll_option);

            this.scroll_resize();
        },
        scroll_init_event: function () {
            this.scroll_button.click(this.scroll_click);

            this.scroll_wrapp.mouseenter(this.scroll_mouseenter).mouseleave(this.scroll_mouseleave);

            this.scroll_input.change(this.scroll_input_change)
        },
        scroll_input_change: function (e) {
            home_obj.size_input_change_each(home_obj.scroll_label);
        },

        // toggle tab upload product JS
        scroll_resize: function(e) {
            home_obj.scroll.getNiceScroll().resize()
        },

        // Product Sizing animation JS
        hover_size_init: function () {
            this.size_wrap.mouseenter(this.hover_mouseenter).mouseleave(this.hover_mouseleave)
        },
        hover_mouseenter: function () {
            home_obj.size_wrap.find('img').css('opacity', 1);

            $(this).find('img').addClass('is-hover')
        },
        hover_mouseleave: function () {
            $(this).find('img').removeClass('is-hover')
        },

        // Switch toggle JS
        switch_toggle_event: function (e) {
            var corner_text = $(this).prop('checked') ? 'دورگرد' : 'چهارگوش';

            home_obj.toggle_input_title.stop().hide().text(corner_text).fadeIn(600);
        },

        // Activation input JS in product size
        size_input_change: function (e) {
            home_obj.size_input_change_each(home_obj.size_wrap);

        },
        size_input_change_each:function (list) {
            var length = list.length, i;

            for(i=0; i < length; i++) {
                var item = list[i];

                $(item).removeClass('is-active');

                if($(item).find('[type="radio"], [type="checkbox"]').prop('checked')) {
                    $(item).addClass('is-active');
                }
            }
        },

        // Product JS upload section
        upload_image_init: function () {

            $.each(this.upload_input_array, this.upload_image_each);
        },
        upload_image_each: function (index, item) {
            $(item).fileinput(home_obj.upload_opt)
        },
        upload_exist_func: function () {
            var list = this.upload_input_array,
                length = list.length, i;

            for(i=0; i < length; i++) {
                var item = $(list[i]);

                if(item.length>0) {
                    return true;
                }
            }
            return false;
        }


    };


    // Create home object
    var home_obj = new HomeJs();


})(jQuery);

