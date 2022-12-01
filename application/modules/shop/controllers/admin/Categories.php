<?php

require_once APPPATH.'modules/shop/concerns/ProductConcerns.php';

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
            ['field' => 'title', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'عنوان'],
            ['field' => 'product_type_id', 'rules' => 'trim|numeric', 'label' => 'گروه کالایی'],
            ['field' => 'has_extra_fields', 'rules' => 'numeric|htmlspecialchars', 'label' => 'فیلدهای ثابت'],
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
        $prd_categories = Category::where("parent_id", null)->with("children")->orderBy('product_type_id',
            'desc')->get();
        $this->smart->assign(
            [
                'title' => 'دسته بندی محصول',
                'productCategories' => $prd_categories
            ]
        );
        $this->smart->view('category/index');
    }

    function edit($cat_id = null)
    {
        // Init
        $edit_mode = false;
        $set_product_type_id = null;
        if ($this->input->get("parent_id")) {
            try {
                $set_product_type_id = Category::query()->whereKey($this->input->get("parent_id"))->first()->product_type_id;
            } catch (Throwable $e) {
                redirect(ADMIN_PATH."/shop/categories");
            }
        }
        $this->smart->assign([
            'set_parent_id' => $this->input->get("parent_id"),
            'set_product_type_id' => $set_product_type_id,
            'edit_mode' => $edit_mode,
            'title' => 'دسته بندی محصول',
            'product_types' => Product_type::all(),
            'categories' => Category::all(),
        ]);
        // Edit Mode
        if ($cat_id) {
            $edit_mode = true;
            $category = Category::query()->findOrFail($cat_id);
            $this->smart->assign([
                'edit_mode' => $edit_mode,
                'Category' => $category
            ]);
        } else {
            $category = (new Category());
        }
        // Process Form
        if ($this->formValidate(false)) {
            if ($this->input->post('slug') === null) {
                $cat_slug = $this->input->post('title');
            } else {
                $cat_slug = $this->input->post('slug');
            }
            $productConcerns = new ProductConcerns($this);
            $category->forceFill([
                'title' => $this->input->post('title'),
                'product_type_id' => $this->input->post('product_type_id'),
                'desc' => $this->input->post('desc'),
                'desc_uri' => $this->input->post('desc_uri'),
                'banner_title' => $this->input->post('banner_title'),
                'parent_id' => $this->input->post('parent_id') ? $this->input->post('parent_id') : null,
                'variants_as_package' => $this->input->post('variants_as_package') ? $this->input->post('variants_as_package') : 0,
                'slug' => slug($cat_slug),
                'has_order_form' => 0,
            ]);
            if ( ! empty($_FILES['image']['name'])) {
                $oldPic = $category->image;
                $category->image = $this->input->imageFile('image', 'products/pic');
                unlink(PUBLICPATH.'upload/products/pic/'.$oldPic);
            }
            if ( ! empty($_FILES['banner']['name'])) {
                $oldPic = $category->banner;
                $category->banner = $this->input->imageFile('banner', 'categories');
                unlink(PUBLICPATH.'upload/categories/'.$oldPic);
            }
            if ($this->input->post('parent_id')) {
                if ($parent = Category::find($this->input->post('parent_id'))) {
                    if (isset($parent->parentCat->id)) {
                        $category->grandparent_id = $parent->parentCat->id;
                    }
                }
            }
            $category->save();
            if ($this->input->post('has_order_form')) {
                try {
                    $productConcerns->categoryVariantsPayLoad($category, 0);
                    $category->forceFill([
                        'has_order_form' => 1,
                    ])->saveOrFail();
                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد', 'success', 'ذخیره اطلاعات',
                        ADMIN_PATH.'/shop/categories')->redirect();
                } catch (Throwable $e) {
                    $this->message->set_message(
                        'اطلاعات دسته بندی ذخیره شد اما '.
                        'شرایط برای فعال سازی سفارش در سایت فراهم نیست. لطفا ابتدا محصول مربوطه به همراه مولفه های تنوع آن را وارد نمایید سپس بعد از درج اولین تنوع می توانید فرم سفارش را فعال کنید.',
                        'warning', 'فرم سفارش',
                        ADMIN_PATH.'/shop/categories/edit/'.$cat_id)->redirect();
                }
            }
            redirect(ADMIN_PATH.'/shop/categories');
        }
        $this->smart->view('category/edit');
    }

    function delete($cat_id = null)
    {
        if ($Category = Category::find($cat_id)) {
            if ($Category->delete()) {
                $this->message->set_message('دسته بندی مربوطه حذف گردید', 'success', 'حذف دسته بندی محصول ',
                    ADMIN_PATH.'/shop/categories')->redirect();
            }
        } else {
            show_404();
        }
    }

    public function getCategories()
    {
        $p_id = $this->input->get('product_type_id');

        $Product_type = Product_type::find($p_id);

        if ( ! $Product_type) {
            die(json_encode(['success' => 0]));
        }

        $data = $Product_type->categories()->where('parent_id', null)->get();
        echo json_encode(['success' => 1, 'results' => $data]);
        exit;
    }

    public function getChildCats()
    {
        $cat_id = $this->input->post('cat_id');

        $parentCat = Category::find($cat_id);

        if ( ! $parentCat) {
            die(json_encode(['success' => 0]));
        }

        $data = $parentCat->children;
        echo json_encode(['success' => 1, 'results' => $data]);
        exit;
    }

}
