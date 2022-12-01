define(function (require, exports, module) {
    require('parsley_fa');

    let $ = require('jquery'),
        obj_confirm = require('../module/jquery-confirm'),
        obj_lang = require('lang'),
        obj_json = require('../module/upload-json'),
        obj_ajax = require('../module/ajax');


    function construct() {
        // Search JS
        this.search_field = $('.js-context-category');
        this.search_form = $('.js-context-form');
        this.result_wrap = $('.js-context-result-wrap');
        this.result_list = $('.js-context-result');

        this.ajax_default_url = "/shop/search/searchThematicCategories";
        this.ajax_value = "";
        this.search_timeout_id = 0;
    }

    construct.prototype = {
        init: function () {

            //  events init
            //  set click event for changing ui
            this.search_form.click(this.click_form_button);
            this.search_field.click(this.open_result);
            $('body').click(this.close_result);

            //  set keyup event for trigger ajax request for every char
            this.search_field.keyup(this.keyup_event);

            //  set submit event for user's submit the form
            this.search_form.submit(this.submit_event);

            //  remove success default ui on using field's event
            this.search_field.parsley().on('field:success', this.parsley_success_event);
        },

        //  init search ajax
        search_ajax_init: function () {
            let item = {
                method: "GET",
                data: {"title": main_obj.ajax_value},
                url: main_obj.ajax_default_url
            };

            obj_ajax.ajax_create(main_obj.search_done, main_obj.search_fail, main_obj.search_always, main_obj.search_before_send, item);
        },
        search_result_clear: function () {

            //  remove previous search result li list
            main_obj.result_list.find('li').remove();
        },
        search_results_push: function (results) {

            if (results.did_you_mean === true) {
                let elm = $('<li>احتمالا منظور شما این دسته بندی های موضوعی است:</li>');
                main_obj.result_list.prepend(elm);
            }
            if (results.data.length === 0) {

                let elm = $('<li></li>').append(
                    $('<span></span>').html(obj_lang.ajax.empty)
                );
                //  append data into li list
                main_obj.result_list.append(elm);
            } else {
                //  update search result list
                obj_json.jquery_for_each(main_obj.update_result_list, results.data, [main_obj.result_list]);
            }
        },
        update_result_list: function (item, index, arg) {

            if (item.did_you_mean === true) {
                let elm = $('<li>احتمالا منظور شما این محصولات است:</li>');
                main_obj.result_list.prepend(elm);
            }
            let elm = $('<li></li>').append(
                $('<a></a>')
                    .attr('href', '?thematic_category_id=' + item.thematic_category_id)
                    .addClass('data').html(item.title)
            );

            //  append data into li list
            arg[0].append(elm);
        },
        update_result_trends: function (item, index, arg) {
            let elm = $('<li></li>'),
                link_elm = $('<a style="-webkit-user-modify: read-write-plaintext-only;"></a>').attr('href', '#').html(item.query);

            //  append elements
            elm.append(link_elm);

            //  append data into li list
            arg[0].append(elm);
        },

        //  search timeout function
        //  when user type fast and it needs to wait a sec
        search_timeout: function () {

            //  clear previous result
            main_obj.search_result_clear();

            //  And call search ajax function
            main_obj.search_ajax_init();
        },
        search_timeout_clear: function () {

            //  bind search url to ajax request
            //  set url in properties
            main_obj.ajax_value = "";

            // set timeout for delaying on sending request
            clearTimeout(main_obj.search_timeout_id);
        },


        //  event func
        click_form_button: function (e) {
            let item = $(e.target);

            main_obj.search_form.submit();
        },
        open_result: function (e) {
            let item = $(e.target);

            main_obj.result_wrap.addClass('is-open');
        },
        close_result: function (e) {
            let item = $(e.target),
                closest_search = $(e.target).closest('.js-context-form');

            if (!item.hasClass('js-context-field') && closest_search.length == 0)
                main_obj.result_wrap.removeClass('is-open');
        },
        submit_event: function (e) {

            //  preventing from submit form
            e.preventDefault();
            e.stopImmediatePropagation();

            //  validate user's input
            let is_valid = main_obj.validate_field(main_obj.search_field);


            //  check if search field is validated
            if (is_valid == true) {

                //  clear previous result
                main_obj.search_result_clear();

                //  And call search ajax function
                main_obj.search_ajax_init();
            }

            //  preventing from submit form because of form must be send with ajax
            return false;
        },
        keyup_event: function (e) {
            e.stopPropagation();
            e.stopImmediatePropagation();
            let item = $(e.currentTarget);

            //  check if search field is validated
            if (item.val().length > 2) {

                //  clear previous timeout func
                main_obj.search_timeout_clear();

                //  bind search url to ajax request
                //  set url in properties
                main_obj.ajax_value += item.val();

                //  set timeout for typing fast
                main_obj.search_timeout_id = setTimeout(main_obj.search_timeout, 500);
            }
        },
        parsley_success_event: function (e) {

            //  remove success class on search field
            main_obj.search_field.removeClass('parsley-success');

            //  remove success default ui on using field's event
            return false;
        },

        //  validate func
        validate_field: function (item) {
            let parsley_instance = item.parsley();

            //  set parsley option & validate it
            // parsley_instance.options.required = true;
            parsley_instance.options.minlength = 2;
            return parsley_instance.validate();
        },

        //  ajax's callback function
        search_before_send: function (xhr) {

            //  enable progress state
            //  disable submit button
            // main_obj.enable_progress_shop();
        },
        search_always: function (data, textStatus, jqXHR) {

            //  disable progress state
            //  enable submit button
            // main_obj.disable_progress_shop();
        },
        search_done: function (results, textStatus, jqXHR) {

            if (jqXHR.status == 200) {

                //  push data & trends into result html
                main_obj.search_results_push(results);

            } else {

                //  show error jquery alert if happened error
                obj_confirm.alert(results.error);
            }


            // console.log(result, textStatus, jqXHR)
        },
        search_fail: function (jqXHR, textStatus, errorThrown) {

            //  show error jquery alert if happened error
            if (textStatus == 'error') {

                //  check if ajax reached to server or not
                if (jqXHR.responseJSON !== undefined && jqXHR.responseJSON.error !== undefined) {

                    //  check if response has error message and status
                    obj_confirm.alert(jqXHR.responseJSON.error);

                } else {

                    //  show error if response doesn't reach to server
                    obj_confirm.alert(obj_lang.ajax.errno2);
                }

            } else if (textStatus == 'timeout') {

                //  show timeout error
                obj_confirm.alert(obj_lang.ajax.errno3);
            } else {

                // show general error
                obj_confirm.alert(obj_lang.ajax.errno4);
            }
        },

        //  submit shopping state function
        enable_progress_searcg: function () {
            obj_global.product_button_shopping.attr('disabled', true);
            obj_global.product_button_shopping.addClass('is-progress');
        },
        disable_progress_search: function () {
            obj_global.product_button_shopping.removeAttr('disabled');
            obj_global.product_button_shopping.removeClass('is-progress');
        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});
