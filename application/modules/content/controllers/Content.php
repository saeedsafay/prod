<?php

use Illuminate\Support\Collection;

(defined('BASEPATH')) or exit('No direct script access allowed');

/**
 * Content_field_types Controller
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2015
 * @license     MIT License
 */
class Content extends Public_Controller
{

    /**
     * @var \string[][][]
     */
    public $validation_rules = array(
        'submitComment' => array(
            ['field' => 'comment', 'rules' => 'required|htmlspecialchars|trim', 'label' => 'متن نظر'],
            ['field' => 'entry', 'rules' => 'numeric|required', 'label' => 'پست']
        )
    );

    public function index()
    {
        $segments = $this->uri->segments;
        //loading page model to check if page exists
        $this->load->eloquent('Page');
        $this->load->eloquent('settings/Setting');
        try {
            if ( ! $homePageID = cache('home_page_id')) {
                $homePageID = cache_set('home_page_id', Setting::findByCode('homepage')->value, 86400 * 30);
            }
        } catch (Throwable $e) {
            log_message('debug', 'Error querying home page id from setting: '.$e->getMessage());
            $this->__404_error();
        }
        //نمایش صفحه اول سایت
        if (count($segments) == 0) {
            if ( ! $homePage = cache('custom_home_page')) {
                $homePage = cache_set('', Page::find($homePageID), 86400 * 30);
            }
            if ($homePage) {
                return $this->showHomePage($homePage);
            } else {
                return $this->__404_error();
            }
        }
        //نمایش صفحات دیگر
        if ($page = Page::findBySlug(urldecode(implode('/', $segments)))) {
            if ($page->getKey() != $homePageID) {
                return $this->showPage($page);
            }
        }

        $this->load->eloquent('Content_type');
        $this->load->eloquent('Comment');
        $this->load->eloquent('Content_type_field');
        $this->load->eloquent('Field_type');
        $this->load->eloquent('Field');
        $this->load->eloquent('Field_short');
        $this->load->eloquent('Field_long');
        $this->load->eloquent('Field_int');
        $this->load->eloquent('Entry');
        $this->load->eloquent('Content_category');
        //Rendering content type page
        if ($contentType = Content_type::findBySlug(urldecode(implode('/', $segments)))) {
            return $this->showContentTypePage($contentType);
        }

        //Rendering Entry of content type page
        if ($contentType = Content_type::findBySlug(urldecode($segments[1]))) {
            // if entry has category, then the third segment of url is slug of entry,
            // and the sencond is for category
            if ($entry = Entry::findBySlug(urldecode($segments[2]))) {
                return $this->showEntryPage($contentType, $entry);
            } elseif (isset($segments[3])) {
                if ($entry = Entry::findBySlug(urldecode($segments[3])) and $entry->categories()->get()->count()) {
                    return $this->showEntryPage($contentType, $entry);
                }
            }
        }
        //Rendering category of content type page
        if ($contentType = Content_type::findBySlug(urldecode($segments[1]))) {
            if ($category = Content_category::findBySlug(urldecode($segments[2]))) {
                return $this->showCategoryPage($contentType, $category);
            }
        }
        return $this->__404_error();
    }

    private function __404_error()
    {
        try {
            if ( ! $customErrorPageID = cache('custom_404_error_page')) {
                $customErrorPageID = cache_set('custom_404_error_page',
                    Setting::findByCode('custom_error_page')->value, 86400 * 7);
            }
            if ($page = Page::find($customErrorPageID)) {
                return $this->showPage($page, 404);
            } else {
                show_404();
            }
        } catch (Throwable $e) {
            log_message('debug', 'Error querying custom_error_page from setting: '.$e->getMessage());
        }
    }

