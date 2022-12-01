<?php

/**
 * Controller: filters for (products)
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Filters extends Admin_Controller {

    public $validation_rules = array(
        'edit' => array(
            [ 'field' => 'input_name' , 'rules' => 'trim|required|htmlspecialchars|callback_name_validation' , 'label' => 'نام انگلیسی' ] ,
            [ 'field' => 'label' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'برچسب' ] ,
            [ 'field' => 'product_type_id' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'نوع محصول' ] ,
            [ 'field' => 'field_type' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'نوع لیست' ] ,
            [ 'field' => 'show_filter' , 'rules' => 'trim|required|htmlspecialchars|numeric' , 'label' => 'نمایش در لیست' ] ,
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Filter');
        $this->load->eloquent('Product_type');
        $this->load->eloquent('Filter_value');
        $this->load->eloquent('Category');
    }

    public function index()
    {
        $data = array();
        $filters = Filter::orderBy('id' , 'desc')->get();
        $this->smart->assign(
                [
                    'title' => 'فیلتر محصولات' ,
                    'Filters' => $filters
                ]
        );
        $this->smart->view('filters/index');
    }

    function edit( $filter_id = null )
    {
        // Init
        $edit_mode = FALSE;

        $this->smart->assign([
            'edit_mode' => $edit_mode ,
            'title' => 'فیلتر محصول' ,
            'product_types' => Product_type::all() ,
            'product_categories' => Category::all() ,
        ]);
        // Edit Mode 
        if( $filter_id ) {
            $edit_mode = TRUE;
            $this->smart->assign([
                'edit_mode' => $edit_mode ,
                'Filter' => Filter::find($filter_id)
            ]);
        }
        // Process Form
        if( $this->formValidate(FALSE) ) {
            $data = [
                'field_type' => $this->input->post('field_type') ,
                'name' => $this->input->post('input_name') ,
                'label' => $this->input->post('label') ,
                'show_filter' => $this->input->post('show_filter') ,
                'product_type_id' => $this->input->post('product_type_id') ,
                'product_category_id' => $this->input->post('product_category_id') ,
                'product_child_category_id' => $this->input->post('product_childCategory_id') != NULL ? $this->input->post('product_childCategory_id') : NULL ,
            ];

            if( $Filter = Filter::updateOrCreate([ 'id' => $filter_id ] , $data) ) {

                if( !empty($this->input->post('values')) && $this->input->post('field_type') != 3 )
                    $this->__storeFilterValues($this->input->post('values') , $Filter->id);


                if( !$edit_mode ) {
                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد' , 'success' , 'ثبت رکورد جدید' , ADMIN_PATH . '/shop/filters')->redirect();
                }
                else
                    $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد' , 'success' , 'بروزرسانی' , ADMIN_PATH . '/shop/filters')->redirect();
            }// else if insertion failed
            else {
                if( $edit_mode )
                    $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در ذخیره سازی' , ADMIN_PATH . '/shop/filters')->redirect();

                else {
                    $this->message->set_message('بروزرسانی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در  بروزسانی' , ADMIN_PATH . '/shop/filters/edit')->redirect();
                }
            }
            redirect(ADMIN_PATH . '/shop/filters');
        }
        $this->smart->view('filters/edit');
    }

    function delete( $filter_id = null )
    {
        if( $Filter = Filter::find($filter_id) ) {
            if( $Filter->delete() )
                $this->message->set_message('فیلتر مربوطه حذف گردید' , 'success' , 'حذف فیلتر محصول ' , ADMIN_PATH . '/shop/filters')->redirect();
        }
        else {
            show_404();
        }
    }

    public function __storeFilterValues( $arrayData , $filter_id )
    {
        $values = array();
        foreach( $arrayData as $value ):
            $data['title'] = $value;
            $data['product_filter_id'] = $filter_id;
            if( substr($value , 0 , 1) == '#' ):
                $data['is_color'] = 1;
            endif;
            $values[] = Filter_value::updateOrCreate($data , [ 'title' => $data['title'] , 'product_filter_id' => $filter_id ])->toArray();
        endforeach;
        foreach( $values as $value ):
            $value_ids[] = $value['id'];
        endforeach;
        Filter_value::where('product_filter_id' , $filter_id)->whereNotIn('id' , $value_ids)->delete();
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
        return TRUE;
    }

}
