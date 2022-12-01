<?php

if ( ! defined('BASEPATH')) {
    exit('No direct script access allowed');
}

/*
 * Print Recursive
 *
 * Simply wraps a print_r() in pre tags for debugging.
 *
 * @param mixed
 * @return string
 */
if ( ! function_exists('_pr')) {

    function _pr($a)
    {
        echo "<pre>";
        print_r($a);
        echo "</pre>";
    }

}
if ( ! function_exists('config')) {

    function config($key)
    {
        $CI = &get_instance();
        return $CI->config->item($key);
    }

}

/**
 * log exceptions
 */
if ( ! function_exists('log_exception')) {

    function log_exception(Throwable $e)
    {
        return CI::$APP->monolog->critical($e->getMessage(), array_slice($e->getTrace(), 0, 4));
        //        log_message('error', $e->getMessage()."\n".$e->getTraceAsString());
    }

}

/**
 * info log
 */
if ( ! function_exists('info')) {

    function info($message, array $context = [])
    {
        return CI::$APP->monolog->info($message, $context);
    }

}

/**
 * event loader
 */
if ( ! function_exists('load_listeners')) {

    function load_listeners($module, $listeners)
    {
        $CI = &get_instance();
        if (is_array($listeners)) {
            foreach ($listeners as $listener) {
                load_listeners($module, $listener);
            }
        } else {
            $CI->load->file(MODULE_PATH."$module/listeners/$listeners.php");
        }

    }

}
/**
 * event loader
 */
if ( ! function_exists('load_events')) {

    function load_events($module, $events)
    {
        $CI = &get_instance();
        if (is_array($events)) {
            foreach ($events as $event) {
                load_events($module, $event);
            }
        } else {
            $CI->load->file(MODULE_PATH."$module/events/$events.php");
        }
    }

}
/**
 * event dispatcher
 */
if ( ! function_exists('event')) {

    function event($event)
    {
        $CI = &get_instance();

        return $CI->dispatcher->dispatch($event, $event::NAME);
    }

}

/*
 * Print Recursive
 *
 * Simply wraps a print_r() in pre tags for debugging.
 *
 * @param mixed
 * @return string
 */
if ( ! function_exists('en_numbers')) {

    function en_numbers($number)
    {
        $number = str_replace(array('۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'),
            array('0', '1', '2', '3', '4', '5', '6', '7', '8', '9'), $number);
        return $number;
    }

}
if ( ! function_exists('set_path')) {
    function set_path()
    {
        $ci = &get_instance();
        $queryString = $ci->input->server('QUERY_STRING');
        $queryString = preg_replace('/(?: (\?+)|(\&+))page=(\d+)/i', '', $queryString);
        return current_url().'?'.$queryString;
    }
}


if ( ! function_exists('slug')) {
    function slug($string, $separator = '-')
    {
        $string = trim($string);
        $string = mb_strtolower($string, 'UTF-8');

        // Make alphanumeric (removes all other characters)
        // this makes the string safe especially when used as a part of a URL
        // this keeps latin characters and Persian characters as well
        //   $string = preg_replace("/[^a-z0-9_\s-ءاآؤئبپتثجچحخدذرزژسشصضطظعغفقکگلمنوهی]/u", '', $string);

        // Remove multiple dashes or whitespaces or underscores
        // $string = preg_replace("/[\s-_]+/", '', $string);

        // Convert whitespaces and underscore to the given separator
        $string = preg_replace("/[\s_]/", $separator, $string);

        return $string;
    }

}

/**
 * Get domain
 *
 * Return the domain name only based on the "base_url" item from your config file.
 *
 * @access    public
 * @return    string
 */
if ( ! function_exists('getDomain')) {

    function getDomain()
    {
        $CI = &get_instance();
        return preg_replace("/^[\w]{2,6}:\/\/([\w\d\.\-]+).*$/", "$1", $CI->config->slash_item('base_url'));
    }

}
// ------------------------------------------------------------------------

/*
 * Variable Dump
 *
 * Simply wraps a var_dump() in pre tags for debugging.
 *
 * @param mixed
 * @return string
 */
if ( ! function_exists('_vd')) {

    function _vd($a)
    {
        echo "<pre>";
        var_dump($a);
        echo "</pre>";
    }

}

// ------------------------------------------------------------------------

/*
 * Array to Object
 * 
 * Converts an array to an object
 *
 * @param array
 * @return object
 */
