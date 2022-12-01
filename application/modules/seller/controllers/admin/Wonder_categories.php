<?php

/**
 * Controller: Main Advertises management
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
use Cocur\Slugify\Slugify as Slugify;

class Wonder_categories extends Admin_Controller {

    public $validation_rules = array(
        'edit' => array(
            [ 'field' => 'title' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'عنوان' ] ,
            [ 'field' => 'slug' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'عنوان' ] ,
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Wonder_category');
        $this->load->eloquent('Wonder');
    }

    public function index()
    {
        $prd_categories = Wonder_category::orderBy('id' , 'desc')->get();
        $this->smart->assign(
                [
                    'title' => 'دسته بندی تخفیفی' ,
                    'categories' => $prd_categories
                ]
        );
        $this->smart->view('wonders_cat/index');
    }

    function edit( $cat_id = null )
    {
        // Init
        $edit_mode = FALSE;

        $categories = Wonder_category::all();
        $this->smart->assign([
            'edit_mode' => $edit_mode ,
            'title' => 'دسته بندی محصول' ,
            'categories' => Wonder_category::all() ,
        ]);
        $this->load->eloquent('Reason');
        // Edit Mode 
        if( $cat_id ) {
            $edit_mode = TRUE;
            $this->smart->assign([
                'edit_mode' => $edit_mode ,
                'Wonder_category' => Wonder_category::find($cat_id)
            ]);
        }
        // Process Form
        if( $this->formValidate(FALSE) ) {
            $slugify = new Slugify();
            if( $this->input->post('slug') === null ) {
                $cat_slug = $this->input->post('title');
            }
            else {
                $cat_slug = $this->input->post('slug');
            }
            $data = [
                'title' => $this->input->post('title') ,
                'slug' => $slugify->slugify($cat_slug) ,
            ];

            // Insert or update data to the db
            // if inserted
            if( Wonder_category::updateOrCreate([ 'id' => $cat_id ] , $data) ) {
                if( !$edit_mode ) {
                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد' , 'success' , 'ثبت رکورد جدید' , ADMIN_PATH . '/shop/wonder-categories/edit')->redirect();
                }
                else
                    $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد' , 'success' , 'بروزرسانی' , ADMIN_PATH . '/shop/wonder-categories')->redirect();
            }// else if insertion failed
            else {
                if( $edit_mode )
                    $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در ذخیره سازی' , ADMIN_PATH . '/shop/wonder-categories')->redirect();

                else {
                    $this->message->set_message('بروزرسانی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در  بروزسانی' , ADMIN_PATH . '/shop/wonder-categories/edit')->redirect();
                }
            }
            redirect(ADMIN_PATH . '/shop/wonder-categories');
        }
        $this->smart->view('wonders_cat/edit');
    }

    function delete( $cat_id = null )
    {
        if( $Wonder_category = Wonder_category::find($cat_id) ) {
            if( $Wonder_category->delete() )
                $this->message->set_message('دسته بندی مربوطه حذف گردید' , 'success' , 'حذف دسته بندی محصول ' , ADMIN_PATH . '/shop/wonder-categories')->redirect();
        }
        else {
            show_404();
        }
    }

    public function getCategories()
    {
        $p_id = $this->input->get('product_type_id');

        $Product_type = Product_type::find($p_id);

        if( !$Product_type )
            die(json_encode([ 'success' => 0 ]));

        $data = $Product_type->categories()->where('parent_id' , NULL)->get();
        echo json_encode([ 'success' => 1 , 'results' => $data ]);
        exit;
    }

}
