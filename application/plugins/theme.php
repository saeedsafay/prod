<?php (defined('BASEPATH')) OR exit('No direct script access allowed');
/**
 * CMS Canvas
 *
 * @author      Mark Price
 * @copyright   Copyright (c) 2012
 * @license     MIT License

 */

class Theme_plugin extends Plugin
{
    public function partial()
    {
        $data = $this->attributes();
        unset($data['name']);

        return theme_partial($this->attribute('name'), $data);
    }
}

