<?php

(defined('BASEPATH')) or exit('No direct script access allowed');

/**
 * Public user controller [Frontend]
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2021
 */
class Users extends Public_Controller
{

    public $validation_rules = array(
        'login' => array(
            [
                'field' => 'username',
                'rules' => 'trim|required|htmlspecialchars',
                'label' => 'شماره همراه یا شناسه کاربری'
            ],
            ['field' => 'password', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'کلمه عبور']
        ),
        'changepass' => array(
            ['field' => 'newpass', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'رمز عبور جدید'],
        ),
        'register' => array(
            ['field' => 'password', 'rules' => 'trim|required', 'label' => 'کلمه عبور'],
            [
                'field' => 'mobile',
                'rules' => 'trim|required|callback_mobile_numbers_validation',
                'label' => 'شماره همراه'
            ],
            ['field' => 'first_name', 'rules' => 'trim|required', 'label' => 'نام'],
            ['field' => 'last_name', 'rules' => 'trim|required', 'label' => 'نام خانوادگی'],
            ['field' => 'policy', 'rules' => 'trim|required', 'label' => 'نام خانوادگی'],
        ),
        'forgot_password' => array(
            ['field' => 'email', 'rules' => 'trim|htmlspecialchars|required|valid_email', 'label' => 'شناسه کاربری'],
        ),
        'resetPassword' => array(
            [
                'field' => 'mobile',
                'rules' => 'trim|htmlspecialchars|required|callback_mobile_numbers_validation',
                'label' => 'شماره موبایل'
            ],
        ),
    );

    function __construct()
    {
        parent::__construct();
        $this->load->sentinel();
        $this->load->eloquent('User');
        $this->load->eloquent('settings/Setting');
        $this->load->library('email');
    }

    /**
     * ورود به حساب کاربری و لاگین کاربر
     * @param $seller
     * @param  null  $reagent
     */
    function login($seller = false, $reagent = null)
    {

        // If redirect session var set redirect to home page
        $redirect_to = $this->session->userdata('requested_url');
        if ( ! $redirect_to) {
            $redirect_to = $this->input->get('requested_url') ? $this->input->get('requested_url') : '/';
        }
        if ($seller == 'seller') {
            $redirect_to = 'dashboard';
            $this->smart->load('ModernDashboard');
            $this->smart->setLayout("outer_layout");
        }
        // If user is already logged in redirect to desired location
        if ($this->sentinel->check()) {
            redirect($redirect_to);
        }

        $this->smart->assign(array('title' => 'ورود به حساب کاربری'));
        // Form Validation & Process Form
        if ($this->formValidate()) {
            load_events('users', 'UserLoggedIn');
            $login = $this->input->post('username');
            $password = $this->input->post('password');
            $remember = (bool)$this->input->post('remember_me');

            if ($this->sentinel->authenticate([
                'mobile' => $login,
                'password' => $password
            ], $remember)) {
                if ($this->uri->segment(1) == ADMIN_PATH) {
                    redirect(site_url(ADMIN_PATH));
                } else {
                    event(new UserLoggedIn($this->sentinel->getUser(false)));

                    redirect($redirect_to);
                }
            } elseif ($user = $this->sentinel->authenticate([
                'username' => $login,
                'password' => $password
            ], $remember)) {
                if ($this->uri->segment(1) == ADMIN_PATH) {
                    redirect(site_url(ADMIN_PATH));
                } else {

                    event(new UserLoggedIn($this->sentinel->getUser(false)));
                    redirect($redirect_to);
                }
            } else {
                $this->message->set_message('شماره موبایل یا رمز عبور اشتباه است', 'fail', 'ورود به حساب کاربری',
                    'users/login')->redirect();
            }
        } else {
            $this->session->set_flashdata("error", validation_errors());
        }
        // If the user was attempting to log into the admin panel use the admin theme
        if ($this->uri->segment(1) == ADMIN_PATH) {
            $this->smart->assign(array('title' => 'ورود به پنل مدیریتی'));
            $this->smart->load('default', true);
            $this->smart->setLayout('login_layout');
            $this->smart->view("login");
        } else {
            $this->smart->assign([
                'reagent_param' => $reagent,
                'error' => $this->session->flashdata("error")
            ]);
            if ($seller == 'seller') {
                $this->smart->view("seller/seller_login");
            } else {
                $this->smart->view("loginregister");
            }
        }
    }

