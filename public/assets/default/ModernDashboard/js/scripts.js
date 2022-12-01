(function ($) {

    "use strict";
    $(".datepicker").persianDatepicker({
        format: "YYYY/MM/DD",
        initialValueType: 'gregorian',
        altField: '.datepicker',
        altFormat: "YYYY MM DD",
        dayPicker: {
            enabled: true
        },
        monthPicker: {
            enabled: true
        },
        yearPicker: {
            enabled: true
        }
    });

})(jQuery);

function selectRefresh() {
    $('select').select2({
        width: '100%',
        closeOnSelect: true
    });
}

function selectRefreshWithoutClose() {
    $('select.stay-open').select2({
        width: '100%',
        closeOnSelect: false
    });
}

$(document).ready(function () {
    selectRefresh();
    selectRefreshWithoutClose();
    $('.dropify').dropify({
        messages: {
            'default': 'فایل خود را کشیده و در این قسمت رها کنید و یا کلیک کنید',
            'replace': 'فایل خود را کشیده و در این قسمت رها کنید و یا کلیک کنید تا جایگزین شود',
            'remove': 'حذف',
            'error': 'یه مشکلی پیش اومده'
        },
        error: {
            'fileSize': 'The file size is too big ({{ value }} max).',
            'minWidth': 'The image width is too small ({{ value }}}px min).',
            'maxWidth': 'The image width is too big ({{ value }}}px max).',
            'minHeight': 'The image height is too small ({{ value }}}px min).',
            'maxHeight': 'The image height is too big ({{ value }}px max).',
            'imageFormat': 'فرمت فایل انتخابی قابل قبول نیست. فرمت ({{ value }}) مجاز است.'
        }
    });
});

$.fn.changeStock = function (product_id) {
    var state = $(this).val();
    // get related reasons
    $.ajax({
        type: "POST",
        url: SITE_URL + 'seller/manage-products/changeStateProduct',
        dataType: 'json',
        cache: false,
        data: {state: state, product_id: product_id},
        success: function (result) {
            $('#stock_change_list' + product_id).fadeIn().css('background', '#2bea2b').fadeOut().fadeIn().fadeOut().fadeIn().fadeOut().fadeIn().css('background', 'none');
        }
    });
};


var i = 0;
$('#add-extra-input').click(function (e) {

    e.preventDefault();
    $('#input-wrapper').append('<input name="product_image[]" type="file" />');
    i += 1;
});
$('.variant-image').on('change', function (e) {
    e.preventDefault();
    var form = $(this);
    var variant_ids = form.val();
    var image_id = form.attr('data-image-id');

    $.ajax({
        type: "POST",
        url: '/seller/variants/sync-images',
        dataType: 'json',
        cache: false,
        data: {'image_id': image_id, 'variants': variant_ids},
        beforeSend: function () {

        },
        error: function (data) {
            $.toast({
                heading: 'خطای فرم',
                text: data.responseJSON.error,
                position: 'top-right',
                loaderBg: '#ff6849',
                icon: 'error',
                showHideTransition: 'fade',
                hideAfter: 8000
            });
        },
        success: function (response) {
            $('#diversity-modal').find('p.errors').empty();

            $.toast({
                heading: 'ساخت عکس محصولات',
                text: response.message,
                position: 'top-right',
                loaderBg: '#71ff2c',
                icon: 'success',
                showHideTransition: 'fade',
                hideAfter: 8000
            });

        }
    });

});