    /**
     * ثبت نظر برای پست ها
     */
    public function submitComment()
    {

        $this->checkAuth(true);
        $this->load->eloquent('Comment');
        $this->load->eloquent('Entry');
        if ($this->formValidate(false)) {
            $entry_id = $this->input->post('entry');
            $data = [
                "comment" => $this->input->post('comment'),
                "status" => 0,
                "user_id" => $this->user->id,
            ];
            $slug = Entry::find($entry_id)->slug;
            if (Comment::create($data)) {
                $this->message->set_message('نظر شما با موفقیت ثبت گردید و پس از تایید نمایش داده می شود.', 'success',
                    'ارسال نظر', '/وبلاگ/'.$slug)->redirect();
            } else {
                $this->message->set_message('ثبت نظر با مشکل مواجه شد. مجدد تلاش کنید', 'fail', 'ارسال نظر',
                    '/وبلاگ/'.$slug)->redirect();
            }
        } else {
            $this->message->set_message('خطا در داده های ورودی. '.validation_errors(), 'fail', 'ثبت نظر')->redirect();
        }
    }

    /**
     * show the home page
     * @param  object  $page
     * @throws \Exception
     */
    public function showHomePage($page)
    {
        require_once APPPATH.'/modules/slider/models/Slider.php';
        $this->load->eloquent('users/User');
        $this->load->eloquent('users/User_profile');

        $lastMostSales = [];//$this->productConcern->getLastMostOrderedProducts(10);
        $lastMostSalesShirts = [];// $this->productConcern->getLastMostOrderedProducts(10, 185);
        $lastSweetShirtProducts = [];// $this->productConcern->getLatestByProductType(14, 190);
        if ( ! $lastPuzzleProducts = cache('last_puzzle_products')) {
            $lastPuzzleProducts = cache_set('last_puzzle_products', $this->productConcern->getLatestByProductType(15,
                238), 3600 * 3);
        }
        if ( ! $lastMugProducts = cache('last_mug_products_194')) {
            $lastMugProducts = cache_set('last_mug_products_194', $this->productConcern->getLatestByProductType(15,
                194), 3600 * 3);
        }
        if ( ! $lastTShirtProducts = cache('last_tshirt_products')) {
            $lastTShirtProducts = cache_set('last_tshirt_products', $this->productConcern->getLatestByProductType(14,
                185), 3600 * 3);
        }

        $pageTPL = $page->tpl;
        if (strpos($pageTPL, '.tpl')) {
            $pageTPL = str_replace('.tpl', '', $pageTPL);
        }
        if ( ! $this->smart->moduleTemplateExists('pages/statics/'.$pageTPL.'.tpl')) {
            $pageTPL = 'default';
        }
        $this->smart->assign(
            array(
                'title' => $page->name,
                'page' => $page,
                'lastMostSales' => $lastMostSales,
                'lastMostSalesShirts' => $lastMostSalesShirts,
                'lastTShirtProducts' => $lastTShirtProducts,
                'lastMugProducts' => $lastMugProducts,
                'lastSweetShirtProducts' => $lastSweetShirtProducts,
                'lastPuzzleProducts' => $lastPuzzleProducts,
                //                'Sliders' => Slider::where('status', 1)->get(),
                //                'most_sold' => Product::take(1)->skip(0)->orderBy('sold_count', 'desc')->first(),
                'is_home' => true,
                'suggest' => cache('home_suggest_products') ? cache('home_suggest_products') : cache_set('home_suggest_products',
                    $this->cookieProducts(), 3600 * 20)
            ,
            ));
        $this->smart->view('pages/statics/'.$pageTPL);
    }

    /**
     * Show to static and dynamic pages
     * @param  object  $page
     * @param  int  $status
     */
    public function showPage($page, $status = 200)
    {
        $this->load->eloquent('shop/Product');
        $this->load->eloquent('users/User');

        $pageTPL = $page->tpl;
        if (strpos($pageTPL, '.tpl')) {
            $pageTPL = str_replace('.tpl', '', $pageTPL);
        }
        if ( ! $this->smart->moduleTemplateExists('pages/statics/'.$pageTPL.'.tpl')) {
            $pageTPL = 'default';
        }
        if($status == 404){
            $this->output->set_status_header($status);
            show_404();
        }

        $this->smart->assign(
            array(
                'page' => $page,
                'title' => $page->name,
            ));
        $this->smart->view('pages/statics/'.$pageTPL);
    }