    /**
     * ثبت نام کاربر با استفاده از تایید شماره موبایل
     */
    public function register()
    {
        if ( ! $this->input->post('policy')) {
            return $this->output->jsonResponse(['errors' => "گزینه قبول شرایط و قوانین را تیک بزنید"], 422);
        }

        if ( ! $this->formValidate()) {
            return $this->output->jsonResponse(['errors' => validation_errors()], 422);
        }

        $credentials = ['mobile' => $this->input->post('mobile')];
        $user = $this->sentinel->getUserRepository()->where($credentials)->first();

        if (isset($user)) {
            if ($user->status == 0) {
                return $this->sendActivationSMS($user, $user->token);
            } else {
                return $this->output->jsonResponse(
                    ['errors' => "شماره موبایل وارد شده در حال حاضر ثبت نام شده است."],
                    422);
            }
        }

        $token = random_string('alnum', 32);
        $credentials = [
            'mobile' => $this->input->post('mobile'),
            'username' => $this->input->post('mobile'),
            'first_name' => $this->input->post('first_name'),
            'last_name' => $this->input->post('last_name'),
            'password' => $this->input->post('password'),
            'token' => $token,
            'status' => 0,
        ];
        //register user
        if ($this->sentinel->validForCreation($credentials)) {

            try {
                $user = $this->sentinel->register($credentials);
                // Buyer role
                $user->roles()->sync(array(3));

                return $this->sendActivationSMS($user, $token);
            } catch (Throwable $e) {
                log_exception($e);
                return $this->output->jsonResponse(['errors' => 'مشکل در ثبت نام. لطفا به پشتیبانی اطلاع دهید.'], 500);
            }
        }
    }

    private function sendActivationSMS($user, $token)
    {
        //creating activation row for user
        $activation = $this->sentinel->getActivationRepository()->init_code($user, true);
        $sms = new Sms($user->mobile);
        try {
            if ($sms->send(
                [
                    "Parameter" => "VerificationCode",
                    "ParameterValue" => $activation->code
                ]
            )) {
                return $this->output->jsonResponse(['token' => $token]);
            } else {
                return $this->output->jsonResponse(['errors' => 'مشکل در ارسال پیامک'], 422);
            }
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse(['errors' => 'مشکل در ارسال پیامک'], 422);
        }
    }

    /**
     * Activate user mobile after user registration
     * @return bool
     */
    function activateMobile()
    {
        $activation_code = $this->input->post('code');
        $token = $this->input->post('token');
        load_events('users', 'UserLoggedIn');
        if ( ! $token) {
            return $this->output->jsonResponse(['errors' => 'درخواست نامعتبر'], 422);
        }
        if ( ! $activation_code) {
            return $this->output->jsonResponse(['errors' => 'کد فعال‌سازی را وارد نمایید .'], 422);
        }

        if ( ! $user = $this->sentinel->getUserRepository()->where(['token' => $token])->first()) {
            return $this->output->jsonResponse(['errors' => 'کاربر در سیستم ثبت نشده است'], 422);
        }

        try {
            $activation = $this->sentinel->getActivationRepository()->exists($user);
            if ( ! $activation) {
                return $this->output->jsonResponse(['errors' => 'کد تایید صحیح نیست'], 422);
            }
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse(['errors' => 'مشکل در ثبت نام. لطفا به پشتیبانی اطلاع دهید.'], 500);
        }

        try {
            if ($this->sentinel->getActivationRepository()->complete($user, $activation_code)) {
                $user->update(['status' => 1]);
                if ($this->sentinel->login($user)) {

                    load_events('users', 'UserIsRegistered');
                    event(new UserIsRegistered($this->sentinel->getUser(false)));
                    event(new UserLoggedIn($this->sentinel->getUser(false)));
                    return $this->output->jsonResponse([
                        'message' => 'ثبت نام با موفقیت انجام شد',
                        'redirect_url' => $this->session->userdata('requested_url')
                    ],
                        200);
                } else {
                    return $this->output->jsonResponse(['message' => 'ثبت نام با موفقیت انجام شد. می توانید به حساب کاربری خود وارد شوید'],
                        200);
                }
            } else {
                return $this->output->jsonResponse(['errors' => 'کد تایید صحیح نیست'], 422);
            }
        } catch (Throwable $e) {
            log_message("error", $e->getMessage());
            return $this->output->jsonResponse(['errors' => 'مشکل در ثبت نام. لطفا به پشتیبانی اطلاع دهید.'], 500);
        }
    }


