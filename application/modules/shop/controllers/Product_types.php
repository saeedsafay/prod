<?php
(defined('BASEPATH')) or exit('No direct script access allowed');

class Product_types extends Public_Controller
{

    public function __construct()
    {
        parent::__construct();
    }

    public function getCategories($productTypeSlug)
    {
        try {
            $productType = Product_type::where("slug", urldecode($productTypeSlug))
                ->with("mainCategories")
                ->firstOrFail();
        } catch (Throwable $e) {
            return show_404();
        }
        $this->smart->assign([
            "title" => "دسته بندی های ".$productType->title,
            "productType" => $productType

        ]);
        $this->smart->view("product_types/categories");
    }

    public function getSubCategories($categorySlug)
    {
        try {
            $category = Category::where("slug", urldecode($categorySlug))
                ->with("children", "product_type:id,title,slug,image")
                ->firstOrFail();
        } catch (Throwable $e) {
            return show_404();
        }
        $this->smart->assign([
            "title" => "دسته بندی های ".$category->title,
            "category" => $category,
            "related" => $this->getRelatedCategories($category)

        ]);
        $this->smart->view("product_types/subcategories");
    }

    protected function getRelatedCategories($category)
    {
        try {
            return Category::query()->where("product_type_id", $category->product_type_id)
                ->where("parent_id", null)
                ->whereKeyNot($category->id)
                ->take(5)
                ->get();
        } catch (Throwable $e) {
            log_message("error", $e->getMessage());
            return [];
        }
    }
}