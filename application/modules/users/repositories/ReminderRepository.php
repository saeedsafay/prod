<?php

use Cartalyst\Sentinel\Reminders\IlluminateReminderRepository as ReminderRepo;
use Cartalyst\Sentinel\Users\UserInterface;
use Cartalyst\Sentinel\Users\UserRepositoryInterface;

class ReminderRepository extends ReminderRepo
{

    function __construct(UserRepositoryInterface $users, $model = null, $expires = null)
    {
        parent::__construct($users, $model, $expires);
    }

    /**
     * {@inheritDoc}
     */
    public function init_code(UserInterface $user, $mobile = false)
    {

        $reminder = $this->createModel();
        if ($mobile) {

            $code = $this->generateReminderCodeForMobile();
        } else {

            $code = $this->generateReminderCode();
        }

        $reminder->fill([
            'code' => $code,
            'completed' => false,
        ]);

        $reminder->user_id = $user->getUserId();

        $reminder->save();

        return $reminder;
    }

    /**
     * Return a random string for an activation code.
     *
     * @return string
     */
    protected function generateReminderCodeForMobile()
    {
        return rand(1000, 9999).rand(52, 95);
    }

}