    /**
     * Reset password by mobile. send sms
     * @return bool
     * @throws \Throwable
     */
    public function resetPassword()
    {
        $mobile = $this->input->post('mobile');
        if ( ! $mobile || $mobile == "") {
            return $this->output->jsonResponse([
                'errors' => 'شماره موبایل را وارد کنید'
            ], 422);
        }

        $user = $this->sentinel->getUserRepository()->where(['mobile' => $mobile])->first();
        if ( ! $user):
            return $this->output->jsonResponse([
                'errors' => 'کاربر یافت نشد'
            ], 422);
        endif;
        try {
            $token = random_string('alnum', 32);
            $reminder = $this->sentinel->getReminderRepository();
            $exist = $reminder->exists($user);
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse(['errors' => $e->getMessage()], 500);
        }
        // Check if reminder code already exist for user, if not so create reminder first
        if ( ! $exist) {
            $newReminder = $reminder->init_code($user, true);
            $verificationCode = $newReminder->code;
        } else {
            $verificationCode = $exist->code;
        }

        // send reminder code to the user mobile number
        $sms = new Sms($user->mobile);
        if ($sms->send(
            [
                "Parameter" => "VerificationCode",
                "ParameterValue" => $verificationCode
            ],
            Sms::FORGOT_VERIFICATION_ID
        )) {
            $user->update(array('token' => $token));
            return $this->output->jsonResponse(['token' => $token]);
        } else {
            return $this->output->jsonResponse(['errors' => 'مشکل در ارسال پیامک. مجدد تلاش کنید'], 500);
        }
    }


    /**
     * set reminder and reset password by email
     */
    public function resetPasswordByCode()
    {
        $reminder_code = $this->input->post('code');
        $password = $this->input->post('password');
        $token = $this->input->post('token');

        $user = $this->sentinel->getUserRepository()->where(['token' => $token])->first();

        $reminder = $this->sentinel->getReminderRepository();

        if ( ! $reminder->exists($user, $reminder_code)) {
            return $this->output->jsonResponse(
                ['errors' => 'کد بازیابی نامعتبر است'],
                422
            );
        }

        if ( ! $reminder->complete($user, $reminder_code, $password)) {
            return $this->output->jsonResponse(
                ['errors' => 'عملیات ناموفق. مجدد تلاش کنید'],
                500
            );
        }

        // full activate user
        $activationModel = $this->sentinel->getActivationRepository()->where('user_id', $user->id)->first();
        $activationModel->update(['completed' => 1]);

        if ($this->sentinel->login($user)) {
            return $this->output->jsonResponse(['message' => 'رمز عبور حساب شما با موفقیت تغییر یافت']);
        } else {
            return $this->output->jsonResponse(
                ['message' => 'رمز عبور حساب شما با موفقیت تغییر یافت. می توانید به حساب کاربری خود وارد شوید'],
                200);
        }
    }

    public function changepass()
    {
        if ($this->formValidate()) {
            //تغییر رمز عبور
            if ($this->input->post('newpass')) {
                if ($this->input->post('newpass') == $this->input->post('password_confirm')) {
                    $reminder = $this->sentinel->getReminderRepository()->create($this->user);
                    $this->sentinel->getReminderRepository()->complete($this->user, $reminder->code,
                        $this->input->post('newpass'));
                    $this->message->set_message('رمزعبور با موفقیت تغییر یافت.', 'success', 'تغییر رمزعبور',
                        'users/changepass')->redirect();
                } else {
                    $this->message->set_message('رمزعبور و تایید رمزعبور یکسان نیست.', 'warning', 'تغییر رمزعبور',
                        'users/changepass')->redirect();
                }
            }
        } else {
            $this->smart->assign([
                'title' => 'تغییر رمزعبور',
            ]);
            $this->smart->load('Dashboard');
            $this->smart->view('changepass');
        }
    }

