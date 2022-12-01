<?php

if ( ! defined('BASEPATH')) {
    exit('No direct script access allowed');
}
require_once __DIR__.'/County.php';
require_once __DIR__.'/Location_region.php';
require_once __DIR__.'/Location_neighbourhood.php';

use Illuminate\Database\Eloquent\Model as Model;

/**
 * Description of User
 *
 * @author Saeed
 */
class Province extends Model
{

    /**
     * {@inheritDoc}
     */
    protected $guarded = [];
    protected $table = 'province';
    public $timestamps = false;

    public function __construct(array $attributes = array())
    {
        parent::__construct($attributes);
    }

    public function user()
    {
        return $this->belongsTo('User');
    }

    public function regions()
    {
        return $this->hasMany('Location_region');
    }

    public function county()
    {
        return $this->hasMany('County');
    }

}
