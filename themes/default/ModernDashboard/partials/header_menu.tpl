<!-- ============================================================== -->
<!-- Topbar header - style you can find in pages.scss -->
<!-- ============================================================== -->
<header class="topbar">
    <nav class="navbar top-navbar navbar-expand-md navbar-dark">
        <!-- ============================================================== -->
        <!-- Logo -->
        <!-- ============================================================== -->
        <div class="navbar-header">
            <a class="navbar-brand" href="/dashboard">
                <!-- Logo icon --><b>
                    <!--You can put here icon as well // <i class="wi wi-sunset"></i> //-->
                    <!-- Light Logo icon -->
                    <img src="{assets_url}images/logo.png" width="150" alt="داشبورد مرکز فروشندگان نوین نقش"
                         class="light-logo"/>
                </b>
                <!--End Logo icon -->
                <!-- Logo text -->
            </a>
        </div>
        <!-- ============================================================== -->
        <!-- End Logo -->
        <!-- ============================================================== -->
        <div class="navbar-collapse">
            <!-- ============================================================== -->
            <!-- toggle and nav items -->
            <!-- ============================================================== -->
            <ul class="navbar-nav ml-auto">
                <!-- This is  -->
                <li class="nav-item"><a class="nav-link nav-toggler d-block d-md-none waves-effect waves-dark"
                                        href="javascript:void(0)"><i class="ti-menu"></i></a></li>
                <li class="nav-item"><a class="nav-link sidebartoggler d-none waves-effect waves-dark"
                                        href="javascript:void(0)"><i class="icon-menu"></i></a></li>
                <!-- ============================================================== -->
            </ul>
            <!-- ============================================================== -->
            <!-- User profile and search -->
            <!-- ============================================================== -->
            <ul class="navbar-nav my-lg-0">
                <!-- ============================================================== -->
                <!-- Comment -->
                <!-- ============================================================== -->
                <li class="nav-item dropdown">
{*                    <a class="nav-link dropdown-toggle waves-effect waves-dark" href="" data-toggle="dropdown"*}
{*                       aria-haspopup="true" aria-expanded="false"> <i class="ti-email"></i>*}
{*                        <div class="notify"><span class="heartbit"></span> <span class="point"></span></div>*}
{*                    </a>*}
{*                    <div class="dropdown-menu dropdown-menu-left mailbox animated bounceInDown">*}
{*                        <ul>*}
{*                            <li>*}
{*                                <div class="drop-title">Notifications</div>*}
{*                            </li>*}
{*                            <li>*}
{*                                <div class="message-center">*}
{*                                    <!-- Message -->*}
{*                                    <a href="javascript:void(0)">*}
{*                                        <div class="btn btn-danger btn-circle"><i class="fa fa-link"></i></div>*}
{*                                        <div class="mail-contnet">*}
{*                                            <h5>Luanch Admin</h5> <span*}
{*                                                    class="mail-desc">Just see the my new admin!</span> <span*}
{*                                                    class="time">9:30 AM</span></div>*}
{*                                    </a>*}
{*                                    <!-- Message -->*}
{*                                    <a href="javascript:void(0)">*}
{*                                        <div class="btn btn-success btn-circle"><i class="ti-calendar"></i></div>*}
{*                                        <div class="mail-contnet">*}
{*                                            <h5>Event today</h5> <span class="mail-desc">Just a reminder that you have event</span>*}
{*                                            <span class="time">9:10 AM</span></div>*}
{*                                    </a>*}
{*                                    <!-- Message -->*}
{*                                    <a href="javascript:void(0)">*}
{*                                        <div class="btn btn-info btn-circle"><i class="ti-settings"></i></div>*}
{*                                        <div class="mail-contnet">*}
{*                                            <h5>Settings</h5> <span class="mail-desc">You can customize this template as you want</span>*}
{*                                            <span class="time">9:08 AM</span></div>*}
{*                                    </a>*}
{*                                    <!-- Message -->*}
{*                                    <a href="javascript:void(0)">*}
{*                                        <div class="btn btn-primary btn-circle"><i class="ti-user"></i></div>*}
{*                                        <div class="mail-contnet">*}
{*                                            <h5>Pavan kumar</h5> <span class="mail-desc">Just see the my admin!</span>*}
{*                                            <span class="time">9:02 AM</span></div>*}
{*                                    </a>*}
{*                                </div>*}
{*                            </li>*}
{*                            <li>*}
{*                                <a class="nav-link text-center link" href="javascript:void(0);"> <strong>Check all*}
{*                                        notifications</strong> <i class="fa fa-angle-right"></i> </a>*}
{*                            </li>*}
{*                        </ul>*}
{*                    </div>*}
                </li>
                <!-- ============================================================== -->
                <!-- End Comment -->
                <!-- ============================================================== -->

                <!-- ============================================================== -->
                <!-- User Profile -->
                <!-- ============================================================== -->
                <li class="nav-item dropdown u-pro">
                    <a class="nav-link dropdown-toggle waves-effect waves-dark profile-pic" href=""
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                src="{assets_url}images/users/2.png" alt="user" class=""> <span
                                class="hidden-md-down">{$user.business_name} &nbsp;<i
                                    class="fa fa-angle-down"></i></span> </a>
                    <div class="dropdown-menu dropdown-menu-left animated flipInY">
                        <!-- text-->
                        <a href="javascript:void(0)" class="dropdown-item"><i class="ti-user"></i> پروفایل شما</a>
                        <!-- text-->
                        <a href="{site_url}dashboard" class="dropdown-item"><i class="ti-wallet"></i> داشبورد عملکرد</a>
                        <!-- text-->
                        <a href="javascript:void(0)" class="dropdown-item"><i class="ti-settings"></i> تنظیمات حساب
                            کاربری</a>
                        <!-- text-->
                        <div class="dropdown-divider"></div>
                        <!-- text-->
                        <a href="/users/logout" class="dropdown-item"><i class="fa fa-power-off"></i> خروج</a>
                        <!-- text-->
                    </div>
                </li>
                <!-- ============================================================== -->
                <!-- End User Profile -->
                <!-- ============================================================== -->
                <li class="nav-item right-side-toggle"><a class="nav-link  waves-effect waves-light"
                                                          href="javascript:void(0)"><i class="ti-settings"></i></a></li>
            </ul>
        </div>
    </nav>
