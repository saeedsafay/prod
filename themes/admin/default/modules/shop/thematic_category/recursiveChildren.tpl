<tr data-id="{$child->id}" data-parent="{$parent_id}">
    <td><span class="uk-text-italic">{$child->id}</span></td>
    <td><span class="uk-text-italic">{$child->title}</span></td>
    <td>
        {$child.parent.title}
    </td>
    <td>
        {if $child->product_type_id != null}
            {$child.product_type.title}
        {else}
            ---
        {/if}
    </td>
    <td class="right">
        <a class="md-btn md-btn-primary md-btn-small"
           href="{site_url({ADMIN_PATH|con:'/shop/thematic-categories/edit/' : $child->id})}">ویرایش</a>
        <a href="{site_url({ADMIN_PATH|con:'/shop/thematic-categories/delete/':$child->id})}"
           class="md-btn md-btn-small md-btn-danger delete" id="delete-btn">حذف دسته
            بندی</a>
        <a class="md-btn md-btn-info md-btn-small"
           href="{site_url({ADMIN_PATH|con:'/shop/thematic-categories/edit?parent_id=' : $child->id})}">افزودن
            زیر-دسته بندی</a>
    </td>
</tr>
{foreach $child->children as $grandChild}
    {include file="modules/shop/thematic_category/recursiveChildren.tpl" parent_id=$child->id child=$grandChild}
{/foreach}