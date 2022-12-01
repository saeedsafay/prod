<?php


class ProductsHandler
{

    protected $ci;

    public function __construct()
    {
        $this->ci = &get_instance();
    }

    /**
     * Get a list of products by the given parameters
     * @param  array  $params
     * @param  int  $page
     * @return mixed
     */
    public function getProducts($params = [], $page = 1)
    {
        $query = Product::query()->where('user_id', $this->ci->user->id)->where('soft_delete', 0);
        // applying filtering parameters
        if ($params['title']) {
            $query->where("title", 'like', '%'.$params['title'].'%');
        }
        if ($params['id']) {
            // possibly remove the string from the id
            if (preg_match('/([0-9]+)/', $params['id'], $matches)) {
                $id = $matches[0];
            } else {
                $id = $params['id'];
            }
            $query->whereKey(en_numbers($id));
        }
        if ($params['product_type']) {
            $query->whereHas('product_type', function ($q) use ($params) {
                return $q->where("title", 'like', '%'.$params['product_type'].'%');
            });
        }
        if ($params['category']) {
            $query->whereHas('category', function ($q) use ($params) {
                return $q->where("title", 'like', '%'.$params['category'].'%');
            })->orWhereHas('child_category', function ($q) use ($params) {
                return $q->where("title", 'like', '%'.$params['category'].'%');
            });
        }
        return $query
            ->with(['product_type:id,title', 'category:id,title', 'child_category:id,title'])
            ->orderBy('created_at', 'desc')
            ->paginate(config("per_page"), '*', 'page', $page)->setPath(set_path());
    }
}