if ( ! function_exists('array_to_object')) {

    function array_to_object($array)
    {
        $Object = new stdClass();
        foreach ($array as $key => $value) {
            $Object->$key = $value;
        }

        return $Object;
    }

}
if ( ! function_exists('show_flash_message')) {

    function show_flash_message($message, $type = "info", $uri = null, $title = '')
    {
        $uri = $uri ? $uri : $_SERVER['HTTP_REFERER'];
        $ci = &get_instance();
        $ci->message->set_message(
            $message,
            $type,
            $title,
            $uri)->redirect();
    }

}

if ( ! function_exists('cache')) {

    function cache($key)
    {
        $ci = &get_instance();
        if (config_item('cache_enabled')) {
            return $ci->cache->get($key);
        }
        return null;
    }

}
if ( ! function_exists('cache_set')) {

    function cache_set($key, $value, $expire = 86400)
    {
        $ci = &get_instance();
        if (config_item('cache_enabled')) {
            $ci->cache->save($key, $value, $expire);
        }
        return $value;
    }

}

// ------------------------------------------------------------------------

/*
 * Object to Array
 * 
 * Converts an object to an array
 * 
 * @param object
 * @return array
 */
if ( ! function_exists('object_to_array')) {

    function object_to_array($Object)
    {
        $array = get_object_vars($Object);

        return $array;
    }

}

// ------------------------------------------------------------------------

/*
 * Is Ajax
 *
 * Returns true if request is ajax protocol
 *
 * @return bool
 */
if ( ! function_exists('is_ajax')) {

    function is_ajax()
    {
        return (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && ($_SERVER['HTTP_X_REQUESTED_WITH'] == 'XMLHttpRequest'));
    }

}

// ------------------------------------------------------------------------

/*
 * Image Thumb
 *
 * Creates an image thumbnail and caches the image
 *
 * @param string
 * @param int
 * @param int
 * @param bool
 * @param array
 * @return string
 */
if ( ! function_exists('image_thumb')) {

    function image_thumb($source_image, $width = 0, $height = 0, $crop = false, $props = array())
    {
        $CI = &get_instance();
        $CI->load->library('image_cache');

        $props['source_image'] = '/'.str_replace(base_url(), '', $source_image);
        $props['width'] = $width;
        $props['height'] = $height;
        $props['crop'] = $crop;

        $CI->image_cache->initialize($props);
        $image = $CI->image_cache->image_cache();
        $CI->image_cache->clear();

        return $image;
    }

}

// ------------------------------------------------------------------------

/*
 * BR 2 NL
 *
 * Converts html <br /> to new line \n
 *
 * @param string
 * @return string
 */
if ( ! function_exists('br2nl')) {

    function br2nl($text)
    {
        return preg_replace('/<br\\s*?\/??>/i', '', $text);
    }

}

// ------------------------------------------------------------------------

/*
 * Option Array Value
 *
 * Returns single dimension array from an Array of objects with the key and value defined
 *
 * @param array
 * @param string
 * @param string
 * @param array
 * @return array
 */
if ( ! function_exists('option_array_value')) {

    function option_array_value($object_array, $key, $value, $default = array())
    {
        $option_array = array();

        if ( ! empty($default)) {
            $option_array = $default;
        }

        foreach ($object_array as $Object) {
            $option_array[$Object->$key] = $Object->$value;
        }

        return $option_array;
    }

}

if ( ! function_exists('full_url')) {

    function full_url()
    {
        $CI = &get_instance();

        $url = $CI->config->site_url($CI->uri->uri_string());
        return $_SERVER['QUERY_STRING'] ? $url.'?'.$_SERVER['QUERY_STRING'] : $url;
    }

}


// ------------------------------------------------------------------------


// ------------------------------------------------------------------------

/*
 * Theme Partial
 *
 * Load a theme partial
 *
 * @param string
 * @param array
 * @param bool
 * @return string
 */
if ( ! function_exists('theme_partial')) {

    function theme_partial($view, $vars = array(), $return = true)
    {
        $CI = &get_instance();
        return base_url('themes/'.$CI->smart->theme_parent_folder.'/'.$CI->smart->template_name.'/partials/'.$view);
    }

}

// ------------------------------------------------------------------------

/*
 * Theme Url
 *
 * Create a url to the current theme
 *
 * @param string
 * @return string
 */
if ( ! function_exists('theme_url')) {

    function theme_url($uri = '')
    {
        $CI = &get_instance();
        return base_url($CI->template->theme_path.'/'.$CI->template->theme.'/'.trim($uri, '/'));
    }

}


// ------------------------------------------------------------------------

/*
 * Domain Name
 *
 * Returns the site domain name and tld
 *
 * @return string
 */