$('#product_type').on('change', function () {
    var product_type_id = $(this).val();
    var cats = $("#cats-ptype-wrapper");
    var cats_select = $('#product_category_id');
    cats_select.find('option:not(:first)').remove();

    //child cats:
    var child_cats = $("#child-cats-ptype-wrapper");
    var child_cats_select = $('#product_child_category_id');
    child_cats_select.find('option:not(:first)').remove();
    child_cats.fadeOut();
    $("#filters-wrapper").find('.prd-specifications').empty();
    $('#loading-filters').show();

    $.getJSON(
        SITE_URL + 'shop/products/getCats',
        {'product_type_id': product_type_id},
        function (result) {
            /**
             * First for loading filter inputs
             */
            var options = '';
            $.each(result.cats, function (i, field) {
                options = options + '<option value="' + field.id + '">' + field.title + '</option>'
            });

            cats_select.append(options);
            cats_select.find('option:disabled').prop('selected', true);
//                $('html, body').animate({
//                    scrollTop: (cats.first().offset().top - 0)
//                }, 600);

            cats.fadeIn();
            $('#loading-filters').hide();
        }).fail(function (data) {
        $.toast({
            heading: 'خطای دیتا',
            text: data.responseJSON.error,
            position: 'top-right',
            loaderBg: '#ff6849',
            icon: 'error',
            showHideTransition: 'fade',
            hideAfter: 8000
        });
        $('#loading-filters').hide();
        return false;

    });
});

if ($('#edit-product').val() === 1) {
    $('#product_type').trigger('change');
    $('#product_category_id').find('option:disabled').prop('selected', true);
}


$('#product_category_id').on('change', function () {
    var product_cat_id = $(this).val();
    var cats = $("#child-cats-ptype-wrapper");
    var cats_select = $('#product_child_category_id');
    cats_select.find('option:not(:first)').remove();

    $("#filters-wrapper").find('.prd-specifications').empty();
    $('#loading-filters').show();
    cats.fadeOut();
    $.getJSON(
        SITE_URL + 'shop/products/getChildCats',
        {'parent_cat_id': product_cat_id},
        function (result) {
            /**
             * First for loading filter inputs
             */
            if (result.cats.length > 0) {
                var options = '';
                $.each(result.cats, function (i, field) {
                    options = options + '<option value="' + field.id + '">' + field.title + '</option>'
                });
                cats_select.append(options);
                cats_select.find('option:disabled').prop('selected', true);
                cats.fadeIn();
                $('html, body').animate({
                    scrollTop: (cats.first().offset().top - 0)
                }, 600);

            } else {
                loadFilters(product_cat_id);
                cats.fadeOut();
            }
            $('#loading-filters').hide();
        }).fail(function (data) {
        $.toast({
            heading: 'خطا',
            text: data.responseJSON.error,
            position: 'top-right',
            loaderBg: '#ff6849',
            icon: 'error',
            showHideTransition: 'fade',
            hideAfter: 8000
        });
        $('#loading-filters').hide();
        return false;

    });
});


$('#product_child_category_id').on('change', function () {
    var product_category_id = $(this).val();

    loadFilters(product_category_id);

});

$('#add-diversity').on('click', function (event) {
    event.preventDefault();
    var $modal = $('#diversity-modal');
    if ($('#edit-product').val() == 0) {
        $modal.find('.modal-body').empty().prepend('<strong>برای درج تنوع ابتدا باید محصول خود را ثبت نمایید</strong>');
        $modal.find('#save-varient').fadeOut();
//        $modal.modal('toggle');
        return false;
    } else {
        $modal.find('#save-varient').fadeIn();
    }
    product_category_id = $('#product_child_category_id').val();

    loadDiversity(product_category_id);
});

