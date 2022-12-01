$(document).ready(function (e) {
    var form = $("#import-form");
    var insertForm = $("#insert-form");
    $("#submit-mockup").on('click', (function (e) {
        e.preventDefault();
        $.ajax({
            url: form.attr("action"),
            type: "POST",
            data: new FormData(document.getElementById('import-form')),
            contentType: false,
            cache: false,
            processData: false,
            beforeSend: function () {
                form.find('.spinner-border').show();
                $(this).attr("disabled", true);
            },
            success: function (data) {
                $.toast({
                    heading: 'ساخت موکاپ محصولات',
                    text: data.message,
                    position: 'top-right',
                    loaderBg: '#71ff2c',
                    icon: 'success',
                    showHideTransition: 'fade',
                    hideAfter: 8000
                });
                form.find('.spinner-border').hide();
                $(this).attr("disabled", false);
                return createForm(data.content);
            },
            error: function (data) {
                $.toast({
                    heading: 'خطای دیتا',
                    text: data.responseJSON.error,
                    position: 'top-right',
                    loaderBg: '#ff6849',
                    icon: 'error',
                    showHideTransition: 'fade',
                    hideAfter: 8000
                });
                form.find('.spinner-border').hide();
                $(this).attr("disabled", false);
                return false;
            }
        });
    }));
    $(".import-data-action > .insert-data").on('click', (function (e) {
        e.preventDefault();
        $.ajax({
            url: insertForm.attr("action"),
            type: "POST",
            data: new FormData(document.getElementById('insert-form')),
            contentType: false,
            cache: false,
            processData: false,
            beforeSend: function () {
                form.find('.spinner-border').show();
                insertForm.find('.spinner-border').show();
            },
            success: function (data) {
                $.toast({
                    heading: 'درج گروهی محصولات',
                    text: data.message,
                    position: 'top-right',
                    loaderBg: '#71ff2c',
                    icon: 'success',
                    showHideTransition: 'fade',
                    hideAfter: 11000
                });
                // clear dropify file input
                $(".dropify-clear").trigger("click");
                // clear generated form of products and mockups
                var importFormDataWrapper = $("#import-data-wrapper");
                importFormDataWrapper.children("div.generated-form-row:not(:first)").remove();
                importFormDataWrapper.fadeOut();

                form.find('.spinner-border').hide();
                insertForm.find('.spinner-border').hide();
            },
            error: function (data) {
                $.toast({
                    heading: 'خطای دیتا',
                    text: data.responseJSON.error,
                    position: 'top-right',
                    loaderBg: '#ff6849',
                    icon: 'error',
                    showHideTransition: 'fade',
                    hideAfter: 8000
                });
                form.find('.spinner-border').hide();
                insertForm.find('.spinner-border').hide();
                return false;
            }
        });
    }));

    function createForm(data) {

        var importFormDataWrapper = $("#import-data-wrapper");
        importFormDataWrapper.children("div.generated-form-row:not(:first)").remove();
        importFormDataWrapper.fadeIn();
        var row = importFormDataWrapper.find(".generated-form-row");

        console.log(data);
        var i = 0;
        $.each(data, function (category, value) {
            $.each(value.files, function (index, file) {

                if (i === 0) {
                    row.find("img.mockup-img").attr("src", value.path + file.path);
                    row.find(".hidden-pic-input").val(value.path + file.path);
                    row.find(".import-category-id").val(value.category_id);
                } else {
                    newRow = row.clone();
                    importFormDataWrapper.find("div.import-data-action").before(newRow);
                    newRow.find("img.mockup-img").attr("src", value.path + file.path);
                    newRow.find(".import-category-id").val(value.category_id);
                    newRow.find(".hidden-pic-input").val(value.path + file.path);
                    newRow.find('input').each(function () {
                        this.name = this.name.replace(0, i);
                    });
                }
                i = i + 1;

            });
        });


        importFormDataWrapper.fadeIn().fadeOut().fadeIn().fadeOut().fadeIn();
        $('html, body').animate({
            scrollTop: (importFormDataWrapper.first().offset().top - 230)
        }, 600);
        $.toast({
            heading: 'ساخت فرم درج محصولات',
            text: "فرم درج محصولات مربوط به موکاپ های شما ساخته شد",
            position: 'top-right',
            loaderBg: '#71ff2c',
            icon: 'success',
            showHideTransition: 'fade',
            hideAfter: 8000
        });
    }
});