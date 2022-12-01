"use strict";

let id_wrap = $('.js-get-pages-id'),
    id_exist = id_wrap.length>0,
    id = id_exist ? id_wrap.attr('id').substr(3) : '',
    url = id_exist ? '../module/' + id : '';

define(['jquery', url], function ($) {
    // run the task


});

