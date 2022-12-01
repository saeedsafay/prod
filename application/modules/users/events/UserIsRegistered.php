<?php

use Symfony\Contracts\EventDispatcher\Event;

class UserIsRegistered extends Event
{
    public const NAME = 'user.registered';

    public $user;

    /**
     * UserLoggedIn constructor.
     * @param $user
     */
    public function __construct($user)
    {
        $this->user = $user;
    }
}