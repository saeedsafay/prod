<?php

/*
 * Smarty plugin
 * -------------------------------------------------------------
 * File:     function.assets_url.php
 * Type:     function
 * Name:     assign
 * Purpose:  assign a value to a template variable
 * -------------------------------------------------------------
 */

function smarty_function_css_url($params, Smarty_Internal_Template $template)
{
    return CI::$APP->smart->getCSSURL();
}
