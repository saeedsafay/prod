<?php

/**
 * Controller: Main Shop management
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 * @link saeedtavakoli.ir author's personal website.
 */
use Cocur\Slugify\Slugify as Slugify;

class Shop extends Admin_Controller
{

    /**
     * تعریف اعتبارسنجی داده ها
     * @var type 
     */
    public $validation_rules = array(
        'index' => array(
        ) ,
        'submit_product' => array(
            [ 'field' => 'title' , 'rules' => 'required|trim|required|htmlspecialchars|max_length[100]' , 'label' => 'عنوان محصول' ] ,
            [ 'field' => 'desc' , 'rules' => 'trim' , 'label' => 'شرح' ] ,
            [ 'field' => 'price' , 'rules' => 'required|htmlspecialchars|trim|numeric' , 'label' => 'قیمت' ] ,
            [ 'field' => 'old_price' , 'rules' => 'trim|numeric' , 'label' => 'قیمت قدیم' ] ,
            [ 'field' => 'stock' , 'rules' => 'required|htmlspecialchars|trim|numeric' , 'label' => 'موجودی' ] ,
            [ 'field' => 'product_category_id' , 'rules' => 'numeric|required|htmlspecialchars' , 'label' => 'دسته بندی' ] ,
        ) ,
        'edit' => array(
            [ 'field' => 'title' , 'rules' => 'required|trim|required|htmlspecialchars|max_length[100]' , 'label' => 'عنوان آگهی' ] ,
            [ 'field' => 'desc' , 'rules' => 'trim' , 'label' => 'شرح' ] ,
            [ 'field' => 'price' , 'rules' => 'htmlspecialchars|trim|numeric' , 'label' => 'قیمت' ] ,
            [ 'field' => 'old_price' , 'rules' => 'trim|numeric' , 'label' => 'قیمت قدیم' ] ,
            [ 'field' => 'product_category_id' , 'rules' => 'numeric|required|htmlspecialchars' , 'label' => 'دسته بندی' ] ,
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Product');
        $this->load->eloquent('Product_type');
        $this->load->eloquent('Category');
        $this->load->eloquent('Ads_tariff');
        $this->load->eloquent('Field');
        $this->load->eloquent('Filter');
        $this->load->eloquent('Filter_value');
    }

    /**
     * لیست محصولات
     */
    public function product_list()
    {
        $Items = Product::orderBy('updated_at' , 'DESC')->get();
        $this->smart->assign(
                [
                    'title' => 'محصول های ثبت شده' ,
                    'Products' => $Items ,
                    'add_link' => site_url(ADMIN_PATH . "/shop/shop/add-shop") ,
                ]
        );
        $this->smart->view('shop/index');
    }

    public function orders()
    {
        $orders = Cart::where('status' , 1)->get();
        $this->smart->assign([
            'Orders' => $orders ,
            'title' => 'لیست سفارشات ثبت شده'
        ]);
        $this->smart->view('shop/orders');
    }

    /**
     * نمایش آگهی
     * @param type $id
     */
    public function view_product( $id )
    {
        $Ads = Product::find($id);
        $this->show_404_on(!$id);
        $this->show_404_on(!$Ads);
        $this->smart->assign(
                [
                    'title' => 'محصول - ' . $Ads->title ,
                    'Product' => $Ads ,
                ]
        );
        $this->smart->view('shop/view');
    }

    /**
     * نمایش آیتم های سفارش
     * @param type $id
     */
    public function view_order( $id )
    {
        $Cart = Cart::find($id);
        $this->show_404_on(!$id);
        $this->show_404_on(!$Cart);
        $this->smart->assign(
                [
                    'title' => 'نمایش موارد خرید شده ' ,
                    'Items' => $Cart->products ,
                    'Cart' => $Cart ,
                    'buyer' => $Cart->user ,
                    'id' => $id ,
                ]
        );
        $this->smart->view('shop/view_order');
    }

    public function publication( $id )
    {
        $Product = Product::find($id);
        if( $Product->update(array( 'status' => 1 )) )
            $this->message->set_message('وضعیت محصول با موفقیت تغییر یافت' , 'success' , 'تغییر وضعیت محصول' , ADMIN_PATH . '/shop/shop/product-list')->redirect();
        else
            $this->message->set_message('مشکلی رخ داد مجدد تلاش کنید' , 'fail' , 'تغییر وضعیت محصول' , ADMIN_PATH . '/shop/shop/product-list')->redirect();
    }

    public function reject( $id )
    {
        $Product = Product::find($id);
        if( $Product->update(array( 'status' => 3 )) )
            $this->message->set_message('وضعیت محصول با موفقیت تغییر یافت' , 'success' , 'تغییر وضعیت محصول' , ADMIN_PATH . '/shop/shop/product-list')->redirect();
        else
            $this->message->set_message('مشکلی رخ داد مجدد تلاش کنید' , 'fail' , 'تغییر وضعیت محصول' , ADMIN_PATH . '/shop/shop/product-list')->redirect();
    }

    /**
     * تغییر وضعیت سفارش 
     * @param type $ads_id
     */
    public function toggleStatus( $id , $status )
    {
        /**
         * استاتوس = 2 محصول ارسال شد
         * استاتوس = 3 محصول تحویل مشتری شد
         * استاتوس = 1 مشتری سفارش را تایید و پرداخت کرد
         */
        $Cart = Cart::find($id);
        if( $Cart->update(array( 'status' => $status )) )
            $this->message->set_message('وضعیت سفارش با موفقیت تغییر یافت' , 'success' , 'تغییر وضعیت سفارش' , ADMIN_PATH . '/shop/shop/orders')->redirect();
        else
            $this->message->set_message('مشکلی رخ داد مجدد تلاش کنید' , 'fail' , 'تغییر وضعیت سفارش' , ADMIN_PATH . '/shop/shop/orders')->redirect();
    }

    /**
     * افزودن فروشگاه جدید
     */
    public function add_product()
    {
        $this->smart->addJS('js/ckeditor/jquery.ckeditor.js');
        $this->smart->addJS('js/ckeditor/ckeditor.js');
        $this->load->eloquent('Feature');
        $this->smart->assign([
            'title' => 'ثبت فروشگاه جدید' ,
            'attr' => [ 'class' => 'uk-form-stacked' ] ,
            'ads_category' => Category::parents()->get() ,
            'prd_cats' => Category::all() ,
            'features' => Feature::all() ,
            'action' => site_url(ADMIN_PATH . '/shop/shop/submit-product') ,
        ]);
        $this->smart->view('shop/add_product');
    }

    /**
     * ثبت فروشگاه و اطلاعات وابسته در پایگاه داده
     */
    public function submit_product()
    {
        $data = [];
        if( $this->formValidate(FALSE) ) {
            $slugify = new Slugify();
            $this->load->eloquent('Keyword');
            $this->load->eloquent('Feature');
            $this->load->eloquent('Color');
            $data = array(
                'title' => $this->input->post('title' , true) ,
                'type' => 10 ,
                'user_id' => $this->user->id ,
                'period_time' => 1000 ,
                'price' => $this->input->post('price' , true) ,
                'wholesale_price' => $this->input->post('wholesale_price' , true) ,
                'old_price' => $this->input->post('old_price' , true) ,
                'stock' => $this->input->post('stock' , true) ,
                'desc' => $this->input->post('desc') ,
                'short_desc' => $this->input->post('short_desc') ,
                'status' => 1 ,
                'start_period_date' => date('Y-m-d H:i:s') ,
                'start_publish_date' => date('Y-m-d H:i:s') ,
                'slug' => $slugify->slugify($this->input->post('title')) ,
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
            //insert model to db and set the relation for category
            $new_ads = new Product($data);

            if( $this->input->post('product_category_child_id' , true) ) {
                $cat_id = $this->input->post('product_category_child_id' , true);
            }
            else {
                $cat_id = $this->input->post('product_category_id' , true);
            }
            $category = Category::find($cat_id);
            $category->product()->save($new_ads);
            // ویژگی ها
            if( $this->input->post('feature') ) {
                foreach( $this->input->post('feature') as $key => $val ):
                    $feature = Feature::find($key);
                    $img = null;
                    if( !empty($_FILES['featurephoto' . $key]) )
                        $img = $this->input->imageFile('featurephoto' . $key , 'ads/pic');
                    $feature->products()->attach($new_ads->id , [ 'valueable' => $key , 'img' => $img ]);
                endforeach;
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
                $key_model->product()->attach($new_ads->id);
            endforeach;

            $new_link = '/shop/shop/product-list';

            if( $new_ads->id )
                $this->message->set_message(
                        'آگهی با موفقیت ثبت شد.' , 'success' , 'ثبت محصول' , ADMIN_PATH . $new_link)->redirect();
            else {
                $this->message->set_message(
                        'مشکلی در درج محصول به وجود آمد.' , 'fail' , 'ثبت محصول' , ADMIN_PATH . $new_link)->redirect();
            }
        }
        else {
            $back_link = '/shop/shop/add-product';

            $this->message->set_message('خطا در داده های ورودی. ' . validation_errors() , 'warning' , 'ثبت محصول' , ADMIN_PATH . $back_link)->redirect();
        }
        redirect(ADMIN_PATH . '/shop/shop');
    }

    /**
     * عملیات ویرایش آگهی در پایگاه داده
     */
    public function edit( $id )
    {
        $this->smart->addJS('js/ckeditor/jquery.ckeditor.js');
        $this->smart->addJS('js/ckeditor/ckeditor.js');
        $this->load->eloquent('keyword');
        $this->load->eloquent('Feature');
        $this->load->eloquent('Color');
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
                    'period_time' => 1000 ,
                    'user_id' => $this->user->id ,
                    'type' => 10 ,
                    'price' => $this->input->post('price' , true) ,
                    'old_price' => $this->input->post('old_price' , true) ,
                    'stock' => $this->input->post('stock' , true) ,
                    'desc' => $this->input->post('desc' , true) ,
                    'short_desc' => $this->input->post('short_desc') ,
                    'status' => 1 ,
                    'slug' => $slugify->slugify($this->input->post('title')) ,
                    'pic' => $this->input->post('picHidden') ,
                    'pic2' => $this->input->post('picHidden2') ,
                    'pic3' => $this->input->post('picHidden3') ,
                );

                if( $this->input->post('product_category_child_id' , true) ) {
                    $data['product_category_id'] = $this->input->post('product_category_child_id' , true);
                }
                else {
                    $data['product_category_id'] = $this->input->post('product_category_id' , true);
                }

                //اسلاگ تکراری نباشد
                $prv_ads = Product::where('slug' , $data['slug'])->where('id' , '!=' , $id)->get();
                if( !$prv_ads->isEmpty() )
                    $data['slug'] .= '-' . time();

                if( !empty($_FILES['video']['name']) )
                    $data['video'] = $this->input->videoFile('video' , 'ads/video');
                //update model 
                Product::where('id' , $id)->update($data);
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

                // ویژگی ها
                foreach( $this->input->post('feature') as $key => $val ):
                    $feature = Feature::find($key);
                    $img = null;
                    if( !empty($_FILES['featurephoto' . $key]) )
                        $img = $this->input->imageFile('featurephoto' . $key , 'ads/pic');
                    $feature->products()->sync([ $ads->id => [ 'valueable' => $val , 'img' => $img ] ]);
                endforeach;

                $back_link = '/shop/shop/product-list';
                $this->message->set_message(
                        'محصول ویرایش شد.' , 'success' , 'ویرایش محصول' , ADMIN_PATH . $back_link)->redirect();
            } else {

                $back_link = '/shop/shop/edit/' . $id;
                $this->message->set_message('خطا در داده های ورودی. ' . validation_errors() , 'warning' , 'ثبت محصول' , ADMIN_PATH . $back_link)->redirect();
            }
        }
        else {

            $action = site_url(ADMIN_PATH . '/shop/shop/edit/' . $id);

            $category = Category::find($ads->product_category_id);
            if( $category->grandparent_id != 0 ) {
                $this->smart->assign([
                    'f_level_c' => $category->parentCat->id ,
                    's_level_c' => $category->id ,
                    'grandson_cats' => Category::where('parent_id' , $category->parent_id)->get() ,
                ]);
            }
            $this->smart->assign([
                'title' => 'ویرایش محصول' ,
                'ads_category' => Category::parents()->get() ,
                'action' => $action ,
                'features' => Feature::all() ,
                'Product' => Product::find($id) ,
                'attr' => [ 'class' => 'uk-form-stacked' ] ,
            ]);
            $this->smart->view('shop/edit_product');
        }
    }

