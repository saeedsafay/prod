<?php
defined('BASEPATH') or exit('No direct script access allowed');
?>
<style>
    * {
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
    }

    body {
        padding: 0;
        margin: 0;
        font-family: 'Shabnam', tahoma !important;
    }

    #notfound {
        position: relative;
        height: 100vh;
    }

    #notfound .notfound {
        position: absolute;
        left: 50%;
        top: 50%;
        -webkit-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
    }

    .notfound {
        max-width: 560px;
        width: 100%;
        padding-left: 160px;
        line-height: 1.1;
    }

    .notfound .notfound-404 {
        position: absolute;
        right: -166px;
        top: -9px;
        display: inline-block;
        width: 140px;
        height: 140px;
        background-image: url('/assets/default/NovinNaghsh2019/images/icon/emoji.png');
        background-size: cover;
    }

    .notfound .notfound-404:before {
        content: '';
        position: absolute;
        width: 100%;
        height: 100%;
        -webkit-transform: scale(2.4);
        -ms-transform: scale(2.4);
        transform: scale(2.4);
        border-radius: 50%;
        background-color: #f2f5f8;
        z-index: -1;
    }

    .notfound h1 {
        font-family: 'Shabnam', tahoma !important;
        font-size: 65px;
        font-weight: 700;
        margin-top: 0px;
        margin-bottom: 10px;
        color: #c11f36;
        text-transform: uppercase;
        text-align: right;
        direction: rtl;
    }

    .notfound h2 {
        font-family: 'Shabnam', tahoma !important;
        font-size: 21px;
        font-weight: 400;
        margin: 0;
        text-transform: uppercase;
        color: #c11f36;
        text-align: right;
        direction: rtl;
    }

    .notfound p {
        font-family: 'Shabnam', tahoma !important;
        color: #999fa5;
        font-weight: 400;
        direction: rtl;
        line-height: 1.5em;
        text-align: justify;
    }

    .notfound a {
        font-family: 'Shabnam', tahoma !important;
        display: inline-block;
        font-weight: 700;
        border-radius: 40px;
        text-decoration: none;
        color: #388dbc;
        float: right;
        direction: rtl;
    }

    @media only screen and (max-width: 767px) {
        .notfound .notfound-404 {
            width: 110px;
            height: 110px;
        }

        .notfound {
            padding-left: 15px;
            padding-right: 15px;
            padding-top: 110px;
        }
    }

</style>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/png" sizes="16x16"
          href="/assets/default/NovinNaghsh2019/images/favi/favicon-16x16.png">

    <title>404 صفحه یافت نشد | نوین نقش</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/shabnam-font/5.0.1/font-face.min.css"
          integrity="sha512-K7kg/b/uwKLejlClSl2m2CDutNLO7w6Wh8R7X2921f6TSs/q+MuhKlTHbM9/8dvN5TK7Y9q2VV6pNtyVKdEKJQ=="
          crossorigin="anonymous"/>

    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-150739372-1"></script>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }

        gtag('js', new Date());
        gtag('config', 'UA-150739372-1');
    </script>
</head>
<body data-new-gr-c-s-check-loaded="14.993.0" data-gr-ext-installed="">
<div id="notfound">
    <div class="notfound">
        <div class="notfound-404"></div>
        <h1>404</h1>
        <h2>صفحه مورد نظر یافت نشد!</h2>
        <p>به دنبال صفحه ای که می خواستید گشتیم اما چیزی پیدا نکردیم! به نظر میاد صفحه تغییر کرده، حذف شده و یا
            منتقل شده باشه</p>
        <a href="/">صفحه اصلی <img style="vertical-align: middle"
                                   src="/assets/default/NovinNaghsh2019/images/home1/logo.jpg"/></a>
    </div>
    <a href="/"><span class="arrow"></span></a>
</div>
</div>

</body>
</html>