{add_js file='lib/jquery.craftpip_confirmbox/js/jquery-confirm.js' part='footer'}
{add_css file='lib/jquery.craftpip_confirmbox/css/jquery-confirm.css'}
<section>
    <div class="remove-bottom">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 col-sm-12 col-lg-12">
                    <div class="row">
                        <div class="col-md-12 col-sm-12 col-lg-12 pull-left">
                            {include file='partials/header_menu.tpl'}
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-lg-12 pull-left">

                                    <div class="row">
                                        <div class="col-md-12 col-lg-12 col-sm-12 col-xs-12">
                                            <table class="points_table">
                                                <thead>
                                                    <tr>
                                                        <th>موضوع</th>
                                                        <th>{if $user->type == 1}فرستنده{else}گیرنده{/if}</th>
                                                        <th>تاریخ ثبت</th>
                                                        <th>وضعیت</th>
                                                    </tr>
                                                </thead>

                                                <tbody class="points_table_scrollbar">
                                                    {$i = 0}
                                                    {foreach $tickets as $val}
                                                        <tr class="{if $i % 2 == 0}even{else}odd{/if}">
                                                            <td>
                                                                <p>
                                                                    <a href="{site_url}contacts/tickets/view-ticket/{$val.id}" target="_blank">
                                                                        {$val.subject}
                                                                    </a>
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>
                                                                    {if $user->type == 1}
                                                                        {$val->user->first_name} {$val->user->last_name}
                                                                    {elseif $user->type == 2}
                                                                        <a href="{site_url}users/profile/{$val.recipient.username}" target="_blank">
                                                                            {$val.recipient.business_name}
                                                                        </a>
                                                                    {/if}
                                                                </p>
                                                            </td>
                                                            <td>
                                                                <p>  
                                                                    <label style="color:#8fdf82">
                                                                        {jdate format='j F Y H:i' date=$val.created_at}
                                                                    </label>
                                                                </p>
                                                            </td>
                                                            <td class="point_table_width_button">
                                                            </td>
                                                        </tr>
                                                        {$i = $i + 1}
                                                    {/foreach}
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>



