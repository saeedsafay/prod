
<section class="bg_img">
    <div class="container">
        <div class="col-md-6 col-md-offset-3">
            <div class="control-group ">
                <label class="control-label color_white" for="username">شناسه کاربری ID</label>
                <div class="controls">
                    <input style="
                           margin-left: 51px;
                           " class="input_page" type="text" id="username" name="username" placeholder="" class="input-xlarge">
                </div>
            </div>
        </div>
    </div>
    <div class="container">

        <div class="">
            <div id="topo">
                <div class="">
                    <div class="row">

                        <div class="col-md-12 col-ms-12 col-xs-12" id="abre-menu-topo">
                            <a href="#" class="btn-collapse">
                                <img width="65%" src="{assets_url}images/pluse.png">
                            </a>
                            <span class="fonts">دسته بندی</span>
                        </div>
                    </div><!--Fim da Row1 -->
                    <div class="row">
                        <ul id="menu-topo">
                            {foreach $cats as $cat}
                                <li><a href="{site_url}cats/{$cat.slug}">{$cat.title}</a></li>
                                {/foreach}
                        </ul>
                    </div>
                </div><!--Fim da coontainer -->
            </div><!--Fim do topo -->
            <div id="topo">
                <div class="">
                    <div class="row">

                        <div class="col-md-12 col-ms-12 col-xs-12" id="abre-menu-topo">
                            <a href="#" class="btn-collapse2">
                                <img width="65%" src="{assets_url}images/pluse.png">
                            </a>
                            <span class="fonts">مناسبت </span>
                        </div>
                    </div><!--Fim da Row1 -->
                    <div class="row">
                        <ul id="menu-topo2">
                            {foreach $reasons as $reason}
                                <li><a href="{site_url}cats/{$reason.slug}">{$reason.title}</a></li>
                                {/foreach}
                        </ul>
                    </div>
                </div><!--Fim da coontainer -->
            </div><!--Fim do topo -->
            <div id="topo">
                <div class="">
                    <div class="row">
                        <div class="col-md-12 col-ms-12 col-xs-12" id="abre-menu-topo">
                            <a href="#" class="btn-collapse3">
                                <img width="65%" src="{assets_url}images/pluse.png">
                            </a>
                            <span class="fonts">اطراف من</span>
                        </div>
                    </div><!--Fim da Row1 -->
                    <div class="row">
                        <ul id="menu-topo3">
                            <form class="form-horizontal">
                                <fieldset>
                                    <div class="form-group width_form">
                                        <label class="control-label" for="requestName">استان:</label>  
                                        <div class="input_width">
                                            <input id="requestName" name="requestName" placeholder="استان" class="form-control input-md" required="" type="text">

                                        </div>
                                    </div>
                                    <div class="form-group width_form">
                                        <label class="control-label" for="requestName">شهر:</label>  
                                        <div class="input_width">
                                            <input id="requestName" name="requestName" placeholder="شهر" class="form-control input-md" required="" type="text">

                                        </div>
                                    </div>
                                    <div class="form-group width_form">
                                        <label class="control-label" for="requestName">منطقه:</label>  
                                        <div class="input_width">
                                            <input id="requestName" name="requestName" placeholder="منطقه" class="form-control input-md" required="" type="text">

                                        </div>
                                    </div>
                                    <div class="form-group width_form">
                                        <label class="control-label" for="requestName">محله:</label>  
                                        <div class="input_width">
                                            <input id="requestName" name="requestName" placeholder="محله" class="form-control input-md" required="" type="text">

                                        </div>
                                    </div>


                                    <!-- Button -->
                                    <div class="form-group width_form">
                                        <label class="col-md-4 control-label" for="submit"></label>
                                        <div class="input_width">
                                            <button id="submit" name="submit" class="btn btn-default">تشخیص خودکار مکان</button>
                                        </div>
                                        <div>

                                            </fieldset>
                                            </form>
                                            </ul>
                                        </div>
                                    </div><!--Fim da coontainer -->
                                    </div><!--Fim do topo -->
                                    </div>

                                    </div>
                                    </section>
                                    <section>
                                        <div class="block gray">
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-md-12 col-sm-12 col-lg-12">
                                                        <div class="title-style2 center-align">
                                                            <h4 itemprop="headline">این متن به صورت پیشفرض </h4>
                                                            <p itemprop="description">این متن به صورت پیشفرض از سوی داده پردازان زانتکس در این قسمت قرار گرفته است تا به کاربر نشان دهد که باید چه چیزی را ویرایش و جایگزین کند .</p>
                                                        </div>
                                                        <div class="services">
                                                            <div class="row">
                                                                <div class="col-md-4 col-sm-6 col-lg-4">
                                                                    <div class="service-box">
                                                                        <i><img src="{assets_url}images/resource/serv1.png"
                                                                                alt="" itemprop="image"/></i>
                                                                        <h2 itemprop="headline">این متن به صورت پیشفرض </h2>
                                                                        <p itemprop="description">این متن به صورت پیشفرض از سوی داده پردازان زانتکس در این قسمت قرار گرفته است </p>
                                                                        <a href="#" title="" itemprop="url">بیشتر بدانید<i class="fa fa-caret-left"></i></a>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 col-sm-6 col-lg-4">
                                                                    <div class="service-box">
                                                                        <i><img src="{assets_url}images/resource/serv2.png"
                                                                                alt="" itemprop="image"/></i>
                                                                        <h2 itemprop="headline">این متن به صورت پیشفرض </h2>
                                                                        <p itemprop="description">این متن به صورت پیشفرض از سوی داده پردازان زانتکس در این قسمت قرار گرفته است </p>
                                                                        <a href="#" title="" itemprop="url">بیشتر بدانید<i class="fa fa-caret-left"></i></a>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4 col-sm-6 col-lg-4">
                                                                    <div class="service-box">
                                                                        <i><img src="{assets_url}images/resource/serv3.png"
                                                                                alt="" itemprop="image"/></i>
                                                                        <h2 itemprop="headline">این متن به صورت پیشفرض </h2>
                                                                        <p itemprop="description">این متن به صورت پیشفرض از سوی داده پردازان زانتکس در این قسمت قرار گرفته است </p>
                                                                        <a href="#" title="" itemprop="url">بیشتر بدانید<i class="fa fa-caret-left"></i></a>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="btns-grp center-align">
                                                                <a href="about.html" title="" class="btn1-drk" itemprop="url">این متن به صورت پیشفرض </a>
                                                                <a href="become-volunteer.html" title="" class="btn1" itemprop="url">این متن به صورت پیشفرض از سوی داده پردازان زانتکس در این قسمت قرار گرفته است </a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </section>


                                    <section>
                                        <div class="block blackish opc7">
                                            <div class="fixed-bg" style="background: url(images/resource/parallax2.jpg);"></div>
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-md-6 col-sm-6 col-lg-6">
                                                        <img src="{assets_url}images/img_side.jpg">
                                                    </div>   
                                                    <div class="col-md-6 col-sm-6 col-lg-6">
                                                        <h1 class="header_title">این متن به صورت پیشفرض از سوی داده پردازان زانتکس </h1>
                                                        <p class="paragraph_box">این متن به صورت پیشفرض از سوی داده پردازان زانتکس در این قسمت قرار گرفته است تا به کاربر نشان دهد که باید چه چیزی را ویرایش و جایگزین کند . اگر فیلد ها خالی باشند ، امکان تشخیص این که مربوط به کدام قسمت در وب سایت هستند دشوار است . </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </section>

