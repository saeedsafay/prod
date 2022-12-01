<?php

/**
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2020
 * @license     MIT License
 */

class Thematic_categories extends Admin_Controller
{

    public $validation_rules = array(
        'edit' => array(
            ['field' => 'title', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'عنوان'],
            ['field' => 'product_type_id', 'rules' => 'trim|numeric|required', 'label' => 'گروه کالایی'],
            ['field' => 'parent_id', 'rules' => 'trim|numeric', 'label' => 'والد'],
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Thematic_category');
        $this->load->eloquent('Product_type');
    }

    public function index()
    {
        $prd_categories = Thematic_category::where("parent_id",
            null)->with("childrenCategories")->orderBy('product_type_id',
            'desc')->get();
        $this->smart->assign(
            [
                'title' => 'دسته بندی موضوعی محصولات',
                'productCategories' => $prd_categories
            ]
        );
        $this->smart->view('thematic_category/index');
    }

    function edit($cat_id = null)
    {
        // Init
        $edit_mode = false;
        $set_product_type_id = null;
        if ($this->input->get("parent_id")) {
            try {
                $set_product_type_id = Thematic_category::query()->whereKey($this->input->get("parent_id"))->first()->product_type_id;
            } catch (Throwable $e) {
                redirect(ADMIN_PATH."/shop/thematic-categories");
            }
        }
        // Edit Mode
        if ($cat_id) {
            $edit_mode = true;
            $category = Thematic_category::find($cat_id);
            $this->smart->assign([
                'edit_mode' => $edit_mode,
                'thematicCategory' => $category
            ]);
            $all = Thematic_category::where('product_type_id', $category->product_type_id)->with("parents",
                "parent")->get();
        } else {
            $all = Thematic_category::with("parents",
                "parent")->get();
        }

        $titleArr = $this->recursiveParents($all);
        $this->smart->assign([
            'set_parent_id' => $this->input->get("parent_id"),
            'set_product_type_id' => $set_product_type_id,
            'edit_mode' => $edit_mode,
            'title' => 'دسته بندی موضوعی محصول',
            'product_types' => Product_type::all(),
            "titleArr" => $titleArr,
        ]);
        // Process Form
        if ($this->formValidate(false)) {
            $data = [
                'title' => $this->input->post('title'),
                'product_type_id' => $this->input->post('product_type_id'),
                'parent_id' => $this->input->post('parent_id') ? $this->input->post('parent_id') : null,
            ];

            // Insert or update data to the db
            // if inserted
            if (Thematic_category::updateOrCreate(['id' => $cat_id], $data)) {
                $this->message->set_message('اطلاعات با موفقیت ذخیره شد', 'success', 'ذخیره اطلاعات',
                    ADMIN_PATH.'/shop/thematic-categories')->redirect();
            }// else if insertion failed
            else {
                $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید', 'fail', 'خطا در ذخیره سازی',
                    ADMIN_PATH.'/shop/thematic-categories/edit')->redirect();
            }
            redirect(ADMIN_PATH.'/shop/thematic-categories');
        }
        $this->smart->view('thematic_category/edit');
    }

    function delete($cat_id = null)
    {
        if ($Thematic_category = Thematic_category::find($cat_id)) {
            if ($Thematic_category->delete()) {
                $this->message->set_message('دسته بندی مربوطه حذف گردید', 'success', 'حذف دسته بندی محصول ',
                    ADMIN_PATH.'/shop/thematic-categories')->redirect();
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

        $parentCat = Thematic_category::find($cat_id);

        if ( ! $parentCat) {
            die(json_encode(['success' => 0]));
        }

        $data = $parentCat->children;
        echo json_encode(['success' => 1, 'results' => $data]);
        exit;
    }

    /**
     * for creating recursive drop down options
     * @param $categories
     * @return mixed
     */
    private function recursiveParents($categories)
    {
        foreach ($categories as $category) {
            $titleArr[$category->id][$category->id] = $category->title;
            if ($category->parent) {
                $parent = $category->parents;
                while ($parent) {
                    $titleArr[$category->id][$parent->id] = $parent->title;
                    $parent = $parent->parent;
                }
            }
            ksort($titleArr[$category->id]);
        }
        return $titleArr;
    }

}