function loadFilters(product_category_id) {

    var filters = $("#filters-wrapper");
    filters.find('.prd-specifications').empty();
    $('#loading-filters').show();
    $.getJSON(
        SITE_URL + 'shop/products/getFiltersByCategory',
        {'product_category_id': product_category_id},
        function (result) {
            /**
             * First for loading filter inputs
             */
            filters.fadeIn();

            $.each(result.filters, function (i, field) {
                var textField = (field.field_type == 3) ? 1 : 0;
                var multiple = (field.field_type == 1) ? 'multiple' : '';
//                    var multiple = '';
                var options = '';


                $.each(field.values, function (i, value) {
                    if (value.is_color === 1) {
                        options = options + '<option style="padding: 1px 13px 0px 13px;border-radius: 7px;color:' + value.title + ';background-color:' + value.title + '" value="' + value.id + '">'
                            + value.title +
                            '</option>';
                    } else {
                        options = options + '<option value="' + value.id + '">'
                            + value.title +
                            '</option>';
                    }
                });

                if (textField) {
                    var colDiv = '<div class="col-md-6 col-lg-6  pull-right"><div class="form-group "><label class="control-label">‌' + field.label + ' :</label><input type="text" name="filters[' + field.name + '][]" class="form-control"/></div></div>';
                } else {
                    var colDiv = '<div class="col-md-6 col-lg-6  pull-right"><div class="form-group "><label>‌' + field.label + ' :</label><select class="form-control select2-custom" name="filters[' + field.name + '][]" ' + multiple + '>' + options + '</select></div></div>';
                }
                filters.fadeIn();
                filters.find('.prd-specifications').append(colDiv);
                selectRefresh();
            });

            $('html, body').animate({
                scrollTop: ($('#filters-wrapper').first().offset().top - 0)
            }, 1500);

            $('#loading-filters').hide();
        }).fail(function (data) {
        if (data.status != 422) {
            $.toast({
                heading: 'خطا',
                text: data.responseJSON.error,
                position: 'top-right',
                loaderBg: '#ff6849',
                icon: 'error',
                showHideTransition: 'fade',
                hideAfter: 8000
            });
        }
        $('#loading-filters').hide();
        filters.hide();
        return false;

    });
}


function loadDiversity(product_category_id) {

    var $modal = $('#diversity-modal');

    var product_id = $('#product_id').val();
    $modal.find('#varient-form').attr('action', '/seller/variants/add-variant/' + product_id);

    var diversity = $("#diversity-wrapper");
    diversity.find('.prd-diversities').empty();
    $.getJSON(
        '/seller/variants/getDiversitiesByCategory',
        {'product_category_id': product_category_id},
        function (result) {
            /**
             * First for loading diversity inputs
             */
            diversity.fadeIn();

            $.each(result.diversities, function (i, field) {
                var multiple = (field.field_type == 1) ? 'multiple' : '';
//                    var multiple = '';
                var options = '';


                $.each(field.values, function (i, value) {
                    if (value.is_color === 1) {
                        options = options + '<option style="padding: 1px 13px 0px 13px;border-radius: 7px;color:' + value.title + ';background-color:' + value.title + '" value="' + value.id + '">'
                            + value.title +
                            '</option>';
                    } else {
                        options = options + '<option value="' + value.id + '">'
                            + value.title +
                            '</option>';
                    }
                });

                var colDiv = '<div class="form-group"><label class="control-label">‌انتخاب ' + field.label + ' :</label><select class="form-control select2-custom" name="diversity[particular][' + field.name + ']" ' + multiple + '><option value="" disabled="" selected="">انتخاب کنید...</option>' + options + '</select></div>';
                diversity.fadeIn();
                diversity.find('.prd-diversities').append(colDiv);
                selectRefresh();

                $modal.modal('show');
            });

        }).fail(function (data) {
        $.toast({
            heading: 'خطای دیتا',
            text: data.responseJSON.error,
            position: 'top-right',
            loaderBg: '#ff6849',
            icon: 'error',
            showHideTransition: 'fade',
            hideAfter: 8000
        });
        return false;

    });
}