    /**
     * مشاهده لیست کد های تخفیف تولید شده
     */
    public function couponGenerator()
    {
        $this->load->eloquent('Coupon');
        $this->smart->assign(array(
            'title' => 'کد تخفیف فروشگاه' ,
            'Coupons' => Coupon::all() ,
        ));
        $this->smart->view('shop/coupons');
    }

    /**
     * مشاهده لیست کد های تخفیف تولید شده
     */
    public function groupDiscounts()
    {
        $this->load->eloquent('Group_discount');
        $saeed = Group_discount::where('id' , '>' , 0)->first();
//        Carbon\Carbon::diffInDays()
//        dd(Carbon\Carbon::now()->diffInDays($saeed->created_at->addDays($saeed->expire)) <= $saeed->expire);
        $this->smart->assign(array(
            'title' => 'تخفیف گروهی' ,
            'group_discounts' => Group_discount::all() ,
        ));
        $this->smart->view('shop/group_discounts');
    }

    /**
     * ساخت یک کد تخفیف جدید
     */
    public function addCoupon( $id = null )
    {
        $this->load->eloquent('Coupon');
        if( $id ) {
            $Coupon = Coupon::find($id);
            $this->smart->assign(array( 'Coupon' => $Coupon ));
        }
        if( $this->input->post('submit_btn') ) {
            $data = [
                'discount' => $this->input->post('discount') ,
                'status' => 0 ,
                'code' => substr(md5(time()) , 5 , 6) ,
            ];
            if( Coupon::updateOrCreate([ 'id' => $id ] , $data) ):
                $back_link = ADMIN_PATH . '/shop/shop/couponGenerator';
                $this->message->set_message(
                        'کوپن جدید افزوده شد' , 'success' , 'ثبت کوپن تخفیف ' , $back_link)->redirect();
            endif;
        }
        else {
            $this->smart->assign([
                'title' => 'تولید کد تخفیف جدید' ,
                'edit_mode' => isset($id) ? 1 : 0 ,
            ]);
            $this->smart->view('shop/edit_coupon');
        }
    }

