<?php

(defined('BASEPATH')) or exit('No direct script access allowed');

class Users_panel extends Public_Controller
{


    public $validation_rules = array(
        'add_address' => array(
            ['field' => 'title', 'rules' => 'required|htmlspecialchars', 'label' => 'عنوان آدرس'],
            ['field' => 'delivery_address', 'rules' => 'required|htmlspecialchars', 'label' => 'آدرس پستی'],
            ['field' => 'province_id', 'rules' => 'integer|required|htmlspecialchars', 'label' => 'استان'],
            ['field' => 'county_id', 'rules' => 'integer|required|htmlspecialchars', 'label' => 'شهر'],
            ['field' => 'postal_code', 'rules' => 'numeric|exact_length[10]|htmlspecialchars', 'label' => 'کد پستی'],
            [
                'field' => 'mobile',
                'rules' => 'htmlspecialchars|callback_mobile_numbers_validation',
                'label' => 'شماره موبایل گیرنده'
            ],
        ),
    );


    public function __construct()
    {
        parent::__construct();
        $this->checkAuth(true);
        $this->load->eloquent("users/User_address");
    }


    public function index()
    {
        $this->smart->assign([
            "title" => "پنل کاربری",
            "addressList" => User_address::query()->user($this->user->id)->get(),
            'provinces' => Province::with('regions', 'county')->get(),
        ]);
        $this->smart->view("index");
    }

    public function profile()
    {
        $this->smart->assign([
            "title" => "حساب کاربری",
        ]);
        $this->smart->view("profile");
    }

    public function orders()
    {
        $orders = Cart::query()
            ->with(["varients.product", "varients.fields.value", "delivery"])
            ->where(["user_id" => $this->user->id, "status" => 1])
            ->orderByDesc("pay_at")
            ->get();
        $this->smart->assign([
            "title" => "سفارش ها",
            "orders" => $orders
        ]);
        $this->smart->view("orders");
    }

    public function addresses()
    {
        $this->smart->assign([
            "title" => "آدرس های من",
        ]);
        $this->smart->view("my_list");
    }

    public function add_address()
    {
        try {
            if ( ! $this->formValidate()) {
                return $this->output->jsonResponse([
                    'error' => validation_errors(),
                ], 422);
            }
            $address = User_address::query()->create([
                'title' => $this->input->post('title'),
                'mobile' => $this->input->post('mobile'),
                'province_id' => $this->input->post('province_id'),
                'county_id' => $this->input->post('county_id'),
                'region_id' => $this->input->post('region_id'),
                'delivery_address' => $this->input->post('delivery_address'),
                'postal_code' => $this->input->post('postal_code'),
                'extra_desc' => $this->input->post('extra_desc'),
                'user_id' => $this->user->id,
            ]);
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطا. لطفا مجدد تلاش کنید',
            ], 500);
        }

        return $this->output->jsonResponse([
            'address' => $address->toArray(),
        ]);
    }

    public function delete_address()
    {
        if ( ! $this->input->is_ajax_request()) {
            redirect();
        }
        try {
            $address_id = $this->input->get('address_id');
            $address = User_address::query()->where('user_id', $this->user->id)->findOrFail($address_id);
            $address->deleted_at = date('Y-m-d H:i:s');
            $address->saveOrFail();
        } catch (Throwable $e) {
            return $this->output->jsonResponse([
                'error' => 'درخواست نامعتبر'
            ], 401);
        }
        return $this->output->jsonResponse([
            'success' => true
        ]);
    }

    public function my_list()
    {
        $this->smart->assign([
            "title" => "لیست های من",
        ]);
        $this->smart->view("my_list");
    }

    /*
     * Form Validation callback to check that the provided email address or mobile is valid.
     */

    public function mobile_numbers_validation($mobile)
    {
        // check if is email and its validation
        $pattern = "/09[1|2|3|4]([()]){0,2}(?:[0-9](|-|[()]){0,2}){8}/";
        if ( ! preg_match($pattern, $mobile)):
            $this->form_validation->set_message('mobile_numbers_validation',
                "شماره موبایل باید با 09 شروع شده و شامل ۱۱ رقم باشد.");
            return false;
        endif;
        return true;
    }
}