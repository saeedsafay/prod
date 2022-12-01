$(function () {
    "use strict";
    //This is for the Notification top right
    $.toast({
        heading: 'مرکز فروشندگان نوین نقش'
        , text: 'برای مدیریت فروشگاه خود از منوی محصولات استفاده کنید'
        , position: 'top-right'
        , loaderBg: '#ff6849'
        , icon: 'info'
        , hideAfter: 3500
        , stack: 6
    });
    // Dashboard 1 Morris-chart
    Morris.Area({
        element: 'morris-area-chart'
        , data: [{
            period: '2010'
            , iphone: 50
            , ipad: 80
            , itouch: 20
        }, {
            period: '2011'
            , iphone: 130
            , ipad: 100
            , itouch: 80
        }, {
            period: '2012'
            , iphone: 80
            , ipad: 60
            , itouch: 70
        }, {
            period: '2013'
            , iphone: 70
            , ipad: 200
            , itouch: 140
        }, {
            period: '2014'
            , iphone: 180
            , ipad: 150
            , itouch: 140
        }, {
            period: '2015'
            , iphone: 105
            , ipad: 100
            , itouch: 80
        }
            , {
                period: '2016'
                , iphone: 250
                , ipad: 150
                , itouch: 200
            }]
        , xkey: 'period'
        , ykeys: ['iphone', 'ipad', 'itouch']
        , labels: ['iPhone', 'iPad', 'iPod Touch']
        , pointSize: 3
        , fillOpacity: 0
        , pointStrokeColors: ['#00bfc7', '#fb9678', '#9675ce']
        , behaveLikeLine: true
        , gridLineColor: '#e0e0e0'
        , lineWidth: 3
        , hideHover: 'auto'
        , lineColors: ['#00bfc7', '#fb9678', '#9675ce']
        , resize: true
    });
    Morris.Area({
        element: 'morris-area-chart2'
        , data: [{
            period: '2010'
            , SiteA: 0
            , SiteB: 0
            ,
        }, {
            period: '2011'
            , SiteA: 130
            , SiteB: 100
            ,
        }, {
            period: '2012'
            , SiteA: 80
            , SiteB: 60
            ,
        }, {
            period: '2013'
            , SiteA: 70
            , SiteB: 200
            ,
        }, {
            period: '2014'
            , SiteA: 180
            , SiteB: 150
            ,
        }, {
            period: '2015'
            , SiteA: 105
            , SiteB: 90
            ,
        }
            , {
                period: '2016'
                , SiteA: 250
                , SiteB: 150
                ,
            }]
        , xkey: 'period'
        , ykeys: ['SiteA', 'SiteB']
        , labels: ['Site A', 'Site B']
        , pointSize: 0
        , fillOpacity: 0.4
        , pointStrokeColors: ['#b4becb', '#01c0c8']
        , behaveLikeLine: true
        , gridLineColor: '#e0e0e0'
        , lineWidth: 0
        , smooth: false
        , hideHover: 'auto'
        , lineColors: ['#b4becb', '#01c0c8']
        , resize: true
    });
});
// sparkline
var sparklineLogin = function () {
    var data_json = $.parseJSON(mostVisitedProducts);
    console.log(data_json)
    $('#sales1').sparkline([
        data_json[0]['visit_counts'],
        data_json[1]['visit_counts'],
        data_json[2]['visit_counts'],
    ], {
        type: 'pie',
        height: '200',
        resize: true,
        sliceColors: ['#01c0c8', '#7d5ab6', '#ffffff']
    });
    $('#sparkline2dash').sparkline([6, 10, 9, 11, 9, 10, 12], {
        type: 'bar',
        height: '154',
        barWidth: '4',
        resize: true,
        barSpacing: '10',
        barColor: '#25a6f7'
    });

};
var sparkResize;

$(window).resize(function (e) {
    clearTimeout(sparkResize);
    sparkResize = setTimeout(sparklineLogin, 500);
});
sparklineLogin();
