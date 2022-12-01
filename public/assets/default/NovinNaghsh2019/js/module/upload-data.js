define(function (require, exports, module) {
    require('fileupload');

    let $ = require('jquery'),
        obj_json = require('../module/upload-json');


    function construct() {
        // Product upload JS
        //  preview section
        this.preview_dropzone = $('.js-preview-dropzone');
        this.preview_title = $('.js-dropzone-title');
        this.preview_link = $('.js-preview-link');

        //  progress & response
        this.progress_wrap = $('#js-preview-progress');
        this.response_wrap = $('.js-preview-response');
        this.response_name = $('.js-file-name');
        this.response_size = $('.js-file-size');

        //  edit bar elements
        this.edit_download = $('#js-edit-download');
        this.edit_remove = $('#js-edit-remove');

        //  comment text in detail preview
        this.detail_comment = $('#js-detail-comment');

        //  json data
        this.layers_id = [];
        this.file_inputs = [];
        this.layers_name = '';
        this.file_pushed = [];

        //  upload messages
        //  error & success messages
        this.messages_wrap = $('#js-preview-messages');

        //  submit shopping cart ajax setting
        this.shopping_opt = {
            data: {},

            method: 'POST',
            url: '/shop/addToCart',

            dataType: 'json',
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',

            beforeSend: this.shopping_before_send,
        };

        //  submit shopping url
        this.shopping_href = '/shop/cart';
    }

    construct.prototype = {
        init: function () {
            //  Initialize function

        },

        //  get array's layer's id
        get_layers_id: function () {

            obj_json.jquery_for_each(this.layer_id_json, this.preview_link, []);

            return main_obj.layers_id;
        },
        layer_id_json: function (item, index, arg) {
            let id = $(item).attr('data-layer-id');

            main_obj.layers_id.push(id);
        },

        //  get input elm's array
        //  return array of jquery file input
        get_input_array: function () {
            let layer_id = this.get_layers_id();

            obj_json.jquery_for_each(this.file_input_return, layer_id, []);

            return this.file_inputs;
        },
        file_input_return: function (item, index, arg) {
            let input = $('#js-preivew-input-' + item);

            main_obj.file_inputs.push(input);
        },

        //  get active layer title
        get_active_title: function (id) {
            obj_json.jquery_for_each(this.layer_name_return, this.preview_link, [ id ]);

            return main_obj.layers_name;
        },
        layer_name_return: function (item, index, arg) {
            let item_id = $(item).attr('data-layer-id');

            if(item_id == arg[0])
                main_obj.layers_name = $(item).attr('title');
        },

        //  get active layer id
        get_active_id: function () {
            return this.preview_dropzone.attr('data-layer-id');
        },

        //  get active elm input file
        //  return a jquery elm input file
        get_active_input: function () {
            let id = this.get_active_id();

            return $('#js-preivew-input-' + id);
        },

        //  get size calculated size
        //  B, KB, MB, GB
        calculate_size: function (size) {
            let size_b = size,
                size_kb = size / 1000,
                size_mb = size / 1000000,
                size_gb = size / 1000000000;

            //  return size in GB
            if(size_gb >= 1)
                return size_gb + ' GB';

            //  return size in MB
            if(size_mb >= 1)
                return size_mb + ' MB';

            //  return size in KB
            if(size_kb >= 1)
                return size_kb + ' KB';

            //  return size in B
            if(size_b >= 1)
                return size_b + ' B';
        },

        //  push file data into array
        file_data_push: function (data) {
            let name_value = Object.values(data.result.content),
                file = data.files[0],
                id = data.fileInput.attr('data-layer-id');

            //  push image data into an array
            main_obj.file_pushed[id] = {
                id: id,
                input_name: data.paramName[0],
                returned_name: name_value[0],
                name: file.name,
                size: file.size,
            };
        },

        //  get data of item which are pushed with given id
        get_data_pushed: function (id) {
            let item = main_obj.file_pushed[id];

            if(item !== undefined)
                return item;
            else
                return false;
        },

        //  remove data of item with given id
        remove_data_pushed: function (id) {

            //  return true if item's data successfully deleted
            return delete main_obj.file_pushed[id];
        },

        //  check pushed data aren't empty
        check_data_pushed: function () {
            main_obj.is_valid = false;

            //  check if file was uploaded or not
            obj_json.jquery_for_each(main_obj.check_file_pushed, main_obj.file_pushed, []);

            return main_obj.is_valid;
        },
        check_file_pushed: function (item, index, arg) {

            //  check if any of items wasn't undefined
            if(item !== undefined)
                main_obj.is_valid = true;
        },



    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