    /**
     * ویرایش اطلاعات حساب کاربری و پروفایل
     */
    public function editprofile()
    {
        $this->checkAuth(true);
        $this->load->eloquent('User_contact');
        $this->load->eloquent('User_profile');
        $this->load->eloquent('Province');
        $this->load->eloquent('City');
        $this->load->eloquent('County');
        $this->load->eloquent('User_address');
        $this->load->eloquent('User_photo');
        $User = User::find($this->user->id);
        $this->smart->assign(array(
                'title' => 'ویرایش اطلاعات حساب کاربری',
                'User' => $User,
            )
        );
        if ($this->input->post('submitbtn')) {
            if ($this->formValidate()) {
                $credentials = [
                    "business_name" => $this->input->post('business_name'),
                    "first_name" => $this->input->post('first_name'),
                    "last_name" => $this->input->post('last_name'),
                    "sex" => $this->input->post('sex'),
                    "email" => $this->input->post('email'),
                    "lat" => $this->input->post('lat'),
                    "long" => $this->input->post('long'),
                ];
                $contact = [
                    'website' => $this->input->post('website'),
                    'instagram' => $this->input->post('instagram'),
                    'telegram' => $this->input->post('telegram'),
                    'tell' => $this->input->post('tell'),
                ];
                $User->contact()->updateOrCreate(array('user_id' => $this->user->id), $contact);
                $address = [
                    'title' => $this->input->post('address_title'),
                    'province_id' => $this->input->post('province_id'),
                    'county_id' => $this->input->post('county_id'),
                    'region_id' => $this->input->post('region_id'),
                    'neighbourhood_id' => $this->input->post('neighbourhood_id'),
                    'full_address' => $this->input->post('full_address'),
                ];
                $User->location()->updateOrCreate(array('user_id' => $this->user->id), $address);


                if ( ! empty($_FILES['shop_photo']['name'])) {
                    $profilePhotos[]['image'] = $this->input->imageFile('shop_photo', 'users');
                }

                if ( ! empty($_FILES['shop_photo2']['name'])) {
                    $profilePhotos[]['image2'] = $this->input->imageFile('shop_photo2', 'users');
                }

                if ( ! empty($_FILES['shop_photo3']['name'])) {
                    $profilePhotos[]['image3'] = $this->input->imageFile('shop_photo3', 'users');
                }

                if ( ! empty($_FILES['shop_photo4']['name'])) {
                    $profilePhotos[]['image4'] = $this->input->imageFile('shop_photo4', 'users');
                }

                if ( ! empty($_FILES['shop_photo5']['name'])) {
                    $profilePhotos[]['image5'] = $this->input->imageFile('shop_photo5', 'users');
                }

                if ( ! empty($_FILES['shop_photo6']['name'])) {
                    $profilePhotos[]['image6'] = $this->input->imageFile('shop_photo6', 'users');
                }

                foreach ($profilePhotos as $photo):
                    $User->photo()->updateOrCreate(array('user_id' => $this->user->id), $photo);
                endforeach;
                $profileData = [
                    'image_slide1' => $this->input->post('picHidden1'),
                    'image_slide2' => $this->input->post('picHidden2'),
                    'image_slide3' => $this->input->post('picHidden3'),
                    'logo' => $this->input->post('picHidden4'),
                    'introduction' => $this->input->post('introduction'),
                    'description' => $this->input->post('description'),
                ];
                if ( ! empty($_FILES['video']['name'])) {
                    $profileData['video'] = $this->input->videoFile('video', 'users');
                }
                $profileData['video_desc'] = $this->input->post('video_desc');
                $User->profile()->updateOrCreate(array('user_id' => $this->user->id), $profileData);

                //بروزرسانی اطلاعات وارد شده توسط کاربر
                if ($User->update($credentials)) {

                    $this->message->set_message('اطلاعات شما با موفقیت بروزرسانی شد', 'success',
                        'ویرایش اطلاعات حساب کاربری', 'dashboard')->redirect();
                } else {
                    $this->message->set_message('ویرایش با مشکل مواجه شد. مجدد تلاش کنید', 'fail',
                        'ویرایش اطلاعات حساب کاربری', 'users/editprofile')->redirect();
                }
            } else {
                $this->message->set_message('خطا در داده های ورودی. '.validation_errors(), 'fail',
                    ' ویرایش اطلاعات حساب کاربری', 'users/editprofile');
            }
        }
        $this->smart->load('Dashboard');
        if ($this->user->type == 1) {
            $this->smart->assign(array(
                    'Provinces' => Province::all(),
                )
            );
            $this->smart->view("editProfile");
        } else {
            $this->smart->view("editProfileBuyer");
        }
    }

