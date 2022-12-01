<?php

(defined('BASEPATH')) or exit('No direct script access allowed');

require_once APPPATH.'modules/shop/concerns/SearchConcerns.php';

class Search extends Public_Controller
{


    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent([
            'Keyword',
            'users/User',
            'Search_log',
        ]);
    }


    public function search_result()
    {
        $query = $this->input->get('q');
        $cat_id = $this->input->get('cat_id');
        $this->load->eloquent('Search_log');
        if ($query !== "") {
            $Products = Product::search($query, $cat_id)->get();
        } else {
            $Products = collect([]);
        }

        $this->smart->assign(
            [
                'Products' => $Products->isEmpty() ? false : $Products,
                'title' => 'جستجو برای عبارت: '.$query,
                'q' => $query,
                'cat' => Category::find($cat_id)
            ]
        );
        Search_log::create([
            'ip' => $this->input->ip_address(),
            'user_id' => isset($this->user->id) ? $this->user->id : 0,
            'query' => $query,
        ]);
        $this->smart->view('search_results');
    }

    /**
     * Ajax search method
     */
    public function getResults()
    {
        $queryString = $this->input->get('query');
        if (in_array($queryString, $this->lang->line("filters"))) {
            return $this->output->jsonResponse([
                "data" => [
                    [
                        "title" => "کارت قشنگ نبود :(",
                        "slug" => "#",
                        "child_category" => ["title" => "بی ادبی"]
                    ]
                ],
                "trends" => []
            ]);
        }

        try {
            if ($queryString != "") {

                // if nothing found by the exact same string, try to find the matching strings
                $results = $this->searchConcerns->fuzzySearch($queryString);
                // searching for order forms products
                //                $results['order_form_data'] = $this->searchConcerns->fuzzySearch(
                //                    $queryString,
                //                    (new Product())->buildSearchQuery(Product::query()->where(['soft_delete' => 0, 'status' => 1])
                //                        ->whereHas('hidden')
                //                    )
                //                );
                // log the search query
                $this->searchConcerns->logSearch($queryString);
            } else {
                $results = ['did_you_mean' => false, 'data' => []];
            }

            return $this->output->jsonResponse([
                "did_you_mean" => $results['did_you_mean'],
                "data" => $results['data'],
                //                "order_form_data" => $results['order_form_data']['data'],
                "trends" => $this->searchConcerns->getTrends()
            ]);
        } catch (Throwable $e) {

            log_message("error", $e->getMessage());
            return $this->output->jsonResponse([
                "error" => "مشکلی پیش آمده لطفا مجددا تلاش کنید."
            ], 500);
        }
    }


    /**
     * @return bool
     */
    public function searchThematicCategories()
    {
        $queryString = $this->input->get('title');

        try {
            if ($queryString !== "") {
                $queryObject = (new Thematic_category())->select("id as thematic_category_id", "title");
                $thematicCategories = $this->searchConcerns->fuzzySearch($queryString, $queryObject);
                $this->searchConcerns->logSearch($queryString);
            } else {
                $thematicCategories = ['data' => [], 'did_you_mean' => false];
            }

        } catch (Throwable $e) {

            log_message("error", $e->getMessage());
            return $this->output->jsonResponse([
                "error" => "مشکلی پیش آمده لطفا مجددا تلاش کنید."
            ], 500);
        }

        return $this->output->jsonResponse([
            "data" => $thematicCategories['data'],
            'did_you_mean' => $thematicCategories['did_you_mean'],
        ]);
    }


}