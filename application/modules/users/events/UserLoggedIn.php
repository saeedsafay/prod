<?php

use Symfony\Contracts\EventDispatcher\Event;

class UserLoggedIn extends Event
{
    public const NAME = 'user.logged.in';

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