<div id="page_content_inner">
    <h3 class="heading_a title-top">{$title}</h3>
    <div class="md-card  uk-margin-small-top">
        <div class="md-card-content">
            <div class="uk-width-medium-1-2 ">
                <a href="{site_url({ADMIN_PATH|con:'/users/users/edit'})}" class="md-btn md-btn-success">افزودن
                    کاربر</a>
                <a href="{site_url({ADMIN_PATH|con:'/users/users?group=seller'})}" class="md-btn md-btn-primary">
                    لیست فروشندگان
                </a>
                <a href="{site_url({ADMIN_PATH|con:'/users/users?group=buyer'})}" class="md-btn md-btn-primary">
                    لیست خریداران
                </a>
                {if $group}
                    <a href="{site_url({ADMIN_PATH|con:'/users/users'})}" class="md-btn md-btn-info">
                        همه
                    </a>
                {/if}
            </div>
        </div>
    </div>
    <div class="md-card uk-margin-medium-bottom">
        <div class="md-card-content">
            <table class="uk-table dataTable uk-table-striped" id="dt_default" role="grid"
                   aria-describedby="dt_default_info">
                <thead>
                <tr>
                    <th>
                        شناسه
                    </th>
                    <th class="sorting">نام و نام خانوادگی</th>
                    <th class="sorting">نام کاربری</th>
                    <th class="sorting">شماره همراه</th>
                    <th class="sorting">گروه</th>
                    <th class="sorting">نام مجموعه</th>
                    <th class="sorting">آخرین ورود</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </thead>
                <tfoot>
                <tr>
                    <th>شناسه</th>
                    <th class="sorting">نام و نام خانوادگی</th>
                    <th class="sorting">نام کاربری</th>
                    <th class="sorting">شماره همراه</th>
                    <th>گروه</th>
                    <th class="sorting">نام مجموعه</th>
                    <th>آخرین ورود</th>
                    <th class="no-sort">عملیات</th>
                </tr>
                </tfoot>
                <tbody class="uk-table uk-table-striped">
                {foreach from=$Users item=User}
                    <tr>
                        <td class="center">{$User->id}</td>
                        <td>{$User->first_name} {$User->last_name}</td>
                        <td>{$User->username}</td>
                        <td>{$User->mobile}</td>
                        <td>
                            {assign var="i" value={count($User->role_name)}}
                            {assign var="j" value=1}
                            {foreach from=$User->role_name item=role}
                                {$role}{if $j<$i} -{/if}
                                {assign var="j" value=$j+1}
                            {/foreach}
                        </td>
                        <td>
                            {$User->business_name}
                        </td>
                        <td>
                            {if !empty($User->last_login)}
                                {jdate format='j F Y - h:i a' date=$User->last_login}
                            {else}
                                {''}
                            {/if}
                        </td>
                        <td class="right">
                            <a class="md-btn md-btn-primary md-btn-small"
                               href="{site_url({ADMIN_PATH|con:'/users/users/edit/':$User->id})}">ویرایش</a>
                            {if !$User->inRole(SUPER_ADMIN)}
                                <a href="{site_url({ADMIN_PATH|con:'/users/users/delete/':$User->id})}"
                                   class="md-btn md-btn-small md-btn-danger delete" id="delete-btn">حذف کاربر</a>
                                <a href="{site_url({ADMIN_PATH|con:'/users/users/loginAsUser/':$User->id})}"
                                   class="md-btn md-btn-small md-btn-success" id="delete-btn">لاگین بعنوان کاربر</a>
                            {/if}
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>
</div>