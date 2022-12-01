<?php

(defined('BASEPATH')) OR exit('No direct script access allowed');

/**
 * Ticket Controller
 *
 *
 * @copyright   Copyright (c) 2015
 * @license     MIT License
 * @link http://www.mirook.ir exclusive CMS for mirookSoft Co.
 */
class Tickets extends Public_Controller {

    public $validation_rules = array(
        'submit_ticket' => array(
            ['field' => 'subject' , 'rules' => 'required|htmlspecialchars|max_length[100]' ,
                'label' => 'موضوع' ] ,
            ['field' => 'content' , 'rules' => 'required|trim|max_length[1000]' , 'label' => 'متن پیام' ] ,
            ['field' => 'recipient_id' , 'rules' => 'required|trim|numeric' , 'label' => 'گیرنده' ] ,
        ) ,
        'submit_reply' => array(
            ['field' => 'content' , 'rules' => 'htmlspecialchars|required|trim|max_length[1000]' , 'label' => 'متن پیام' ] ,
        )
    );

    public function __construct () {
        parent::__construct();
        $this->load->eloquent('Ticket');
        $this->load->eloquent('Ticket_reply');
        $this->load->eloquent('users/User');
        $this->smart->load('Dashboard');
        $this->checkAuth(true);
    }

    public function new_ticket ( $recipient_id ) {
        $shop = User::find($recipient_id);
        if ( !$recipient_id OR ! $shop ) {
            show_404();
        }
        $this->smart->assign(
                [
                    'title' => 'ارسال تیکت پشتیبانی' ,
                    'recipient_id' => $recipient_id ,
                    'Ticket' => false ,
                    'shop_name' => $shop->business_name ,
                    'action' => site_url('contacts/tickets/submit-ticket') ,
                ]
        );
        $this->smart->view('new_ticket');
    }

    public function ticket_list () {
        $this->checkAuth(true);
//        $is_admin = $this->sentinel->getUser()->getRoles()->contains('slug' , SUPER_ADMIN);
        $user_id = $this->user->id;
        if ( $this->user->type == 2 )
            $Tickets = Ticket::where('user_id' , $this->user->id)->get();
        elseif ( $this->user->type == 1 )
            $Tickets = Ticket::where('recipient_id' , $this->user->id)->get();
        $this->smart->assign(
                [
                    'title' => 'لیست پیام‌ها' ,
                    'tickets' => $Tickets ,
                    'action' => site_url('contacts/tickets/submit-ticket') ,
                ]
        );
        $this->smart->view('index');
    }

    public function view_ticket ( $id ) {
        $Contact = Ticket::find($id);
        $this->show_404_on(!$id);
        $this->show_404_on(!$Contact);
        if ( $this->user->type == 2 ) {
            if ( $Contact->user_id != $this->user->id )
                redirect();
            $rcp_name = $Contact->recipient->business_name;
        }
        elseif ( $this->user->type == 1 ) {
            if ( $Contact->recipient_id != $this->user->id )
                redirect();
            $rcp_name = $Contact->user->first_name . ' ' . $Contact->user->last_name;
        }

        $this->smart->assign(
                [
                    'title' => 'پیام - '.$Contact->subject ,
                    'Ticket' => $Contact ,
                    'shop_name' => $rcp_name ,
                    'recipient_id' => $Contact->recipient_id ,
                    'action' => site_url('contacts/tickets/submit-reply/' . $id) ,
                    'logged_in_user_id' => $this->user->id ,
                ]
        );
        $this->smart->view('new_ticket');
    }

