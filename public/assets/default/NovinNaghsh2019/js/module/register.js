define(function (require, exports, module) {
    require('parsley_fa');

    let $ = require('jquery'),
        obj_confirm = require('../module/jquery-confirm');


    function construct() {
        this.login_form = $('.js-login-form');
        this.register_form = $('.js-register-form');
        this.verification_mobile = $('#verification-wrapper > form');
        this.login_form_link = $('#login-form-link');
        this.forgot_password_link = $('#forgot-password-link');
        this.send_forgot = $('#SendForgotSMS');
        this.new_pass = $('#forgotSetNewPassword');

    }

    construct.prototype = {
        init: function () {

            //  initiate validate register form
            this.validate_login_form(this.login_form);

            //  initiate validate register form
            this.validate_login_form(this.register_form);

            //  Events function
            this.init_event();
        },
        init_event: function () {

            // ajax for register form
            this.register_form.on('submit', this.register_submit);

            // ajax for mobile number activation
            this.verification_mobile.on('submit', this.register_click_verification);

            // fade in forgot password form
            this.forgot_password_link.on('click', this.show_forgot_password_form);
            // fade in forgot password form
            this.login_form_link.on('click', this.show_forgot_password_form);

            // ajax for forgot password
            this.send_forgot.on('click', this.register_click_forgot_sms);

            // ajax for forgot password
            this.new_pass.on('click', this.register_click_new_pass);
        },

        //  initiate validate func
        validate_login_form: function (item) {

            //  create parsley instance for address form
            let parsley_instance = item.parsley();

            //  submit if form was validated
            parsley_instance.whenValid();
        },

        // register function
        register_submit: function (event) {
            //  prevent default action on submit event
            event.preventDefault();

            //  define local variable
            let form = $(event.currentTarget);
            // ajax request call to server side
            $.ajax({
                url: form.attr('action'),
                type: "POST",
                data: form.serialize(),
                dataType: "json",
                cache: false,
                beforeSend: function (xhr) {
                    $('.errors > p').html('').parent().fadeOut();
                    form.find('.btn-register').attr('disabled', true);
                },
                success: function (result) {
                    form.fadeOut();
                    $('#verification-wrapper').fadeIn();
                    $('input[name="__verificationUserToken"]').val(result.token);
                },
                error: function (xhr, err) {
                    $('.errors > p').html(xhr.responseJSON.errors).parent().fadeIn();
                    form.find('.btn-register').attr('disabled', false);
                },
                complete: function () {
                    window.setTimeout(function () {
                        $('.errors > p').html('').parent().fadeOut();
                    }, 8000);

                    //   form.find('i.fa-spin').hide();
                    form.find('.btn-register').attr('disabled', false);
                },
            });

        },

        // register function
        register_click_verification: function (event) {
            event.preventDefault();
            //  define local variable
            let form = $(event.currentTarget);
            let code = form.find('input[name="code"]').val();
            let token = $('input[name="__verificationUserToken"]').val();
            // ajax request call to server side
            $.ajax({
                url: '/users/activateMobile',
                type: "POST",
                data: {"code": code, "token": token},
                dataType: "json",
                cache: false,
                beforeSend: function (xhr) {
                    $('.errors > p').html('').parent().fadeOut();
                    form.find('.btn').attr('disabled', true);
                },
                success: function (result) {
                    obj_confirm.info(result.message);
                    window.setTimeout(function () {
                        if (result.redirect_url) {
                            window.location.href = result.redirect_url;
                        } else {
                            window.location.href = "/";
                        }
                    }, 3000);
                },
                error: function (xhr, err) {
                    $('.errors > p').html(xhr.responseJSON.errors).parent().fadeIn();
                    form.find('.btn').attr('disabled', false);
                },
                complete: function () {
                    $('.errors > p').html('').parent().fadeOut();
                    form.find('.btn').attr('disabled', false);
                },
            });

        },

        show_forgot_password_form: function (event) {
            event.preventDefault();
            $(".js-login-form").fadeToggle(300, "linear");
            $("#forgot-sms-form").fadeToggle(300, "linear");
        },

        // register function
        register_click_forgot_sms: function (event) {
            event.preventDefault();
            let form = $("#forgot-sms-form");
            let mobile = $('input[name="forgotMobile"]');

            if (mobile.val() == '') {
                alert('پر کردن فیلد شماره موبایل است.');
                return false;
            }
            // ajax request call to server side
            $.ajax({
                url: '/users/resetPassword',
                type: "POST",
                data: {"mobile": mobile.val()},
                dataType: "json",
                cache: false,
                beforeSend: function (xhr) {
                    $('.errors > p').html('').parent().fadeOut();
                    form.find('.btn').attr('disabled', true);
                },
                success: function (result) {
                    form.fadeOut();
                    $('#forgot-code-form').fadeIn();
                    $('input[name="__forgotVerificationUserToken"]').val(result.token);
                },
                error: function (xhr, err) {
                    $('.errors > p').html(xhr.responseJSON.errors).parent().fadeIn();
                    form.find('.btn').attr('disabled', false);
                },
                complete: function () {
                    $('.errors > p').html('').parent().fadeOut();
                    form.find('.btn').attr('disabled', false);
                },
            });


        },

        // register function
        register_click_new_pass: function (event) {
            event.preventDefault();
            let form = $("#forgot-code-form");
            let code = $('input[name="forgotMobileCode"]');
            let pass = $('input[name="newPassword"]');
            let token = $('input[name="__forgotVerificationUserToken"]');

            if (code.val() == '' || pass.val() == '') {
                alert('پر کردن فیلدها اجباری است');
                return false;
            }
            // ajax request call to server side
            $.ajax({
                url: base_url + 'users/resetPasswordByCode',
                type: "POST",
                data: {"code": code.val(), "password": pass.val(), "token": token.val()},
                dataType: "json",
                cache: false,
                beforeSend: function (xhr) {
                    $('.errors > p').html('').parent().fadeOut();
                    form.find('.btn').attr('disabled', true);
                },
                success: function (result) {
                    obj_confirm.info(result.message);
                    window.setTimeout(function () {
                        window.location.href = "/";
                    }, 3000);
                },
                error: function (xhr, err) {
                    $('.errors > p').html(xhr.responseJSON.errors).parent().fadeIn();
                    form.find('.btn').attr('disabled', false);
                },
                complete: function () {
                    $('.errors > p').html('').parent().fadeOut();
                    form.find('.btn').attr('disabled', false);
                },
            });


        },
    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});
