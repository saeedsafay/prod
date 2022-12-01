<?php

(defined('BASEPATH')) OR exit('No direct script access allowed');

use PHPImageWorkshop\ImageWorkshop;

/**
 * Galleries panel Controller
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 * @link http://www.saeedtavakoli.ir exclusive CMS.
 */
class Galleries extends Admin_Controller {

    public $validation_rules = array(
        'edit' => array(
            // ['field' => 'image', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'فایل عکس'],
            ['field' => 'title' , 'rules' => 'required|trim|htmlspecialchars' , 'label' => 'عنوان گالری عکس' ] ,
            ['field' => 'status' , 'rules' => 'required|numeric' , 'label' => 'وضعیت' ] ,
        )
    );

    public function __construct () {
        parent::__construct();
        $this->load->eloquent('Gallery');
        $this->load->eloquent('Gallery_photo');
    }

    public function index () {
        $data = array();
        $Galleries = Gallery::orderBy('id' , 'desc')->get();
        $this->smart->assign(
                [
                    'title' => 'گالری‌ تصاویر' ,
                    'Galleries' => $Galleries ,
                ]
        );
        $this->smart->view('index');
    }

    function edit ( $gallery_id = null ) {
        // Init
        $edit_mode = FALSE;

        $this->smart->addJS('js/ckeditor/jquery.ckeditor.js');
        $this->smart->addJS('js/ckeditor/ckeditor.js');
        // Edit Mode 
        if ( $gallery_id ) {
            $edit_mode = TRUE;
            $this->smart->assign([
                'title' => 'افزودن گالری' ,
                'edit_mode' => $edit_mode ,
                'Gallery' => Gallery::find($gallery_id)
            ]);
        }
        // Process Form
        if ( $this->formValidate(FALSE) ) {
            $data = [
                'title' => $this->input->post('title') ,
                'top_title' => $this->input->post('top_title') ,
                'full_story' => $this->input->post('full_story') ,
                'photographer' => $this->input->post('photographer') ,
                'status' => $this->input->post('status') ,
            ];
            if ( !empty($_FILES['index_photo']['name']) ) {
                $data['index_photo'] = $this->input->imageFile('index_photo' , 'gallery');

                $this->addWaterMark($data['index_photo']);
            }
            if ( $Gallery = Gallery::updateOrCreate(['id' => $gallery_id ] , $data) ) {
                if ( !$edit_mode ) {

                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد حال تصاویر خود را بارگذاری نمایید.' , 'success' , 'ساخت گالری جدید' , ADMIN_PATH . '/gallery/galleries/photos/' . $Gallery->id)->redirect();
                }
                else
                    $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد' , 'success' , 'بروزرسانی' , ADMIN_PATH . '/gallery/galleries/photos/' . $Gallery->id)->redirect();
            }// else if insertion failed
            else {
                if ( $edit_mode )
                    $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در ذخیره سازی' , ADMIN_PATH . '/gallery/galleries/photos/' . $Gallery->id)->redirect();

                else {
                    $this->message->set_message('بروزرسانی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در  بروزسانی' , ADMIN_PATH . '/gallery/galleries/edit')->redirect();
                }
            }
            redirect(ADMIN_PATH . '/gallery/galleries');
        }
        $this->smart->assign(['title' => 'افزودن گالری تصاویر' ]);
        $this->smart->view('edit');
    }

    public function photos ( $gallery_id ) {
        $Gallery = Gallery::find($gallery_id);

        if ( !empty($_FILES) ) {
            if ( !$gallery_id OR ! $Gallery ):
                die(json_encode(['result' => 0 ]));
            endif;
            $data['pic'] = $this->input->imageFile('file' , 'gallery');

            $this->addWaterMark($data['pic'] , $Gallery->photographer);

            $data['gallery_id'] = $gallery_id;
            if ( Gallery_photo::create($data) )
                die(json_encode(['result' => 1 ]));
        }else {
            $this->show_404_on(!$gallery_id OR ! $Gallery);
            $this->smart->assign([
                'title' => 'آپلود تصاویر گالری' ,
                'action' => site_url(ADMIN_PATH . '/gallery/galleries/photos/' . $gallery_id) ,
                'gallery_id' => $gallery_id ,
            ]);
            $this->smart->view('photos/edit');
        }
    }

    public function view ( $gallery_id ) {

        $photos = Gallery::find($gallery_id)->photos;

        $this->smart->assign(['photos' => $photos , 'title' => 'نمایش گالری' ]);
        $this->smart->view('view');
    }

    public function addWaterMark ( $image_name , $photographer = null ) {

        $imgLayer = ImageWorkshop::initFromPath(PUBLICPATH . 'upload/gallery/' . $image_name);
        // add a watermark to the uploaded image
        $watermarkLayer = ImageWorkshop::initFromPath(PUBLICPATH . 'assets/admin/default/img/logo_main.png');
        if ( $photographer ) {
// This is the text layer
            $textLayer = ImageWorkshop::initTextLayer('Photo: ' . $photographer , FCPATH . 'assets/admin/default/css/rtl/fonts/ARIAL.TTF' , 15 , 'ffffff' , 0);
            // We add the text layer 12px from the Left and 12px from the Bottom ("LB") of the norway layer:
            $imgLayer->addLayerOnTop($textLayer , 12 , 12 , "LB");
        }

        $imgLayer->addLayerOnTop($watermarkLayer , 12 , 40 , "LB");

        $imgLayer->getResult();
        // saving the watermarked image
        $dirPath = PUBLICPATH . 'upload/gallery';
        $filename = $image_name;
        $createFolders = true;
        $backgroundColor = null; // transparent, only for PNG (otherwise it will be white if set null)
        $imageQuality = 95; // useless for GIF, usefull for PNG and JPEG (0 to 100%)

        return $imgLayer->save($dirPath , $filename , $createFolders , $backgroundColor , $imageQuality);
    }

    function delete ( $gallery_id = null ) {
        if ( $Gallery = Gallery::find($gallery_id) ) {
            if ( $Gallery->delete() )
                $this->message->set_message(' تصویر اسلایدر مربوطه حذف گردید' , 'success' , 'حذف تصویر اسلایدر  ' , ADMIN_PATH . '/slider/slider-image')->redirect();
        }
        else {
            show_404();
        }
    }

}