    /**
     * ساخت یک کد تخفیف جدید
     */
    public function addGroupDiscount( $id = null )
    {
        $this->load->eloquent('Group_discount');
        if( $id ) {
            $Discount = Group_discount::find($id);
            $this->smart->assign(array( 'Discount' => $Discount ));
        }
        $slugify = new Slugify();
        if( $this->input->post('submit_btn') ) {
            $data = [
                'discount' => $this->input->post('discount') ,
                'status' => $this->input->post('status') ,
                'expire' => $this->input->post('expire') ,
                'slug' => $slugify->slugify($this->input->post('slug')) ,
            ];
            if( $group_discount = Group_discount::updateOrCreate([ 'id' => $id ] , $data) ):

                $group_discount->products()->sync($this->input->post('products') , true);
                $back_link = ADMIN_PATH . '/shop/shop/groupDiscounts';
                $this->message->set_message(
                        'تخفیف گروهی ثبت شد' , 'success' , 'ثبت تخفیف گروهی ' , $back_link)->redirect();
            endif;
        }
        else {
            $this->smart->assign([
                'title' => 'افزودن تخفیف جدید' ,
                'edit_mode' => isset($id) ? 1 : 0 ,
                'products' => Product::all() ,
            ]);
            $this->smart->view('shop/edit_discountGroup');
        }
    }

