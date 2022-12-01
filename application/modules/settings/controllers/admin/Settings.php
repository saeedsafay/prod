<?php

use samdark\sitemap\Sitemap;

class Settings extends Admin_Controller
{

    public $validation_rules = array(
        'index' => array(
            ['field' => 'site_name', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'عنوان سایت'],
            ['field' => 'homepage', 'rules' => 'numeric|required|htmlspecialchars', 'label' => 'صفحه اصلی'],
            ['field' => 'custom_error_page', 'rules' => 'htmlspecialchars', 'label' => 'صفحه خطا'],
            ['field' => 'site_status', 'rules' => 'numeric|htmlspecialchars', 'label' => 'وضعیت سایت'],
            ['field' => 'footer', 'rules' => 'htmlspecialchars', 'label' => 'متن فوتر سایت'],
        ),
        'sms_body' => array(
            ['field' => 'birthday', 'rules' => 'trim|htmlspecialchars', 'label' => 'تولد'],
            ['field' => 'anniversary', 'rules' => 'trim|htmlspecialchars', 'label' => 'سالگرد'],
            ['field' => 'death', 'rules' => 'trim|htmlspecialchars', 'label' => 'ترحیم و تسلیت'],
            ['field' => 'marriage', 'rules' => 'trim|htmlspecialchars', 'label' => 'سالگرد ازدواج'],
            ['field' => 'dating', 'rules' => 'trim|htmlspecialchars', 'label' => 'آشنایی'],
            ['field' => 'monthly', 'rules' => 'trim|htmlspecialchars', 'label' => 'ماهگرد'],
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Setting');
        $this->load->eloquent('content/Page');
    }

    public function index()
    {
        // Init
        $this->smart->addJS('js/ckeditor/jquery.ckeditor.js');
        $this->smart->addJS('js/ckeditor/ckeditor.js');
        $Pages = Page::all();
        $site_name = Setting::findByCode('site_name');
        $homepage = Setting::findByCode('homepage');
        $site_status = Setting::findByCode('site_status');
        $footer = Setting::findByCode('footer');
        $about = Setting::findByCode('about');
        $theme = Setting::findByCode('theme');
        $reagent = Setting::findByCode('reagent');
        $meta_description = Setting::findByCode('meta_description');
        $transportation_price = Setting::findByCode('transportation_price');
        // Get themes from theme directory
        $available_themes = new \League\Flysystem\Adapter\Local(PUBLICPATH.'themes/default');
        $themes = $available_themes->listContents();
        $custom_error_page = Setting::findByCode('custom_error_page');
        $this->smart->assign([
            'title' => 'تنظیمات کلی سیستم',
            'Pages' => $Pages,
            'server_signature' => $this->input->server('SERVER_SIGNATURE'),
            'display_errors' => ini_get('display_errors') ? 'فعال' : 'غیرفعال',
            'post_max_size' => ini_get('post_max_size'),
            'site_name' => $site_name->value,
            'homepage' => $homepage,
            'site_status' => $site_status->value,
            'footer' => $footer->value,
            'about' => isset($about->value) ? $about->value : null,
            'reagent' => isset($reagent->value) ? $reagent->value : null,
            'themes' => $themes,
            'current_theme' => $theme->value,
            'transportation_price' => isset($transportation_price) ? $transportation_price : null,
            'meta_description' => isset($meta_description) ? $meta_description : null,
            'custom_error_page' => $custom_error_page,
        ]);
        // Process Form
        if ($this->formValidate(false)) {

            // Insert or update data to the db
            // if inserted
            foreach ($this->input->post() as $key => $val) {
                $affected_row = Setting::updateOrCreate(['code' => $key], ['value' => $val]);
            }
            if ($affected_row) {
                $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد', 'success', 'بروزرسانی',
                    ADMIN_PATH.'/settings')->redirect();
            }// else if insertion failed
            else {
                $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید', 'fail', 'خطا در ذخیره سازی',
                    ADMIN_PATH.'/settings')->redirect();
            }
            redirect(ADMIN_PATH.'/settings');
        }
        $this->smart->view('edit');
    }

    public function sms_body()
    {
        // Init
        $birthday = Setting::findByCode('birthday');
        $marriage = Setting::findByCode('marriage');
        $dating = Setting::findByCode('dating');
        $death = Setting::findByCode('death');
        $anniversary = Setting::findByCode('anniversary');
        $monthly = Setting::findByCode('monthly');
        $app = Setting::findByCode('app_sms');
        $this->smart->assign([
            'title' => 'تنظیمات متون پیامک',
            'birthday' => isset($birthday->value) ? $birthday->value : null,
            'marriage' => isset($marriage->value) ? $marriage->value : null,
            'dating' => isset($dating->value) ? $dating->value : null,
            'death' => isset($death->value) ? $death->value : null,
            'anniversary' => isset($anniversary->value) ? $anniversary->value : null,
            'monthly' => isset($monthly->value) ? $monthly->value : null,
            'app' => isset($app->value) ? $app->value : null,
        ]);
        // Process Form
        if ($this->formValidate(false)) {
            $data = [
                'birthday' => $this->input->post('birthday'),
                'marriage' => $this->input->post('marriage'),
                'dating' => $this->input->post('dating'),
                'death' => $this->input->post('death'),
                'anniversary' => $this->input->post('anniversary'),
                'monthly' => $this->input->post('monthly'),
                'app_sms' => $this->input->post('app'),
            ];

            // Insert or update data to the db
            // if inserted
            foreach ($data as $key => $val) {
                $affected_row = Setting::updateOrCreate(['code' => $key], ['value' => $val]);
            }
            if ($affected_row) {
                $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد', 'success', 'بروزرسانی',
                    ADMIN_PATH.'/settings/settings/sms-body')->redirect();
            }// else if insertion failed
            else {
                $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید', 'fail', 'خطا در ذخیره سازی',
                    ADMIN_PATH.'/settings/settings/sms-body')->redirect();
            }
            redirect(ADMIN_PATH.'/settings/settings/sms-body');
        }
        $this->smart->view('edit_sms');
    }

    public function sitemap()
    {

        try {// create sitemap
            $path = '/sitemap_shop.xml';
            $sitemap = new Sitemap(PUBLICPATH.$path);
            $menuLinks = Product_type::query()->orderByDesc('order_in_menu')
                ->with([
                    'mainCategories:id,parent_id,slug,product_type_id',
                    'products' => function ($q) {
                        return $q->select('id', 'slug', 'product_type_id')->active();
                    }
                ])->get(['id', 'slug', 'order_in_menu']);
            foreach ($menuLinks as $link) {
                $sitemap->addItem(site_url('product-types/'.urlencode($link->slug)), time(), Sitemap::YEARLY, 1);
                foreach ($link->mainCategories as $mainCategory) {
                    $sitemap->addItem(site_url('subcategories/'.urlencode($mainCategory->slug)), time(),
                        Sitemap::MONTHLY,
                        0.9);
                    foreach ($mainCategory->children as $child) {
                        $sitemap->addItem(
                            site_url(
                                'product-type/'.urlencode($link->slug).'/category/'.urlencode($mainCategory->slug).'/'.urlencode($child->slug)
                            ),
                            time(),
                            Sitemap::WEEKLY,
                            0.9);
                    }
                }
            }
            foreach ($menuLinks as $link) {
                foreach ($link->products as $product) {
                    $sitemap->addItem(
                        site_url("product/NPI-{$product->id}/".urlencode($product->slug)),
                        time(),
                        Sitemap::DAILY,
                        0.9);
                }
            }// write it
            $sitemap->write();
            $this->message->set_message(
                "سایت مپ با موفقیت ساخته شد. لینک سایت مپ: ".site_url($path),
                'success',
                'تولید سایت مپ تازه',
                ADMIN_PATH.'/settings'
            )->redirect();
        } catch (Throwable $e) {
            $this->message->set_message(
                $e->getMessage(),
                'fail',
                'خطا در تولید سایت مپ تازه',
                ADMIN_PATH.'/settings'
            )->redirect();
        }

    }
}
