<?php

(defined('BASEPATH')) or exit('No direct script access allowed');

use PHPImageWorkshop\ImageWorkshop;

/**
 * Galleries panel Controller
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 * @link http://www.saeedtavakoli.ir exclusive CMS.
 */
class Banners extends Admin_Controller
{

    public $validation_rules = array(
        'edit' => array(
            ['field' => 'title', 'rules' => 'required|trim|htmlspecialchars', 'label' => 'عنوان عکس'],
            ['field' => 'position', 'rules' => 'required|numeric', 'label' => 'موقعیت'],
            ['field' => 'origin_time_counter', 'rules' => 'numeric', 'label' => 'مبدا شمارش معکوس'],
            ['field' => 'duration_time_counter', 'rules' => 'numeric', 'label' => 'مدت شمار معکوس'],
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Banner');
    }

    public function index()
    {
        $Banners = Banner::all();
        $this->smart->assign(
            [
                'title' => 'تصاویر بنر',
                'Banners' => $Banners,
            ]
        );
        $this->smart->view('index');
    }

    function edit($banner_id = null)
    {
        $this->smart->addJS('js/ckeditor/jquery.ckeditor.js');
        $this->smart->addJS('js/ckeditor/ckeditor.js');
        // Edit Mode 
        $edit_mode = false;
        if ($banner_id) {
            $edit_mode = true;
            $this->smart->assign([
                'title' => 'افزودن بنر',
                'Banner' => Banner::find($banner_id)
            ]);
        }
        // Process Form
        if ($this->formValidate(false)) {
            $data = [
                'position' => $this->input->post('position'),
                'target' => $this->input->post('target'),
                'title' => $this->input->post('title'),
                'origin_time_counter' => $this->input->post('origin_time_counter'),
                'duration_time_counter' => $this->input->post('duration_time_counter') ? $this->input->post('duration_time_counter') : 0,
            ];
            if ( ! empty($_FILES['image']['name'])) {
                $data['image'] = $this->input->imageFile('image', 'banners');

                //                $this->addWaterMark($data['image']);
            }
            Banner::updateOrCreate(['id' => $banner_id], $data);

            $this->message->set_message('اطلاعات با موفقیت ذخیره شد.', 'success', 'بنر جدید',
                ADMIN_PATH.'/banners')->redirect();
        }
        $this->smart->assign(['title' => 'افزودن گالری تصاویر', 'edit_mode' => $edit_mode]);
        $this->smart->view('edit');
    }

    public function photos($banner_id)
    {
        $Banner = Banner::find($banner_id);

        if ( ! empty($_FILES)) {
            if ( ! $banner_id or ! $Banner):
                die(json_encode(['result' => 0]));
            endif;
            $data['pic'] = $this->input->imageFile('file', 'gallery');

            $this->addWaterMark($data['pic'], $Banner->photographer);

            $data['gallery_id'] = $banner_id;
            if (Banner_photo::create($data)) {
                die(json_encode(['result' => 1]));
            }
        } else {
            $this->show_404_on(! $banner_id or ! $Banner);
            $this->smart->assign([
                'title' => 'آپلود تصاویر گالری',
                'action' => site_url(ADMIN_PATH.'/gallery/galleries/photos/'.$banner_id),
                'gallery_id' => $banner_id,
            ]);
            $this->smart->view('photos/edit');
        }
    }

    public function view($banner_id)
    {

        $photos = Banner::find($banner_id)->photos;

        $this->smart->assign(['photos' => $photos, 'title' => 'نمایش گالری']);
        $this->smart->view('view');
    }

    public function addWaterMark($image_name, $photographer = null)
    {

        $imgLayer = ImageWorkshop::initFromPath(PUBLICPATH.'upload/gallery/'.$image_name);
        // add a watermark to the uploaded image
        $watermarkLayer = ImageWorkshop::initFromPath(PUBLICPATH.'assets/admin/default/img/logo_main.png');
        if ($photographer) {
            // This is the text layer
            $textLayer = ImageWorkshop::initTextLayer('Photo: '.$photographer,
                PUBLICPATH.'assets/admin/default/css/rtl/fonts/ARIAL.TTF', 15, 'ffffff', 0);
            // We add the text layer 12px from the Left and 12px from the Bottom ("LB") of the norway layer:
            $imgLayer->addLayerOnTop($textLayer, 12, 12, "LB");
        }

        $imgLayer->addLayerOnTop($watermarkLayer, 12, 40, "LB");

        $imgLayer->getResult();
        // saving the watermarked image
        $dirPath = PUBLICPATH.'upload/gallery';
        $filename = $image_name;
        $createFolders = true;
        $backgroundColor = null; // transparent, only for PNG (otherwise it will be white if set null)
        $imageQuality = 95; // useless for GIF, usefull for PNG and JPEG (0 to 100%)

        return $imgLayer->save($dirPath, $filename, $createFolders, $backgroundColor, $imageQuality);
    }

    function delete($banner_id = null)
    {
        if ($Banner = Banner::find($banner_id)) {
            if ($Banner->delete()) {
                $this->message->set_message(' تصویر بنر مربوطه حذف گردید', 'success', 'حذف تصویر بنر  ',
                    ADMIN_PATH.'/banners')->redirect();
            }
        } else {
            show_404();
        }
    }

    /*
     * Form Validation callback to check that the provided email address or mobile is valid.
     */

    function unique_position($position)
    {

        $banner = Banner::where('position', $position)->first();

        if ($banner):
            $this->form_validation->set_message('mobile_numbers_validation',
                "موقعیت بنر تکراری است. لطفا بنر موجود را ویرایش کنید.");
            return false;
        endif;
        return true;
    }

}