    /**
     * خروج از حساب کاربری
     */
    public function logout()
    {
        if ($user = $this->sentinel->check()) {
            $this->sentinel->logout($user);
            if ($this->uri->segment(1) == ADMIN_PATH) {
                redirect(ADMIN_PATH.'/users/login');
            } else {
                redirect('users/login');
            }
        } else {
            redirect('/');
        }
    }

    /**
     * ّthis method, create a reminder and send the reminder code for user by email,
     * then user must use the new code for set the new password
     * NOTE: this function works for admin side
     */
    function forgot_password()
    {
        $this->load->repository('ReminderRepository');
        // If user was in admin panel load admin view
        if ($this->uri->segment(1) == ADMIN_PATH) {

            if ($this->formValidate(false)) {
                $email = $this->input->post('email');
                $User = $this->sentinel->getUserRepository();
                $User = $User->findByCredentials(['email' => $email]);
                $Reminder = new Mirook\Users\Reminders\ReminderRepository($User);
                // Create reminders
                if ($User) {
                    // Check if reminder code already exist for user, if not so create reminder first
                    if ( ! $this->sentinel->getReminderRepository()->exists($User)) {
                        $new_reminder = $Reminder->create($User);
                        // send reminder code to the user mobile number
                        if ($this->__sendSmsReminder($User, $new_reminder)) {
                            $this->message->set_message('کد اعتبارسنجی به شماره همراه شما ارسال شد. لطفا کد مربوطه را در فیلد زیر وارد کنید',
                                'success', 'تغییر رمز عبور',
                                ADMIN_PATH.'/users/users/resetPasswordBySms/'.$User->id)->redirect();
                        }
                    } else {
                        $this->message->set_message('لطفا کد ارسال شده به تلفن همراه خود را در فیلد زیر وارد کنید',
                            'success', 'تغییر رمز عبور',
                            ADMIN_PATH.'/users/users/resetPasswordBySms/'.$User->id)->redirect();
                    }
                }
            }

            $this->smart->assign(array('title' => 'ورود به پنل مدیریتی'));
            $this->smart->setLayout('login_layout');
            $this->smart->load('default', true);
            $this->smart->view("admin/login");
        } else {
            $this->smart->view("users/forgot_password");
        }
    }


