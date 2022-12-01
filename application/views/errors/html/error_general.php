<style>

    /**/
    :root {
        --main-color: #eaeaea;
        --stroke-color: #c23443;

    }

    /**/
    body {
        background: var(--main-color);
        font-family: 'Shabnam', tahoma !important;
    }

    h1 {
        margin: 100px auto 0 auto;
        color: var(--stroke-color);
        font-family: 'Shabnam', tahoma !important;
        font-size: 10rem;
        line-height: 10rem;
        font-weight: 200;
        text-align: center;
        color: #c23443;
    }

    h2 {
        margin: 20px auto 30px auto;
        font-family: 'Shabnam', tahoma !important;
        font-size: 1.5rem;
        font-weight: 200;
        text-align: center;
    }

    h3 {
        margin: 20px auto 30px auto;
        font-family: 'Shabnam', tahoma !important;
        font-size: 1.4rem;
        font-weight: 200;
        text-align: center;
    }

    h1, h2 {
        -webkit-transition: opacity 0.5s linear, margin-top 0.5s linear; /* Safari */
        transition: opacity 0.5s linear, margin-top 0.5s linear;
    }

    a {
        text-decoration: none;
    }

    .loading h1, .loading h2 {
        margin-top: 0px;
        opacity: 0;
    }

    .gears {
        position: relative;
        margin: 0 auto;
        width: auto;
        height: 0;
    }

    .gear {
        position: relative;
        z-index: 0;
        width: 120px;
        height: 120px;
        margin: 0 auto;
        border-radius: 50%;
        background: var(--stroke-color);
    }

    .gear:before {
        position: absolute;
        left: 5px;
        top: 5px;
        right: 5px;
        bottom: 5px;
        z-index: 2;
        content: "";
        border-radius: 50%;
        background: var(--main-color);
    }

    .gear:after {
        position: absolute;
        left: 25px;
        top: 25px;
        z-index: 3;
        content: "";
        width: 70px;
        height: 70px;
        border-radius: 50%;
        border: 5px solid var(--stroke-color);
        box-sizing: border-box;
        background: var(--main-color);
    }

    .gear.one {
        left: -130px;
    }

    .gear.two {
        top: -75px;
    }

    .gear.three {
        top: -235px;
        left: 130px;
    }

    .gear .bar {
        position: absolute;
        left: -15px;
        top: 50%;
        z-index: 0;
        width: 150px;
        height: 30px;
        margin-top: -15px;
        border-radius: 5px;
        background: var(--stroke-color);
    }

    .gear .bar:before {
        position: absolute;
        left: 5px;
        top: 5px;
        right: 5px;
        bottom: 5px;
        z-index: 1;
        content: "";
        border-radius: 2px;
        background: var(--main-color);
    }

    .gear .bar:nth-child(2) {
        transform: rotate(60deg);
        -webkit-transform: rotate(60deg);
    }

    .gear .bar:nth-child(3) {
        transform: rotate(120deg);
        -webkit-transform: rotate(120deg);
    }

    @-webkit-keyframes clockwise {
        0% {
            -webkit-transform: rotate(0deg);
        }
        100% {
            -webkit-transform: rotate(360deg);
        }
    }

    @-webkit-keyframes anticlockwise {
        0% {
            -webkit-transform: rotate(360deg);
        }
        100% {
            -webkit-transform: rotate(0deg);
        }
    }

    @-webkit-keyframes clockwiseError {
        0% {
            -webkit-transform: rotate(0deg);
        }
        20% {
            -webkit-transform: rotate(30deg);
        }
        40% {
            -webkit-transform: rotate(25deg);
        }
        60% {
            -webkit-transform: rotate(30deg);
        }
        100% {
            -webkit-transform: rotate(0deg);
        }
    }

    @-webkit-keyframes anticlockwiseErrorStop {
        0% {
            -webkit-transform: rotate(0deg);
        }
        20% {
            -webkit-transform: rotate(-30deg);
        }
        60% {
            -webkit-transform: rotate(-30deg);
        }
        100% {
            -webkit-transform: rotate(0deg);
        }
    }

    @-webkit-keyframes anticlockwiseError {
        0% {
            -webkit-transform: rotate(0deg);
        }
        20% {
            -webkit-transform: rotate(-30deg);
        }
        40% {
            -webkit-transform: rotate(-25deg);
        }
        60% {
            -webkit-transform: rotate(-30deg);
        }
        100% {
            -webkit-transform: rotate(0deg);
        }
    }

    .gear.one {
        -webkit-animation: anticlockwiseErrorStop 2s linear infinite;
    }

    .gear.two {
        -webkit-animation: anticlockwiseError 2s linear infinite;
    }

    .gear.three {
        -webkit-animation: clockwiseError 2s linear infinite;
    }

    .loading .gear.one, .loading .gear.three {
        -webkit-animation: clockwise 3s linear infinite;
    }

    .loading .gear.two {
        -webkit-animation: anticlockwise 3s linear infinite;
    }
</style>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <link rel="icon" type="image/png" sizes="16x16"
          href="/assets/default/NovinNaghsh2019/images/favi/favicon-16x16.png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/shabnam-font/5.0.1/font-face.min.css"
          integrity="sha512-K7kg/b/uwKLejlClSl2m2CDutNLO7w6Wh8R7X2921f6TSs/q+MuhKlTHbM9/8dvN5TK7Y9q2VV6pNtyVKdEKJQ=="
          crossorigin="anonymous"/>
    <title>خطای سرور | نوین نقش</title>
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
<body class="loading">
<h1>500</h1>
<h2><b>:(</b> خطای غیرمنتظره ی سرور </h2>
<h2>ما ازین مشکل مطلع شدیم و به سرعت مشکل رو برطرف می کنیم</h2>
<h2>
    <a href="/">صفحه اصلی<img style="vertical-align: middle" width="50"
                              src="/assets/default/NovinNaghsh2019/images/logo/logo.png"/></a>
</h2>
<h3>

</h3>
<div class="gears">
    <div class="gear one">
        <div class="bar"></div>
        <div class="bar"></div>
        <div class="bar"></div>
    </div>
    <div class="gear two">
        <div class="bar"></div>
        <div class="bar"></div>
        <div class="bar"></div>
    </div>
    <div class="gear three">
        <div class="bar"></div>
        <div class="bar"></div>
        <div class="bar"></div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-1.10.2.js"></script>
<script>
    $(function () {
        setTimeout(function () {
            $('body').removeClass('loading');
        }, 1000);
    });
</script>
</body>
</html>