    /**
     * ثبت ویژگی جدید برای محصول
     */
    public function features_edit( $id = null )
    {
        $this->load->eloquent('Feature');
        if( $id ) {
            $Feature = Feature::find($id);
            $this->smart->assign(array( 'Feature' => $Feature ));
        }
        if( $this->input->post('submit_btn') ) {
            $data = [
                'title' => $this->input->post('title') ,
            ];
            if( Feature::updateOrCreate([ 'id' => $id ] , $data) ):
                $back_link = ADMIN_PATH . '/shop/shop/features-list';
                $this->message->set_message(
                        'ویژگی افزوده شد' , 'success' , 'ثبت ویژگی اضافه' , $back_link)->redirect();
            endif;
        }
        else {
            $this->smart->assign([
                'title' => isset($id) ? $Feature->title : 'افزودن ویژگی اضافه محصول' ,
                'edit_mode' => isset($id) ? 1 : 0 ,
            ]);
            $this->smart->view('shop/features/edit');
        }
    }

    public function features_list()
    {
        $this->load->eloquent('Feature');
        $this->smart->assign([
            'title' => 'ویژگی های اضافی محصول' ,
            'Features' => Feature::all() ,
        ]);
        $this->smart->view('shop/features/index');
    }

    /**
     * حذف آگهی
     * @param type $ads_id
     */
    public function features_delete( $id = null )
    {
        $this->load->eloquent('Feature');
        if( $Feature = Feature::find($id) ) {

            $url = ADMIN_PATH . '/shop/shop/features-list';
            if( $Feature->delete() ) {
                $this->message->set_message('ویژگی مربوطه حذف گردید' , 'success' , 'حذف ویژگی ' , $url)->redirect();
            }
        }
        else {
            show_404();
        }
    }

///////////////////shipping ///////////////////////////

