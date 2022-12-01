<?php

/**
 * Controller: diversities for (products)
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Diversities extends Admin_Controller {

    public $validation_rules = array(
        'edit' => array(
            [ 'field' => 'input_name' , 'rules' => 'trim|required|htmlspecialchars|callback_name_validation' , 'label' => 'نام انگلیسی' ] ,
            [ 'field' => 'label' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'برچسب' ] ,
            [ 'field' => 'product_type_id' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'نوع محصول' ] ,
            [ 'field' => 'field_type' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'نوع لیست' ] ,
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Diversity');
        $this->load->eloquent('Product_type');
        $this->load->eloquent('Diversity_value');
        $this->load->eloquent('Category');
    }

    public function index()
    {
        $diversities = Diversity::orderBy('id' , 'desc')->get();
        $this->smart->assign(
                [
                    'title' => 'تنوع محصولات' ,
                    'Diversities' => $diversities
                ]
        );
        $this->smart->view('diversities/index');
    }

    function edit( $diversity_id = null )
    {
        // Init
        $edit_mode = FALSE;

        $this->smart->assign([
            'edit_mode' => $edit_mode ,
            'title' => 'تنوع محصول' ,
            'product_types' => Product_type::all() ,
            'product_categories' => Category::all() ,
        ]);
        // Edit Mode 
        if( $diversity_id ) {
            $edit_mode = TRUE;
            $this->smart->assign([
                'edit_mode' => $edit_mode ,
                'Diversity' => Diversity::find($diversity_id)
            ]);
        }
        // Process Form
        if( $this->formValidate(FALSE) ) {
            $data = [
                'can_change' => $this->input->post('can_change') ,
                'field_type' => 2 ,
                'name' => $this->input->post('input_name') ,
                'label' => $this->input->post('label') ,
                'product_type_id' => $this->input->post('product_type_id') ,
                'product_category_id' => $this->input->post('product_category_id') ,
                'product_child_category_id' => $this->input->post('product_childCategory_id') != NULL ? $this->input->post('product_childCategory_id') : NULL ,
            ];

            if( $Diversity = Diversity::updateOrCreate([ 'id' => $diversity_id ] , $data) ) {

                if( !empty($this->input->post('values')) && $this->input->post('field_type') != 3 )
                    $this->__storeFilterValues($this->input->post('values') , $Diversity->id);


                if( !$edit_mode ) {
                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد' , 'success' , 'ثبت رکورد جدید' , ADMIN_PATH . '/shop/diversities')->redirect();
                }
                else
                    $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد' , 'success' , 'بروزرسانی' , ADMIN_PATH . '/shop/diversities')->redirect();
            }// else if insertion failed
            else {
                if( $edit_mode )
                    $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در ذخیره سازی' , ADMIN_PATH . '/shop/diversities')->redirect();

                else {
                    $this->message->set_message('بروزرسانی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در  بروزسانی' , ADMIN_PATH . '/shop/diversities/edit')->redirect();
                }
            }
            redirect(ADMIN_PATH . '/shop/diversities');
        }
        $this->smart->view('diversities/edit');
    }

    function delete( $diversity_id = null )
    {
        if( $Diversity = Diversity::find($diversity_id) ) {
            if( $Diversity->delete() )
                $this->message->set_message('تنوع مربوطه حذف گردید' , 'success' , 'حذف تنوع محصول ' , ADMIN_PATH . '/shop/diversities')->redirect();
        }
        else {
            show_404();
        }
    }

    public function __storeFilterValues( $arrayData , $diversity_id )
    {
        $values = array();
        foreach( $arrayData as $value ):
            $data['title'] = $value;
            $data['product_diversity_id'] = $diversity_id;
            if( substr($value , 0 , 1) == '#' ):
                $data['is_color'] = 1;
            endif;
            $values[] = Diversity_value::updateOrCreate($data , [ 'title' => $data['title'] , 'product_diversity_id' => $diversity_id ])->toArray();
        endforeach;
        foreach( $values as $value ):
            $value_ids[] = array_get($value , 'id');
        endforeach;
        Diversity_value::where('product_diversity_id' , $diversity_id)->whereNotIn('id' , $value_ids)->delete();
        return true;
    }

    function name_validation( $name )
    {
// check if is email and its validation
        $pattern = "/[a-zA-Z0-9_]/";
        if( !preg_match($pattern , $name) ):
            $this->form_validation->set_message('username_validation' , 'نام فیلد باید شامل حروف لاتین و بدون فاصله باشد');
            return FALSE;
        endif;

        $Varient = Diversity::where('name' , $name)->first();
        if( $Varient ):
            $this->form_validation->set_message('username_validation' ,'نام لاتین تکراری است.');
            return FALSE;
        endif;
        return TRUE;
    }

}
