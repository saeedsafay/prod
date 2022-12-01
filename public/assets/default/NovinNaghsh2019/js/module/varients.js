(function ($) {

    function loadVarient(data) {

        if (data.varient.lead_time > 0)
            var ersal = 'از ' + data.varient.lead_time + ' روز آینده';
        else
            var ersal = 'آماده ارسال';

        var lead_time = '<i class="fa fa-shipping-fast"></i> زمان ارسال کالا: ' + ersal;

        $('.varient_price').html(data.varient.price).priceFormat({
            prefix: '',
            suffix: ' ریال',
            centsLimit: 0,
            thousandsSeparator: ',',
            insertPlusSign: false
        });
        $('.lead_time').html(lead_time);

        $('li.varient-row').remove();
        $.each(data.varient.fields, function (i, v) {
            if (v.value.parent_diversity.can_change !== 1) {
                var varient_row = '<li class="varient-row"><i class="fa fa-check"></i>' + v.value.parent_diversity.label + ': <span>' + v.value.title + '</span></li>';
                $('ul.product-varient-rows').prepend(varient_row);
            }
        });

        $('#selected-varient-id').val(data.varient.id);

    }

    function loadOutOfStock() {


        $('.product-button').html('');
        $('.product-button').html('<div class="btn-noexist mr-auto out-of-stock">ناموجود</div>');

    }

    "use strict";

    var element = $('span.varient-part input[type=radio]');

    element.on('change', function (e) {
        e.preventDefault();

        var $this = $(this);

        var wrapper = $this.parent(),
            varient_value_id = wrapper.find('.varient_value_id').val(),
            product_id = wrapper.find('.product_id').val();
        $.ajax({
            type: "POST",
            url: base_url + 'shop/products/getDiversityInfo',
            dataType: 'json',
            cache: false,
            data: {
                product_id: product_id,
                varient: $this.val(),
                varient_value_id: varient_value_id
            },
            beforeSend: function () {
                $('.loading-varient').fadeIn();
            },
            success: function (data) {
                if (data === null) {
                    return loadOutOfStock();
                }
                if (data.varient.status == 1) {
                    return loadVarient(data);
                }


                return loadOutOfStock();
            },
            complete: function () {
                $('.loading-varient').fadeOut();
            }
        });
    });


})(jQuery);