function loadDiversityById(diversity_data_id) {

    var $modal = $('#diversity-modal');

    $modal.find('#varient-form').attr('action', '/seller/variants/edit-variant/' + diversity_data_id);
    var diversity = $("#diversity-wrapper");
    diversity.find('.prd-diversities').empty();
    $.getJSON(
        '/seller/variants/getDiversityById',
        {'diversity_data_id': diversity_data_id},
        function (data) {
            /**
             * First for loading diversity inputs
             */
            $('input[name="diversity[price]"]').val(data.results.price);
            $('input[name="diversity[stock]"]').val(data.results.stock);
            $('input[name="diversity[max_order]"]').val(data.results.max_order);
            $('input[name="diversity[lead_time]"]').val(data.results.lead_time);

            diversity.fadeIn();

            $.each(data.allDiversities, function (i, diversityRow) {
                var options = '';

                var is_disabled = false;
                input_name = 'diversity[particular][' + diversityRow.name + ']';
                $.each(diversityRow.values, function (i, diversity_value) {

                    var selected = ''
                    $.each(data.results.fields, function (i, diversity_field) {
                        if (diversity_field.diversity_value_id === diversity_value.id) {
                            selected = 'selected=""';
                            input_name = '';
                            is_disabled = true;
                        }
                    });

                    if (diversity_value.is_color === 1) {
                        options = options + '<option style="padding: 1px 13px 0px 13px;border-radius: 7px;color:' + diversity_value.title + ';background-color:' + diversity_value.title + '" value="' + diversity_value.id + '" ' + selected + '>'
                            + diversity_value.title +
                            '</option>';
                    } else {
                        options = options + '<option value="' + diversity_value.id + '" ' + selected + '>'
                            + diversity_value.title +
                            '</option>';
                    }
                });

                let label = $('<label></label>')
                    .addClass('control-label')
                    .html(diversityRow.label);

                let select = $('<select></select>')
                    .attr('name', input_name)
                    .attr('disabled', is_disabled)
                    .addClass("form-control select2-custom")
                    .prepend('<option value="" disabled="" selected="">انتخاب کنید</option>' + options);

                let colDiv = $("<div></div>").addClass('form-group').prepend(label).append(select);
                diversity.fadeIn();
                diversity.find('.prd-diversities').append(colDiv);
                selectRefresh();

            });
            $modal.modal('show');
        }).fail(function (data) {
        $.toast({
            heading: 'خطا',
            text: data.responseJSON.error,
            position: 'top-right',
            loaderBg: '#ff6849',
            icon: 'error',
            showHideTransition: 'fade',
            hideAfter: 8000
        });
        return false;

    });
}

function createVariantRow(data) {

    var variant_title = data.product.title + ' | ';
    $.each(data.variant_fields, function (i, field) {
        variant_title = variant_title + field.value.title + ' | ';
    });

    if (data.variant_data.status)
        var status_icon = '<i class="fa fa-check"></i>';
    else
        var status_icon = '<i class="fa fa-close"></i>';


    if (data.variant_data.stock > 0)
        var sale = 'قابل فروش';
    else
        var sale = 'اتمام موجودی';

    var newRow = '<tr><td><p>' + variant_title
        + '</p></td><td><p>' + data.variant_data.id
        + '</p></td><td class="varient-active"><p>' + status_icon
        + '</p></td><td class="varient-status"><p>' + sale
        + '</p></td><td class="varient-price"><p>' + data.variant_data.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
        + '</p></td><td class="varient-stock"><p>' + data.variant_data.stock
        + '</p></td><td class="varient-max-order"><p>' + data.variant_data.max_order
        + '</p></td><td class="varient-lead-time"><p>' + data.variant_data.lead_time
        + '</p></td><td class="point_table_width_button"><a onclick="$(this).editVarientModal(' + data.variant_data.id + ')"'
        + ' href="javascript:void()"'
        + ' class="btn btn-sm btn-secondary"><span>ویرایش</span></a></td></tr>';

    return newRow;
}

