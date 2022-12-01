<?php

/**
 * Controller: Main Advertises management
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */
use Cocur\Slugify\Slugify as Slugify;

class Products extends Admin_Controller
{

    /**
     * تعریف اعتبارسنجی داده ها
     * @var type 
     */
    public $validation_rules = array(
        'index' => array(
        ) ,
        'submit_ads' => array(
            [ 'field' => 'title' , 'rules' => 'required|trim|required|htmlspecialchars|max_length[100]' , 'label' => 'عنوان محصول' ] ,
            [ 'field' => 'type' , 'rules' => 'trim|required|htmlspecialchars|numeric' , 'label' => 'نوع محصول' ] ,
            [ 'field' => 'period_time' , 'rules' => 'htmlspecialchars|required|numeric' , 'label' => 'دوره نمایش' ] ,
            [ 'field' => 'desc' , 'rules' => 'trim' , 'label' => 'شرح' ] ,
            [ 'field' => 'price' , 'rules' => 'htmlspecialchars|trim|numeric' , 'label' => 'قیمت' ] ,
            [ 'field' => 'tell' , 'rules' => 'htmlspecialchars|trim|numeric' , 'label' => 'تماس' ] ,
            [ 'field' => 'product_category_id' , 'rules' => 'numeric|required|htmlspecialchars' , 'label' => 'دسته بندی' ] ,
        ) ,
        'add' => array(
            [ 'field' => 'title' , 'rules' => 'required|trim|required|htmlspecialchars|max_length[100]' , 'label' => 'عنوان محصول' ] ,
            [ 'field' => 'type' , 'rules' => 'trim|required|htmlspecialchars|numeric' , 'label' => 'نوع محصول' ] ,
            [ 'field' => 'period_time' , 'rules' => 'htmlspecialchars|required|numeric' , 'label' => 'دوره نمایش' ] ,
            [ 'field' => 'desc' , 'rules' => 'trim' , 'label' => 'شرح' ] ,
            [ 'field' => 'price' , 'rules' => 'htmlspecialchars|trim|numeric' , 'label' => 'قیمت' ] ,
            [ 'field' => 'tell' , 'rules' => 'htmlspecialchars|trim|numeric' , 'label' => 'تماس' ] ,
            [ 'field' => 'product_category_id' , 'rules' => 'numeric|required|htmlspecialchars' , 'label' => 'دسته بندی' ] ,
        ) ,
        'submit_edit_ads' => array(
            [ 'field' => 'title' , 'rules' => 'required|trim|required|htmlspecialchars|max_length[100]' , 'label' => 'عنوان محصول' ] ,
            [ 'field' => 'desc' , 'rules' => 'trim' , 'label' => 'شرح' ] ,
            [ 'field' => 'price' , 'rules' => 'htmlspecialchars|trim|numeric' , 'label' => 'قیمت' ] ,
            [ 'field' => 'tell' , 'rules' => 'htmlspecialchars|trim|numeric' , 'label' => 'تماس' ] ,
            [ 'field' => 'product_category_id' , 'rules' => 'numeric|required|htmlspecialchars' , 'label' => 'دسته بندی' ] ,
        ) ,
        'edit' => array(
            [ 'field' => 'title' , 'rules' => 'required|trim|required|htmlspecialchars|max_length[100]' , 'label' => 'عنوان محصول' ] ,
            [ 'field' => 'desc' , 'rules' => 'trim' , 'label' => 'شرح' ] ,
            [ 'field' => 'price' , 'rules' => 'htmlspecialchars|trim|numeric' , 'label' => 'قیمت' ] ,
            [ 'field' => 'product_category_id' , 'rules' => 'numeric|required|htmlspecialchars' , 'label' => 'دسته بندی' ] ,
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Advertise');
        $this->load->eloquent('Ads_category');
        $this->load->eloquent('Ads_tariff');
        $this->load->eloquent('Ads_field');
    }

    /**
     * لیست محصول ها
     */
    public function index()
    {
        $Ads = Product::orderBy('created_at' , 'DESC')->where('type' , '!=' , 10)->get();
        $this->smart->assign(
                [
                    'title' => 'محصول های ثبت شده' ,
                    'Ads' => $Ads ,
                    'add_link' => site_url(ADMIN_PATH . "/shop/products/add") ,
                    'is_shop' => 0 ,
                ]
        );
        $this->smart->view('product/index');
    }

    /**
     * لیست فروشگاها
     */
    public function product_list()
    {
        $Items = Product::orderBy('created_at' , 'DESC')->get();
        $this->smart->assign(
                [
                    'title' => 'آیتم های ثبت شده' ,
                    'Ads' => $Items ,
                    'add_link' => site_url(ADMIN_PATH . "/shop/products/add-product") ,
                    'is_shop' => 1 ,
                ]
        );
        $this->smart->view('product/index');
    }

    /**
     * نمایش محصول
     * @param type $id
     */
    public function view_ads( $id )
    {
        $Ads = Product::find($id);
        $this->show_404_on(!$id);
        $this->show_404_on(!$Ads);
        $this->smart->assign(
                [
                    'title' => 'محصول - ' . $Ads->title ,
                    'Ads' => $Ads ,
                ]
        );
        $this->smart->view('product/view_ads');
    }

    /**
     * بالا اندازی محصول
     * @param type $product_id
     * @return type
     */
    public function update_position( $product_id )
    {
        $ads = Product::find($product_id);
        $data = array(
            'start_publish_date' => date('Y-m-d H:i:s') ,
            'start_period_date' => date('Y-m-d H:i:s') ,
        );
        if( $ads->update($data) )
            $this->message->set_message('جایگاه محصول با موفقیت ارتقا یافت' , 'success' , 'بروزرسانی جایگاه محصول' , ADMIN_PATH . '/shop/advertises')->redirect();
        else
            $this->message->set_message('عملیات انجام نشد. مجدد تلاش کنید' , 'fail' , 'بروزرسانی جایگاه محصول' , ADMIN_PATH . '/shop/advertises')->redirect();
    }

    /**
     * تغییر وضعیت آکهی از تایید شده به رد شده و برعکس
     * @param type $product_id
     */
    public function toggleStatus( $product_id )
    {
        $current_status = Product::find($product_id);
        if( Product::toggleStatus($current_status) )
            $this->message->set_message('وضعیت محصول با موفقیت تغییر یافت' , 'success' , 'تغییر وضعیت محصول' , ADMIN_PATH . '/shop/advertises')->redirect();
        else
            $this->message->set_message('مشکلی رخ داد مجدد تلاش کنید' , 'fail' , 'تغییر وضعیت محصول' , ADMIN_PATH . '/shop/advertises')->redirect();
    }

    /**
     * افزودن محصول جدید
     */
    public function add()
    {
        $this->smart->addJS('js/ckeditor/jquery.ckeditor.js');
        $this->smart->addJS('js/ckeditor/ckeditor.js');
        if( $this->input->post('submit_btn') AND $this->formValidate(FALSE) ) {
            $slugify = new Slugify();
            $this->load->eloquent('Keyword');
            $data = array(
                'title' => $this->input->post('title' , true) ,
                'type' => $this->input->post('type' , true) ,
                'period_time' => $this->input->post('period_time' , true) ,
                'price' => $this->input->post('price' , true) ,
                'tell' => $this->input->post('tell' , true) ,
                'desc' => $this->input->post('desc') ,
                'short_desc' => $this->input->post('short_desc') ,
                'status' => 1 ,
                'start_period_date' => date('Y-m-d H:i:s') ,
                'start_publish_date' => date('Y-m-d H:i:s') ,
                'slug' => $slugify->slugify($this->input->post('title')) ,
                'user_id' => $this->input->post('user_id' , true) ,
                'pic' => $this->input->post('picHidden') ,
                'pic2' => $this->input->post('picHidden2') ,
                'pic3' => $this->input->post('picHidden3') ,
            );
            //وضعیت پرداخت
            $data['pay_status'] = 1;
            //اسلاگ تکراری نباشد
            $prv_ads = Product::where('slug' , $data['slug'])->get();
            if( !$prv_ads->isEmpty() )
                $data['slug'] .= '-' . time();
            //فیلم ها و فایل صوتی
//            if (!empty($_FILES['audio']['name']))
//                $data['audio'] = $this->input->audioFile('audio', 'product/audio');
//                
            if( !empty($_FILES['video']['name']) )
                $data['video'] = $this->input->videoFile('video' , 'product/video');
            //insert model to db and set the relation for category
            $new_product = new Advertise($data);
            $category = Ads_category::find($this->input->post(
                                    'product_category_id' , true));
            $category->ads()->save($new_product);

            /**
             * ذخیره فیلدهای اضافی برای محصول پیانو آکوستیک
             */
            if( $new_product->category->id == 1 ) {
                $field = array(
                    'model' => $this->input->post('ac_model' , true) ,
                    'brand' => $this->input->post('ac_brand' , true) ,
                    'piano_type' => $this->input->post('ac_piano_type' , true) ,
                    'diameter' => $this->input->post('ac_diameter' , true) ,
                    'height' => $this->input->post('ac_height' , true) ,
                    'color' => $this->input->post('ac_color' , true) ,
                    'creator_country' => $this->input->post('ac_creator_country' , true) ,
                    'pedal_count' => $this->input->post('ac_pedal_count' , true) ,
                    'years' => $this->input->post('ac_years' , true) ,
                    'sound_board' => $this->input->post('ac_sound_board' , true) ,
                    'wire' => $this->input->post('ac_wire' , true) ,
                    'action' => $this->input->post('ac_action' , true) ,
                    'product_id' => $new_product->id
                );
                Ads_field::create($field);
            }
            /**
             * ذخیره فیلدهای اضافی برای محصول پیانو دیجیتال
             */
            if( $new_product->id AND $new_product->category->id == 2 ) {
                $field = array(
                    'model' => $this->input->post('model' , true) ,
                    'brand' => $this->input->post('brand' , true) ,
                    'piano_type' => $this->input->post('piano_type' , true) ,
                    'color' => $this->input->post('color' , true) ,
                    'creator_country' => $this->input->post('creator_country' , true) ,
                    'years' => $this->input->post('years' , true) ,
                    'sound_layer_count' => $this->input->post('sound_layer_count' , true) ,
                    'speaker_count' => $this->input->post('speaker_count' , true) ,
                    'action' => $this->input->post('action' , true) ,
                    'product_id' => $new_product->id
                );
                Ads_field::create($field);
            }
            //کلمات کلیدی
            $keywords = explode('-' , $this->input->post('keywords'));
            $keyword_arr = array();
            foreach( $keywords as $val ):
                if( $val == "" OR $val == " " )
                    continue;
                $keyword_arr['keyword'] = $slugify->slugify($val);
                $key_model = Keyword::firstOrCreate($keyword_arr);
                // the third table many to many relationship
                $key_model->ads()->attach($new_product->id);
            endforeach;

            if( $shop )
                $new_link = '/shop/products/shop-list';
            else
                $new_link = '/shop/advertises';

            if( $new_product->id )
                $this->message->set_message(
                        'محصول با موفقیت ثبت شد.' , 'success' , 'ثبت محصول' , ADMIN_PATH . $new_link)->redirect();
            else {
                $this->message->set_message(
                        'مشکلی در درج محصول به وجود آمد.' , 'fail' , 'ثبت محصول' , ADMIN_PATH . $new_link)->redirect();
            }
        }
        else {
            $this->smart->assign([
                'title' => 'ثبت محصول جدید' ,
                'attr' => [ 'class' => 'uk-form-stacked' ] ,
                'users' => $this->sentinel->getUserRepository()->all() ,
                'product_category' => Ads_category::parents()->get() ,
                'shop' => 0 ,
                'product_tariff' => Ads_tariff::orderBy('time_period' , 'ASC')->get() ,
                'action' => site_url(ADMIN_PATH . '/shop/products/add') ,
            ]);
            $this->smart->view('product/add');
        }
    }

    /**
     * افزودن فروشگاه جدید
     */
    public function add_product()
    {
        $this->smart->addJS('js/ckeditor/jquery.ckeditor.js');
        $this->smart->addJS('js/ckeditor/ckeditor.js');
        $this->smart->assign([
            'title' => 'ثبت فروشگاه جدید' ,
            'attr' => [ 'class' => 'uk-form-stacked' ] ,
            'shop' => 1 ,
            'product_category' => Ads_category::parents()->get() ,
            'action' => site_url(ADMIN_PATH . '/shop/products/submit-product/1') ,
        ]);
        $this->smart->view('product/add_product');
    }

    /**
     * ثبت فروشگاه و اطلاعات وابسته در پایگاه داده
     */
    public function submit_ads( $shop = 0 )
    {
        $data = [];
        if( $this->formValidate(FALSE) ) {
            $slugify = new Slugify();

            $this->load->eloquent('Keyword');
            $data = array(
                'title' => $this->input->post('title' , true) ,
                'type' => $this->input->post('type' , true) ,
                'period_time' => $this->input->post('period_time' , true) ,
                'price' => $this->input->post('price' , true) ,
                'tell' => $this->input->post('tell' , true) ,
                'desc' => $this->input->post('desc') ,
                'short_desc' => $this->input->post('short_desc') ,
                'status' => 1 ,
                'start_period_date' => date('Y-m-d H:i:s') ,
                'start_publish_date' => date('Y-m-d H:i:s') ,
                'slug' => $slugify->slugify($this->input->post('title')) ,
                'user_id' => $this->input->post('user_id' , true) ,
                'pic' => $this->input->post('picHidden') ,
                'pic2' => $this->input->post('picHidden2') ,
                'pic3' => $this->input->post('picHidden3') ,
            );
            //وضعیت پرداخت
            $data['pay_status'] = 1;
            //اسلاگ تکراری نباشد
            $prv_ads = Product::where('slug' , $data['slug'])->get();
            if( !$prv_ads->isEmpty() )
                $data['slug'] .= '-' . time();
            //فیلم ها و فایل صوتی
//            if (!empty($_FILES['audio']['name']))
//                $data['audio'] = $this->input->audioFile('audio', 'product/audio');  
            if( !empty($_FILES['video']['name']) )
                $data['video'] = $this->input->videoFile('video' , 'product/video');
            //insert model to db and set the relation for category
            $new_product = new Advertise($data);
            $category = Ads_category::find($this->input->post(
                                    'product_category_id' , true));
            $category->ads()->save($new_product);

            /**
             * ذخیره فیلدهای اضافی برای محصول پیانو آکوستیک
             */
            if( $new_product->category->id == 1 ) {
                $field = array(
                    'model' => $this->input->post('ac_model' , true) ,
                    'brand' => $this->input->post('ac_brand' , true) ,
                    'piano_type' => $this->input->post('ac_piano_type' , true) ,
                    'diameter' => $this->input->post('ac_diameter' , true) ,
                    'height' => $this->input->post('ac_height' , true) ,
                    'color' => $this->input->post('ac_color' , true) ,
                    'creator_country' => $this->input->post('ac_creator_country' , true) ,
                    'pedal_count' => $this->input->post('ac_pedal_count' , true) ,
                    'years' => $this->input->post('ac_years' , true) ,
                    'sound_board' => $this->input->post('ac_sound_board' , true) ,
                    'wire' => $this->input->post('ac_wire' , true) ,
                    'action' => $this->input->post('ac_action' , true) ,
                    'product_id' => $new_product->id
                );
                Ads_field::create($field);
            }
            /**
             * ذخیره فیلدهای اضافی برای محصول پیانو دیجیتال
             */
            if( $new_product->id AND $new_product->category->id == 2 ) {
                $field = array(
                    'model' => $this->input->post('model' , true) ,
                    'brand' => $this->input->post('brand' , true) ,
                    'piano_type' => $this->input->post('piano_type' , true) ,
                    'color' => $this->input->post('color' , true) ,
                    'creator_country' => $this->input->post('creator_country' , true) ,
                    'years' => $this->input->post('years' , true) ,
                    'sound_layer_count' => $this->input->post('sound_layer_count' , true) ,
                    'speaker_count' => $this->input->post('speaker_count' , true) ,
                    'action' => $this->input->post('action' , true) ,
                    'product_id' => $new_product->id
                );
                Ads_field::create($field);
            }
            //کلمات کلیدی
            $keywords = explode('-' , $this->input->post('keywords'));
            $keyword_arr = array();
            foreach( $keywords as $val ):
                if( $val == "" OR $val == " " )
                    continue;
                $keyword_arr['keyword'] = $slugify->slugify($val);
                $key_model = Keyword::create($keyword_arr);
                // the third table many to many relationship
                $key_model->ads()->attach($new_product->id);
            endforeach;

            if( $shop )
                $new_link = '/shop/products/shop-list';
            else
                $new_link = '/shop/advertises';

            if( $new_product->id )
                $this->message->set_message(
                        'محصول با موفقیت ثبت شد.' , 'success' , 'ثبت محصول' , ADMIN_PATH . $new_link)->redirect();
            else {
                $this->message->set_message(
                        'مشکلی در درج محصول به وجود آمد.' , 'fail' , 'ثبت محصول' , ADMIN_PATH . $new_link)->redirect();
            }
        }
        else {
            if( $shop )
                $back_link = '/shop/products/add-product';
            else
                $back_link = '/shop/products/add';

            $this->message->set_message('خطا در داده های ورودی. ' . validation_errors() , 'warning' , 'ثبت محصول' , ADMIN_PATH . $back_link)->redirect();
        }
        redirect(ADMIN_PATH . '/shop/advertises');
    }

    /**
     * عملیات ویرایش محصول در پایگاه داده
     */
    public function edit( $id , $shop = 0 )
    {
        $this->smart->addJS('js/ckeditor/jquery.ckeditor.js');
        $this->smart->addJS('js/ckeditor/ckeditor.js');
        $this->load->eloquent('Keyword');
        $ads = Product::find($id);
        if( !$id OR ! $ads ) {
            show_404();
        }

        if( $this->input->post('submit_btn') ) {
            if( $this->formValidate(FALSE) ) {
                $data = [];
                $slugify = new Slugify();
                $data = array(
                    'title' => $this->input->post('title' , true) ,
                    'period_time' => $this->input->post('period_time' , true) ,
                    'type' => $shop == 1 ? 10 : $this->input->post('type' , true) ,
                    'price' => $this->input->post('price' , true) ,
                    'tell' => $this->input->post('tell' , true) ,
                    'desc' => $this->input->post('desc' , true) ,
                    'short_desc' => $this->input->post('short_desc') ,
                    'status' => 1 ,
                    'product_category_id' => $this->input->post('product_category_id') ,
                    'slug' => $slugify->slugify($this->input->post('title')) ,
                    'pic' => $this->input->post('picHidden') ,
                    'pic2' => $this->input->post('picHidden2') ,
                    'pic3' => $this->input->post('picHidden3') ,
                );
                //اسلاگ تکراری نباشد
                $prv_ads = Product::where('slug' , $data['slug'])->where('id' , '!=' , $id)->get();
                if( !$prv_ads->isEmpty() )
                    $data['slug'] .= '-' . time();

                if( !empty($_FILES['video']['name']) )
                    $data['video'] = $this->input->videoFile('video' , 'product/video');
                //update model 
                Product::where('id' , $id)->update($data);
                /**
                 * ذخیره فیلدهای اضافی برای محصول پیانو آکوستیک
                 */
                if( $ads->category->id == 1 ) {
                    $field = array(
                        'model' => $this->input->post('ac_model' , true) ,
                        'brand' => $this->input->post('ac_brand' , true) ,
                        'piano_type' => $this->input->post('ac_piano_type' , true) ,
                        'diameter' => $this->input->post('ac_diameter' , true) ,
                        'height' => $this->input->post('ac_height' , true) ,
                        'color' => $this->input->post('ac_color' , true) ,
                        'creator_country' => $this->input->post('ac_creator_country' , true) ,
                        'pedal_count' => $this->input->post('ac_pedal_count' , true) ,
                        'years' => $this->input->post('ac_years' , true) ,
                        'sound_board' => $this->input->post('ac_sound_board' , true) ,
                        'wire' => $this->input->post('ac_wire' , true) ,
                        'action' => $this->input->post('ac_action' , true) ,
                        'product_id' => $id
                    );
                    $ads->fields()->updateOrCreate([ 'id' => $ads->fields->id ] , $field);
                }
                /**
                 * ذخیره فیلدهای اضافی برای محصول پیانو دیجیتال
                 */
                if( $ads->category->id == 2 ) {
                    $field = array(
                        'model' => $this->input->post('model' , true) ,
                        'brand' => $this->input->post('brand' , true) ,
                        'piano_type' => $this->input->post('piano_type' , true) ,
                        'color' => $this->input->post('color' , true) ,
                        'creator_country' => $this->input->post('creator_country' , true) ,
                        'years' => $this->input->post('years' , true) ,
                        'sound_layer_count' => $this->input->post('sound_layer_count' , true) ,
                        'speaker_count' => $this->input->post('speaker_count' , true) ,
                        'action' => $this->input->post('action' , true) ,
                        'product_id' => $id
                    );
                    $ads->fields()->updateOrCreate([ 'id' => $ads->fields->id ] , $field);
                }
                //کلمات کلیدی
                $keywords = explode('-' , $this->input->post('keywords'));
                $keyword_arr = array();
                $key_ids = array();
                foreach( $keywords as $val ):
                    if( $val == "" OR $val == " " )
                        continue;
                    $keyword_arr['keyword'] = $slugify->slugify($val);
                    $key_model = Keyword::firstOrCreate($keyword_arr);
                    $key_ids[] = $key_model->id;
                endforeach;
                // the third table many to many relationship
                $ads->keywords()->sync($key_ids);

                if( $shop )
                    $back_link = '/shop/products/shop-list';
                else
                    $back_link = '/shop/advertises';
                $this->message->set_message(
                        'محصول ویرایش شد.' , 'success' , 'ویرایش محصول' , ADMIN_PATH . $back_link)->redirect();
            } else {

                if( $shop )
                    $back_link = '/shop/products/edit/' . $id . '/1';
                else
                    $back_link = '/shop/products/edit/' . $id;
                $this->message->set_message('خطا در داده های ورودی. ' . validation_errors() , 'warning' , 'ثبت محصول' , ADMIN_PATH . $back_link)->redirect();
            }
        } else {

            if( $ads->type == 10 )
                $action = site_url(ADMIN_PATH . '/shop/products/edit/' . $id . '/1');
            else
                $action = site_url(ADMIN_PATH . '/shop/products/edit/' . $id);
            $this->smart->assign([
                'title' => 'ویرایش محصول' ,
                'product_category' => Ads_category::parents()->get() ,
                'action' => $action ,
                'is_shop' => $shop ,
                'Ads' => Product::find($id) ,
                'users' => $this->sentinel->getUserRepository()->all() ,
                'attr' => [ 'class' => 'uk-form-stacked' ] ,
            ]);
            $this->smart->view('product/edit');
        }
    }

    /**
     * حذف محصول
     * @param type $product_id
     */
    public function delete( $product_id = null )
    {
        $Prd = Product::find($product_id);
        if( !$Prd ) {
            show_404();
        }
        if( $Prd->update([ 'soft_delete' => 1 ]) ) {
            $Prd->filters()->detach();
            $this->message->set_message('محصول مربوطه حذف گردید' , 'success' , 'حذف محصول ' , ADMIN_PATH . $url)->redirect();
        }
    }

}
