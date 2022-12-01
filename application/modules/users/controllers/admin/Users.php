<?php

(defined('BASEPATH')) or exit('No direct script access allowed');

/**
 * Users Controller using Sentinel Authentication Library
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Users extends Admin_Controller
{

    public $validation_rules = array(
        'edit' => array(
            ['field' => 'password', 'rules' => 'trim|htmlspecialchars', 'label' => 'کلمه عبور'],
            [
                'field' => 'confirm_password',
                'rules' => 'trim|matches[password]|htmlspecialchars',
                'label' => 'تایید کلمه عبور'
            ],
            ['field' => 'username', 'rules' => 'trim|htmlspecialchars', 'label' => 'نام کاربری'],
            ['field' => 'business_name', 'rules' => 'trim|htmlspecialchars', 'label' => 'عنوان مجموعه'],
            ['field' => 'email', 'rules' => 'trim|htmlspecialchars|valid_email', 'label' => 'کلمه عبور'],
            ['field' => 'first_name', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'نام'],
            ['field' => 'last_name', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'نام خانوادگی'],
            ['field' => 'mobile', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'شماره موبایل'],
            ['field' => 'sale_percent', 'rules' => 'trim|numeric|htmlspecialchars', 'label' => 'درصد از فروش'],
        ),
        'resetPasswordBySms' => array(
            ['field' => 'password', 'rules' => 'trim|htmlspecialchars|required', 'label' => 'رمز عبور جدید'],
            [
                'field' => 'confirm_password',
                'rules' => 'trim|htmlspecialchars|required|matches[password]',
                'label' => 'تایید رمز عبور جدید'
            ],
        ),
    );
    public $users;
    public $role;

    public function __construct()
    {
        parent::__construct();
        $this->users = $this->sentinel->getUserRepository();
        $this->role = $this->sentinel->getRoleRepository();
    }

    public function index()
    {
        $data = array();

        $data['title'] = 'کاربران';

        $group = $this->input->get('group') ? $this->input->get('group') : null;

        if ($group) {

            $requestedGroup = $this->role->where('slug', $group)->first();
            $data['title'] .= " {$requestedGroup->name}";
            $Users = $this->users->whereHas('roles', function ($q) use ($requestedGroup) {
                return $q->where('id', $requestedGroup->id);

            })->get();
        } else {

            // Query
            $Users = $this->users->all();
        }
        // Get groups for group filter
        $data['Roles'] = $this->role->all();

        // assign user roles to user object
        foreach ($Users as $key => $val) {
            if ($val->getRoles()->isEmpty()) {
                $Users[$key]->setAttribute('role_name', '--');
            } else {
                $roles_arr = array();
                foreach ($val->getRoles() as $roles) {
                    $roles_arr[] = $roles->name;
                }
                $Users[$key]->setAttribute('role_name', $roles_arr);
            }
        }
        $this->smart->assign(
            [
                'Users' => $Users,
                'title' => 'کاربران',
                'roles' => $data['Roles'],
                'group' => $group
            ]
        );

        $this->smart->view('users/index');
    }

    /**
     * Edit or Create users
     * @param  null  $userId
     */
    public function edit($userId = null)
    {
        // Init
        $edit_mode = false;
        $role = $this->role->all();

        $activation = $this->sentinel->getActivationRepository();
        if ($userId) {
            $User = $this->users->find($userId);
            $this->show_404_on(! $User);

            $isActivated = $activation->completed($User);
        }
        // Filter the superadmin role to avoid attaching this role to other users
        $filtered = $role->filter(function ($item) {
            return $item->slug != SUPER_ADMIN;
        });
        $role = $filtered->all();

        // Permissions list
        $this->load->eloquent('Permission');
        $Permissions = Permission::all();
        // Make permissions in Groups by module name
        $GroupedByPermission = $Permissions->groupBy('module_name');
        $injectedPermission = [];
        // now inject all permissions in suitable index of array
        foreach ($GroupedByPermission as $key => $val) {
            $injectedPermission[$key] = $val;
        }
        $this->smart->assign([
            'edit_mode' => $edit_mode,
            'title' => 'کاربران',
            'Roles' => $role,
            'is_admin' => $this->sentinel->getUser()->getRoles()->contains('slug', SUPER_ADMIN),
            'Permissions' => collect($injectedPermission),
        ]);
        // Edit Mode 
        if ($userId) {
            $edit_mode = true;
            $this->smart->assign([
                'edit_mode' => $edit_mode,
                'User' => $User ? $User : null,
                'is_activated' => $isActivated,
            ]);
        }

        // Process Form
        if ($this->formValidate(false)) {
            $credentials = [
                'email' => $this->input->post('email'),
                'username' => $this->input->post('username'),
                'business_name' => $this->input->post('business_name'),
                'first_name' => $this->input->post('first_name'),
                'last_name' => $this->input->post('last_name'),
                'status' => $this->input->post('status'),
                'mobile' => $this->input->post('mobile'),
                'sale_percent' => $this->input->post('sale_percent') ? $this->input->post('sale_percent') : 0,
                'top' => $this->input->post('top'),
                'type' => 0,
            ];
            //            if( $credentials['status'] ) {
            //                if( !$is_activated ) {
            //                    $new_activation = $this->sentinel->getActivationRepository()->init_code($User , true);
            //                }
            //                else {
            //                    $new_activation = $is_activated;
            //                }
            //                $this->sentinel->getActivationRepository()->complete($User , $new_activation->code);
            //            }
            //            else {
            //                $mamad = $this->sentinel->getActivationRepository();
            //                $mamad->updateOrCreate([ 'user_id' => $user_id ] , [ 'completed' => 0 , 'user_id' => $user_id ]);
            //            }
            if ( ! $edit_mode) {
                $credentials['password'] = $this->input->post('password');
                if ($this->users->validForCreation($credentials)) {
                    if ($credentials['status']) {
                        $newUser = $this->sentinel->registerAndActivate($credentials);
                    } else {
                        $newUser = $this->users->create($credentials);
                    }
                    // make relationship for roles and user
                    if ($this->input->post('role_id')) {
                        $newUser->roles()->sync($this->input->post('role_id'));
                    }
                    // Setting permissions for user
                    $this->setPermission($newUser, $Permissions);
                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد', 'success', 'ثبت رکورد جدید',
                        ADMIN_PATH.'/users/')->redirect();
                } else {
                    $this->message->set_message('اطلاعات وارد شده برای ذخیره کاربر معتبر نیست', 'fail',
                        'خطای ورود داده', 'users')->redirect();
                }
            } else {
                if ($this->input->post('password')) {
                    $credentials['password'] = $this->input->post('password');
                }
                if ($this->users->validForUpdate($User, $credentials)) {
                    if ($this->users->update($this->users->find($userId), $credentials)) {
                        // if User is superadmin, push the superadmin's id to the post array
                        if ($User->getRoles()->contains('slug', SUPER_ADMIN)) {
                            $_POST['role_id'][] = 1;
                        }
                        // Synchronizing Relationship for user and roles
                        $User->roles()->sync($this->input->post('role_id'));
                        // Setting permissions for user
                        $this->setPermission($User, $Permissions);
                        $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد', 'success', 'بروزرسانی',
                            ADMIN_PATH.'/users/users')->redirect();
                    } else {
                        $this->message->set_message('اطلاعات وارد شده برای بروزرسانی کاربر معتبر نیست', 'fail',
                            'خطای ورود داده', ADMIN_PATH.'/users/users/edit/'.$userId)->redirect();
                    }
                }
            }
            redirect(ADMIN_PATH.'/users/users');
        }
        $this->smart->view('users/edit');
    }

    /**
     *
     * collect of operations for validating code and changing password by sms reminder code
     * @param  type  $user_id
     */
    public function resetPasswordBySms($user_id)
    {
        $this->load->eloquent('User');
        $User = $this->sentinel->getUserRepository()->find($user_id);
        if ($this->formValidate(false)) {
            $code = $this->input->post('reminderCode');
            $password = $this->input->post('password');
            $reminder = $this->sentinel->getReminderRepository();
            if ($reminder->exists($User)) {
                if ($reminder->complete($User, $code, $password)) {
                    $this->message->set_message('رمز عبور شما با موفقیت تغییر یافت. می توانید با رمز عبور جدید وارد پنل کاربری خود شوید.',
                        'success', 'تغییر رمز عبور', ADMIN_PATH.'/users/login')->redirect();
                } else {
                    $this->message->set_message('کد وارد شده اشتباه است', 'warning', 'تغییر رمز عبور',
                        ADMIN_PATH.'/users/users/resetPasswordBySms/'.$user_id)->redirect();
                }
            } else {
                $this->message->set_message('کد وارد شده معتبر نیست. لطفا مجدد تلاش کنید', 'fail', 'تغییر رمز عبور',
                    ADMIN_PATH.'/users/login')->redirect();
            }
        }
        $this->smart->assign(array('title' => 'reminder'));
        $this->smart->load('default', true);
        $this->smart->setLayout('login_layout');
        $this->smart->view("resetPasswordBySms");
    }

    /**
     * set Permissions for user
     * @param  type  $user
     * @param $Permissions
     */
    public function setPermission($user, $Permissions)
    {
        $input_permissions = $this->input->post('user_permissions');
        $perm_array = array();
        //make true and false permissions based on input cheched in the form
        foreach ($Permissions as $per):
            if ( ! empty($input_permissions) and in_array($per['permission'], $input_permissions)) {
                $perm_array[$per['permission']] = true;
            } else {
                $perm_array[$per['permission']] = false;
            }
        endforeach;
        $user->permissions = $perm_array;
        $user->save();
    }

    public function delete($user_id)
    {
        $superadmin = $this->role->findBySlug('superadmin');
        if ($User = $this->users->find($user_id) and ! $User->roles->contains($superadmin)) {
            // Delete user uploads
            $this->load->helper('file');

            $upload_path = CMS_ROOT.USER_DATA.$User->id.'/';
            delete_files($upload_path, true);
            @rmdir($upload_path);

            $User->delete();
            $this->message->set_message('کاربر مربوطه حذف گردید', 'success', 'حذف کاربر',
                ADMIN_PATH.'/users')->redirect();
        } else {
            show_404();
        }
    }

    function resend_activation()
    {
        $user_id = $this->uri->segment('4');

        $this->load->eloquent('Users');
        $User = $this->Users->get_by_id($user_id);

        if ( ! $User->exists()) {
            return show_404();
        }

        $this->load->library('email');

        $this->email->from('noreply@'.domain_name(), $this->settings->site_name);
        $this->email->to($User->email);
        $this->email->subject($this->settings->site_name.' Activation');
        $this->email->message("Thank you for your new member registration.\n\nTo activate your account, please visit the following URL\n\n".site_url('users/activate/'.$User->id.'/'.$User->activation_code)."\n\nThank You!\n\n".$this->settings->site_name);
        $this->email->send();
    }

    /*
     * Form Validation callback to check if an email address is already in use.
     */

    function email_check($email, $user_id)
    {
        $credential = ['email' => $email];
        $User = $this->sentinel->findUserByCredentials($credential);
        if ($User && $User->id != $user_id) {
            $this->form_validation->set_message('email_check', "این آدرس ایمیل در حال حاضر در سایت ثبت نام شده است.");
            return false;
        } else {
            return true;
        }
    }

    public function withdraw()
    {
        $this->load->eloquent('withdraw');
        $all = Withdraw::orderBy('id', 'desc')->get();
        $this->smart->assign([
            'withdraw' => $all,
            'title' => 'درخواست تسویه',
        ]);
        $this->smart->view('users/withdraw');
    }

    public function view_withdraw($id)
    {

        $this->load->eloquent('withdraw');
        $request = Withdraw::find($id);
        if ( ! $id or ! $request) {
            show_404();
        }
        if ($request->status == 1) {
            $labell = 'پرداخت نشده';
        } else {
            $labell = 'پرداخت شده';
        }
        $this->smart->assign(
            [
                'title' => 'درخواست تسویه '.$request->account_holder,
                'Row' => $request,
                'status_label' => $labell,
            ]
        );
        $this->smart->view('users/view_withdraw');
    }

    public function withdraw_status($id)
    {
        $this->load->eloquent('withdraw');
        $request = Withdraw::find($id);
        if ($request->status == 1) {
            $request->status = 0;
        } elseif ($request->status == 0 or $request->status == 2) {
            $request->status = 1;
        }
        $request->save();

        $this->message->set_message('وضعیت تغییر یافت', 'success', '',
            ADMIN_PATH.'/users/users/view-withdraw/'.$id)->redirect();
    }

    public function withdraw_status_q($id, $status)
    {
        $this->load->eloquent('withdraw');
        $request = Withdraw::find($id);
        $request->status = $status;
        $request->save();

        $this->message->set_message('وضعیت تغییر یافت', 'success', '',
            ADMIN_PATH.'/users/users/view-withdraw/'.$id)->redirect();
    }

    /**
     * افزایش شارژ حساب کاربر
     * @param  int  $user_id
     */
    public function increase($user_id = null)
    {
        $User = $this->sentinel->getUserRepository()->find($user_id);
        $this->load->eloquent('payment/Transaction');
        if ($this->input->post('amount')) {
            $desc = $this->input->post('desc');

            Transaction::create(array(
                'invoice_type' => 10,
                'price' => $this->input->post('amount'),
                'user_id' => $user_id,
                'description' => $desc != "" ? $desc : 'افزایش شارژ حساب توسط مدیریت',
                'trans_id' => 'ADMIN_INCREASE'.time(),
                'cash' => $User->cash + $this->input->post('amount'),
                'status' => 1
            ));
            $User->update(
                array(
                    'cash' => $User->cash + $this->input->post('amount'),
                )
            );
            $this->message->set_message('مبلغ با موفقیت به حساب کاربر واریز شد', 'success', 'افزایش شارژ حساب',
                ADMIN_PATH.'/users')->redirect();
        } else {
            $this->smart->assign(
                [
                    'title' => 'افزایش موجودی کاربر '.$User->first_name.' '.$User->last_name,
                ]
            );
            $this->smart->view('users/increase');
        }
    }

    /**
     * کاهش شارژ حساب کاربر
     * @param  int  $user_id
     */
    public function decrease($user_id = null)
    {
        $User = $this->sentinel->getUserRepository()->find($user_id);
        $this->load->eloquent('payment/Transaction');
        if ($this->input->post('amount')) {
            $desc = $this->input->post('desc');

            Transaction::create(array(
                'invoice_type' => 11,
                'price' => $this->input->post('amount'),
                'user_id' => $user_id,
                'description' => $desc != "" ? $desc : 'کاهش شارژ حساب توسط مدیریت',
                'trans_id' => 'ADMIN_DECREASE'.time(),
                'cash' => $User->cash - $this->input->post('amount'),
                'status' => 1
            ));
            $User->update(
                array(
                    'cash' => $User->cash - $this->input->post('amount'),
                )
            );
            $this->message->set_message('مبلغ با موفقیت از حساب کاربر کسر گردید.', 'success', 'کاهش شارژ حساب',
                ADMIN_PATH.'/users')->redirect();
        } else {
            $this->smart->assign(
                [
                    'title' => 'کاهش موجودی کاربر '.$User->first_name.' '.$User->last_name,
                ]
            );
            $this->smart->view('users/increase');
        }
    }

    public function cancel_withdraw($id)
    {
        $this->load->eloquent('Withdraw');
        $withdraw = Withdraw::find($id);
        if ( ! $withdraw or ! $id) {
            redirect(ADMIN_PATH);
        }
        $User = $this->sentinel->getUserRepository()->find($withdraw->user_id);
        $this->load->eloquent('payment/Transaction');

        if ($User->update(array('cash' => $User->cash + $withdraw->amount))) {

            $this->load->eloquent('payment/Transaction');
            Transaction::create([
                'trans_id' => time().$User->id,
                'price' => $withdraw->amount,
                'invoice_type' => 40,
                'cash' => $User->cash + $withdraw->amount,
                'user_id' => $User->id,
                'description' => 'لغو درخواست تسویه',
            ]);
            $withdraw->delete();
            $this->message->set_message('درخواست مورد نظر لغو شد.', 'success', 'لغو درخواست تسویه',
                ADMIN_PATH.'/users/users/withdraw')->redirect();
        }
    }

    public function loginAsUser($user_id)
    {
        $user = $this->users->findById($user_id);

        if ($this->sentinel->login($user)) {
            redirect('dashboard');
        }
    }

    public function updateCash($user_id, $cash)
    {
        $user = $this->sentinel->getUserRepository();
        $user = $user->find($user_id);
        $user->update(array(
            'cash' => $cash,
        ));
    }

    /**
     * Uploading excel file and call the insertion method
     */
    public function createFromExcel()
    {
        $this->smart->assign([
            'title' => 'واردسازی فایل اکسل'
        ]);
        if (isset($_FILES['excel_file']['name'])) {
            $excel_file = $this->input->dataFile('excel_file', 'users/excel');
            if ($excel_file and $this->__insertFromExcel($excel_file)) {
                $this->message->set_message('اطلاعات با موفقیت ذخیره شد', 'success', 'واردسازی کاربران',
                    ADMIN_PATH.'/users/users')->redirect();
            }
        }
        $this->smart->view('users/excel');
    }

    /**
     * insert the records of excel into the database
     * @param  varchar  $excel_file  name of uploaded file
     */
    public function __insertFromExcel($excel_file)
    {
        $this->load->library('MirookExcel');
        $this->load->eloquent('Province');
        $this->load->eloquent('Location_county');
        $this->load->eloquent('Location_region');
        $this->load->eloquent('Location_neighbourhood');
        $this->load->eloquent('User');
        $target_dir = 'upload/users/excel/';
        $excel_file = $target_dir.$excel_file;
        //  Read Excel workbook
        try {
            $inputFileType = PHPExcel_IOFactory::identify($excel_file);
            $objReader = PHPExcel_IOFactory::createReader($inputFileType);
            $objPHPExcel = $objReader->load($excel_file);
        } catch (Exception $e) {
            $this->message->set_message('فایل اکسل وارد شده نامعتبر است', 'fail', 'واردسازی کاربران',
                ADMIN_PATH.'/users/users')->redirect();
        }
        $sheets = $objPHPExcel->getSheetNames();
        foreach ($sheets as $k => $currentSheet):
            if ($k != 7) {
                continue;
            }
            if ($k == 8 || $k == 22 || $k == 29 || $k == 27):
                continue;
            endif;
            //  Get worksheet dimensions
            $sheet = $objPHPExcel->setActiveSheetIndexByName($currentSheet);
            $highestRow = $sheet->getHighestRow();
            $highestColumn = $sheet->getHighestColumn();
            //  Read a row of data into an array
            $all_regions = $sheet->rangeToArray('H2:'.$highestColumn.'2', null, false, false);
            foreach ($all_regions[0] as $key => $region_data) {
                if ($region_data == null) {
                    continue;
                }
                $ColIndex = PHPExcel_Cell::stringFromColumnIndex($key + 7);
                $allRows = $sheet->rangeToArray($ColIndex.'3:'.$ColIndex.$highestRow, null, false, false);
                $county_cell = $sheet->getCell('F1');
                $region_cell = $sheet->getCell($ColIndex.'2');
                //        $county_cell = 'کرج';
                $county = Location_county::where('name', $county_cell)->first();
                // Insert to the database
                if (isset($county)) {
                    foreach ($allRows as $rowData) {
                        $region = Location_region::where([
                            'name' => $region_cell,
                            'location_county_id' => $county->id
                        ])->first();
                        if (Location_neighbourhood::where(array(
                            'name' => $rowData[0],
                            'location_region_id' => $region->id,
                            'province_id' => $county->province_id,
                        ))->first()) {
                            continue;
                        }
                        if ( ! $region) {
                            dump($region_cell);
                            dump($rowData[0]);
                        }
                        if ($rowData[0] != null) {
                            Location_neighbourhood::create(array(
                                'name' => $rowData[0],
                                'location_region_id' => $region->id,
                                'province_id' => $county->province_id,
                            ));
                        }
                    }
                } else {
                    echo('کاراکترهای شهرستان '.$county_cell.' همخوان نیست');
                    die;
                }
            }
        endforeach;

        dd('محلات واردسازی شدند! '.$county_cell);
        if ($affected_row) {
            return true;
        }
        return false;
    }

}