    /**
     * display page for all content types (parameter pass by url)
     * @param  object  $contentType
     */
    public function showContentTypePage($contentType)
    {
        $pageTPL = $contentType->list_tpl;
        if (strpos($pageTPL, '.tpl')) {
            $pageTPL = str_replace('.tpl', '', $pageTPL);
        }
        if ( ! $this->smart->moduleTemplateExists('pages/content_types/'.$pageTPL.'.tpl')) {
            $pageTPL = 'default';
        }
        $this->smart->assign(compact('contentType'));
        $this->smart->addModulePluginsDir('content');
        $this->smart->assign(array(
                'entries',
                $contentType->entries,
                'title' => $contentType->title,
            )
        );
        $this->smart->assign('entriesCount', $contentType->entries->count());
        $this->smart->view('pages/content_types/'.$pageTPL);
    }

    /**
     * display page for all categories of a content type (parameter pass by url)
     * @param  object  $contentType
     * @param  object  $category
     */
    public function showCategoryPage($contentType, $category)
    {
        $pageTPL = $category->list_tpl;
        if (strpos($pageTPL, '.tpl')) {
            $pageTPL = str_replace('.tpl', '', $pageTPL);
        }
        if ( ! $this->smart->moduleTemplateExists('pages/categories/'.$pageTPL.'.tpl')) {
            $pageTPL = 'default';
        }
        $this->smart->assign(compact('contentType'));
        $this->smart->assign(compact('category'));
        $this->smart->assign('entriesCount', $category->entries->count());
        $this->smart->view('pages/categories/'.$pageTPL);
    }

    /**
     * display page for all entries of a content type (parameter pass by url)
     * @param  object  $contentType
     * @param  object  $category
     */
    public function showEntryPage($contentType, $entry)
    {

        $this->load->library('field_handler');
        $this->load->eloquent('Field_short');
        $this->load->eloquent('Field_long');
        $this->load->eloquent('Field_int');
        $this->load->eloquent('Content_type');
        $this->load->eloquent('Entry');
        $this->load->eloquent('Field_type');
        $this->load->eloquent('Field');
        $this->load->eloquent('Content_type_field');
        $this->load->eloquent('Content_category');
        //injecting extra fields to the entry object
        foreach ($entry->fields as $field):
            if ($field->contentTypeField->slug) {
                $entry->{$field->contentTypeField->slug} = json_decode($field->valuable->value);
            }
            if (is_array($entry->{$field->contentTypeField->slug})) {
                $entry->{$field->contentTypeField->slug} = site_url('upload/content/fields/'.implode('',
                        json_decode($field->valuable->value)));
            }
        endforeach;
        // set the page template
        $pageTPL = $entry->entry_tpl ? $entry->entry_tpl : $contentType->full_tpl;
        if (strpos($pageTPL, '.tpl')) {
            $pageTPL = str_replace('.tpl', '', $pageTPL);
        }
        if ( ! $this->smart->moduleTemplateExists('pages/entries/'.$pageTPL.'.tpl')) {
            $pageTPL = 'default';
        }

        $Extra_fields = $this->__getExtraFieldObjs($contentType, isset($entry) ? $entry : null);
        $this->smart->assign(compact('contentType'));
        $this->smart->assign(compact('entry'));
        $this->smart->assign(compact('Extra_fields'));
        $this->smart->assign(['title' => $entry->title, 'content_type' => $contentType]);

        $this->smart->view('pages/entries/'.$pageTPL);
    }

    /**
     *
     * @param  type  $content_type
     * @param  type  $entry
     * @return Collection
     */
    protected function __getExtraFieldObjs($content_type, $entry = null)
    {
        //Extra Fields
        $Extra_fields = new Collection();
        foreach ($content_type->fields as $extra_field) {
            $item = $this->field_handler->getFieldObj($extra_field->fieldType, $extra_field);
            if ($entry) {
                $item->setValue($entry->extra_field($extra_field->id));
            }
            if ($this->input->post($extra_field->slug) != '') {
                $item->setNewValue($this->input->post($extra_field->slug));
            } elseif (isset($_FILES[$extra_field->slug]) && $_FILES[$extra_field->slug]['name'] != '') {
                $item->setNewValue($_FILES[$extra_field->slug]);
            }
            $Extra_fields->put($extra_field->slug, $item);
        }
        return $Extra_fields;
    }

}
