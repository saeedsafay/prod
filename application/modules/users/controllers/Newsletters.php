<?php
(defined('BASEPATH')) or exit('No direct script access allowed');


class Newsletters extends Public_Controller
{

    public $validation_rules = [
        'subscribe' => array(
            [
                'field' => 'email',
                'rules' => 'valid_email|trim|required|htmlspecialchars',
                'label' => 'ایمیل'
            ],
        )
    ];

    function __construct()
    {
        parent::__construct();
        $this->load->sentinel();
        $this->load->eloquent('User');
        $this->load->eloquent('Newsletter');
    }

    public function subscribe()
    {

        try {
            //csrf token check
            if ( ! $this->session->userdata('csrf_token') ||
                $this->session->userdata('csrf_token') != $this->input->post('csrf')) {

                return $this->output->jsonResponse([
                    'error' => "دسترسی غیرمجاز به دلایل امنیتی",
                ], 401);
            }

            if ( ! $this->formValidate()) {
                return $this->output->jsonResponse([
                    'error' => validation_errors()
                ], 422);
            }
            if (Newsletter::query()->where('email', $this->input->post('email'))->first()) {
                return $this->output->jsonResponse([
                    'error' => 'ایمیل وارد شده تکراری است'
                ], 422);
            }
            $token = random_string('alnum', 32);
            $newsletter = Newsletter::query()->create([
                'email' => $this->input->post('email'),
                'status' => 0,
                'token' => $token,
                'user_id' => isset($this->user->id) ? $this->user->id : null
            ]);

            load_events('users', 'NewsletterMemberAdded');
            event(new NewsletterMemberAdded($newsletter));

            return $this->output->jsonResponse([
                'message' => 'عضویت شما تکمیل شد. برای تایید آدرس ایمیل خود، لطفا دستورالعمل موجود در ایمیل ارسالی را دنبال کنید.',
            ]);
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطای سرور. مجدد تلاش کنید',
            ], 500);
        }

    }

    public function verify($token = null)
    {

        if ( ! $token) {
            redirect();
        }
        try {
            $newsletter = Newsletter::query()
                ->where('token', $token)
                ->where('status', 0)
                ->firstOrFail();
        } catch (Throwable $e) {
            redirect('/');
            exit;
        }
        try {
            $newsletter->forceFill([
                'status' => true,
            ])->saveOrFail();
        } catch (Throwable $e) {
            log_exception($e);
            redirect('/');
        }
        $this->smart->assign(['title' => 'تایید آدرس ایمیل', 'email' => $newsletter->email]);
        $this->smart->view('users/verify_email');
    }
}