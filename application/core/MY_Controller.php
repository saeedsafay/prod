<?php

(defined('BASEPATH')) or exit('No direct script access allowed');

use Symfony\Component\EventDispatcher\EventDispatcher;


/**
 * @property $smart
 * @property \MY_Output $output
 * @property $sentinel
 * @property \Logger $monolog
 * Class MY_Controller
 */
class MY_Controller extends CI_Controller
{

    public $productConcern;
    public $cartConcern;
    /**
     * @var \Symfony\Component\EventDispatcher\EventDispatcher
     */
    public $dispatcher;

    function __construct()
    {
        date_default_timezone_set('Asia/Tehran');
        parent::__construct();
        if ($get_message = $this->message->get_message()) {
            $this->smart->assign([
                'system_message' => $get_message,
            ]);
        } else {
            $this->smart->assign([
                'system_message' => '',
            ]);
        }

        try {// Check if to force ssl on controller
            if (isset($_ENV['CI_ENV']) && $_ENV['CI_ENV'] == 'production') {
                if ($_ENV['SSL_ENABLED']) {
                    force_ssl();
                } else {
                    remove_ssl();
                }
            }
            if (config_item('cache_enabled')) {
                $this->load->driver('cache', array('adapter' => 'memcached', 'backup' => 'apc'));
                //            $this->cache->clean();
            }
            $this->load->sentinel();
            $this->load->monolog();
            $this->dispatcher = new EventDispatcher();
            $this->addListeners();

            list($path, $_model) = Modules::find('ProductConcerns', 'shop', 'concerns/');
            Modules::load_file($_model, $path);
            $this->productConcern = new ProductConcerns($this);

            list($path, $_model) = Modules::find('CartConcerns', 'shop', 'concerns/');
            Modules::load_file($_model, $path);
            $this->cartConcern = new CartConcerns($this);
            $this->smart->assign([
                "products_thumbnail_dir" => site_url(str_replace(PUBLICPATH, "/", config("import_seller")['thumbnail_prefix_dir'])),
                "products_pic_dir" => site_url(str_replace(PUBLICPATH, "/", config("import_seller")['product_pic_prefix_dir']))
            ]);
        } catch (Throwable $e) {
            log_exception($e);
        }
    }

    private function addListeners()
    {
        $events = config_item('events');
        $action = config_item('events_actions_name');
        foreach ($events as $eventName => $items) {
            foreach ($items as $module => $listeners) {
                foreach ($listeners as $listener) {

                    if ( ! $listener) {
                        log_message("error", "Invalid config array for the events: {$eventName}[$module]");
                        continue;
                    }
                    load_listeners($module, [
                        $listener
                    ]);
                    $listenerObject = new $listener();
                    $this->dispatcher->addListener($eventName, [$listenerObject, $action]);
                }
            }

        }
    }

    /**
     * check the user is logged in or not, if logged, then return the user object, else redirect to the login page
     * @param  boolean  $auth  authentication needed or not
     * @return
     */
    public function checkAuth($auth = true)
    {
        if ( ! ($this->user = $this->sentinel->check()) and $auth) {
            $this->session->set_userdata('requested_url', current_url());
            redirect('/users/login', 'auto', 302);
        } else {
            return $this->user;
        }
    }

    /**
     *
     * sets form validation rules from $validation_rules array,
     * it gets method name and uses it for getting rules array from rules,
     * it loads global rules before this
     * @param  Bool  $attach_global_validation  set global validation rules or not
     * @return boolean
     */
    public function formValidate(
        $attach_global_validation = true
    ) {
        $rule_collections = array_slice(func_get_args(), 1);
        if (isset($this->validation_rules) && ! empty($this->validation_rules)) {
            $this->load->library('form_validation');
            $method_name = $this->router->fetch_method();
            if ($attach_global_validation and key_exists('__global__', $this->validation_rules)) {
                $this->form_validation->set_rules($this->validation_rules['__global__']);
            }
            if (key_exists($method_name, $this->validation_rules)) {
                $this->form_validation->set_rules($this->validation_rules[$method_name]);
            }
            if (count($rule_collections) > 0) {
                foreach ($rule_collections as $rule_collection) {
                    if (key_exists($rule_collection, $this->validation_rules)) {
                        $this->form_validation->set_rules($this->validation_rules[$rule_collection]);
                    }
                }
            }
            if ($this->form_validation->run() === true) {
                return true;
            } else {
                return false;
            }
        }
        return true;
    }

    /**
     * نمایش خطای 404 در شرایط تعیین شده
     * @param  mixed  $condition
     */
    public function show_404_on(
        $condition
    ) {
        if ($condition) {
            show_404();
        }
    }
}
