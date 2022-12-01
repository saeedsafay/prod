<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Category of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 */
class Category extends EloquentModel
{


    protected $table = "product_categories";

    protected $guarded = ['id'];

    public function product()
    {
        return $this->hasMany('Product', 'product_category_id', 'id');
    }

    public function child_cat_products()
    {
        return $this->hasMany('Product', 'product_child_category_id', 'id');
    }


    public function parentCat()
    {
        return $this->belongsTo('Category', 'parent_id');
    }

    public function product_type()
    {
        return $this->belongsTo('Product_type', 'product_type_id', 'id');
    }

    public function grandparentCat()
    {
        return $this->belongsTo('Category', 'grandparent_id');
    }

    public function children()
    {
        return $this->hasMany('Category', 'parent_id');
    }

    public function grandchildren()
    {
        return $this->hasMany('Category', 'grandparent_id');
    }

    public function scopeParents($query)
    {
        return $query->where('parent_id', 0);
    }

    public function filters()
    {
        return $this->hasMany('Filter', 'product_child_category_id', 'id');
    }

    public function diversities()
    {
        return $this->hasMany('Diversity', 'product_child_category_id', 'id')
            ->orderBy("priority", "desc");
    }

    public static function findBySlug($slug)
    {
        return self::query()->where('slug', $slug)->with(['parentCat', 'product_type', 'filters'])->firstOrFail();
    }

    public function getLinkAttribute()
    {
        if ($this->parent_id) {
            return "product-type/{$this->product_type->slug}/category/{$this->parentCat->slug}/{$this->slug}";
        }
        return "subcategories/{$this->slug}";
    }

}
