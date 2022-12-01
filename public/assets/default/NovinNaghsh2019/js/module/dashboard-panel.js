define(function (require, exports, module) {
    require('parsley_fa');

    let $ = require('jquery'),
        obj_lang = require('lang'),
        obj_confirm = require('../module/jquery-confirm');


    function construct() {
        //  data
        this.address_form = $('.address-form');
        this.address_province = this.address_form.find('select.province');
        this.address_city = this.address_form.find('select.county');
        this.address_list = $('.address-list');
        this.remove_button = this.address_list.find('.remove-address');
    }

    construct.prototype = {
        init: function () {

            this.init_event();
        },
        init_event: function () {
            this.address_form.on('submit', this.submit_ajax_address);
            this.address_province.on('change', this.get_counties);
            this.remove_button.on('click', this.remove_address);
        },
        // Export JSON cart JS in upload section
        submit_ajax_address: function (event) {
            //  prevent default action on submit event
            event.preventDefault();
            let form = $(event.currentTarget);
            //  submit a request to shopping cart
            this.jqxhr = $.ajax({
                url: form.attr('action'),
                type: "POST",
                data: form.serialize(),
                dataType: "json",
                cache: false,
                beforeSend: main_obj.address_before_send,
            });
            this.jqxhr.done(main_obj.address_done);
            this.jqxhr.fail(main_obj.request_failed);
            this.jqxhr.always(main_obj.address_always);
        },

        get_counties: function () {
            this.jqxhr = $.ajax({
                url: '/services/getCounties',
                type: "GET",
                data: {'province_id': main_obj.address_province.val()},
                dataType: "json",
                cache: false,
                beforeSend: main_obj.before_counties,
            });
            this.jqxhr.success(main_obj.push_counties);
            this.jqxhr.fail(main_obj.request_failed);
            this.jqxhr.complete(main_obj.complete_counties);
        },
        remove_address: function (event) {
            event.preventDefault();
            //  submit a request to shopping cart
            this.jqxhr = $.ajax({
                url: '/dashboard/users-panel/delete-address',
                type: "GET",
                data: {'address_id': $(this).data('address-id')},
                dataType: "json",
                cache: false,
                beforeSend: main_obj.address_before_send,
            });
            this.jqxhr.done(main_obj.address_done);
            this.jqxhr.fail(main_obj.request_failed);
            this.jqxhr.always(main_obj.address_always);

        },
        before_counties: function () {
            main_obj.address_city.attr('disabled', true)
        },

        push_counties: function (result) {
            main_obj.address_city.find('option').not(':first').remove();
            $.each(result.data.county, function (i, city) {
                let opt = $('<option></option>').attr('value', city.id).html(city.name);
                main_obj.address_city.append(opt);
            });
        },
        complete_counties: function () {
            main_obj.address_city.removeAttr('disabled')
        },

        //  callback response shopping cart
        address_before_send: function (xhr) {

            //  enable progress state
            //  disable submit button
            main_obj.enable_progress_address();
        },
        address_done: function (response, textStatus, jqXHR) {
            $('.modal').modal('hide');
            location.reload();
        },
        address_always: function (data, textStatus, jqXHR) {

            //  disable progress state
            //  enable submit button
            main_obj.disable_progress_address();
        },
        request_failed: function (jqXHR, textStatus, errorThrown) {

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

            // console.log(jqXHR, textStatus, errorThrown, jqXHR.responseJSON.error)
        },
        //  submit shopping state function
        enable_progress_address: function () {
            main_obj.address_form.find('button[type="submit"]').attr('disabled', true);
            main_obj.address_form.find('i.fa-spin').removeClass('hidden');
        },
        disable_progress_address: function () {
            main_obj.address_form.find('button[type="submit"]').removeAttr('disabled');
            main_obj.address_form.find('i.fa-spin').addClass('hidden');
        }


    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

