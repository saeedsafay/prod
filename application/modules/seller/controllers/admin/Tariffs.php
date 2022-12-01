<?php

/**
 * Controller: Main Advertises management
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
class Tariffs extends Admin_Controller {

    public $validation_rules = array(
        'edit' => array(
            ['field' => 'price', 'rules' => 'numeric|trim|required|htmlspecialchars', 'label' => 'عنوان'],
            ['field' => 'ads_type', 'rules' => 'numeric|htmlspecialchars', 'label' => 'نوع آگهی'],
            ['field' => 'time_period', 'rules' => 'numeric|htmlspecialchars', 'label' => 'دوره نمایش'],
        )
    );

    public function __construct() {
        parent::__construct();
        $this->load->eloquent('Ads_tariff');
        $this->load->eloquent('Advertise');
    }

    public function index() {
        $data = array();
        $Ads_tariffs = Ads_tariff::all();

        $this->smart->assign(
                [
                    'title' => 'دسته بندی آگهی',
                    'Ads_tariffs' => $Ads_tariffs
                ]
        );
        $this->smart->view('tariff/index');
    }

    function edit($tariff_id = null) {
        // Init
        $edit_mode = FALSE;

        $Ads_tariffs = Ads_tariff::all();
        $this->smart->assign([
            'edit_mode' => $edit_mode,
            'title' => 'دسته بندی آگهی',
            'Ads_tariffs' => $Ads_tariffs,
        ]);

        // Edit Mode 
        if ($tariff_id) {
            $edit_mode = TRUE;
            $this->smart->assign([
                'edit_mode' => $edit_mode,
                'Ads_tariff' => Ads_tariff::find($tariff_id)
            ]);
        }
        // Process Form
        if ($this->formValidate(FALSE)) {
            $data = [
                'time_period' => $this->input->post('time_period'),
                'ads_type' => $this->input->post('ads_type'),
                'price' => $this->input->post('price'),
            ];

            // Insert or update data to the db
            // if inserted
            if (Ads_tariff::updateOrCreate(['id' => $tariff_id], $data)) {
                if (!$edit_mode) {
                    $this->message->set_message('اطلاعات با موفقیت ذخیره شد',
                            'success', 'ثبت رکورد جدید',
                            ADMIN_PATH . '/advertise/tariffs/edit')->redirect();
                } else
                    $this->message->set_message('اطلاعات با موفقیت بروزرسانی شد',
                            'success', 'بروزرسانی',
                            ADMIN_PATH . '/advertise/tariffs/edit')->redirect();
            }// else if insertion failed
            else {
                if ($edit_mode)
                    $this->message->set_message('ذخیره سازی انجام نشد. مجدد تلاش کنید',
                            'fail', 'خطا در ذخیره سازی',
                            ADMIN_PATH . '/advertise/tariffs/edit')->redirect();

                else {
                    $this->message->set_message('بروزرسانی انجام نشد. مجدد تلاش کنید',
                            'fail', 'خطا در  بروزسانی',
                            ADMIN_PATH . '/advertise/tariffs/edit')->redirect();
                }
            }
            redirect(ADMIN_PATH . '/advertise/tariffs');
        }
        $this->smart->view('tariff/edit');
    }
/*
    function delete($tariff_id = null) {
        if ($Ads_tariff = Ads_tariff::find($tariff_id)) {
            if ($Ads_tariff->delete())
                $this->message->set_message('تعرفه مربوطه حذف گردید',
                        'success', 'حذف تعرفه  ', ADMIN_PATH . '/advertise/tariffs')->redirect();
        }
        else {
            show_404();
        }
    }*/

}
