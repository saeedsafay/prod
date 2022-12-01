define(function (require, exports, module) {

    let $ = require('jquery'),
        obj_lang = require('lang');


    function construct() {
        //  data

        this.counter_number = $(".js-counter-number");
        this.minicart_lists = $(".js-minicart-lists");
        this.minicart_qty = $(".js-minicart-quantity");
        this.minicart_total = $(".js-minicart-total");

        this.minicart_item = ".js-minicart-item";
        this.minicart_item_title = ".js-title";
        this.minicart_item_link = ".js-link";
        this.minicart_item_price = ".js-price";
        this.minicart_item_img = ".js-img";
        this.minicart_item_remove = ".js-remove";

        this.template_li = '<li class="product-inner js-minicart-item clearfix"> <div class="product-thumb style1"> <div class="thumb-inner"> <a class="js-link" href="#"> <img class="js-img" alt="title" src="sourceImage" width="80"> </a> </div> </div> <div class="product-innfo"> <div class="product-name"> <a class="js-link js-title" href="#">title</a> </div> <a class="remove js-remove" href="#" onclick="$(this).removeCartItem();" title="حذف این محصول"> <i class="fa fa-times" aria-hidden="true"></i> </a> <span class="price price-dark"> <ins class="js-price">price</ins> </span> </div> </li>';
    }

    construct.prototype = {
        init: function () {
            //
        },

        // update mini cart list
        update_shopping_icon: function (data) {
            // update qty in mini cart
            let qty = parseInt(main_obj.minicart_qty.text())+1;
            main_obj.counter_number.text(qty);
            main_obj.minicart_qty.text(qty);

            // update template with actual data
            let html = $(main_obj.template_li);

            html.find(main_obj.minicart_item_title).text(data.title);
            html.find(main_obj.minicart_item_link).attr("href", data.href);
            html.find(main_obj.minicart_item_price).html(
                data.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+ ' ریال');
            html.find(main_obj.minicart_item_img).attr("src", data.image);
            html.find(main_obj.minicart_item_img).attr("alt", data.title);
            html.find(main_obj.minicart_item_remove).attr("onclick", "$(this).removeCartItem("  + data.id + ");");

            main_obj.minicart_lists.append(html);

            // update price in mini cart
            let price = main_obj.minicart_total.text().replace(/,/g, '');
            price = (parseInt(price) + data.price)
                .toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
            main_obj.minicart_total.text(price);
        },

    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});