if ( ! function_exists('domain_name')) {

    function domain_name()
    {
        $protocol = ( ! empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off' || $_SERVER['SERVER_PORT'] == 443) ? "https://" : "http://";
        $domainName = $_SERVER['HTTP_HOST'].'/';
        return $domainName;
    }

}

// ------------------------------------------------------------------------

/*
 * Glob Recursive
 *
 * Run glob function recursivley on a directory
 *
 * @param string
 * @return array
 */
if ( ! function_exists('glob_recursive')) {

    // Does not support flag GLOB_BRACE

    function glob_recursive($pattern, $flags = 0)
    {
        $files = glob($pattern, $flags);

        foreach (glob(dirname($pattern).'/*', GLOB_ONLYDIR | GLOB_NOSORT) as $dir) {
            $files = array_merge($files, glob_recursive($dir.'/'.basename($pattern), $flags));
        }

        return $files;
    }

}

// ------------------------------------------------------------------------

/*
 * URL Base64 Encode
 * 
 * Encodes a string as base64, and sanitizes it for use in a CI URI.
 * 
 * @param string
 * @return string
 */
if ( ! function_exists('url_base64_encode')) {

    function url_base64_encode(&$str = "")
    {
        return strtr(
            base64_encode($str), array(
                '+' => '.',
                '=' => '-',
                '/' => '~'
            )
        );
    }

}

// ------------------------------------------------------------------------

/*
 * URL Base64 Decode
 *
 * Decodes a base64 string that was encoded by ci_base64_encode.
 * 
 * @param string
 * @return string
 */
if ( ! function_exists('url_base64_decode')) {

    function url_base64_decode(&$str = "")
    {
        return base64_decode(strtr(
            $str, array(
                '.' => '+',
                '-' => '=',
                '~' => '/'
            )
        ));
    }

}

// ------------------------------------------------------------------------

/*
 * Output XML
 *
 * Sets the header content type to XML and
 * outputs the <?php xml tag
 * 
 * @param string
 * @return string
 */
if ( ! function_exists('xml_output')) {

    function xml_output()
    {
        $CI = &get_instance();
        $CI->output->set_content_type('text/xml');
        $CI->output->set_output("<?xml version=\"1.0\"?>\r\n");
    }

}

// ------------------------------------------------------------------------

/*
 * JS Head Start
 *
 * Starts output buffering to place javascript in the <head> of the template
 * 
 * @return void
 */
if ( ! function_exists('js_start')) {

    function js_start()
    {
        ob_start();
    }

}

// ------------------------------------------------------------------------

/*
 * JS Head End
 *
 * Ends output buffering to place javascript in the <head> of the template
 * 
 * @return void
 */
if ( ! function_exists('js_end')) {

    function js_end()
    {
        $CI = &get_instance();
        $CI->template->add_script(ob_get_contents());
        ob_end_clean();
    }

}

// ------------------------------------------------------------------------

/*
 * String to Boolean
 *
 * This function analyzes a string and returns false if the string is empty, false, or 0
 * and true for everything else
 * 
 * @param string
 * @return bool
 */
if ( ! function_exists('str_to_bool')) {

    function str_to_bool($str)
    {
        if (is_bool($str)) {
            return $str;
        }

        $str = ( string )$str;

        if (in_array(strtolower($str), array('false', '0', ''))) {
            return false;
        } else {
            return true;
        }
    }

}

// ------------------------------------------------------------------------

/*
 * Is Inline Editable
 *
 * Returns true if inline editing is enabled, admin toolbar is enabled, and user is an administrator
 *
 * @return bool
 */
if ( ! function_exists('is_inline_editable')) {

    function is_inline_editable($content_type_id = null)
    {
        $CI = &get_instance();
        $CI->load->eloquent('content_types_model');

        if ($CI->settings->enable_inline_editing && $CI->settings->enable_admin_toolbar && $CI->secure->group_types(array(ADMINISTRATOR))->is_auth()) {
            if (empty($content_type_id)) {
                return true;
            }

            if ($CI->Group_session->type != SUPER_ADMIN) {
                // Check if we have already cached permissions for this content type
                if ( ! isset($CI->content_types_model->has_permission_cache[$content_type_id])) {
                    $Content_types_model = new Content_types_model();

                    // No permission for this content type has been cached yet.
                    // Query to see if current user has permission to this content type
                    $Content_type = $Content_types_model->group_start()
                        ->where('restrict_admin_access', 0)
                        ->or_where_related('admin_groups', 'group_id', $CI->Group_session->id)
                        ->group_end()
                        ->get_by_id($content_type_id);

                    $CI->content_types_model->has_permission_cache[$content_type_id] = ($Content_type->exists()) ? true : false;
                }

                return $CI->content_types_model->has_permission_cache[$content_type_id];
            } else {
                return true;
            }
        } else {
            return false;
        }
    }

}  