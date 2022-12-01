<head>

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="UTF-8">
    <title>{if isset($title)}{$title}{/if} | نوین نقش</title>

    <meta name="description" content="{setting name=meta_description} {if isset($title)}{$title}{/if}">
    <!-- favicon tag -->
    <link rel="shortcut icon" type="image/x-icon" href="{assets_url}images/favi/favicon.ico">
    <link rel="apple-touch-icon" sizes="180x180" href="{assets_url}images/favi/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="{assets_url}images/favi/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="{assets_url}images/favi/favicon-16x16.png">
    <link rel="manifest" href="{assets_url}images/favi/site.webmanifest">
    <link rel="mask-icon" href="{assets_url}images/favi/safari-pinned-tab.svg" color="#5bbad5">
    <meta name="msapplication-TileColor" content="#b91d47">
    <meta name="theme-color" content="#ffffff">

    <link rel="stylesheet" type="text/css" href="{css_url}animate.css">
    <link rel="stylesheet" type="text/css" href="{css_url}bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="{css_url}bootstrap-rtl.min.css">
    <link rel="stylesheet" type="text/css" href="{css_url}fontawesome.min.css">
    <link rel="stylesheet" type="text/css" href="{css_url}jquery-confirm.min.css">
    <link rel="stylesheet" type="text/css" href="{css_url}pe-icon-7-stroke.css">
    <link rel="stylesheet" type="text/css" href="{css_url}owl.carousel.css">
    <link rel="stylesheet" type="text/css" href="{css_url}chosen.css">
    <link rel="stylesheet" type="text/css" href="{css_url}jquery.bxslider.css">

    {header_css}

    <link rel="stylesheet" type="text/css" href="{css_url}fonts.css">
    <link rel="stylesheet" type="text/css" href="{css_url}style.css?v={time()}">
    <link rel="stylesheet" type="text/css" href="{css_url}custom.css?v={time()}">

    <!-- jQuery -->
    <script data-main="{assets_url}js/main.js?v={time()}" src="{assets_url}js/require.js?v={time()}"
            async="true"></script>
    {header_js}

    <script>
        var base_url = '{site_url()}';
        var asset_url = '{assets_url}';
        {if isset($min_price)}
        var min_price_range = {$min_price};
        {else}
        var min_price_range = 0;
        {/if}
        {if isset($max_price)}
        var max_price_range = {$max_price};
        {else}
        var max_price_range = 5000000;
        {/if}
        data = [];
        countTime = [];
    </script>
    {if $production}
    {literal}
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
    {/literal}
    {/if}

    <!-- JSON-LD markup -->

    <script type="application/ld+json">
        {
            "@context": "https://schema.org",
            "@type": "Organization",
            "url": "{site_url()}",
            "logo": "{assets_url}/images/home1/logo.jpg"
        }
    </script>
    <script type="application/ld+json">
        {
            "@context": "http://schema.org",
            "@type": "LocalBusiness",
            "name": "نوین نقش",
            "image": "{assets_url}/images/home1/logo.jpg",
            "telephone": "021-66126993",
            "email": "info@novinnaghsh.ir",
            "address": {
                "@type": "PostalAddress",
                "streetAddress": "اسکندری شمالی، پلاک 79",
                "addressLocality": "تهران",
                "addressCountry": "ایران"
            },
            "openingHoursSpecification": {
                "@type": "OpeningHoursSpecification",
                "dayOfWeek": [
                    "Saturday",
                    "Sunday",
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday"
                ],
                "opens": "09:00",
                "closes": "18:00"
            },
            "priceRange": "$",
            "geo": {
                "@type": "GeoCoordinates",
                "latitude": 35.70339781233979,
                "longitude": 51.380699693235314
            },
            "url": "https://novinnaghsh.ir/"
        }
    </script>
</head>