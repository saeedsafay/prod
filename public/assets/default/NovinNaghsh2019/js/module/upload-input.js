define(function (require, exports, module) {
    require('fileupload');

    let $ = require('jquery'),
        progress_plugin = require('progressbar'),
        obj_global = require('../module/upload-global'),
        obj_json = require('../module/upload-json'),
        obj_data = require('../module/upload-data'),
        obj_preview = require('../module/upload-preview'),
        obj_lang = require('lang');


    function construct() {

        // upload's option data
        // deleteUrl: base_url + 'delete.php',
        this.upload_opt = {
            url: base_url + 'shop/uploadImages',
            formAcceptCharset: 'utf-8',
            type: 'POST',
            dataType: 'json',
            formData: {},

            // simultaneous requests set true
            // maximum async requests is two request
            // else adds into queues list
            sequentialUploads: false,
            limitConcurrentUploads: 2,

            //  if multi selection is enabled,
            //  each selection file send with individual request
            singleFileUploads: true,

            //  requests sends as multipart/form-data
            multipart: true,

            //  this option needs to be false,
            //  because sometimes progress became 60% from 73%
            recalculateProgress: false,

            //  uploading images in drag & drop way
            dropZone: obj_data.preview_dropzone,

            // maxChunkSize: 1000000,
            // uploadedBytes: 10000000,

            //  validation ajax plugin
            acceptFileTypes: /(\.)(jpe?g|cdr|png|pdf)$/i,
            acceptFileExt: /^(image\/jpe?g|cdr|png|pdf)$/i,

            //  callback functions
            submit: this.fileinput_submit,
            send: this.fileinput_send,
            progress: this.fileinput_progress,
            done: this.fileinput_done,
            fail: this.fileinput_fail,


        };

        //  progress's option data
        this.progress_opt = {

            //  progress bar styles
            strokeWidth: 1,
            svgStyle: {
                width: 'calc(100% - 100px)',
                height: 2,
            },

            //  trail styles
            trailColor: '#f0f0f0',
            trailWidth: 1,

            //  percent text styles
            text: {
                style: this.text_style,
                autoStyleContainer: false
            },

            //  animation styles
            easing: 'easeInOut',
            duration: 2500,
            from: {
                color: '#e6e6e6',
                text_color: '#ffe5e9',
            },
            to: {
                color: '#ebc7ca',
                text_color: '#d36271',
            },
            step: function(state, svg) {
                let value = Math.round(svg.value() * 100) + ' %',
                    styles = main_obj.text_style;

                //  change text color in styles
                styles.color = state.text_color;

                //  update percent text & styles
                svg.setText(value);
                $(svg.text).css(styles);

                //  change color of progress bar
                svg.path.setAttribute('stroke', state.color);
            }
        };

        this.text_style = {
            position: 'absolute',
            right: 0,
            left: 0,
            top: 'calc(20% + 15px)',

            width: '100%',
            padding: 0,
            margin: 0,

            'font-size': 40,
            'font-weight': '100',

            'text-align': 'center',
            transform: null,
        };

    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },
        input_events: function () {
            obj_data.preview_dropzone.click(this.dragzone_click);

            //  events for edit bar
            //  remove and download images
            obj_data.edit_download.click(this.download_image);
            obj_data.edit_remove.click(this.remove_image);
        },

        //  initialize ajax plugin
        input_init: function () {

            // change event on input's file
            this.input_fileinput();

            // $(preview_selector).on('dragover dragenter', function() {
            //     $(preview_selector).addClass('is-dragover');
            // }).on('dragleave dragend drop', function() {
            //     $(preview_selector).removeClass('is-dragover');
            // });
        },
        input_fileinput: function () {
            let input_array = obj_data.get_input_array(),
                progress_id = '#' + obj_data.progress_wrap.attr('id');

            obj_json.jquery_for_each(this.fileinput_init, input_array, []);

            this.progress = new progress_plugin.Line(progress_id, this.progress_opt);
        },

        //  init for each input element files
        fileinput_init: function (item, index, arg) {
            let name = item.attr('name');

            item.fileupload(main_obj.upload_opt, {
                paramName: name,

            });
        },
        fileinput_submit: function (e, data) {
            let rule_name = main_obj.upload_opt.acceptFileTypes,
                rule_ext = main_obj.upload_opt.acceptFileExt,
                is_valid_name = data.files[0].name.search(rule_name),
                is_valid_type = data.files[0].type.search(rule_ext);

            //  validate image file before send it to server
            //  returns false if isn't valid
            if(is_valid_name == -1 && is_valid_type == -1) {
                obj_preview.error_msg('فایل شما باید با jpg یا cdr باشد.')

                return false;
            }

            return true;
        },
        fileinput_send: function (e, data) {

            //  hide error messages
            obj_preview.clear_msg();

            //  prepare progress for upload
            obj_preview.show_progress();
            main_obj.progress.set(0);
        },
        fileinput_progress: function (e, data) {
            let percent = (data.loaded / data.total);

            main_obj.progress.animate(percent);
        },
        fileinput_done: function (e, data) {

            //  show response from server if, status was true
            if(data.result.status) {

                //  show success response
                //  push name & size & input name data into an array
                obj_data.file_data_push(data);

                //  change name & size in drop zone preview
                obj_preview.change_data_preview(data.files[0]);

                //  remove disable class if a file was upload
                //  and for write more complex code
                //  step_button_next need to write with triggers & events
                if(obj_data.check_data_pushed())
                    obj_global.step_button_next.removeClass('disabled');

                //  hide progress & show response wrap
                obj_preview.show_response();
                obj_preview.success_msg(obj_lang.ajax.success_no1);

            } else {

                //  hide progress & show dropzone wrap
                obj_preview.show_dropzone();

                //  show error response
                obj_preview.error_msg(data.result.error);

            }
        },
        fileinput_fail: function (e, data) {

            //  hide progress & show dropzone wrap
            obj_preview.show_dropzone();

            //  show error response for text status error
            //  sometimes request reached to server but show text status error
            if(data.textStatus == 'error') {

                //  check if request reached to server or not
                if(data.jqXHR.responseJSON !== undefined)
                    obj_preview.error_msg(data.jqXHR.responseJSON.error);
                else
                    obj_preview.error_msg(obj_lang.ajax.errno2);

            } else if (data.textStatus == 'timeout') {

                //  show time out error
                obj_preview.error_msg(obj_lang.ajax.errno3);
            }
            else {

                //  show general error
                obj_preview.error_msg(obj_lang.ajax.errno1);
            }

// console.log(data, data.textStatus, data.errorThrown, data.jqXHR.responseJSON);
        },

        //  ajax plugin's events
        dragzone_click: function (event) {
            let input = obj_data.get_active_input();

            event.preventDefault();

            input.trigger('click');
        },
        download_image: function (event) {
            event.preventDefault();

            //  download the original file
        },
        remove_image: function (event) {
            let id = obj_data.get_active_id();

            event.preventDefault();

            obj_data.remove_data_pushed(id);

            //  remove disable class if a file was upload
            //  and for write more complex code
            //  step_button_next need to write with triggers & events
            if(!obj_data.check_data_pushed())
                obj_global.step_button_next.addClass('disabled');

            obj_preview.show_dropzone();

            obj_preview.clear_msg();
        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

