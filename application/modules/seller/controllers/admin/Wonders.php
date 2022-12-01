<?php

/**
 * Controller: Wonders for flowers
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Wonders extends Admin_Controller {

    public $validation_rules = array(
        'edit' => array(
            [ 'field' => 'discount' , 'rules' => 'trim|required|htmlspecialchars|numeric' , 'label' => 'درصد تخفیف' ] ,
            [ 'field' => 'expire_hour' , 'rules' => 'trim|required|htmlspecialchars|numeric' , 'label' => 'اعتبار' ] ,
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Product');
        $this->load->eloquent('Wonder');
        $this->load->eloquent('Wonder_category');
    }

    public function index()
    {
        $data = array();
        $wonders = Wonder::all();
        $this->smart->assign(
                [
                    'title' => 'شگفت انگیزها' ,
                    'wonders' => $wonders
                ]
        );
        $this->smart->view('wonders/index');
    }

    function edit( $wonder_id = null )
    {
        // Init
        $edit_mode = FALSE;

        $this->smart->assign([
            'edit_mode' => $edit_mode ,
            'title' => 'محصولات شگفت انگیز' ,
            'cats' => Wonder_category::all() ,
            'products' => Product::where('soft_delete' , 0)->where('status' , 1)->where('type' , 4)->get() ,
        ]);

        // Edit Mode 
        if( $wonder_id ) {
            $edit_mode = TRUE;
            $this->smart->assign([
                'edit_mode' => $edit_mode ,
                'Wonder' => Wonder::find($wonder_id)
            ]);
        }
        // Process Form
        if( $this->formValidate(FALSE) ) {
            $data = [
                'product_id' => $this->input->post('product_id') ,
                'discount' => $this->input->post('discount') ,
                'origin_time_counter' => $this->input->post('origin_time_counter') ,
                'wonder_category_id' => $this->input->post('wonder_category_id') ,
                'expire_hour' => $this->input->post('expire_hour') ,
                'short_title' => $this->input->post('short_title') ,
                'status' => $this->input->post('status') ,
            ];

            // Insert or update data to the db
            // if inserted
            if( Wonder::updateOrCreate([ 'id' => $wonder_id ] , $data) ) {
                $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد' , 'success' , 'بروزرسانی' , ADMIN_PATH . '/shop/wonders')->redirect();
            }// else if insertion failed
            else {
                if( $edit_mode )
                    $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در ذخیره سازی' , ADMIN_PATH . '/shop/wonders')->redirect();

                else {
                    $this->message->set_message('بروزرسانی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در  بروزسانی' , ADMIN_PATH . '/shop/wonders/edit')->redirect();
                }
            }
            redirect(ADMIN_PATH . '/shop/wonders');
        }
        $this->smart->view('wonders/edit');
    }

    function delete( $wonder_id = null )
    {
        if( $Wonder = Wonder::find($wonder_id) ) {
            if( $Wonder->delete() )
                $this->message->set_message('شگفت انگیز مربوطه حذف گردید' , 'success' , 'حذف شگفت انگیز ' , ADMIN_PATH . '/shop/wonders')->redirect();
        }
        else {
            show_404();
        }
    }

}
