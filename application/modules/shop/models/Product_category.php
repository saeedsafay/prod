<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

/**
 * Model: Category of products
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Product_category extends Category {

    public function __construct( array $attributes = array() )
    {
        parent::__construct($attributes);
    }

}
