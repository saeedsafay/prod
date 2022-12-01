<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable uk-table-striped" id="dt_default" role="grid"
                   aria-describedby="dt_default_info">
                <thead>
                <tr>
                    <th class="sorting">نام فایل لاگ</th>
                    <th class="sorting">سایز</th>
                    <th class="sorting">عملیات</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th class="sorting">نام فایل لاگ</th>
                    <th class="sorting">سایز</th>
                    <th class="sorting">عملیات</th>
                </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                {foreach $logs as $key => $val}
                    <tr>
                        <td>
                            {$val['header']['path']}
                        </td>
                        <td>KB {number_format(($val['header']['size']/1024),2)}</td>
                        <td class="right">

                            <!-- This is an anchor toggling the modal -->
                            <a class="uk-badge uk-badge-notification" href="#logs{$key}" data-uk-modal>مشاهده</a>
                            <!-- This is the modal -->
                            <div id="logs{$key}" class="uk-modal">
                                <div class="uk-modal-dialog uk-modal-dialog-large">
                                    <a class="uk-modal-close uk-close"></a>
                                    <h3 class="heading_a title-top">{$val['header']['path']}</h3>
                                    <div class="uk-overflow-container" style="direction: ltr;">
                                        {$val["content"]}
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>
