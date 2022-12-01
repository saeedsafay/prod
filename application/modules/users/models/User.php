<?php

use Cartalyst\Sentinel\Users\EloquentUser as EloquentUser;

require_once FCPATH.'application/modules/shop/models/Product.php';
require_once MODULE_PATH.'shop/models/Order.php';
require_once FCPATH.'application/modules/users/models/User_address.php';

/**
 * Description of User
 *
 * @author Saeed
 */
class User extends EloquentUser
{

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $guarded = [
        "id"
    ];

    protected $hidden = [
        'password'
    ];

    protected $fillable = [
        "mobile",
        "username",
        'email',
        'password',
        'last_name',
        'first_name',
        'permissions',
        'token',
        'status',
        'address',
        'business_name',
        'sex',
        'last_login',
        'created_at',
        'updated_at',
    ];
    /**
     * Array of login column names.
     *
     * @var array
     */
    protected $loginNames = ['mobile', 'username'];

    public function __construct(array $attributes = array())
    {
        parent::__construct($attributes);
    }

    public function profile()
    {
        return $this->hasOne('User_profile', 'user_id');
    }

    public function contact()
    {
        return $this->hasOne('User_contact', 'user_id');
    }

    public function certificate()
    {
        return $this->hasOne('User_cert', 'user_id');
    }

    public function location()
    {
        return $this->hasOne('User_address', 'user_id');
    }

    public function reagent()
    {
        return $this->hasOne('Reagent', 'user_id');
    }

    public function subset_users()
    {
        return $this->hasMan('Reagent', 'invited_user_id', 'id');
    }

    public function photo()
    {
        return $this->hasOne('User_photo', 'user_id');
    }

    public function sales()
    {
        return $this->hasMany('Order', 'shop_id', 'id');
    }

    public function products()
    {
        return $this->hasMany('Product');
    }

    public function getFullNameAttribute()
    {
        return $this->first_name.' '.$this->last_name;
    }

    public function aff()
    {
        return $this->hasOne("AffiliatesPro", "user_id", "id");
    }

    public static function getShops($params, $limit = 0, $offset = 0)
    {
        $query = self::where(['status' => 1])->whereNotNull('business_name');
        if ($params['province_id']) {
            $query->whereHas('location', function ($query) use ($params) {
                $query->where('province_id', $params['province_id'])->orderBy('updated_at', 'desc');
            });
        }
        if ($params['county_id']) {
            $query->whereHas('location', function ($query) use ($params) {
                $query->where('county_id', $params['county_id'])->orderBy('updated_at', 'desc');
            });
        }
        if ($params['region_id']) {
            $query->whereHas('location', function ($query) use ($params) {
                $query->where('region_id', $params['region_id'])->orderBy('updated_at', 'desc');
            });
        }
        if ($params['neighbourhood_id']) {
            $query->whereHas('location', function ($query) use ($params) {
                $query->where('neighbourhood_id', $params['neighbourhood_id'])->orderBy('updated_at', 'desc');
            });
        }
        if (isset($params['business_name'])) {
            $query->where('business_name', 'like', '%'.$params['business_name'].'%')->orderBy('updated_at', 'desc');
        }

        if ( ! empty($params['coordinates'])) {
            $query->where('lat', '>=', $params['coordinates']['min_lat'])->where('lat', '<=',
                $params['coordinates']['max_lat'])->where('long', '>=', $params['coordinates']['min_lon'])->where('lat',
                '<=', $params['coordinates']['max_lon']);
        }

        if ($limit) {
            $shops = array(
                'requested' => $query->take($limit)
                    ->skip($offset)
                    ->orderBy('edited_product_time', 'desc')
                    ->get(),
                'total' => $query->get(),
            );
        } else {
            $shops = array(
                'requested' => $query
                    ->orderBy('edited_product_time', 'desc')
                    ->get(),
                'total' => $query->get(),
            );
        }
        return $shops;
    }

}
