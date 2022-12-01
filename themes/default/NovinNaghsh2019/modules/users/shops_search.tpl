{add_css file="css/jquery-ui.css"}
{add_js file='js/cart.js' part='footer'}
{add_js file='js/shop_loc.js' part='footer'}
<section class=" new-arrivals pb-40">
    <div class="container space_bottom">
        <ol class="breadcrumb">
            <li>
                <a href="{site_url}">خانه</a>
            </li>
            <li>
                <a href="">گل‌فروشی‌ها‌</a>
            </li>
        </ol>
    </div>
    <div class="container">
        <div class="row row-10">    
            <form action="" method="GET" class="filter-form">
                <div class="col-lg-10 col-md-10">
                    {if $Shops == false}
                        <div class="col-md-12 col-lg-12 col-sm-12">
                            <label class="text-warning"> 
                                فروشگاهی یافت نشد
                            </label>
                        </div>
                    {else}
                        <div class="row">
                            <div id="gmap" style="with:300px;height:250px;    margin-bottom: 22px;width:100%"></div>
                            {foreach from=$Shops item=val}
                                <div class="col-md-12 col-xs-12 pull-right">
                                    <div class="entry-author-box clearfix">
                                        <a href="{site_url}users/profile/{$val.username}">
                                            {if isset($val.profile.logo)}
                                                <a href="{site_url}users/profile/{$val.username}"> <img
                                                            class="author-img"
                                                            src="{$products_thumbnail_dir}{$val.profile.logo}"
                                                            alt="{$val.business_name}"></a>
                                            {else}
                                                <a href="{site_url}users/profile/{$val.username}"> <img
                                                            class="author-img" style="float:right" width="20%"
                                                            src="{assets_url}img/shop/shop_icon.png"
                                                            alt="{$val.business_name}"></a>
                                            {/if}
                                        </a>
                                        <div class="author-info">
                                            <h6 class="author-name uppercase"> <a class="product-title" href="{site_url}users/profile/{$val.username}"> {$val.title}</a></h6>
                                            <p class="mb-0">
                                                <a target="_blank" href="{site_url}users/profile/{$val.username}"> 
                                                    {$val.business_name} ({$val.username})
                                                </a>
                                                {$count_products = $val->products()->where('type',1)->get()->count()}
                                                <span class="pull-left">
                                                    {if $count_products==0}
                                                        بدون محصول 
                                                    {else}
                                                        {$count_products|persian_number}محصول
                                                    {/if}</span>
                                            </p>
                                            <p>{$val.location.province.name}</p>
                                            <p> آدرس:{$val.location.full_address} <span class="pull-left">شماره تماس: {$val.contact.tell|persian_number} </span></p>
                                        </div>                        
                                    </div>
                                </div>
                            {/foreach}
                        </div>
                    {/if}
                </div> <!-- end col -->
                <div class="col-lg-2 col-md-2 col-sm-12 col-xs-12 space_top">
                    <h1 class="title_siderbar_product"> فیلتر ها</h1>
                    <div>
                        <label>نام کاربری گل‌فروشی</label>
                        <input type='text' placeholder="نام گل‌فروشی" name="username_query" value="{set_value('username_query',{$q})}">
                    </div>
                    <hr class="hr"/>
                    <input class="btn btn-sm  btn-light" type="submit" value="جستجو کنید">
                </div> <!-- end row -->
            </form>
        </div>
    </div>
</section> <!-- end new arrivals -->


{if isset($province_id)}
    <input type="hidden" name="province_id_hidden" value="{$province_id}" />                         {/if}
    {if isset($county_id)}
        <input type="hidden" name="county_id_hidden" value="{$county_id}" />                        {/if}
        {if isset($region_id)}
            <input type="hidden" name="region_id_hidden" value="{$region_id}" />                         {/if}  
            {if isset($neighbourhood_id)}
                <input type="hidden" name="neighbourhood_id_hidden" value="{$neighbourhood_id}" />                         {/if}  

                <script type="text/javascript">
                    data = [
                    {foreach from=$Shops item=val}
                        {if $val.lat != null AND $val.long}
                            {literal}{{/literal}
                            lat:{$val.lat},
                            lon:{$val.long},
                            title: '{$val.business_name}',
                            html: {if $val.profile.logo != ''}'<a style="font-family:xantoxa;display:block" target="_blank" href="{site_url}users/profile/{$val.username}">{$val.business_name}</a><img width="60" src="{$products_thumbnail_dir}{$val.profile.logo}">'
                            {else}'<a target="_blank" href="{site_url}users/profile/{$val.username}">{$val.business_name}</a>'{/if},
                            zoom: 14,
                            {literal} },  {/literal}
                        {/if}
                    {/foreach}
                                ];
                </script>