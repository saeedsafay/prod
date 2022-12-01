<?php

if ( ! defined('BASEPATH')) {
    exit('No direct script access allowed');
}

use Illuminate\Database\Eloquent\Model as Model;

require_once __DIR__."/Province.php";

/**
 * Description of User
 *
 * @author Saeed
 */
class User_address extends Model
{

    /**
     * {@inheritDoc}
     */
    protected $guarded = [];
    protected $table = 'users_address';
    public $timestamps = false;

    public function __construct(array $attributes = array())
    {
        parent::__construct($attributes);
    }

    public function user()
    {
        return $this->belongsTo('User');
    }

    public function province()
    {
        return $this->belongsTo('Province', 'province_id', 'id');
    }

    public function county()
    {
        return $this->belongsTo('County', 'county_id', 'id');
    }

    public function scopeUser($query, $userId)
    {
        return $query->where("user_id", $userId)->whereNull('deleted_at');
    }

}
