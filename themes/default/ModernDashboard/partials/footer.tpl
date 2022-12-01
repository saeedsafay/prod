<!-- ============================================================== -->
<!-- All Jquery -->
<!-- ============================================================== -->
<script src="{assets_url}js/jquery-3.2.1.min.js"></script>
<!-- Bootstrap popper Core JavaScript -->
<script src="{assets_url}js/popper.min.js"></script>
<script src="{assets_url}js/bootstrap.min.js"></script>
<!-- slimscrollbar scrollbar JavaScript -->
<script src="{assets_url}js/perfect-scrollbar.jquery.min.js"></script>
<!--Wave Effects -->
<script src="{assets_url}js/waves.js"></script>
<!--Menu sidebar -->
<script src="{assets_url}js/sidebarmenu.js"></script>
<!--select2 plugin -->
<script src="{assets_url}js/select2.full.min.js"></script>
<!--dropify plugin -->
<script src="{assets_url}js/dropify.js"></script>
<!--Custom JavaScript -->
<script src="{assets_url}js/custom.min.js"></script>
<!-- ============================================================== -->
<!-- This page plugins -->
<!-- ============================================================== -->
<!--morris JavaScript -->
<script src="{assets_url}js/raphael-min.js"></script>
<script src="{assets_url}js/morris.min.js"></script>
<script src="{assets_url}js/jquery.sparkline.min.js"></script>
<!-- Popup message jquery -->
<script src="{assets_url}js/jquery.toast.js"></script>
<!-- Popup message jquery -->
<script src="{assets_url}js/icheck.min.js"></script>
<script src="{assets_url}js/icheck.init.js"></script>

<script src="{assets_url}lib/pwt.datepicker/dist/js/persian-datepicker-0.4.5.min.js"></script>
<script src="{assets_url}lib/PersianDate/dist/persian-date-0.1.8.min.js"></script>
<script src="{assets_url}js/scripts.js?v={time()}" defer></script>
{literal}
    <script>
        $(function () {
            $('#chat, #msg, #comment, #todo').perfectScrollbar();
        });
    </script>
{/literal}

{footer_js}
</body>
