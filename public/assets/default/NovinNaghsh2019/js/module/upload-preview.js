define(function (require, exports, module) {
    require('fileupload');

    let $ = require('jquery'),
        obj_json = require('../module/upload-json'),
        obj_data = require('../module/upload-data');


    function construct() {
        // Product upload JS
    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },

        //  initialize upload's preview
        init_ready: function () {},

        preview_setup: function () {

            //  change title in preview to active title
            this.preview_change_title(0);
        },

        //  initialize the events of upload's preview
        init_event: function () {

            //  change preview when clicked on layer link
            obj_data.preview_link.click(this.change_layer);

        },


        //  side and layers' function
        change_data_preview: function (file) {
            //  change name & size in drop zone preview
            obj_data.response_name.html(file.name);
            obj_data.response_size.html(obj_data.calculate_size(file.size));
        },
        preview_change_title: function (id) {
            let title = obj_data.get_active_title(id);

            obj_data.preview_title.html(title);

            obj_data.preview_dropzone.attr('data-layer-id', id);
        },
        change_layer: function (event) {
            let item = $(event.currentTarget),
                id = item.attr('data-layer-id');

            event.preventDefault();

            if(!item.parent().hasClass('is-active')) {

                //  @todo set animation for clicking on layer's title
                //  this.preview_layer_animation

                // change active layer
                obj_data.preview_link.parent().removeClass('is-active');
                item.parent().addClass('is-active');

                //  change content of drop zone
                //  show file info if was uploaded or ready for upload a file
                main_obj.change_dropzone(id);

                //  remove alert or success message if they exist
                main_obj.clear_msg();
            }

            return false;
        },
        change_dropzone: function (id) {
            let item = obj_data.get_data_pushed(id);
            
            //  change title in default preview
            main_obj.preview_change_title(id);

            //  find pushed data id, if it exist and change ii
            if(!item) {

                //  hide response & show default preview
                main_obj.show_dropzone();

            } else {

                //  hide default & show response
                main_obj.show_response();

                //  change image info uploaded in drop zone
                main_obj.change_data_preview(item);
            }
        },

        //  response & states
        //  show & hide states
        show_dropzone: function () {
            obj_data.progress_wrap.addClass('is-hide');
            obj_data.response_wrap.addClass('is-hide');
            obj_data.preview_dropzone.removeClass('is-hide');
        },
        show_progress: function () {
            obj_data.preview_dropzone.addClass('is-hide');
            obj_data.response_wrap.addClass('is-hide');
            obj_data.progress_wrap.removeClass('is-hide');
        },
        show_response: function () {
            obj_data.preview_dropzone.addClass('is-hide');
            obj_data.progress_wrap.addClass('is-hide');
            obj_data.response_wrap.removeClass('is-hide');
        },

        //  show error & success
        error_msg: function (msg = '') {
            let alert = this.create_alert(msg, 'alert-danger');

            this.clear_msg();

            obj_data.messages_wrap.html(alert);
            obj_data.messages_wrap.removeClass('is-hide');
        },
        success_msg: function (msg = '') {
            let alert = this.create_alert(msg, 'alert-success');

            this.clear_msg();

            obj_data.messages_wrap.html(alert);
            obj_data.messages_wrap.removeClass('is-hide');
        },
        clear_msg: function () {
            obj_data.messages_wrap.html('');
            obj_data.messages_wrap.addClass('is-hide');
        },
        create_alert: function (msg, class_name) {
            let elm = $('<div></div>').addClass('alert alert-dismissible').addClass(class_name),
                button = $('<button></button>').addClass('close fa fa-times').attr('data-dismiss', 'alert');

            elm.append(button);
            elm.append(msg);

            return elm;
        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