    /**
     * ثبت ویژگی جدید برای محصول
     */
    public function shipping_edit( $id = null )
    {
        $this->load->eloquent('Shipping');
        if( $id ) {
            $Shipping = Shipping::find($id);
            $this->smart->assign(array( 'Shipping' => $Shipping ));
        }
        if( $this->input->post('submit_btn') ) {
            $data = [
                'shipping' => $this->input->post('shipping') ,
                'price' => $this->input->post('price') ,
            ];
            if( Shipping::updateOrCreate([ 'id' => $id ] , $data) ):
                $back_link = ADMIN_PATH . '/shop/shop/shipping-list';
                $this->message->set_message(
                        'حمل و نقل افزوده شد' , 'success' , 'ثبت حمل و نقل' , $back_link)->redirect();
            endif;
        }
        else {
            $this->smart->assign([
                'title' => isset($id) ? $Shipping->shipping : 'افزودن حمل و نقل' ,
                'edit_mode' => isset($id) ? 1 : 0 ,
            ]);
            $this->smart->view('shop/shipping/edit');
        }
    }

    public function shipping_list()
    {
        $this->load->eloquent('Shipping');
        $this->smart->assign([
            'title' => 'حمل و نقل محصول' ,
            'Shipping' => Shipping::all() ,
        ]);
        $this->smart->view('shop/shipping/index');
    }

    /**
     * حذف آگهی
     * @param type $ads_id
     */
    public function shipping_delete( $id = null )
    {
        $this->load->eloquent('Shipping');
        if( $Shipping = Shipping::find($id) ) {

            $url = ADMIN_PATH . '/shop/shop/shipping-list';
            if( $Shipping->delete() ) {
                $this->message->set_message('حمل و نقل مربوطه حذف گردید' , 'success' , 'حذف حمل و نقل ' , $url)->redirect();
            }
        }
        else {
            show_404();
        }
    }

//////////////////////////////////END SHIPPING ///////////////////////////

    /**
     * حذف محصول
     * @param type $product_id
     */
    public function delete( $product_id = null )
    {
        if( $Prd = Product::find($product_id) ) {
            if( $Prd->update([ 'soft_delete' => 1 ]) ) {
                foreach( $Prd->filters as $filter_value ):
                    $filter_value->delete();
                endforeach;
                $url = '/shop/shop/product-list';
                $this->message->set_message('محصول مربوطه حذف گردید' , 'success' , 'حذف محصول ' , ADMIN_PATH . $url)->redirect();
            }
        }
        else {
            show_404();
        }
    }

    public function getChildCats()
    {
        $cat_id = $this->input->post('id');
        echo json_encode(array( 'result' => Category::where('parent_id' , $cat_id)->get() ));
        exit();
    }

}
