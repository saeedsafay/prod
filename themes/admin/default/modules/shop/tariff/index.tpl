<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-1-6 uk-margin-small-bottom">
                <a class="md-btn md-btn-success" href="{site_url({ADMIN_PATH|con:"/advertise/tariffs/edit"})}">افزودن تعرفه آگهی</a>
            </div>
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable uk-table-striped" id="dt_default" role="grid" aria-describedby="dt_default_info">
                <thead>
                    <tr>
                        <th class="sorting">دوره نمایش</th>
                        <th class="sorting">تعرفه (ريال)</th>
                        <th class="sorting">نوع آگهی</th>
                        <th class="no-sort">عملیات</th>
                    </tr>
                </thead>
                <tfoot>
                    <tr>
                        <th class="sorting">دوره نمایش</th>
                        <th class="sorting">تعرفه (ريال)</th>
                        <th class="sorting">نوع آگهی</th>
                        <th class="no-sort">عملیات</th>
                    </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                    {foreach from=$Ads_tariffs item=val}
                        <tr>
                            <td>{$val->time_period}</td>
                            <td>{$val->price|price_format}</td>
                            <td>

                                {if $val.ads_type eq 0}
                                    رایگان
                                {else if $val.ads_type eq 2}
                                    ویژه
                                {else if $val.ads_type eq 3}
                                    ویترین
                                {/if}

                            </td>
                            <td class="right">
                                <a class="md-btn md-btn-primary md-btn-small" href="{site_url({ADMIN_PATH|con:'/advertise/tariffs/edit/' : $val->id})}">ویرایش</a>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>