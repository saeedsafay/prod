<?php

(defined('BASEPATH')) OR exit('No direct script access allowed');

/**
 * Contact_us Controller
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Contact_us extends Public_Controller {

    public $validation_rules = array(
        'index' => array(
            ['field' => 'name_family', 'rules' => 'trim|required|htmlspecialchars|max_length[100]', 'label' => 'نام و نام خانوادگی'],
            ['field' => 'email', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'ایمیل'],
            ['field' => 'tell', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'شماره تماس'],
            ['field' => 'address', 'rules' => 'trim|required|htmlspecialchars', 'label' => 'آدرس'],
            ['field' => 'subject', 'rules' => 'htmlspecialchars|max_length[100]', 'label' => 'موضوع'],
            ['field' => 'message', 'rules' => 'htmlspecialchars|required|trim|max_length[1000]', 'label' => 'متن پیام'],
        )
    );

    public function __construct() {
        parent::__construct();
        $this->load->eloquent('Contact');
    }

    public function index() {
        $data = [];

        if ($this->input->post('submit_btn') AND $this->formValidate(FALSE)) {
            $data = $this->__fetch_from_PostArray();
            $contact = new Contact;
            foreach ($data as $key => $val):
                $contact->$key = $val;
            endforeach;
            if ($contact->save())
                $this->message->set_message('پیام شما ارسال شد', 'success', 'پیغام ارسال شد', 'contacts/contact-us/')->redirect();
        }else {
            $this->smart->assign(
                    [
                        'title' => 'تماس با ما',
                        'action' => site_url('contacts/contact-us'),
                    ]
            );
            $this->smart->view('index');
        }
    }

    public function submit_contact() {
        $data = [];
        if ($this->formValidate(FALSE)) {
            $data = $this->__fetch_from_PostArray();
            $contact = new Contact;
            foreach ($data as $key => $val):
                $contact->$key = $val;
            endforeach;
            if ($contact->save())
                $this->message->set_message('پیام شما ارسال شد', 'success', 'پیغام ارسال شد', 'contacts/contact-us/')->redirect();
        } else
            $this->message->set_message('اشکال در داده های ورودی', 'fail', 'پیغام ارسال نشد', 'contacts/contact-us/')->redirect();
        redirect('contacts/contact-us');
    }

    public function __fetch_from_PostArray() {
        $data = [];
        foreach ($this->input->post() as $name => $value) {
            $data[$name] = $value;
        }
        $data['is_ticket'] = 0;
        return $data;
    }

}
