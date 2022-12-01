<?php

if ( ! defined('BASEPATH')) {
    exit('No direct script access allowed');
}

use Illuminate\Database\Eloquent\Model as Model;

class Newsletter extends Model
{

    /**
     * {@inheritDoc}
     */
    protected $table = 'newsletter';
    protected $guarded = ['id'];
    protected $hidden = ['token'];

    public function user()
    {
        return $this->belongsTo('User');
    }

}
