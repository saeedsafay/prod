<!DOCTYPE html>
<html lang="{setting name=lang}">
    {include file="partials/header.tpl"}

    <body class="horizontal-nav boxed skin-megna fixed-layout">
        <!-- ============================================================== -->
        <!-- Preloader - style you can find in spinners.css -->
        <!-- ============================================================== -->

        <div class="preloader">
            <div class="loader">
                <div class="loader__figure"></div>
                <p class="loader__label">در حال بارگذاری ...</p>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- Main wrapper - style you can find in pages.scss -->
        <!-- ============================================================== -->
        <div id="main-wrapper">
            <!-- ============================================================== -->
            <!-- Topbar header - style you can find in pages.scss -->
            <!-- ============================================================== -->
            {include file="partials/header_menu.tpl"}
            {include file="partials/sidebar.tpl"}
            {$content}
            <footer class="footer text-center">
                © 1398 تمامی حقوق این وب سایت محفوظ می باشد
            </footer>
            {include file="partials/footer.tpl"}
        </div>
    </body>
</html>