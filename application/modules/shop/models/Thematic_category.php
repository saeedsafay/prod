<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2020
 * @license     MIT License
 */
class Thematic_category extends EloquentModel
{

    /**
     *
     * @var string
     */
    protected $table = "product_thematic_category";
    protected $guarded = [''];
    public $timestamps = false;

    public function products()
    {
        return $this->belongsToMany('Product', 'product_has_thematic_categories',
            'thematic_category_id', 'product_id');
    }

    public function parent()
    {
        return $this->belongsTo('Thematic_category', 'parent_id');
    }

    public function parents()
    {
        return $this->belongsTo('Thematic_category', 'parent_id')->with("parent");
    }

    public function product_type()
    {
        return $this->belongsTo('Product_type', 'product_type_id', 'id');
    }

    public function children()
    {
        return $this->hasMany('Thematic_category', 'parent_id');
    }

    public function childrenCategories()
    {
        return $this->hasMany('Thematic_category', 'parent_id')->with('children');
    }


    /**
     * @param $query
     * @param $search
     * @return mixed
     */
    public function scopeSearch($query, $search)
    {

        $query = $query->select("id as thematic_category_id", "title");

        $search = explode(" ", $search);

        return $query
            ->where(function ($query) use ($search) {
                foreach ($search as $string) {
                    $query->where('title', 'like', '%'.$string.'%');
                }
            });
    }
}