function editVariantRow(variant_data, new_fields) {

    var $variant_row = $('.varient-row-' + variant_data.id);

    var variant_title = variant_data.product.title + ' | ';
    $.each(new_fields, function (i, field) {
        variant_title = variant_title + field.value.title + ' | ';
    });
    if (variant_data.status)
        var status_icon = '<i class="fa fa-check"></i>';
    else
        var status_icon = '<i class="fa fa-times"></i>';


    if (variant_data.stock > 0)
        var sale = 'قابل فروش';
    else
        var sale = 'اتمام موجودی';


    $variant_row.find('.varient-title p').html(variant_title);
    $variant_row.find('.varient-price p').html(variant_data.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
    $variant_row.find('.varient-active p').html(status_icon);
    $variant_row.find('.varient-status p').html(sale);
    $variant_row.find('.varient-stock p').html(variant_data.stock);
    $variant_row.find('.varient-max-order p').html(variant_data.max_order);
    $variant_row.find('.varient-lead-time p').html(variant_data.lead_time);
    return true;
}

$('#varient-form').on('submit', function (e) {
    e.preventDefault();

    var form = $(this);

    // get related reasons
    $.ajax({
        type: "POST",
        url: form.attr('action'),
        dataType: 'json',
        cache: false,
        data: form.serialize(),
        error: function (data) {
            $.toast({
                heading: 'خطای فرم',
                text: data.responseJSON.errors,
                position: 'top-right',
                loaderBg: '#ff6849',
                icon: 'error',
                showHideTransition: 'fade',
                hideAfter: 8000
            });
        },
        success: function (data) {
            $('#diversity-modal').find('p.errors').empty();
            if (data.edit) {
                editVariantRow(data.variant_data, data.new_fields);
            } else {
                newRow = createVariantRow(data);
                $('#varient-table tbody').append(newRow);
            }
            $('#diversity-modal').modal('hide');
        }
    });
});


$.fn.editVarientModal = function (diveristy_data_id) {

    loadDiversityById(diveristy_data_id);

};

$('#subscribe').change(function () {
    if ($(this).is(":checked")) {
        $('#subscribe_discout').fadeIn();
    } else
        $('#subscribe_discout').fadeOut();
});
if ($('#is-edit').val() == 1) {
    var catid = $('#category').val();
    // for subscribe specific categories
    if (catid == 1 || catid == 2 || catid == 3 || catid == 4 || catid == 6 || catid == 7) {
        $('#subscribe_check').fadeIn();
    }
}

// province and cities selection in edit profile page
prv = $('input[name="province_id_hidden"]').val();
county = $('input[name="county_id_hidden"]').val();
region = $('input[name="region_id_hidden"]').val();
neighbourhood = $('input[name="neighbourhood_id_hidden"]').val();

$('#province').on('change', function () {
    var prv_id = $(this).val();
    $('#county-wrapper').find('i').show();
    $.getJSON(
        SITE_URL + 'users/getCounties',
        {'province_id': prv_id},
        function (result) {
            $('#county-wrapper').find('i').hide();
            $("#county").find('option').not(':first').remove();
            $("#county-wrapper").fadeIn();
            $.each(result, function (i, field) {
                if (county > 0) {
                    if (county == field.id)
                        $("#county").append('<option selected=""  value="' + field.id + '">' + field.name + '</option>');
                    else
                        $("#county").append('<option  value="' + field.id + '">' + field.name + '</option>');
                } else
                    $("#county").append('<option value="' + field.id + '">' + field.name + '</option>');
            });
        });
});
if (prv > 0)
    $('#province').trigger('change');

// province and cities selection in edit profile page
$('#county').on('change', function () {
    var county_id = $(this).val();
    if (county_id < 1)
        county_id = county;
    $('#region-wrapper').find('i').show();
    $.getJSON(
        SITE_URL + 'users/getRegions',
        {'county_id': county_id},
        function (result) {
            $('#region-wrapper').find('i').hide();
            $("#region").find('option').not(':first').remove();
            if (result.length > 0) {
                $("#region-wrapper").fadeIn();
                $.each(result, function (i, field) {
                    if (region > 0) {
                        if (region == field.id)
                            $("#region").append('<option selected=""  value="' + field.id + '">' + field.name + '</option>');
                        else
                            $("#region").append('<option  value="' + field.id + '">' + field.name + '</option>');
                    } else
                        $("#region").append('<option value="' + field.id + '">' + field.name + '</option>');
                });
            } else {
                $("#region-wrapper").find('option').not(':first').remove();
                $("#region-wrapper").fadeOut();
                $("#neighbourhood-wrapper").find('option').not(':first').remove();
                $("#neighbourhood-wrapper").fadeOut();

            }
        });
});
if (county > 0)
    $('#county').trigger('change');
// province and cities selection in edit profile page
$('#region').on('change', function () {
    var region_id = $(this).val();
    if (region_id < 1)
        region_id = region;
    $('#neighbourhood-wrapper').find('i').show();
    $.getJSON(
        SITE_URL + 'users/getNeighbourhood',
        {'region_id': region_id},
        function (result) {
            $('#neighbourhood-wrapper').find('i').hide();
            $("#neighbourhood").find('option').not(':first').remove();
            if (result.length > 0) {
                $("#neighbourhood-wrapper").fadeIn();
                $.each(result, function (i, field) {
                    if (neighbourhood > 0) {
                        if (neighbourhood == field.id)
                            $("#neighbourhood").append('<option selected=""  value="' + field.id + '">' + field.name + '</option>');
                        else
                            $("#neighbourhood").append('<option  value="' + field.id + '">' + field.name + '</option>');
                    } else
                        $("#neighbourhood").append('<option value="' + field.id + '">' + field.name + '</option>');
                });
            } else {
                $("#region-wrapper").find('option').not(':first').remove();
                $("#region-wrapper").fadeOut();

            }
        });
});
if (region > 0)
    $('#region').trigger('change');


$(window).scroll(function (event) {
    var scroll = $(window).scrollTop();
    if (scroll >= 50) {
        $("#back-to-top").addClass("show");
    } else {
        $("#back-to-top").removeClass("show");
    }

});
$('#has_deco_cost').on('change', function () {
    if ($(this).prop("checked")) {
        $('#price-wrapper').slideDown();
    } else {
        $('#price-wrapper').slideUp();
    }
});
// $('.delete').on('click', function (e) {
//     e.preventDefault();
//     $this = $(this);
//     $.confirm({
//         title: 'حذف',
//         icon: 'text-warning',
//         confirmButton: 'بله',
//         cancelButton: 'انصراف',
//         animation: 'zoom',
//         autoClose: 'cancel|10000',
//         animationSpeed: 600,
//         content: 'آیتم انتخابی حذف خواهد شد. آیا اطمینان دارید؟',
//         confirmButtonClass: 'btn-success',
//         cancelButtonClass: 'btn-warning',
//         contentClass: 'btn-danger',
//         confirm: function () {
//             window.location.href = $this.attr("href");
//         },
//         cancel: function () {
//         }
//     });
// });
$('a[href="#top"]').on('click', function () {
    $('html, body').animate({scrollTop: 0}, 1350, "easeInOutQuint");
    return false;
});
$('#product_id').on('change', function (e) {
    var value = $(e.currentTarget).val();
    var price = $(e.currentTarget).find('[value="' + value + '"]').attr('data-price');
    if (price != -1) {
        $('#discount_price').val('');
        $('p#old_price > label').fadeIn().css('color', '#df13c7').fadeOut().fadeIn().fadeOut().fadeIn();
        $('p#old_price > label > span').html(price + ' تومان');
    } else {
        $('#discount_price').val('');
    }
});


//Tooltip, activated by hover event
$("body").tooltip({
    selector: "[data-toggle='tooltip']",
    container: "body"
})
    //Popover, activated by clicking
    .popover({
        selector: "[data-toggle='popover']",
        container: "body",
        html: true
    });
//They can be chained like the example above (when using the same selector).

/* Style Switcher
 -------------------------------------------------------*/

// $(".main-wrapper").after('<div id="customizer" class="s-close"><span class="corner"><i class="fa fa-cog"></i></span><div id="options" class="text-center"><a href="https://themeforest.net/user/deothemes?ref=DeoThemes" class="btn btn-md btn-fill btn-color mt-40 mb-40"><span>Purchase Now</span></a><h6 class="uppercase">Select Demo</h6><ul class="demo-list clearfix"><li><a href="index.html" target="_blank"><img src="img/demos/agency.jpg" alt=""></a></li><li><a href="index-2.html" target="_blank"><img src="img/demos/business.jpg" alt=""></a></li><li><a href="index-3.html" target="_blank"><img src="img/demos/onepage.jpg" alt=""></a></li><li><a href="index-4.html" target="_blank"><img src="img/demos/classic.jpg" alt=""></a></li><li><a href="index-5.html" target="_blank"><img src="img/demos/portfolio.jpg" alt=""></a></li><li><a href="index-restaurant.html" target="_blank"><img src="img/demos/restaurant.jpg" alt=""></a></li><li><a href="index-restaurant-op.html" target="_blank"><img src="img/demos/restaurant-op.jpg" alt=""></a></li></ul></div></div>');

// $(".corner").on('click',function (){
//   $("#customizer").toggleClass("s-open");
// });
