<?php

(defined('BASEPATH')) or exit('No direct script access allowed');
require_once APPPATH."modules/shop/models/Product.php";

use FuzzyWuzzy\Fuzz;
use FuzzyWuzzy\Process;

class SearchConcerns
{

    private $ci;
    const STRING_MATCH_RATIO = 63;
    const STRING_MATCH_EXACT_RATIO = 89;
    const SEARCH_CACHE = 60 * 20;

    public function __construct($CI)
    {
        $this->ci = $CI;
    }

    private function getDataSorted($data, $sortBag, $column = 'title')
    {
        $sortedResults = [];
        foreach ($sortBag as $sort) {
            foreach ($data as $item) {
                if ($item[$column] == $sort['title']) {
                    $sortedResults[] = $item;
                }
            }
        }
        return $sortedResults;
    }


    /**
     * Fuzzy string matching for find the nearest result to the given query string
     * @param $queryString
     * @param  null  $searchQuery
     * @param  string  $column
     * @return mixed
     * @throws \Exception
     */
    public function fuzzySearch($queryString, $searchQuery = null, $column = 'title')
    {

        try {
            if ($cachedResult = cache(hash('sha256', $queryString))) {
                return $cachedResult;
            }
            $fuzz = new Fuzz();
            $process = new Process($fuzz);

            // Load the choices either from the cache or database
            if ( ! $searchQuery) {
                $model = new Product();
                $searchQuery = ($model->buildSearchQuery());
                if ( ! $cacheBagChoices = cache('products_bag')) {
                    $cacheBagChoices = cache_set('products_bag', $searchQuery->get()->toArray(), self::SEARCH_CACHE);
                }
            } else {
                if ( ! $cacheBagChoices = cache(md5($searchQuery->toSql()))) {
                    $cacheBagChoices = cache_set(md5($searchQuery->toSql()), $searchQuery->get()->toArray(),
                        self::SEARCH_CACHE);
                }
            }

            if ( ! $bag = cache('fuzzy_search_bag')) {
                $bag = [];
                // TODO performance improvement is needed
                foreach ($cacheBagChoices as $choice) {
                    $bag[] = $choice[$column];
                    //$bag[] = $choice->product_title_en;
                }
                $bag = cache_set('fuzzy_search_bag', array_unique($bag), self::SEARCH_CACHE);
            }

            $results = $process->extractBests($queryString, $bag, null, null, self::STRING_MATCH_EXACT_RATIO, 10);

            if ($results->count()) {
                $hasExactItem = true;
            } else {
                $results = $process->extractBests($queryString, $bag, null, null, self::STRING_MATCH_RATIO, 10);
                $hasExactItem = false;
            }

            $where = [];
            foreach ($results as $result) {
                $where[] = $result[0];
            }
            $data = $searchQuery->whereIn('title', $where)->take(10)->get();

            //appending the slug to the results. see Product::getLinkAttribute() for more
            foreach ($data as $value) {
                $value->slug = $value->link;
            }

            $response = ['data' => $data, 'did_you_mean' => ! $hasExactItem && count($data)];
            cache_set(hash('sha256', $queryString), $response, self::SEARCH_CACHE * 10);

            return $response;
        } catch (Throwable $e) {
            log_message("error", $e->getMessage()."\n".$e->getTraceAsString());
            throw $e;
        }
    }


    /**
     * @return mixed
     * @throws \Exception
     */
    public function getTrends()
    {
        try {
            return Search_log::selectRaw('query,COUNT(query) as searchedCount')
                ->groupBy('query')->orderBy('searchedCount', 'desc')->take(4)->get();
        } catch (Throwable $e) {
            log_message("error", $e->getMessage()."\n".$e->getTraceAsString());
            throw $e;
        }
    }


    /**
     * @param $queryString
     * @return \Illuminate\Database\Eloquent\Builder|\Illuminate\Database\Eloquent\Model
     * @throws \Exception
     */
    public function logSearch($queryString)
    {

        try {
            return Search_log::query()->updateOrCreate([
                'ip' => $this->ci->input->ip_address(),
                ['created_at', ">", date("Y-m-d H:i:s", strtotime("-1 minutes"))]
            ],
                [
                    'ip' => $this->ci->input->ip_address(),
                    'user_id' => isset($this->ci->user->id) ? $this->ci->user->id : 0,
                    'query' => $queryString,
                ]);
        } catch (Throwable $e) {
            log_message("error", $e->getMessage()."\n".$e->getTraceAsString());
            throw $e;
        }
    }
}