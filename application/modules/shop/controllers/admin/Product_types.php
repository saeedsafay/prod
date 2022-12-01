<?php

//use \Cviebrock\EloquentSluggable\Services\SlugService;

/**
 * Controller: Product_types for products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Product_types extends Admin_Controller
{

    public $validation_rules = array(
        'edit' => array(
            ['field' => 'title', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'عنوان'],
            ['field' => 'slug', 'rules' => 'htmlspecialchars|required', 'label' => 'آدرس لینک سئو'],
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Product_type');
    }

    public function index()
    {
        $data = array();
        $prd_types = Product_type::all();
        $this->smart->assign(
            [
                'title' => 'گروه‌های کالایی',
                'Product_types' => $prd_types
            ]
        );
        $this->smart->view('product_type/index');
    }

    function edit($type_id = null)
    {
        // Init
        $edit_mode = false;

        $this->smart->assign([
            'edit_mode' => $edit_mode,
            'title' => 'گروه کالایی',
        ]);

        // Edit Mode 
        if ($type_id) {
            $edit_mode = true;
            $this->smart->assign([
                'edit_mode' => $edit_mode,
                'Product_type' => Product_type::find($type_id)
            ]);
        }
        // Process Form
        if ($this->formValidate(false)) {
            $data = [
                'title' => $this->input->post('title'),
                'slug' => slug($this->input->post('slug')),
                'descriptions' => $this->input->post('descriptions'),
                'hidden_from_nav' => $this->input->post('hidden_from_nav'),
                'order_in_menu' => $this->input->post('order_in_menu'),
            ];
            if ( ! empty($_FILES['image']['name'])) {
                $data['image'] = $this->input->imageFile('image', 'product-types/pic');
            }

            // Insert or update data to the db
            // if inserted
            if ($Product_type = Product_type::updateOrCreate(['id' => $type_id], $data)) {
                if ( ! $edit_mode) {
                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد', 'success', 'ثبت رکورد جدید',
                        ADMIN_PATH.'/shop/product-types')->redirect();
                } else {
                    $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد', 'success', 'بروزرسانی',
                        ADMIN_PATH.'/shop/product-types')->redirect();
                }
            }// else if insertion failed
            else {
                if ($edit_mode) {
                    $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید', 'fail', 'خطا در ذخیره سازی',
                        ADMIN_PATH.'/shop/product-types')->redirect();
                } else {
                    $this->message->set_message('بروزرسانی انجام نشد. مجدد تلاش کنید', 'fail', 'خطا در  بروزسانی',
                        ADMIN_PATH.'/shop/product-types/edit')->redirect();
                }
            }
            redirect(ADMIN_PATH.'/shop/product-types');
        }
        $this->smart->view('product_type/edit');
    }

    function delete($type_id = null)
    {

        $this->message->set_message('حذف گروه کالایی', 'success', 'حذف گروه کالایی در حال حاضر امکان پذیر نیست. ',
            ADMIN_PATH.'/shop/product-types')->redirect();
        return;
        if ($Product_type = Product_type::find($type_id)) {
            if ($Product_type->delete()) {
                $this->message->set_message('گروه کالایی مربوطه حذف گردید', 'success', 'حذف گروه کالایی ',
                    ADMIN_PATH.'/shop/product-types')->redirect();
            }
        } else {
            show_404();
        }
    }

}