    public function __sendEmailReminder($User, $Reminder)
    {

        $site_name = Setting::findByCode('site_name')->value;
        $this->load->library('email');
        $domain_name = getDomain();
        $this->email->from('noreply@'.$domain_name);
        $this->email->to($User->email);
        $this->email->subject('بازیابی کلمه عبور');
        $mail_message = "برای بازیابی کلمه عبور حسابتان در وب سایت $site_name  ، از لینک زیر استفاده نمایید\n".site_url('users/resetPasswordByEmail/'.$User->id.'/'.$Reminder->code);
        $this->email->message($mail_message);
        if ($this->email->send()) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * Activate user email after registering
     * @param  null  $userId
     * @param  null  $activationCode
     */
    public function activate($userId = null, $activationCode = null)
    {
        if ( ! $userId || ! $activationCode) {
            show_404();
        }
        // Show 404 if user not found
        if ( ! $user = $this->sentinel->findById($userId)) {
            show_404();
        }
        if ($activation = $this->sentinel->getActivationRepository()->exists($user)) {

            if ($this->sentinel->getActivationRepository()->complete($user, $activation->code)) {
                if ($this->sentinel->login($user)) {
                    $this->message->set_message('حساب شما با موفقیت فعال و ایمیل شما تایید شد. لطفا با استفاده از فرم زیر اطلاعات کاربری خود را تکمیل نمایید.',
                        'success', 'فعالسازی حساب کاربری', 'users/editprofile')->redirect();
                } else {
                    echo 'حساب شما فعال شد اما عملیات لاگین صورت نگرفت. برای ورود مجدد تلاش کنید.';
                }
                exit();
            } else {
                $this->message->set_message('فعال سازی انجام نشد.', 'fail', 'فعالسازی حساب کاربری',
                    'users/login')->redirect();
            }
        } else {
            redirect('/users/login');
        }
    }

    public function profile($username)
    {
        $this->load->eloquent('User');
        $this->load->eloquent('User_address');
        $this->load->eloquent('User_profile');
        $this->load->eloquent('User_contact');
        $this->load->eloquent('User_photo');
        $this->load->eloquent('shop/Product');
        $User = User::where('username', $username)->first();
        if ( ! $User or ! $username or $User->type != 1) {
            show_404();
        }
        $products = Product::where('user_id', $User->id)->where('type', 1)->get();
        $single_flowers = Product::where('user_id', $User->id)->where('type', 2)->get();
        $decorations = Product::where('user_id', $User->id)->where('type', 3)->get();

        if (isset($User->photo->image)) {
            $photo[] = $User->photo->image;
        }
        if (isset($User->photo->image2)) {
            $photo[] = $User->photo->image2;
        }
        if (isset($User->photo->image3)) {
            $photo[] = $User->photo->image3;
        }
        if (isset($User->photo->image4)) {
            $photo[] = $User->photo->image4;
        }
        if (isset($User->photo->image5)) {
            $photo[] = $User->photo->image5;
        }
        if (isset($User->photo->image6)) {
            $photo[] = $User->photo->image6;
        }

        $this->smart->assign([
            'title' => $User->business_name,
            'seller' => $User,
            'products' => $products,
            'single_flowers' => $single_flowers,
            'photo' => isset($photo) ? $photo : [],
            'decorations' => $decorations,
        ]);
        $this->smart->view('profile');
    }


    public function search_shops()
    {
        $this->load->eloquent('User_address');
        $this->load->eloquent('User_contact');
        $this->load->eloquent('Province');
        $this->load->eloquent('Location_county');
        $q = $this->input->get('username_query');
        $shops = User::select(['id', 'business_name', 'username', 'lat', 'long'])
            ->where('type', 1)
            ->where(function ($query) use ($q) {
                $query->where('username', 'like', '%'.$q.'%')
                    ->orWhere('business_name', 'like', '%'.$q.'%');
            })
            ->get();
        $this->smart->assign([
            'title' => 'جستجوی فروشگاه',
            'Shops' => $shops,
            'q' => $q,
        ]);
        $this->smart->view('shops_search');
    }

    /*
     * Form Validation callback to check that the provided email address or mobile is valid.
     */

    function mobile_exists_validation($login)
    {
        $credentials = ['mobile' => $login];
        $User = $this->sentinel->getUserRepository()->where($credentials)->first();

        if (isset($User)) {
            $this->form_validation->set_message('mobile_validation',
                "شماره موبایل وارد شده در حال حاضر ثبت نام شده است.");
            return false;
        }
        return true;
    }

    /*
     * Form Validation callback to check that the provided email address exists.
     */

    function email_exists($login)
    {
        if (str_contains($login, '@')) {
            $credentials = ['email' => $login];
        } else {
            $credentials = ['mobile' => $login];
        }

        $User = $this->sentinel->getUserRepository()->where($credentials)->first();

        if (isset($User)) {
            $this->form_validation->set_message('email_exists', "$login وارد شده درحال حاضر در سایت ثبت نام شده است");
            return false;
        } else {
            $_POST['user'] = $User;
            return true;
        }
    }

    /*
     * Form Validation callback to check that the provided mobile is valid.
     */

    function mobile_numbers_validation($mobile)
    {
        $pattern = "/09[0|1|2|3|4]([()]){0,2}(?:[0-9](|-|[()]){0,2}){8}/";
        if ( ! preg_match($pattern, $mobile)):
            $this->form_validation->set_message('mobile_numbers_validation',
                "شماره موبایل باید با09 شروع شده و شامل ۱۱ رقم باشد.");
            return false;
        endif;
        return true;
    }

    function username_validation($login)
    {
        // check if is email and its validation
        $pattern = "/[a-zA-Z0-9_]/";
        if ( ! preg_match($pattern, $login)):
            $this->form_validation->set_message('username_validation', 'نام کاربری باید شامل حروف لاتین و اعداد باشد');
            return false;
        endif;
        $credentials = ['username' => $login];
        $User = $this->sentinel->getUserRepository()->where($credentials)->first();

        if (isset($User)) {
            $this->form_validation->set_message('username_validation',
                "$login وارد شده درحال حاضر در سایت ثبت نام شده است");
            return false;
        }
        return true;
    }

}
