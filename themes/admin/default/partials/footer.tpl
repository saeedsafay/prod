<!-- Footer -->
<script src="{assets_url}bower_components/moment/min/moment.min.js"></script>

<script src="{assets_url}js/common.min.js?v={time()}"></script>

<script src="{assets_url}js/uikit_custom.min.js"></script>

<script src="{assets_url}js/altair_admin_common.min.js"></script>


<script src="{assets_url}bower_components/ionrangeslider/js/ion.rangeSlider.min.js"></script>

<script src="{assets_url}js/uikit_htmleditor_custom.min.js"></script>

<script src="{assets_url}js/jquery.aCollapTable.min.js"></script>

<script src="{assets_url}bower_components/datatables/media/js/jquery.dataTables.min.js"></script>

<script src="{assets_url}bower_components/datatables-colvis/js/dataTables.colVis.js"></script>

<script src="{assets_url}bower_components/datatables-tabletools/js/dataTables.tableTools.js"></script>

<script src="{assets_url}js/custom/datatables_uikit.min.js"></script>

<script src="{assets_url}js/pages/plugins_datatables.min.js"></script>

<script src="{assets_url}bower_components/jquery.inputmask/dist/jquery.inputmask.bundle.min.js"></script>

<script src="{assets_url}bower_components/jquery.craftpip_confirmbox/js/jquery-confirm.js"></script>

<script src="{assets_url}bower_components/slug/slug.js"></script>

<script src="{assets_url}bower_components/PersianDate/dist/persian-date-0.1.8.min.js"></script>

<script src="{assets_url}bower_components/pwt.datepicker/dist/js/persian-datepicker-0.4.5.min.js"></script>

<script src="{assets_url}js/pages/forms_advanced.min.js"></script>

{literal}
    <script>
        window.FileAPI = {
            debug: false // debug mode
            , staticPath: '{assets_url}lib/jquery.fileapi/FileAPI/' // path to *.swf
        };

        $(function () {
            $('#filter-type input[type=radio]').on('ifChanged',function () {
                if ($(this).val() != 3)
                    $('#filter_value_wrapper').fadeIn();
                else
                    $('#filter_value_wrapper').fadeOut();
            })
        })
    </script>
{/literal}

{footer_js}
<script>
    // load parsley config (altair_admin_common.js)
    altair_forms.parsley_validation_config();
</script>
<script src="{assets_url}js/main.js"></script>

<script>
    $(function () {
        altair_helpers.retina_images();
    });
</script>
</body>

</html>