<?php

/**
 * Controller: Colors for (products)flowers
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Colors extends Admin_Controller {

    public $validation_rules = array(
        'edit' => array(
            ['field' => 'title' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'رنگ' ] ,
        )
    );

    public function __construct () {
        parent::__construct();
        $this->load->eloquent('Color');
    }

    public function index () {
        $data = array();
        $prd_colors = Color::all();
        $this->smart->assign(
                [
                    'title' => 'رنگ‌ها' ,
                    'Colors' => $prd_colors
                ]
        );
        $this->smart->view('colors/index');
    }

    function edit ( $color_id = null ) {
        // Init
        $edit_mode = FALSE;

        $this->smart->assign([
            'edit_mode' => $edit_mode ,
            'title' => 'رنگ‌ها' ,
        ]);

        // Edit Mode 
        if ( $color_id ) {
            $edit_mode = TRUE;
            $this->smart->assign([
                'edit_mode' => $edit_mode ,
                'Color' => Color::find($color_id)
            ]);
        }
        // Process Form
        if ( $this->formValidate(FALSE) ) {
            $data = [
                'title' => $this->input->post('title') ,
            ];

            // Insert or update data to the db
            // if inserted
            if ( $Color = Color::updateOrCreate(['id' => $color_id ] , $data) ) {
                if ( !$edit_mode ) {
                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد' , 'success' , 'ثبت رکورد جدید' , ADMIN_PATH . '/shop/colors/edit')->redirect();
                }
                else
                    $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد' , 'success' , 'بروزرسانی' , ADMIN_PATH . '/shop/colors')->redirect();
            }// else if insertion failed
            else {
                if ( $edit_mode )
                    $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در ذخیره سازی' , ADMIN_PATH . '/shop/colors')->redirect();

                else {
                    $this->message->set_message('بروزرسانی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در  بروزسانی' , ADMIN_PATH . '/shop/colors/edit')->redirect();
                }
            }
            redirect(ADMIN_PATH . '/shop/colors');
        }
        $this->smart->view('colors/edit');
    }

    function delete ( $color_id = null ) {
        if ( $Color = Color::find($color_id) ) {
            if ( $Color->delete() )
                $this->message->set_message('رنگ مربوطه حذف گردید' , 'success' , 'حذف رنگ محصول ' , ADMIN_PATH . '/shop/colors')->redirect();
        }
        else {
            show_404();
        }
    }

}