</header>
<!-- ============================================================== -->
<!-- End Topbar header -->
<!-- ============================================================== -->


{if ($system_message != '')}
    <div class="container">
        <div class="row rtl">
            <div class="col-lg-10 col-md-10 col-sm-12 col-xs-12 box_msg">
                <div class=" {if $system_message['type'] eq 'success' }
                     {'msgsuccess'}
                {elseif $system_message['type'] eq 'warning'}
                    {'msgwarning'}
                {elseif $system_message['type'] eq 'fail'}
                    {'msgerror'}
                {/if}">

                    <h4 class="title_msg"><i class="fa fa-
                                         {if $system_message['type'] eq 'success' }
                                             {'check-square-o'}
                                         {elseif $system_message['type'] eq 'warning'}
                                             {'warning'}
                                         {elseif $system_message['type'] eq 'fail'}
                                             {'remove'}
                                         {/if}
                                         fa-2x" style="vertical-align: middle;"></i>
                        <span class="span_msg">{$system_message['title']}</span>
                    </h4>
                    {literal}
                        <style>
                            .box_msg {

                                text-align: right;
                                direction: rtl;
                                margin-bottom: 24px;
                                margin-top: 41px;
                                border-radius: 3px;

                            }

                            .msgsuccess {
                                background: #3dce5d;
                                padding: 3px 10px;
                                width: 100%;
                                margin: 0 0;
                                border-radius: 3px;
                                box-shadow: 4px 6px 4px #444;
                            }

                            .msgwarning {
                                background: #faff31;
                                padding: 3px 0;
                                width: 100%;
                                margin: 0 0;
                                border-radius: 3px;
                                box-shadow: 4px 6px 4px #444;
                            }

                            .msgerror {
                                background: #ff3139;
                                padding: 3px 0;
                                width: 100%;
                                margin: 0 0;
                                border-radius: 3px;
                                box-shadow: 4px 6px 4px #444;
                            }

                            .span_msg {
                                font-family: Shabnam, IRANSans, 'Open Sans', sans-serif;
                                padding-top: 9px ! important;
                                font-size: 27px;
                                color: #fff; /* border-bottom: 4px dashed rgb(221, 221, 221); */
                                margin-bottom: 9px ! important;
                            }

                            .p_msg {
                                color: #fff;
                                padding-right: 7px;
                            }

                            .title_msg {
                                margin-bottom: 15px;
                                margin-top: 24px;
                            }

                            .btntop {
                                background: #ececec;
                                padding: 14px 40px;
                                line-height: 38px;
                                color: #282828;
                                border-radius: 3px;
                                margin-top: 17px;
                                transition: 0.5s;
                                font-family: Shabnam, IRANSans, 'Open Sans', sans-serif;
                            }

                            .btntop:hover {
                                transition: 0.5s;
                                background: #eee;
                            }
                        </style>
                    {/literal}
                    <p class="p_msg"> {$system_message['message']}</p>
                </div>
            </div>

        </div>
    </div>
{/if}