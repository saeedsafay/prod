<?php

use Cartalyst\Sentinel\Activations\IlluminateActivationRepository as ActivationRepo;
use Cartalyst\Sentinel\Users\UserInterface as UserInterface;

class ActivationRepository extends ActivationRepo {

    function __construct ( $model = null , $expires = null ) {
        parent::__construct($model , $expires);
    }

    /**
     * {@inheritDoc}
     */
    public function init_code ( UserInterface $user , $mobile = false ) {

        $activation = $this->createModel();
        if ( $mobile ) {

            $code = $this->generateActivationCodeForMobile();
        }
        else {

            $code = $this->generateActivationCode();
        }

        $activation->fill(compact('code'));

        $activation->user_id = $user->getUserId();

        $activation->save();

        return $activation;
    }

    /**
     * Return a random string for an activation code.
     *
     * @return string
     */
    protected function generateActivationCodeForMobile () {
        return rand(1000 , 9999) . rand(52 , 95);
    }

}
