<!doctype html>
<!--[if lte IE 9]> <html class="lte-ie9" lang="en"> <![endif]-->
<!--[if gt IE 9]><!--> <html lang="en"> <!--<![endif]-->

    <head>
        <meta charset="UTF-8">
        <!-- Controller Defined Stylesheets -->
        <script type="text/javascript">
            var ADMIN_PATH = '{ADMIN_PATH}';
            var ADMIN_URL = '{site_url(ADMIN_PATH)}';
            var SITE_URL = '{site_url()}';
            var asset_url = '{assets_url}';
        </script>
        <title>داشبورد مدیریتی-{$title}</title>

        <link rel="stylesheet" href="{assets_url}bower_components/codemirror/lib/codemirror.css">

        <link rel="stylesheet" href="{assets_url}bower_components/uikit/css/uikit.almost-flat.min.css" media="all">

        <link rel="stylesheet" href="{assets_url}icons/flags/flags.min.css" media="all">
        <link rel="stylesheet" href="{assets_url}bower_components/jquery.craftpip_confirmbox/css/jquery-confirm.css"
              media="all">
        <link rel="stylesheet"
              href="{assets_url}bower_components/pwt.datepicker/dist/css/persian-datepicker-0.4.5.min.css" media="all">

        <link rel="stylesheet" href="{assets_url}css/main.min.css?v={time()}" media="all">
        <link rel="stylesheet" href="{assets_url}css/rtl/style.css?v={time()}"/>

        {header_css}
    </head>
<body class="sidebar_main_open">

<header id="header_main">
    <div class="header_main_content">
        <nav class="uk-navbar">

            <a href="#" id="sidebar_main_toggle" class="sSwitch sSwitch_right">
                        <span class="sSwitchIcon"></span>
                    </a>

                    <a href="#" id="sidebar_secondary_toggle" class="sSwitch sSwitch_right sidebar_secondary_check">-->
                        <span class="sSwitchIcon"></span>
                    </a>
                    <div class="uk-navbar-flip">
                        <ul class="uk-navbar-nav user_actions">
                            <li data-uk-dropdown="{*mode:'click'*}">
                                <a href="{site_url('backoffice/users/logout')}" class="user_action_image"><img
                                            class="md-user-image" src="{assets_url}img/power.png" alt="خروج"/></a>

                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </header>
        {include file="partials/sidebar.tpl"}
