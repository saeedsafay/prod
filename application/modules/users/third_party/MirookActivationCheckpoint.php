<?php

use Cartalyst\Sentinel\Checkpoints\ActivationCheckpoint;
use Cartalyst\Sentinel\Users\UserInterface;

class MirookActivationCheckpoint extends ActivationCheckpoint
{

    /**
     * Checks the throttling status of the given user.
     *
     * @param UserInterface|null $user
     * @return bool
     */
    protected function checkActivation(UserInterface $user = null): bool
    {
        try {
            parent::checkActivation($user);
        } catch (Throwable $e) {
            $link = '<br><a class="link_form btn btn-color btn-lg" data-toggle="modal" data-target="#forgotPassModal" href="#">فعالسازی مجدد! </a>';
            $CI = &get_instance();
            $message = 'کاربر گرامی، حساب شما در حال حاضر غیرفعال است. برای فعال‌سازی حسابتان لطفا دکمه ارسال مجدد کد را بزنید.';
            $CI->message->set_message($message . $link, 'fail', ' ورود', '/users/login')->redirect();
        }

        return true;
    }

}
