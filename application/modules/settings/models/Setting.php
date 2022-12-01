<?php

use Illuminate\Database\Eloquent\Model as EloquentModel;

class Setting extends EloquentModel {

    protected $guarded = [''];


    public static function findByCode($code) {
        return self::where('code', $code)->first();
    }

    public static function setHomePage($HomePageID) {
        return Setting::where('code', 'homepage')->update(['value' => $HomePageID]);
    }

}
