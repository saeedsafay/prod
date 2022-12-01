<?php

use Cartalyst\Sentinel\Checkpoints\ThrottleCheckpoint;
use Cartalyst\Sentinel\Users\UserInterface;

class MirookThrottleCheckpoint extends ThrottleCheckpoint
{


    /**
     * Checks the throttling status of the given user.
     *
     * @param string $action
     * @param UserInterface|null $user
     * @return bool
     */
    protected function checkThrottling($action, UserInterface $user = null): bool
    {
        try {
            parent::checkThrottling($action, $user);
        } catch (Throwable $e) {

            $CI =& get_instance();
            $CI->message->set_message(' تعداد تلاش های شما در ورود ناموفق به حداکثر رسیده است. تا دقایقی دیگر مجددا تلاش نمایید', 'fail', ' ورود', '/users/login')->redirect();

            return false;
        }
        return true;
    }

}
