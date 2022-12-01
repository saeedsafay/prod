require.config({
    baseUrl: "/assets/default/NovinNaghsh2019/js/vendor/",
    enforceDefine: false,
    paths: {
        //  app path global
        search: '../module/search',
        route: '../module/route',
        global_cart: '../module/global-cart',
        varients: '../module/shopping-cart',
        newsletter: '../module/newsletter',

        //  modules path
        lang: '../module/lang',

        // jQuery plugins
        jquery: './jquery-2.1.4.min',
        bootstrap: './bootstrap.min',
        jquery_ui: './jquery-ui.min',
        owl_carousel: './owl.carousel.min',
        wow: './wow.min',
        actual: './jquery.actual.min',
        chosen: './chosen.jquery.min',
        bxslider: './jquery.bxslider.min',
        sticky: './jquery.sticky',
        elevate_zoom: './jquery.elevateZoom.min',
        fancybox: './fancybox/source/jquery.fancybox.pack',
        fancybox_media: './fancybox/source/helpers/jquery.fancybox-media',
        fancybox_thumbs: './fancybox/source/helpers/jquery.fancybox-thumbs',
        jquery_function: './function.min',
        Modernizr: './Modernizr',
        jquery_plugin: './jquery.plugin',
        countdown: './jquery.countdown',
        freewall: './freewall',
        smart_wizard: './jquery.smartWizard.min',
        iframe_transport: './jquery.iframe-transport',
        fileupload: './jquery.fileupload',
        nice_scroll: './jquery.nicescroll.min',
        progressbar: './progressbar.min',
        jquery_confirm: './jquery-confirm.min',
        parsley_core: './parsley.min',
        parsley_fa: './parsley.fa',
    },
    shim: {
        route: ['jquery'],
        header: ['jquery', 'sticky'],
        search: ['jquery'],
        global_cart: ['jquery'],
        varients: ['jquery'],

        // Global dependencies plugin
        bootstrap: ['jquery'],
        jquery_ui: ['jquery'],
        owl_carousel: ['jquery'],
        actual: ['jquery'],
        chosen: ['jquery'],
        bxslider: ['jquery'],
        sticky: ['jquery'],
        elevate_zoom: ['jquery'],
        fancybox: ['jquery'],
        fancybox_media: ['fancybox'],
        fancybox_thumbs: ['fancybox'],
        jquery_function: ['Modernizr', 'jquery', 'bootstrap', 'jquery_ui', 'owl_carousel', 'wow', 'actual', 'chosen', 'bxslider', 'sticky', 'elevate_zoom', 'fancybox_media', 'fancybox_thumbs',],
        jquery_plugin: ['jquery'],
        countdown: ['jquery_plugin'],

        // Local dependencies plugin
        freewall: ['jquery'],
        smart_wizard: ['jquery'],
        fileupload: ['jquery', 'iframe_transport'],
        nice_scroll: ['jquery'],
        jquery_confirm: ['jquery'],
        parsley_fa: ['jquery', 'parsley_core'],

    }
});


//  global functions
define(function (require, exports, module) {
    require('jquery_function');
    require('countdown');
    require('search');
    require('route');

    var $ = require('jquery');

    require('global_cart');
    require('newsletter')
});