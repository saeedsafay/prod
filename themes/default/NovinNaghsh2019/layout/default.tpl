<!DOCTYPE html>
<html lang="{setting name=lang}">
{include file="partials/header.tpl"}

<body class="index-opt-1">
<div class="wrapper">
    {include file="partials/header_menu.tpl"}
    {if ($system_message != '')}
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-xs-12 badge">
                <div class="title-top" style="padding: 10px">
                    {if $system_message['title']!=""}{$system_message['title']}{/if}
                </div>
                <div class="alert {if $system_message['type'] eq 'success' }alert-success{else}alert-danger{/if}">
                    <p> {$system_message['message']}</p>
                </div>
            </div>
        </div>
    </div>

</div>
{/if}
{$content}
<input type="hidden" name="__token" value="{$csrfToken}" />
{include file="partials/footer.tpl"}
</div>
<a href="#" id="scrollup" title="اسکرول به بالای صفحه">برو بالا</a>
</body>
</html>