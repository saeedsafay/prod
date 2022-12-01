define(function (require, exports, module) {
    require('smart_wizard');

    let $ = require('jquery'),
        obj_submit = require('../module/upload-submit'),
        obj_json = require('../module/upload-json'),
        obj_lang = require('lang'),
        obj_data = require('../module/upload-data'),
        obj_global = require('../module/upload-global'),
        obj_validate = require('../module/upload-validate');


    function construct() {

        //  options wizard
        this.step_opt = {
            selected: 0,
            theme: 'dots',

            keyboardSettings: {
                keyNavigation: false,
            },

            autoAdjustHeight: false,
            enableURLhash: false,

            toolbarSettings: {
                showNextButton: false,
                showPreviousButton: false,
            },

            anchorSettings: {
                enableAllAnchors: false,
            },

            transition: {
                animation: 'fade',
                speed: '400',
                easing:''
            },
        };

        this.step_selected = this.step_opt.selected;
    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },
        init_event: function () {},

        // Initialize step wizard in product
        step_wizard_init: function () {

            // Initialize plugin
            this.wizard = obj_global.step_wrap.smartWizard(this.step_opt);

            // Initialize events
            this.step_wizard_event();
        },

        // next and previous buttons' events & their functions
        step_wizard_event: function () {

            //  buttons events
            obj_global.step_button_prev.on('click', {direction: 'prev' }, this.step_wizard_direct);
            obj_global.step_button_next.on('click', {direction: 'next'}, this.step_wizard_direct);

            obj_global.step_size_previous.on('click', {direction: 'prev' }, this.step_wizard_direct);
            obj_global.step_size_next.on('click', {direction: 'next'}, this.step_wizard_direct);


            //  validation event
            obj_global.step_wrap.on('leaveStep', this.wizard_validate);

            //  update step wizard
            //  update selected step
            obj_global.step_wrap.on('showStep', this.wizard_selected);

        },
        step_wizard_direct: function (e) {
            if(e.preventDefault !== undefined) e.preventDefault();

            obj_global.step_wrap.smartWizard(e.data.direction);

            main_obj.submit_ajax_upload();
        },
        submit_ajax_upload: function () {
            let step = main_obj.step_selected;

            //  if this is last step of wizard for submit into shopping card
            if(step == 3) {

                //  check all validation, if all of them are true
                //  send a request to shopping card
                let is_valid = obj_validate.validate_all();

                // disable shopping cart button for invalid variants
                if (obj_global.json_price == 0 || obj_global.json_price == '')
                    is_valid = 'not_valid';

                if ( is_valid == 'valid' )
                    obj_submit.submit_ajax_into_cart();
            }
        },

        //  update selected step
        wizard_selected: function (e, anchor, step_num, direction) {

            //  update selected step wizard
            main_obj.step_selected = step_num;

            if (step_num == 2 && !obj_global.selected_data.service_status)
                main_obj.step_wizard_direct({ data: { direction: 'next' } });

            //  disable previous button in first step
            if(step_num == 0)
                main_obj.disable_button_prev();
            else
                main_obj.enable_button_prev();

            //  disable & enable next button if a value is valid
            //  validate button is on selecting an input
            main_obj.disable_button_next();
            main_obj.update_next_state();

            //  remove class name done from,
            //  all items in step header
            main_obj.update_step_link();


            //  update top header wizard
            main_obj.update_headline(step_num);

            //  update title of buttons in step header
            main_obj.update_button_text(step_num);

        },
        update_headline: function (step_num) {
            let header = obj_lang.wizard_header[step_num];

            obj_global.step_head.html(header.title);
            obj_global.step_headtext.html(header.text);
        },
        update_button_text: function (num) {
            let prev_title = num > 0 ? obj_lang.wizard_header[num-1].title : obj_lang.upload.default_title,
                prev_text = obj_lang.upload.return_to + ' ' + prev_title;

            let length = obj_lang.wizard_header.length-1,
                next_title = num < length ? obj_lang.wizard_header[num+1].title : obj_lang.upload.default_title,
                next_text = num < length ? obj_lang.upload.go_to + ' ' + next_title : obj_lang.upload.go_to_cart;

            obj_global.step_button_prev.attr('title', prev_text);

            obj_global.step_button_next.find('span').html(next_text);
            obj_global.step_button_next.attr('title', next_text);
        },

        //  disable & enable buttons
        update_next_state: function () {
            let step_num = main_obj.step_selected;

            //  validate all step by step
            let valid_num = obj_validate.validate_all();

            //  return false if user wants to go next without being valid
            if ( step_num == 2 && (obj_global.json_price == 0 || obj_global.json_price == '') )
                valid_num = 'not_valid';

            if ( valid_num > step_num || valid_num == 'valid' )
                this.enable_button_next();
            else
                this.disable_button_next();

        },
        disable_button_prev: function () {
            obj_global.step_size_previous.addClass('disabled');
            obj_global.step_button_prev.addClass('disabled');
        },
        disable_button_next: function () {
            obj_global.step_button_next.addClass('disabled');
            obj_global.step_size_next.addClass('disabled');
        },
        enable_button_prev: function () {
            obj_global.step_size_previous.removeClass('disabled');
            obj_global.step_button_prev.removeClass('disabled');
        },
        enable_button_next: function () {
            obj_global.step_size_next.removeClass('disabled');
            obj_global.step_button_next.removeClass('disabled');
        },

        //  remove & update class name done in step header
        update_step_link: function () {
            let is_valid = obj_validate.validate_all();

            obj_global.step_link.parent().removeClass('done');

            obj_json.jquery_for_each(this.update_class_done, obj_global.step_link, [ is_valid ]);
        },
        update_class_done: function (item, index, arg) {
            let is_active = $(item).parent().hasClass('active');

            if(!is_active) {
                if (index <= arg[0] || arg[0] == 'valid')
                    $(item).parent().addClass('done');
            }
        },


        //  validation step wizard
        wizard_validate: function(e, anchor, step_num, step_next, direction) {

            //validate all step by step
            let valid_num = obj_validate.validate_all();

            //  return false if user wants to go next without being valid
            if ( step_num == 2 && (obj_global.json_price == 0 || obj_global.json_price == '') )
                valid_num = 'not_valid';

            //  return true if all values are checked
            if(valid_num == 'valid')
                return true;

            //  return false if user wants to go next without being valid
            if(direction == 'backward' || valid_num > step_num)
                return true;

            return false;
        },


    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

