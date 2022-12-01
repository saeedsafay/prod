<?php

/**
 * Controller: Main Advertises management
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */

class Categories extends Admin_Controller
{

    public $validation_rules = array(
        'edit' => array(
            [ 'field' => 'title' , 'rules' => 'trim|required|htmlspecialchars' , 'label' => 'عنوان' ] ,
            [ 'field' => 'product_type_id' , 'rules' => 'trim|numeric' , 'label' => 'گروه کالایی' ] ,
            [ 'field' => 'has_extra_fields' , 'rules' => 'numeric|htmlspecialchars' , 'label' => 'فیلدهای ثابت' ] ,
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Category');
        $this->load->eloquent('Product_type');
    }

    public function index()
    {
        $data = array();
        $prd_categories = Category::orderBy('id' , 'desc')->get();
        $this->smart->assign(
                [
                    'title' => 'دسته بندی محصول' ,
                    'Ads_categories' => $prd_categories
                ]
        );
        $this->smart->view('category/index');
    }

    function edit( $cat_id = null )
    {
        // Init
        $edit_mode = FALSE;

        $categories = Category::all();
        $this->smart->assign([
            'edit_mode' => $edit_mode ,
            'title' => 'دسته بندی محصول' ,
            'product_types' => Product_type::all() ,
            'categories' => Category::all() ,
        ]);
        // Edit Mode
        if( $cat_id ) {
            $edit_mode = TRUE;
            $this->smart->assign([
                'edit_mode' => $edit_mode ,
                'Category' => Category::find($cat_id)
            ]);
        }
        // Process Form
        if( $this->formValidate(FALSE) ) {

            if( $this->input->post('slug') === null ) {
                $cat_slug = $this->input->post('title');
            }
            else {
                $cat_slug = $this->input->post('slug');
            }
            $data = [
                'title' => $this->input->post('title') ,
                'product_type_id' => $this->input->post('product_type_id') ,
                'parent_id' => $this->input->post('parent_id') ? $this->input->post('parent_id') : NULL ,
                'slug' => slug($cat_slug),
            ];
            if( !empty($_FILES['image']['name']) ) {
                $data['image'] = $this->input->imageFile('image' , 'products/pic');
            }
            if( $this->input->post('parent_id') ) {
                if( $parent = Category::find($this->input->post('parent_id')) ) {
                    if( isset($parent->parentCat->id) ) {
                        $data['grandparent_id'] = $parent->parentCat->id;
                    }
                }
            }


            // Insert or update data to the db
            // if inserted
            if( Category::updateOrCreate([ 'id' => $cat_id ] , $data) ) {
                if( !$edit_mode ) {
                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد' , 'success' , 'ثبت رکورد جدید' , ADMIN_PATH . '/shop/categories/edit')->redirect();
                }
                else
                    $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد' , 'success' , 'بروزرسانی' , ADMIN_PATH . '/shop/categories')->redirect();
            }// else if insertion failed
            else {
                if( $edit_mode )
                    $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در ذخیره سازی' , ADMIN_PATH . '/shop/categories')->redirect();

                else {
                    $this->message->set_message('بروزرسانی انجام نشد. مجدد تلاش کنید' , 'fail' , 'خطا در  بروزسانی' , ADMIN_PATH . '/shop/categories/edit')->redirect();
                }
            }
            redirect(ADMIN_PATH . '/shop/categories');
        }
        $this->smart->view('category/edit');
    }

    function delete( $cat_id = null )
    {
        if( $Category = Category::find($cat_id) ) {
            if( $Category->delete() )
                $this->message->set_message('دسته بندی مربوطه حذف گردید' , 'success' , 'حذف دسته بندی محصول ' , ADMIN_PATH . '/shop/categories')->redirect();
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

    public function getChildCats()
    {
        $cat_id = $this->input->post('cat_id');

        $parentCat = Category::find($cat_id);

        if( !$parentCat ) {
            die(json_encode([ 'success' => 0 ]));
        }

        $data = $parentCat->children;
        echo json_encode([ 'success' => 1 , 'results' => $data ]);
        exit;
    }

}
