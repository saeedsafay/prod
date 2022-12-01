<?php

(defined('BASEPATH')) OR exit('No direct script access allowed');

/**
 * Ticket Controller
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2015
 * @license     MIT License
 * @link http://www.mirook.ir exclusive CMS for mirookSoft Co.
 */
class Ticket extends Admin_Controller {

    public $validation_rules = array(
        'submit_ticket' => array(
            ['field' => 'subject', 'rules' => 'htmlspecialchars|max_length[100]', 'label' => 'موضوع'],
            ['field' => 'attachment', 'rules' => '', 'label' => 'فایل پیوست'],
            ['field' => 'message', 'rules' => 'required|trim|max_length[1000]', 'label' => 'متن پیام'],
        )
    );

    public function __construct() {
        parent::__construct();
        $this->load->eloquent('Contact');
    }

    public function index() {
        $this->smart->addJS('js/ckeditor/jquery.ckeditor.js');
        $this->smart->addJS('js/ckeditor/ckeditor.js');
        $this->smart->assign(
                [
                    'title' => 'ارسال تیکت به مدیریت',
                    'action' => site_url(ADMIN_PATH . '/contacts/ticket/submit-ticket'),
                ]
        );
        $this->smart->view('ticket');
    }

    public function submit_ticket() {
        $data = [];
        $user = $this->sentinel->getUser();
        if ($this->formValidate(FALSE)) {
            $data = $this->__fetch_from_PostArray();
            $data['is_ticket'] = 1;
            $data['name_family'] = $user->first_name . ' ' . $user->last_name;
            $data['email'] = $user->username;
            $data['attachment'] = $this->input->file('attachment', 'contacts');
            $contact = new Contact;
            foreach ($data as $key => $val):
                $contact->$key = $val;
            endforeach;
            if ($contact->save())
                $this->message->set_message('پیام شما ارسال شد', 'success', 'ارسال تیکت', ADMIN_PATH . '/contacts/ticket/')->redirect();
        }
        redirect(ADMIN_PATH . '/contacts/ticket');
    }

    public function __fetch_from_PostArray() {
        $data = [];
        foreach ($this->input->post() as $name => $value) {
            $data[$name] = $value;
        }
        return $data;
    }

    public function delete($ticket_id = null) {
        if ($Ticket = Contact::find($ticket_id)) {
            if ($Ticket->delete())
                $this->message->set_message('تیکت مربوطه حذف گردید', 'success', 'حذف تیکت', ADMIN_PATH . '/contacts/contact-us/tickets')->redirect();
        }
        else {
            show_404();
        }
    }

}
