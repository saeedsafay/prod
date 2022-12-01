define(function (require, exports, module) {
    var $ = require('jquery');


    function construct() {
        // Product upload JS

        this.minicart_wrapper = ".js-minicart-wrapper";
        this.minicart_item = ".js-minicart-item";
        this.minicart_item_price = ".js-price";
        this.counter_number = $(".js-counter-number");
        this.minicart_lists = $(".js-minicart-lists");
        this.minicart_qty = $(".js-minicart-quantity");
        this.minicart_total = $(".js-minicart-total");
    }

    construct.prototype = {
        init: function () {
            // shopping extend init
            this.shopping_extend_jq();

            // date picker event
            $('body').on('focus', '.datepicker', this.shopping_focus_datepicker);

            // shopping cart event
            $('#subscribe').change(this.shopping_change_subscribe);

            $('.add-extra-date').click(this.shopping_click_extra_date);

            // COUPON AJAX event
            $("#do_coupon").click(this.shopping_click_coupon);
        },

        // jQuery extend shopping function
        shopping_extend_jq: function () {
            $.fn.addToCart = function(product_id) {
                event.preventDefault();
                form = $('#cart_form');
                item = $('.item' + product_id);
                prd_id = product_id;
                qty = item.find('.item-qty').val();
                if (qty < 1 || qty === 'undefined') {
                    qty = 1;
                }
                $.ajax({
                    url: base_url + 'shop/addToCart',
                    type: "POST",
                    data: {"prd_id": prd_id, "qty": qty, /* 'color': color*/},
                    dataType: "json",
                    cache: false,
                    beforeSend: function(xhr) {
                        form.find('i.fa-spin').show();
                    },
                    error: function (data) {

                    },
                    success: function(result) {
                        var modalTitle = $('h4.modal-title');
                        var modalBody = $('div.modal-body p');
                        if (result.response == 1) {
                            var amount = result.item['price'] * result.qty;
                            if (result.type == 2) {
                                var singleItem = $('li#cartItem' + result.item['id']);
                                var filled = $('.ul-cartItems li');
                                if (filled.length < 1 || singleItem.length < 1) {
                                    var new_single_flower = '<li id="cartItem' + result.item['id'] + '"><div class="pic_basket"><a href="' + base_url + 'product/' + result.item['slug'] + '"><img alt="{$item.title}" src="' + base_url + 'upload/products/pic/' + result.item['pic'] + '" alt=""></a></div><div class="name_basket_product"><a href="#">' + result.item['title'] + '</a><div class=""><span><strong data-prvqty="' + result.qty + '" class="qty-single">' + result.qty + '</strong> شاخه</span><br><span data-prvprice="' + amount + '" class="price-single">' + amount + '</span></div><div class="button_basket_product"><a href="#" onclick="$(this).removeCartItem(' + result.item['id'] + ');"><i class="fa fa-remove" aria-hidden="true"></i></a></div></div></li>';
                                    $('.basketbox').append(new_single_flower);

                                    singleItem.find('.qty-single').html(result.qty);
                                    prvqty = singleItem.find('.qty-single').data('prvqty');
                                    var prvqtysum = $('.prvqtysum').data('prvqtysum');
                                    newqtysum = prvqtysum - (prvqty - result.qty);
                                    $('.prvqtysum').html(newqtysum);

                                    //price
                                    prvprice = singleItem.find('.price-single').data('prvprice');
                                    var prvpricesum = $('.prvpricesum').data('prvpricesum');
                                    newpricesum = prvpricesum - (result.item['price'] * (prvqty - result.qty));
                                    $('.prvpricesum').html(newpricesum);

                                    $('.prvqtysum').data('prvqtysum', newqtysum);
                                    $('.prvpricesum').data('prvpricesum', newpricesum);
                                    singleItem.find('.qty-single').data('prvqty', result.qty);
                                    location.reload();
                                } else {
                                    singleItem.find('.qty-single').html(result.qty);
                                    prvqty = singleItem.find('.qty-single').data('prvqty');
                                    var prvqtysum = $('.prvqtysum').data('prvqtysum');
                                    newqtysum = prvqtysum - (prvqty - result.qty);
                                    $('.prvqtysum').html(newqtysum);

                                    //price
                                    prvprice = singleItem.find('.price-single').data('prvprice');
                                    var prvpricesum = $('.prvpricesum').data('prvpricesum');
                                    newpricesum = prvpricesum - (result.item['price'] * (prvqty - result.qty));
                                    $('.prvpricesum').html(newpricesum);

                                    $('.prvqtysum').data('prvqtysum', newqtysum);
                                    $('.prvpricesum').data('prvpricesum', newpricesum);
                                    singleItem.find('.qty-single').data('prvqty', result.qty);
                                }
                            } else {
                                modalTitle.html('افزودن به سبد خرید').css('color', '#2AA22A');
                                modalBody.html('کالای مورد نظر به سبد خرید شما اضافه شد.<br> <a class="btn btn-color add-to-cart left" href="' + base_url + 'shop/cart">مشاهده سبد خرید</a>');
                                $('#notifModal').modal('show');
                                // UPDATE THE CART IN HEADER

                                var new_cart_item = '<div class="cart-img-details"><div class="cart-img-photo"><a href="' + base_url + '/shop/' + result.item['slug'] + '"><img src="' + base_url + 'upload/products/pic/' + result.item['pic'] + '" alt=""></a><span class="quantity">' + result.qty + '</span></div><div class="cart-img-contaent"><a href="' + base_url + 'shop/' + result.item['slug'] + '"><h4>' + result.item['title'] + '</h4></a><span>' + amount + '</span></div><div class="pro-del"><a href="#"><i class="fa fa-times-circle"></i></a></div></div>';

                                //append the new data to the header cart
                                //if the item is first for cart
                                if ($('span.amount').data('amount') != 'undefind' || $('span.amount').data('amount') < 1) {
                                    $('.cart-img-details').html(new_cart_item);
                                } else { // if the item is not first cart item
                                    $('.add_cart_clear').last().after(new_cart_item);
                                }
                            }
                            // END
                        } else if (result.response == 10) {
                            modalTitle.html('بروزرسانی سبد خرید').css('color', '#2AA22A');
                            modalBody.html('سبد خرید شما بروز رسانی شد.<br> <a class="readmore pull-left" href="' + base_url + 'shop/cart">مشاهده سبد خرید</a>');
                            $('#notifModal').modal('show');
                        } else if (result.response == 1000) {
                            modalTitle.html('افزودن به سبد خرید').css('color', '#2AA22A');
                            modalBody.html('برای این منظور می بایست در سایت به عنوان خریدار عضو شوید .');
                            $('#notifModal').modal('show');
                        } else if (result.response == 2) {
                            modalTitle.html('خطا در افزودن به سبد خرید ').css('color', 'red');
                            modalBody.html('کالای انتخابی از قبل در سبد خرید شما موجود است. برای انتخاب تعداد بیشتر می توانید با استفاده از فیلد تعداد سفارش، تعداد سفارش را افزایش دهید.');
                            $('#notifModal').modal('show');
                        } else if (result.response == 404) {
                            modalTitle.html('خطا در افزودن به سبد خرید ').css('color', 'red');
                            modalBody.html('برای این منظور می بایست در سایت به عنوان خریدار عضو شوید. شما در حال حاضر با حساب کاربری فروشنده وارد شده اید.');
                            $('#notifModal').modal('show');
                        } else if (result.response == 403) {
                            modalTitle.html('خطا در افزودن به سبد خرید ').css('color', 'red');
                            modalBody.html('برای ساختن محصول شاخه ای می بایست حتما تمامی شاخه گل ها را از یک فروشگاه انتخاب نمایید.');
                            $('#notifModal').modal('show');
                        } else if (result.response == 3) {
                            modalTitle.html('کالا یافت نشد').css('color', 'red');
                            modalBody.html('کالای مورد نظر در پایگاه داده وجود ندارد');
                            $('#notifModal').modal('show');
                        } else if (result.response == 30) {
                            modalTitle.html('رنگ کالا را انتخاب کنید').css('color', 'red');
                            modalBody.html('رنگ مورد نظر خود را انتخاب نکردید. ');
                            $('#notifModal').modal('show');
                        } else if (result.response == 4) {
                            modalTitle.html('تعداد سفارش').css('color', '#eb9316');
                            modalBody.html('تعداد سفارش را یک یا بیشتر از یک انتخاب کنید!!');
                            $('#notifModal').modal('show');
                        } else if (result.response == 40) {
                            modalTitle.html('تعداد سفارش').css('color', '#eb9316');
                            modalBody.html('متاسفانه موجودی کالا با تعداد درخواستی شما برای سفارش همخوانی ندارد.');
                            $('#notifModal').modal('show');
                        } else if (result.response == 0) {
                            modalTitle.html('خطای سبد خرید').css('color', '#eb9316');
                            modalBody.html('برای ساختن سبد خرید لطفا در سایت عضو شوید یا لاگین کنید.');
                            $('#notifModal').modal('show');
                        } else if (result.response == 100) {
                            modalTitle.html('احراز هویت').css('color', '#eb9316');
                            modalBody.html('کاربر گرامی برای استفاده از این امکان لازم است تا در سایت ثبت نام کرده و وارد حساب کاربری خود شوید.<br><br><a class="btn btn-color left" href="' + base_url + 'users/login"> ثبت نام/ورود </a><br>');
                            $('#notifModal').modal('show');
                        }

                    },
                    complete: function() {
                        form.find('i.fa-spin').hide();
                    },
                });
            };

            $.fn.removeCartItem = function (variant_id) {
                var element = this;

                $.ajax({
                    url: base_url + 'shop/removeCartItem',
                    type: "POST", data: {"variant_id": variant_id},
                    dataType: "json",
                    cache: false,
                    success: function(result) {

                        var modalTitle = $('h4.modal-title');
                        var modalBody = $('div.modal-body p');
                        if (result.response == 1) {
                            modalTitle.html('حذف کالا از سبد خرید');
                            modalBody.html('کالای انتخابی از لیست سبد خرید شما با موفقیت حذف گردید.');
                            $('#cartItem' + variant_id).fadeOut().css('color', 'red').remove();
                            $('#notifModal').modal('show');

                            // remove item from mini cart
                            let qty = parseInt(main_obj.minicart_qty.text())-1;
                            main_obj.counter_number.text(qty);
                            main_obj.minicart_qty.text(qty);

                            let price = main_obj.minicart_total.text().replace(/,/g, '');
                            let price_remove = $(element).closest(main_obj.minicart_item)
                                .find(main_obj.minicart_item_price).text().replace(/,/g, '');

                            price = (parseInt(price) - parseInt(price_remove))
                                .toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');

                            main_obj.minicart_total.text(price);

                            $(element).closest(main_obj.minicart_item).remove();

//                    if (result.count == 0) {
//                        $('.wc-proceed-to-checkout a').fadeOut().remove();
//                             window.setTimeout(function() {
//                                 location.reload();
//                             }, 3000);
//                    }
                        }

                    }
                });
            };

            $.fn.addFavorite = function(product_id) {
                $.ajax({
                    url: base_url + 'shop/products/addFavorite',
                    type: "POST",
                    data: {"product_id": product_id},
                    dataType: "json",
                    cache: false,
                    success: function(result) {
                        var modalTitle = $('h4.modal-title');
                        var modalBody = $('div.modal-body p');
                        if (result.response == 1) {
                            modalTitle.html('افزودن به علاقمندی‌ها');
                            modalBody.html('کالای انتخابی شما با موفقیت به لیست علاقمندی‌ها اضافه گردید.<br> <a class="btn btn-color add-to-cart left" href="' + base_url + 'shop/manage-products/favorites">مشاهده لیست علاقمندی</a>');
                            $('#notifModal').modal('show');
                        }
                        else if (result.response == 0) {
                            modalTitle.html('افزودن به علاقمندی‌ها');
                            modalBody.html('برای ساختن لیست علاقمندی‌هایتان لازم است در سایت وارد شوید.<br> <a class="btn btn-color add-to-cart left" href="' + base_url + 'users/login">ورود/عضویت</a>');
                            $('#notifModal').modal('show');
                        } else if (result.response == 404) {
                            modalTitle.html('خطا در افزودن به علاقمندی ').css('color', 'red');
                            modalBody.html('برای این منظور می بایست در سایت به عنوان خریدار عضو شوید. شما در حال حاضر با حساب کاربری فروشنده وارد شده اید.');
                            $('#notifModal').modal('show');
                        }

                    }
                });
            }
        },

        // date picker function
        body_focus_datepicker: function (event) {
            $(event.currentTarget).persianDatepicker({
                minDate: new persianDate().unix(),
                format: "YYYY/MM/DD",
                persianDigit: false,
            });
        },

        // shopping function
        shopping_change_subscribe: function () {
            if ($(this).is(":checked")) {
                $('.subscribe_date_wrapper').fadeIn();
            } else
                $('.subscribe_date_wrapper').fadeOut();
        },

        // shopping function
        shopping_click_extra_date: function (e) {
            e.preventDefault();
            $(this).parent().find('.saeed').append('<input name="subscribe_date[]"  placeholder="تاریخ دریافت"  type="text" class="datepicker" />');
        },

        // shopping function
        shopping_click_coupon: function (event) {
            event.preventDefault();
            form = $('#cart_form');
            code = $('#coupon_code').val();
            if (code == '') {
                alert('ابتدا کد را وارد نمایید.');
                return false;
            }
            $.ajax({
                url: base_url + 'shop/coupon',
                type: "POST", data: {"code": code},
                dataType: "json",
                cache: false,
                beforeSend: function(xhr) {
                    $('i.fa-refresh').show();
                },
                success: function(result) {
                    var modalTitle = $('h4.modal-title');
                    var modalBody = $('div.modal-body p');
                    if (result.response == 1) {
                        modalTitle.html('اعمال کوپن').css('color', '#2AA22A');
                        modalBody.html('کد تخفیف شما با موفقیت بر روی فاکتور شما اعمال شد.');
                        $('#notifModal').modal('show');
                        $('.order-total span.amount').html(result.total);
                    } else if (result.response == 10) {
                        modalTitle.html('بروزرسانی سبد خرید').css('color', '#2AA22A');
                        modalBody.html('سبد خرید شما بروز رسانی شد.<br> <a class="readmore pull-left" href="' + base_url + 'advertise/ads/show-compare">مشاهده سبد خرید</a>');
                        $('#notifModal').modal('show');
                    } else if (result.response == 0) {
                        modalTitle.html('اعمال کوپن').css('color', 'red');
                        modalBody.html('کد وارد شده نامعتبر است.');
                        $('#notifModal').modal('show');
                    } else if (result.response == 2) {
                        modalTitle.html('اعمال کوپن').css('color', 'red');
                        modalBody.html('کاربر گرامی کد تخفیف یا هدیه ای که وارد کردید از قبل در سایت استفاده شده است.');
                        $('#notifModal').modal('show');
                    }

                },
                complete: function() {
                    $('i.fa-refresh').hide();
                },
            });
        },
    };

    const main_obj = new construct();

    // initializing obj JS
    main_obj.init();

    return main_obj;
});
