<?php

/**
 * Controller: Affiliates for (products)flowers
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Aff extends Admin_Controller
{

    public $validation_rules = array(
        'edit' => array(
            [ 'field' => 'product_type_id' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'نوع محصول' ] ,
            [ 'field' => 'user_id' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'کاربر' ] ,
        )
    );
    public $ranges = array();

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Affiliate');
        $this->ranges = [ [ 0 , 20 ] , [ 21 , 100 ] , [ 101 , 999999999 ] ];
    }

    public function index()
    {
        $data = array();
        $aff = Affiliate::all();
        $this->smart->assign(
                [
                    'title' => 'درصد پورسانت لیدرها' ,
                    'Affiliates' => $aff
                ]
        );
        $this->smart->view('aff/index');
    }

    function edit( $aff_id = null )
    {
        // Init
        $edit_mode = FALSE;

        $leaders = $this->sentinel->getRoleRepository()->where('slug' , 'sale_leader')->first();
        $this->smart->assign([
            'edit_mode' => $edit_mode ,
            'leaders' => $leaders->users ,
            'ranges' => $this->ranges ,
            'product_types' => Product_type::all() ,
            'title' => 'درصد پورسانت لیدرها' ,
        ]);

        // Edit Mode 
        if( $aff_id ) {
            $Aff = Affiliate::find($aff_id);
            $edit_mode = TRUE;
            $this->smart->assign([
                'edit_mode' => $edit_mode ,
                'Aff' => $Aff ,
                'percentages' => json_decode($Aff->percentages) ,
            ]);
        }
        // Process Form
        if( $this->formValidate(FALSE) ) {

            $code = substr(sha1(str_random()) , 0 , 6);
            $data = [
                'user_id' => $this->input->post('user_id') ,
                'percentages' => json_encode($this->input->post('percentages')) ,
                'product_type_id' => $this->input->post('product_type_id') ,
                'code' => $code ,
            ];

            // Insert or update data to the db
            // if inserted
            if( $Affiliate = Affiliate::updateOrCreate([ 'id' => $aff_id ] , $data) ) {
                if( !$edit_mode ) {
                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد' , 'success' , 'ثبت رکورد جدید' , ADMIN_PATH . '/users/aff')->redirect();
                }
                else
                    $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد' , 'success' , 'بروزرسانی' , ADMIN_PATH . '/users/aff')->redirect();
            }// else if insertion failed
            else {
                if( $edit_mode )
                    $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در ذخیره سازی' , ADMIN_PATH . '/users/aff')->redirect();

                else {
                    $this->message->set_message('بروزرسانی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در  بروزسانی' , ADMIN_PATH . '/users/aff')->redirect();
                }
            }
            redirect(ADMIN_PATH . '/users/aff');
        }
        else {
            $this->smart->view('aff/edit');
        }
    }

    function delete( $aff_id = null )
    {
        if( $Affiliate = Affiliate::find($aff_id) ) {
            if( $Affiliate->delete() )
                $this->message->set_message('پورسانت مربوطه حذف گردید' , 'success' , 'حذف پورسانت' , ADMIN_PATH . '/users/aff')->redirect();
        }
        else {
            show_404();
        }
    }

}