    public function submit_ticket () {
        $data = [ ];
        if ( $this->formValidate(FALSE) ) {
            $data['user_id'] = $this->user->id;
            $data['subject'] = $this->input->post('subject');
            $data['status'] = 0;
            $data['recipient_id'] = $this->input->post('recipient_id');
            $Ticket = Ticket::create($data);

            $reply['user_id'] = $this->user->id;
            $reply['ticket_id'] = $Ticket->id;
            $reply['content'] = $this->input->post('content');
            if(!empty($_FILES['attach']['name']))
                $reply['attach'] = $this->input->imageFile('attach','users');

            if ( $ticket_id = Ticket_reply::create($reply) ) {
//                $tMessage = $reply['content'];
//                $email = $this->user->email;
//                $this->load->library('email');
//                $this->email->from('ticket@landabet.com' , 'تیکت جدید');
//                $this->email->to($this->sentinel->findById(6)->email);
//                $this->email->subject('تیکت جدید ');
//                $this->email->message("شما یک تیکت جدید از سوی کاربران دارید:.\n تیکت دهنده: $email \n متن پیام: $tMessage \n برای پاسخ به تیکت روی لینک زیر کلیک کنید: \n $ticket_link>ارسال پاسخ به تیکت</a>");
//                $this->email->send();
                $this->message->set_message('پیام شما ارسال شد' , 'success' , 'ارسال تیکت' , 'contacts/tickets/ticket-list')->redirect();
            }
        }
        else {
            $this->message->set_message('پیام ارسال نشد.' . validation_errors() , 'warning' , 'ارسال تیکت' , 'contacts/tickets/new-ticket')->redirect();
        }
    }

    public function submit_reply ( $id ) {
        $Contact = Ticket::find($id);
        $this->show_404_on(!$id);
        $this->show_404_on(!$Contact);

        if ( $this->user->type == 2 ) {
            if ( $Contact->user_id != $this->user->id )
                redirect();
            $rcp_name = $Contact->recipient->business_name;
        }
        elseif ( $this->user->type == 1 ) {
            if ( $Contact->recipient_id != $this->user->id )
                redirect();
            $rcp_name = $Contact->user->first_name . ' ' . $Contact->user->last_name;
        }
        $data = [ ];
        if ( $this->formValidate(FALSE) ) {
            $reply['user_id'] = $this->user->id;
            $reply['ticket_id'] = $id;
            $reply['content'] = $this->input->post('content' , true);
            if ( Ticket_reply::create($reply) ) {
                $Contact->update(array( 'status' => 0 ));
//                $tMessage = $reply['content'];
//                $email = $this->user->email;
//                $this->load->library('email');
//                $this->email->from('ticket@landabet.com' , 'پاسخ جدید به تیکت');
//                $this->email->to($this->sentinel->findById(6)->email);
//                $this->email->subject('پاسخ جدید - لاندابت');
//                $this->email->message("شما یک پاسخ جدید از سوی کاربران دارید:.\n تیکت دهنده: $email \n متن پیام: $tMessage \n برای پاسخ به تیکت روی لینک زیر کلیک کنید: \n $ticket_link>ارسال پاسخ به تیکت</a>");
//                $this->email->send();
                $this->message->set_message('پیام شما ارسال شد' , 'success' , 'ارسال تیکت' , 'contacts/tickets/ticket-list')->redirect();
            }
        }
        else {
            $this->message->set_message('پیام ارسال نشد.' . validation_errors() , 'warning' , 'ارسال تیکت' , 'contacts/tickets/new-ticket')->redirect();
        }
    }

    public function set_seen () {
        $id = $this->input->post('input');
        $this->show_404_on(!$id);
        header('Content-type: application/json');
        $saeed = Ticket::find($id);

        $saeed->status = 1;
        $saeed->seen_datetime = date("Y-m-d H:i:s");
        if ( $saeed->save() )
            echo json_encode(array( 'success' => 1 ));
        else
            echo json_encode(array( 'success' => 0 ));
        die();
    }

    public function __fetch_from_PostArray () {
        $data = [ ];
        foreach ( $this->input->post() as $name => $value ) {
            $data[$name] = $value;
        }
        return $data;
    }

    public function delete ( $ticket_id = null ) {
        if ( $Ticket = Contact::find($ticket_id) ) {
            if ( $Ticket->delete() )
                $this->message->set_message('تیکت مربوطه حذف گردید' , 'success' , 'حذف تیکت' , 'contacts/contact-us/tickets')->redirect();
        }
        else {
            show_404();
        }
    }

}
