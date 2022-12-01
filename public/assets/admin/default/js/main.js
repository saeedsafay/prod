$(document).ready(function () {
        if ($(window).width() < 1220) {
            $('body').addClass('sidebar_main_active');
        }

        $(".collaptable").aCollapTable({

            // the table is collapased at start
            startCollapsed: true,

            // the plus/minus button will be added like a column
            addColumn: true,

            // The expand button ("plus" +)
            plusButton: '<span class="uk-icon-plus uk-text-success"></span>  ',

            // The collapse button ("minus" -)
            minusButton: '<span class="uk-icon-minus uk-text-danger">-</span>  '

        });

        $('#dt_default').dataTable({
            "language": {
                "sProcessing": "درحال پردازش...",
                "sLengthMenu": "نمایش محتویات _MENU_",
                "sZeroRecords": "موردی یافت نشد",
                "sInfo": "نمایش _START_ تا _END_ از مجموع _TOTAL_ مورد",
                "sInfoEmpty": "تهی",
                "sInfoFiltered": "(فیلتر شده از مجموع _MAX_ مورد)",
                "sInfoPostFix": "",
                "sSearch": "جستجو:",
                "sUrl": "",
                "oPaginate": {
                    "sFirst": "ابتدا",
                    "sPrevious": "قبلی",
                    "sNext": "بعدی",
                    "sLast": "انتها"
                }
            },
            "displayLength": 100000,
            "aoColumnDefs": [
                {"bSortable": false, "aTargets": ['no-sort']}
            ]
        });
        $('.delete').on('click', function (e) {
            e.preventDefault();
            $this = $(this);
            $.confirm({
                title: 'حذف',
                icon: 'uk-icon-warning uk-text-warning',
                confirmButton: 'بله',
                cancelButton: 'بیخیال',
                animation: 'zoom',
                autoClose: 'cancel|10000',
                animationSpeed: 600,
                content: 'آیتم انتخابی حذف خواهد شد. آیا اطمینان دارید؟',
                confirmButtonClass: 'btn-success',
                cancelButtonClass: 'btn-warning',
                contentClass: 'btn-danger',
                confirm: function () {
                    window.location.href = $this.attr("href");
                },
                cancel: function () {
                }
            });
        });
        $page_content = $("#page_content");
        $("[data-md-one-selectize], .data-md-one-selectize").each(function () {
            var e = $(this);
            if (!e.hasClass("selectized")) {
                var i = e.attr("data-md-selectize-bottom");
                e.after('<div class="selectize_fix"></div>').selectize({
                    create: false,
                    sortField: 'text',
                    onDropdownOpen: function (e) {
                        "undefined" != typeof i && e.css({"margin-top": "0"});
                    },
                    onDropdownClose: function (e) {
                        "undefined" != typeof i && e.css({"margin-top": ""});
                    }
                })
            }
        });
        $("[data-md-tag-selectize], .data-md-tag-selectize").each(function () {
            var e = $(this);
            if (!e.hasClass("selectized")) {
                var i = e.attr("data-md-selectize-bottom");
                e.after('<div class="selectize_fix"></div>').selectize({
                    plugins: {'remove_button': {label: ""}},
                    create: function (input) {
                        return {
                            value: input,
                            text: input
                        }
                    },
                    onDropdownOpen: function (e) {
                        "undefined" != typeof i && e.css({"margin-top": "0"});
                    },
                    onDropdownClose: function (e) {
                        "undefined" != typeof i && e.css({"margin-top": ""});
                    }
                })
            }
        });
        $("[data-md-closable-selectize], .data-md-closable-selectize").each(function () {
            var e = $(this);
            if (!e.hasClass("selectized")) {
                var i = e.attr("data-md-selectize-bottom");
                e.after('<div class="selectize_fix"></div>').selectize({
                    plugins: {'remove_button': {label: ""}},
                    create: false,
                    sortField: 'text',
                    onDropdownOpen: function (e) {
                        "undefined" != typeof i && e.css({"margin-top": "0"});
                    },
                    onDropdownClose: function (e) {
                        "undefined" != typeof i && e.css({"margin-top": ""});
                    }
                })
            }
        });
        // slug making :
        $('.slug').on('focus', function () {
            var character = $('.title').val();
            $(".slug").val(character);
        });
        $('.set_as_homepage').on('click', function (e) {
            e.preventDefault();
            url = $(this).attr('href');
            $.post(url, '', function (res) {
                if (res.success) {
                    $('#body_for_ajax_notif').prepend("<div data-uk-alert='' id='ajax_notif' class='uk-alert uk-alert-success'><a class='uk-alert-close uk-close' href='#'></a>صفحه مورد نظر بعنوان صفحه اصلی تعیین شد</div>");
                    setTimeout(function () {
                        $('#ajax_notif').slideUp(2500);
                        setTimeout(function () {
                            $('div').remove('.uk-alert');
                        }, 3500);
                    }, 4500);
                }
            }, 'json');
        });
        /*************************** JALALI DATEPICKER **********************/


        $(".datepicker").persianDatepicker({
                format: "YYYY-MM-DD HH:mm:ss",
                altFormat: "YYYY-MM-DD HH:mm:ss",
                altField: '.datepicker-alt',
                initialValue: false,
                timePicker: {
                    enabled: true,
                    meridiem: {
                        enabled: true
                    }
                },
                formatter: function (unix) {
                    return unix / 1000;
                }
            }
        );


        /*
         month
         */
        $("#monthYearPicker").persianDatepicker({
            format: "YYYY-MM",
            altField: '#monthpickerAlt',
            altFormat: "YYYY MM DD HH:mm:ss",
            yearPicker: {
                enabled: true
            },
            monthPicker: {
                enabled: true
            },
            dayPicker: {
                enabled: false
            }
        });
        /*
         month
         */
        $("#fromMonthPicker, #toMonthPicker").persianDatepicker({
            format: "MM",
            altField: '#monthpickerAlt',
            altFormat: "YYYY MM DD HH:mm:ss",
            yearPicker: {
                enabled: false
            },
            monthPicker: {
                enabled: true
            },
            dayPicker: {
                enabled: false
            }
        });

        /*
         year
         */
        $("#fromYearPicker, #toYearPicker").persianDatepicker({
            format: "YYYY",
            altField: '#yearpickerAlt',
            altFormat: "YYYY MM DD HH:mm:ss",
            dayPicker: {
                enabled: false
            },
            monthPicker: {
                enabled: false
            },
            yearPicker: {
                enabled: true
            }
        });

        /*************************** END JALALI DATEPICKER **********************/


        $('#product_type_id').on('change', function () {
            var p_type_id = $(this).val();

            $('#child-cat-wrapper').fadeOut();
            $('#diversity-type-wrapper').fadeOut();
            // get related reasons
            $.ajax({
                type: "GET",
                url: ADMIN_URL + '/shop/categories/getCategories',
                dataType: 'json',
                cache: false,
                data: {product_type_id: p_type_id},
                success: function (data) {
                    $('#category_parents').find('option:not(:first)').remove();

                    var selectize_tags = $("#category_parents")[0].selectize;
                    selectize_tags.clearOptions();
                    $.each(data.results, function (index, value) {
                        selectize_tags.addOption({
                            text: value.title,
                            value: value.id
                        });
                    });
                },
                beforeSend: function () {
                    $('.loadings').show();
                    altair_helpers.content_preloader_show()
                },
                complete: function () {
                    $('.loadings').hide();
                    altair_helpers.content_preloader_hide()
                },
            });

        });
        $('#category_parents').change(function () {
                cat_id = $(this).val();
                $.ajaxSetup({
                    beforeSend: function () {
                        $('.loadings').show();
                        altair_helpers.content_preloader_show()
                    },
                    complete: function () {
                        $('.loadings').hide();
                        altair_helpers.content_preloader_hide()
                    },
                });
                $.post(ADMIN_URL + '/shop/categories/getChildCats',
                    {'cat_id': cat_id}, function (res) {

                        $("#product_childCategory_id").selectize({
                            create: true
                        })

                        var selectize_tags = $("#product_childCategory_id")[0].selectize;
                        selectize_tags.clearOptions();
                        if (res.results.length > 0) {
                            $('#child-cat-wrapper').fadeIn();
                            // if (cat_id == 162)
                                $('#diversity-type-wrapper').fadeIn();
                            $.each(res.results, function (index, value) {
                                selectize_tags.addOption({
                                    text: value.title,
                                    value: value.id
                                });
                            });
                        } else {
                            $('#child-cat-wrapper').fadeOut();
                            $('#diversity-type-wrapper').fadeOut();
                        }
                    }, 'json');
            }
        );
    }
);