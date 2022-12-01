<?php

defined('BASEPATH') OR exit('No direct script access allowed');

// This can be removed if you use __autoload() in config.php OR use Modular Extensions
/** @noinspection PhpIncludeInspection */
require APPPATH . 'libraries/REST_Controller.php';

/**
 *  کلاس مربوط به سرویس‌های موبایل و apiها
 * 
 *
 * @package         API
 * @subpackage      Shop Category
 * @category        Controller
 * @author          Saeed Tavakoli <saeed.g71@gmail.com>
 * @license         GNU
 */
class Get_api extends REST_Controller
{

    function __construct()
    {
        // Construct the parent class
        parent::__construct();


        // Configure limits on our controller methods
        // Ensure you have created the 'limits' table and enabled 'limits' within application/config/rest.php
        $this->methods['cats_get']['limit'] = 50000000; // 500 requests per hour per user/key
    }

    public function test_get()
    {
        print_r($this->get());
        $data = array( 'msg' => $msg );
        $this->load->view('mobilePaymentDone' , $data);
        return true;
    }

    /**
     * ثبت نام کاربر با استفاده از تایید شماره موبایل

     * @param varchar $mobile شماره موبایل
     * @param varchar $password کلمه عبور
     * @param varchar $first_name نام کاربر
     * @param varchar $last_name نام خانوادگی کاربر
     * @param varchar $username نام کاربری که شامل حروف لاتین می‌باشد
     */
    public function register_post()
    {

        $this->load->sentinel();
        $params['mobile'] = $this->post('mobile');
        $params['password'] = $this->post('password');
        $params['first_name'] = urldecode($this->post('first_name'));
        $params['last_name'] = urldecode($this->post('last_name'));
        $params['username'] = $this->post('username');
        $front_TOKEN = md5($this->post('mobile') . time());

        $mobile_validation = $this->mobile_validation($params['mobile']);
        if( $mobile_validation === true ) {
            $username_validation = $this->username_validation($params['username']);
            if( $username_validation ) {

                $credentials = [
                    'mobile' => $params['mobile'] ,
                    'password' => $params['password'] ,
                    'first_name' => $params['first_name'] ,
                    'last_name' => $params['last_name'] ,
                    'type' => 2 ,
                    'username' => $params['username'] ,
                    'token' => $front_TOKEN ,
                    'status' => 0 ,
                ];
                //register user
                $user = $this->sentinel->register($credentials);
                $user->roles()->sync(array( 3 )); // buyer
                //creating activation row for user
                $activation = $this->sentinel->getActivationRepository()->init_code($user , true);
                $message_sms = "کد فعال سازی حساب شما: " . $activation->code;
                $smsParams = array( 'message' => $message_sms , 'rcpt_nm' => array( $credentials['mobile'] ) );
                if( $this->sendSms($smsParams) ) {

                    $res = array(
                        'status' => true ,
                        'msg' => 'OK' ,
                        'data' => array( 'token' => $front_TOKEN , 'user_id' => $user->id ) ,
                    );

                    // Set the response and exit
                    $this->response($res , REST_Controller::HTTP_CREATED); // OK (200) being the HTTP response code
                }
            }
            else {
                if( $username_validation == 2 ) {
                    $res = array(
                        'status' => false ,
                        'resend_code' => false ,
                        'msg' => 'نام کاربری باید شامل حروف لاتین و اعداد باشد' ,
                    );

                    // Set the response and exit
                    $this->response($res , REST_Controller::HTTP_NOT_ACCEPTABLE); // OK (200) being the HTTP response code
                }
                else {
                    $res = array(
                        'status' => false ,
                        'resend_code' => false ,
                        'msg' => "نام کاربری وارد شده درحال حاضر در سایت ثبت نام شده است"
                    );

                    // Set the response and exit
                    $this->response($res , REST_Controller::HTTP_NOT_ACCEPTABLE); // OK (200) being the HTTP response code
                }
            }
        }
        elseif( $mobile_validation ) {
            $res = array(
                'status' => false ,
                'resend_code' => true ,
                'msg' => 'شماره موبایل وارد شده ثبت شده است ولی فعال سازی انجام نشده است.' ,
                'data' => array( 'token' => $mobile_validation->token , 'user_id' => $mobile_validation->id ) ,
            );

            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_NOT_ACCEPTABLE); // OK (200) being the HTTP response code
        }
        else {
            $res = array(
                'status' => false ,
                'resend_code' => false ,
                'msg' => "شماره موبایل وارد شده درحال حاضر در سایت ثبت نام شده است"
            );

            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_NOT_ACCEPTABLE); // OK (200) being the HTTP response code
        }
    }

    /**
     * Activate user mobile after registering
     * @param type $user_id
     * @param type $activation_code
     * @return type
     */
    function activate_get()
    {
        // کدی که کابر وارد کرده
        $activation_code = $this->get('code');
        $token = $this->get('token');
        if( !$token ) {

            $res = array(
                'status' => false ,
                'msg' => 'درخواست نامعتبراست' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_NOT_FOUND);
        }
        if( !isset($activation_code) ) {
            $res = array(
                'status' => false ,
                'msg' => 'کد فعال‌سازی را وارد نمایید .' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_NOT_FOUND);
        }
        $credentials = [
            'token' => $token ,
        ];
        $this->load->sentinel();
        // اگر کابری که با توکن ثبت نام شده در پایگاه داده یافت نشده
        if( !$user = $this->sentinel->getUserRepository()->where($credentials)->first() ) {
            $res = array(
                'status' => false ,
                'msg' => 'چنین کاربری در سیستم ثبت نشده است' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_NOT_FOUND);
        }
        if( $activation = $this->sentinel->getActivationRepository()->exists($user) ) {

            if( $this->sentinel->getActivationRepository()->complete($user , $activation_code) ) {
                $user->update([ 'status' => 1 ]);
                if( $this->sentinel->login($user) ) {
                    $res = array(
                        'status' => true ,
                        'msg' => 'ثبت با موفقیت انجام شد' ,
                        'data' => array(
                            'username' => $user->username ,
                            'user_id' => $user->id ,
                            'fist_name' => $user->first_name ,
                            'last_name' => $user->last_name ,
                        ) ,
                    );
                    // Set the response and exit
                    $this->response($res , REST_Controller::HTTP_OK);
                }
                else {
                    $res = array(
                        'status' => true ,
                        'msg' => 'حساب شما فعال شد اما عملیات لاگین صورت نگرفت. برای ورود مجدد تلاش کنید.' ,
                    );
                    // Set the response and exit
                    $this->response($res , REST_Controller::HTTP_OK);
                }
            }
            else {
                $res = array(
                    'status' => false ,
                    'msg' => 'کد فعال‌سازی صحیح نیست.' ,
                );
                // Set the response and exit
                $this->response($res , REST_Controller::HTTP_NOT_ACCEPTABLE);
            }
        }
        else {
            $res = array(
                'status' => false ,
                'msg' => 'درخواست نامعتبراست' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_NOT_FOUND);
        }
    }

    public function cart_get()
    {
        $user_id = $this->get('user_id');
        $type = $this->get('type');
        $type = isset($type) ? $type : 1;
        $this->load->eloquent('shop/Cart');
        $this->load->eloquent('shop/Product');
        $Cart = [];
        if( $type == 1 ) {
            if( $Cart = Cart::where('user_id' , $user_id)->where('status' , 0)->where('product_type' , 1)->first() ) {
                //push single products to the cart
                if( $Cart->single_cart_id ) {
                    $subCart = Cart::where('user_id' , $user_id)->where('status' , 0)->where('product_type' , 2)->first();
                    $push = array();
                    foreach( $subCart->products as $val ):
                        $push[] = $val;
                    endforeach;
//                    $Cart->products->put('single' , $subCart);
                }
                $CartItems = $Cart->products;
//                dd($CartItems['single']->products);
                $data['single']['products'] = isset($subCart) ? $subCart->products : null;
                $data['single']['cart'] = isset($subCart) ? $subCart : null;
                $data['pack']['products'] = $Cart->products;
                $data['pack']['cart'] = $Cart;
            }
            // برای سبد شاخه ای ها
        }
        elseif( $type == 2 ) {
            $data['cart'] = Cart::where('user_id' , $user_id)->where('status' , 0)->where('product_type' , 2)->first();
            $data['products'] = $data['cart']->products;
        }
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => $data ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت اسلایدرهای پروفایل فروشنده
     */
    public function sliders_get()
    {
        $this->load->eloquent('users/User');
        $this->load->eloquent('users/User_profile');
        $user_id = $this->get('user_id');
        $User = User::find($user_id);
        $data = array(
            'img1' => $User->profile->image_slide1 ,
            'img2' => $User->profile->image_slide2 ,
            'img3' => $User->profile->image_slide3 ,
        );
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => $data ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت لیست علاقمندی‌ها
     */
    public function favorites_get()
    {
        $this->load->eloquent('shop/Favorite');
        $this->load->eloquent('shop/Product');
        $user_id = $this->get('user_id');
        $favorites = Favorite::getUserFavs($user_id);

        $data = [];
        foreach( $favorites as $val ):
            $data[] = array(
                'id' => $val->id ,
                'title' => $val->product->title ,
                'img' => $val->product->pic ,
                'price' => $val->product->price ,
                'product_id' => $val->product->id ,
            );
        endforeach;
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array( 'list' => $data ) ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * ویرایش پروفایل
     */
    public function editprofile_put()
    {
        $this->load->eloquent('users/User');
        $this->load->eloquent('users/User_contact');
        $user_id = $this->put('user_id');


        $data = [
            'first_name' => urldecode($this->put('first_name')) ,
            'last_name' => urldecode($this->put('last_name')) ,
            'sex' => $this->put('sex') ,
            'email' => $this->put('email') ,
        ];
        $User = User::find($user_id);
        $User->update($data);

        $contact = [
            'telegram' => $this->put('telegram') ,
            'tell' => $this->put('tell') ,
        ];
        $User->contact()->updateOrCreate(array( 'user_id' => $user_id ) , $contact);
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * افزودن آدرس های من
     */
    public function addressadd_get()
    {
        $this->load->eloquent('users/User_address');

        $user_id = $this->get('user_id');

        $address = [
            'title' => urldecode($this->get('title')) ,
            'province_id' => $this->get('province_id') ,
            'county_id' => $this->get('county_id') ,
            'region_id' => $this->get('region_id') ,
            'neighbourhood_id' => $this->get('neighbourhood_id') ,
            'full_address' => urldecode($this->get('full_address')) ,
            'user_id' => $this->get('user_id') ,
        ];

        $reminders = User_address::create($address)->get();

        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت لیست آدرس‌ها
     */
    public function addresses_get()
    {
        $this->load->eloquent('users/User_address');
        $user_id = $this->get('user_id');
        $addresses = User_address::where('user_id' , $user_id)->get();
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array( 'list' => $addresses ) ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت لیست تراکنش های مالی من
     */
    public function transactions_get()
    {
        $this->load->eloquent('payment/Transaction');
        $user_id = $this->get('user_id');
        $transactions = Transaction::where('user_id' , $user_id)->get();
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array( 'list' => $transactions ) ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * گل فروشی های برتر
     */
    public function topshops_get()
    {
        $this->load->eloquent('users/User');
        $this->load->eloquent('users/User_profile');
        $tops = User::where('top' , 1)->get();
        foreach( $tops as $val ):
            $data[] = array(
                'id' => $val->id ,
                'business_name' => $val->business_name ,
                'username' => $val->username ,
                'logo' => $val->profile->logo ,
            );
        endforeach;
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array( 'list' => $data ) ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * گل فروشی های برتر
     */
    public function shopinfo_get()
    {
        $this->load->eloquent('users/User');
        $this->load->eloquent('users/User_profile');
        $this->load->eloquent('users/User_address');
        $this->load->eloquent('users/User_contact');
        $shop_id = $this->get('shop_id');
        $shop = User::find($shop_id);
        $contact = $shop->contact;
        $profile = $shop->profile;
        $location = $shop->location;
        $shop = collect($shop);
        $shop->forget('permissions');
        $shop->forget('password');
        $shop->forget('last_login');
        $shop->forget('token');
        $shop->forget('created_at');
        $shop->forget('updated_at');
        $shop->forget('sale_percent');
        $shop->forget('cash');
        $shop->forget('sex');
        $shop->forget('address');
        $shop->forget('type');
        $data = array(
            'shop_info' => $shop ,
            'contact' => $contact ,
            'profile' => $profile ,
            'address' => $location ,
        );
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array( 'list' => $data ) ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * حذف از علاقمندی
     */
    public function deleteFavorite_get()
    {
        $this->load->eloquent('shop/Favorite');
        $fav_id = $this->get('fav_id');
        Favorite::where('id' , $fav_id)->first()->delete();

        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array() ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * حذف از آدرس‌ها
     */
    public function deleteaddress_get()
    {
        $this->load->eloquent('users/User_address');
        $address_id = $this->get('address_id');
        User_address::where('id' , $address_id)->first()->delete();

        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array() ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت لیست یادآورها
     */
    public function reminders_get()
    {
        $this->load->eloquent('users/Reason_reminder');
        $user_id = $this->get('user_id');
        $reminder_id = $this->get('reminder_id');
        if( $reminder_id ) {
            $reminder = Reason_reminder::find($reminder_id);
            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => $reminder ,
            );

            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
        }
        else {
            $reminders = Reason_reminder::where('user_id' , $user_id)->get();
            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => array( 'list' => $reminders ) ,
            );

            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
        }
    }

    /**
     * دریافت لیست یادآورها
     */
    public function remindersadd_get()
    {
        $this->load->eloquent('users/Reason_reminder');

        $reminder_id = $this->get('reminder_id');

        $data = [
            'title' => urldecode($this->get('title')) ,
            'reason_type' => urldecode($this->get('reason_type')) ,
            'description' => urldecode($this->get('desc')) ,
            'user_id' => $this->get('user_id') ,
        ];
        $reminder_timestamp = $this->get('date');

        $data['date'] = date('Y-m-d' , $reminder_timestamp);
        $reminders = Reason_reminder::updateOrCreate([ 'id' => $reminder_id ] , $data)->get();

        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * حذف یادآورها
     */
    public function reminderDelete_get()
    {
        $this->load->eloquent('users/Reason_reminder');
        $reminder_id = $this->get('reminder_id');
        $reminders = Reason_reminder::where('id' , $reminder_id)->first()->delete();

        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array() ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت لیست شهر و استان و محله
     */
    public function provinces_get()
    {
        $this->load->eloquent('users/Province');
        $this->load->eloquent('users/Location_county');
        $this->load->eloquent('users/Location_region');
        $this->load->eloquent('users/Location_neighbourhood');
        $province_id = $this->get('province_id');
        $county_id = $this->get('county_id');
        $region_id = $this->get('region_id');

        if( $province_id ) {
            $counties = Province::find($province_id)->county;

            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => array( 'list' => $counties ) ,
            );
        }
        elseif( $county_id ) {
            $regions = Location_county::find($county_id)->regions;
            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => array( 'list' => $regions ) ,
            );
        }
        elseif( $region_id ) {
            $neighbourhoods = Location_region::find($region_id)->neighbourhoods;

            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => array( 'list' => $neighbourhoods ) ,
            );
        }
        else {

            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => array( 'list' => Province::all() ) ,
            );
        }
        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت لیست همه دسته بندی های فروشگاه
     */
    public function cats_get()
    {
        $this->load->eloquent('shop/Category');
        $cats = Category::select(array( 'id as catid' , 'title' , 'image' ))->get();

        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array( 'list' => $cats ) ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت لیست مناسبت ها
     */
    public function reasons_get()
    {
        $this->load->eloquent('shop/Reason');
        $reasons = Reason::select(array( 'id as rid' , 'title' , 'image' ))->get();

        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array( 'list' => $reasons ) ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت محصولات وابسته به یک دسته بندی
     */
    public function productsByCategory_get()
    {
        // Params
        $params['catid'] = $this->get('catid');
        $params['user_id'] = $this->get('user_id');
        $params['reason_id'] = $this->get('reason_id');
        $params['flower_type'] = $this->get('flower_type');
        $params['stock_type'] = $this->get('stock_type');
        $params['free_shipping'] = $this->get('free_shipping');
        $params['is_discounnt'] = $this->get('discount');
        $params['price']['min'] = $this->get('min_price');
        $params['price']['max'] = $this->get('max_price');
        $params['limit'] = $this->get('limit') ? $this->get('limit') : 20;
        $params['offset'] = $this->get('offset') ? $this->get('offset') : 0;
        $params['province_id'] = null;
        $params['county_id'] = null;
        $params['region_id'] = null;
        $params['neighbourhood_id'] = null;

        $this->load->eloquent('shop/Product');
        $this->load->eloquent('shop/Flower_type');
        $this->load->eloquent('shop/Category');
        $this->load->eloquent('shop/Reason');
        $this->load->eloquent('shop/Favorite');
        $this->load->sentinel();
        // Params for filtering results
        // Sort By 
        // Default
        $orderBy = array( 'edited_time' , 'DESC' );
        // User request
        if( $this->get('sort') ) {
            $getOrder = $this->get('sort');
            if( $getOrder == 'lowPrice' ) {
                $orderBy[0] = 'price';
                $orderBy[1] = 'asc';
            }
            elseif( $getOrder == 'highPrice' ) {
                $orderBy[0] = 'price';
                $orderBy[1] = 'desc';
            }
            elseif( $getOrder == 'newest' ) {
                $orderBy[0] = 'edited_time';
                $orderBy[1] = 'desc';
            }
            elseif( $getOrder == 'mostVisited' ) {
                $orderBy[0] = 'visit_counts';
                $orderBy[1] = 'desc';
            }
            elseif( $getOrder == 'sold' ) {
                $orderBy[0] = 'sold_count';
                $orderBy[1] = 'desc';
            }
        }
        // Get current category given by parameter
        $Category = Category::find($params['catid']);

        $whereCatsIn = [];
        // For a category and its children filter
        $ids = Category::where('id' , $params['catid'])->orWhere('parent_id' , $params['catid'])->get();
        foreach( $ids as $id ):
            $whereCatsIn[] = $id->id;
        endforeach;
        $params['type'] = 1;
        // Get products for needed categories

        $Products = Product::getProductsByCategory($whereCatsIn , $orderBy , $params , $params['limit'] , $params['offset']);
        $item = [];
        foreach( $Products['requested'] as $val ):
            $fav = Favorite::where('user_id' , $params['user_id'])->where('product_id' , $val->id)->get();
            $item[] = array(
                'id' => $val->id ,
                'title' => $val->title ,
                'state' => $val->stock_type ,
                'cash' => $val->price ,
                'discount_price' => $val->discount_price ,
                'main_img' => $val->pic ,
                'business_name' => $val->user->business_name ,
                'favorite' => $fav->isEmpty() ? false : true ,
            );
        endforeach;
//Pagination configs
// Now init the configs for pagination class
        $data = array( 'products' =>
            $item
        );
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => $data ,
        );
        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    public function specialSales_get()
    {
        $this->load->eloquent('shop/Product');
        $this->load->eloquent('shop/Favorite');
        // Params for filtering results
        $params['category_id'] = $this->get('category_id');
        $params['user_id'] = $this->get('user_id');
        $params['reason_id'] = $this->get('reason_id');
        $params['flower_type'] = $this->get('flower_type');
        $params['stock_type'] = $this->get('stock_type');
        $params['free_shipping'] = $this->get('free_shipping');
        $params['price']['min'] = $this->get('min_price');
        $params['price']['max'] = $this->get('max_price');
        $params['province_id'] = null;
        $params['county_id'] = null;
        $params['region_id'] = null;
        $params['neighbourhood_id'] = null;
        if( $params['category_id'] )
            $Category = Category::find($params['category_id']);
        // Sort By 
        // Default
        $orderBy = array( 'id' , 'DESC' );
        // User request
        if( $this->get('sort') ) {
            $getOrder = $this->get('sort');
            if( $getOrder == 'lowPrice' ) {
                $orderBy[0] = 'price';
                $orderBy[1] = 'asc';
            }
            elseif( $getOrder == 'highPrice' ) {
                $orderBy[0] = 'price';
                $orderBy[1] = 'desc';
            }
            elseif( $getOrder == 'newest' ) {
                $orderBy[0] = 'id';
                $orderBy[1] = 'desc';
            }
            elseif( $getOrder == 'mostVisited' ) {
                $orderBy[0] = 'visit_counts';
                $orderBy[1] = 'desc';
            }
            elseif( $getOrder == 'sold' ) {
                $orderBy[0] = 'sold_count';
                $orderBy[1] = 'desc';
            }
        }

        $params['type'] = 1;
        // Get products for needed categories
        $Products = Product::getProductsDiscount($orderBy , $params , 1000000000000000000000);
        $item = [];
        foreach( $Products as $val ):
            $fav = Favorite::where('user_id' , $params['user_id'])->where('product_id' , $val->id)->get();
            $item[] = array(
                'id' => $val->id ,
                'title' => $val->title ,
                'state' => $val->stock_type ,
                'discount_cash' => $val->discount_price ,
                'main_cash' => $val->price ,
                'main_img' => $val->pic ,
                'favorite' => $fav->isEmpty() ? false : true ,
            );
        endforeach;
//Pagination configs
// Now init the configs for pagination class
        $data = array( 'products' =>
            $item
        );
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => $data ,
        );
        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    public function subscribes_get()
    {
        $this->load->eloquent('shop/Product');
        $this->load->eloquent('shop/Favorite');
        // Params for filtering results
        $params['category_id'] = $this->get('category_id');
        $params['user_id'] = $this->get('user_id');
        $params['reason_id'] = $this->get('reason_id');
        $params['flower_type'] = $this->get('flower_type');
        $params['stock_type'] = $this->get('stock_type');
        $params['free_shipping'] = $this->get('free_shipping');
        $params['price']['min'] = $this->get('min_price');
        $params['price']['max'] = $this->get('max_price');
        $params['province_id'] = null;
        $params['county_id'] = null;
        $params['city_id'] = null;
        if( $params['category_id'] )
            $Category = Category::find($params['category_id']);
        // Sort By 
        // Default
        $orderBy = array( 'id' , 'DESC' );
        // User request
        if( $this->get('sort') ) {
            $getOrder = $this->get('sort');
            if( $getOrder == 'lowPrice' ) {
                $orderBy[0] = 'price';
                $orderBy[1] = 'asc';
            }
            elseif( $getOrder == 'highPrice' ) {
                $orderBy[0] = 'price';
                $orderBy[1] = 'desc';
            }
            elseif( $getOrder == 'newest' ) {
                $orderBy[0] = 'id';
                $orderBy[1] = 'desc';
            }
            elseif( $getOrder == 'mostVisited' ) {
                $orderBy[0] = 'visit_counts';
                $orderBy[1] = 'desc';
            }
            elseif( $getOrder == 'sold' ) {
                $orderBy[0] = 'sold_count';
                $orderBy[1] = 'desc';
            }
        }

        $params['type'] = 1;
        // Get products for needed categories
        $Products = Product::getProductsSubscribe($orderBy , $params , 1000000000000000000000);
        $item = [];
        foreach( $Products as $val ):
            $fav = Favorite::where('user_id' , $params['user_id'])->where('product_id' , $val->id)->get();
            $item[] = array(
                'id' => $val->id ,
                'title' => $val->title ,
                'state' => $val->stock_type ,
                'cash' => $val->price ,
                'subscribe_price' => $val->price - ($val->price * $val->subscribe_discount / 100 ) ,
                'main_img' => $val->pic ,
                'favorite' => $fav->isEmpty() ? false : true ,
            );
        endforeach;
//Pagination configs
// Now init the configs for pagination class
        $data = array( 'products' =>
            $item
        );
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => $data ,
        );
        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت محصولات یک فروشگاه
     */
    public function ProductsByUser_get()
    {
        // Params
        $u_id = $this->get('shop_id');
        $p_type = $this->get('product_type');

        $this->load->eloquent('shop/Product');
        $this->load->eloquent('shop/Favorite');
        $this->load->eloquent('shop/Color');

        $Products = Product::where('type' , $p_type)->where('user_id' , $u_id)->get();
        $item = [];
        $color = [];
        foreach( $Products as $val ):
            if( $val->type == 3 )
                foreach( $val->ribbons as $ribbon_color ):
                    $color[] = array(
                        'id' => $ribbon_color->id ,
                        'title' => $ribbon_color->title
                    );
                endforeach;
            $fav = Favorite::where('user_id' , $u_id)->where('product_id' , $val->id)->get();
            $item[] = array(
                'id' => $val->id ,
                'title' => $val->title ,
                'state' => $val->stock_type ,
                'cash' => $val->price ,
                'main_img' => $val->pic ,
                'favorite' => $fav->isEmpty() ? false : true ,
                'ribbon_color' => $color
            );
        endforeach;
//Pagination configs
// Now init the configs for pagination class
        $data = array( 'products' =>
            $item
        );
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => $data ,
        );
        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت یک محصول
     */
    public function product_get()
    {

        $productID = $this->get('productid');
        $this->load->eloquent('shop/Product');
        $this->load->eloquent('shop/Flower_type');
        $this->load->eloquent('shop/Category');
        $this->load->eloquent('shop/Reason');
        $this->load->sentinel();
        $product = Product::find($productID);
        if( !$product ) {
            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => [] ,
            );
            $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
        }
        if( $product->type == 1 ) {
            $related = $product->category->product;
        }
        elseif( $product->type == 2 ) {
            $related = $product->flower_types()->first()->product;
        }
        $reasons = '';
        foreach( $product->reasons as $val ):
            $reasons .= '/' . $val->title;
        endforeach;
        $flower_types = '';
        foreach( $product->flower_types as $val ):
            $flower_types .= '/' . $val->title;
        endforeach;
        $data = array(
            'id' => $product->id ,
            'title' => $product->title ,
            'state' => $product->stock_status ,
            'price' => $product->price ,
            'discount_price' => $product->discount_price ,
            'main_img' => $product->pic ,
            'img' => $product->pic2 . ',' . $product->pic3 . ',' . $product->pic4
            ,
            'sellerName' => $product->user->business_name ,
            'sellerID' => $product->user->id ,
            'desc' => $product->desc ,
            'productData' => "" ,
            'category' => $product->category->title ,
            'reasons' => $reasons ,
            'flower_types' => $flower_types ,
            'flower_count' => $product->flower_count ,
            'size' => $product->size ,
            'relatedProducts' => array(
                $related
            ) ,
        );
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => $data ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * دریافت مقادیر فیلدهای فیلتر محصولات
     */
    public function getFilterResources_get()
    {

        $this->load->eloquent('shop/Product');
        $this->load->eloquent('shop/Flower_type');
        $this->load->eloquent('shop/Category');
        $this->load->eloquent('shop/Reason');
        $cat_id = $this->get('catid');
        $reason_id = $this->get('reason_id');

        if( $cat_id ) {

            $cat = Category::find($cat_id);
            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => array(
                    'reasons' => $cat->reasons ,
                ) ,
            );
            $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
        }
        elseif( $reason_id ) {

            $reason = Reason::find($reason_id);
            $cat = $reason->category->first();
            $cat_data = array(
                'id' => $cat->id ,
                'title' => $cat->title ,
            );
            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => array(
                    'cat' => $cat_data ,
                ) ,
            );
            $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
        }

        $categories = Category::select(array( 'id' , 'title' ))->get();
        $flower_types = Flower_type::select(array( 'id' , 'title' ))->get();
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array(
                'cats' => $categories ,
                'flower_types' => $flower_types ,
            ) ,
        );
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * لاگین کاربر در حساب کاربری
     */
    public function login_get()
    {

        $this->load->sentinel();
        $mobile = $this->get('mobile');
        $pass = $this->get('password');

        if( $user = $this->sentinel->authenticate([
            'mobile' => $mobile ,
            'password' => $pass
                ]) ) {
            $data = [
                'userid' => $user->id ,
                'first_name' => $user->first_name ,
                'last_name' => $user->last_name ,
                'mobile' => $mobile ,
                'username' => $user->username ,
                'email' => $user->email ,
            ];
            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => $data ,
            );

            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
        }
        else {
            $res = array(
                'status' => false ,
                'msg' => 'مشخصات ورود صحیح نیست' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_NON_AUTHORITATIVE_INFORMATION); // (203) HTTP_NON_AUTHORITATIVE_INFORMATION  }
        }
    }

    /**
     * دریافت لیست فروشگاه ها به همراه موقعیت جغرافیایی
     */
    public function shops_get()
    {

        $this->load->sentinel();
        $this->load->eloquent('users/User');
        $this->load->eloquent('users/User_profile');
        $this->load->eloquent('users/User_address');
        $this->load->eloquent('users/Province');
        $this->load->eloquent('users/City');
        $this->load->eloquent('shops/Product');
        $shops = User::select([ 'id' , 'business_name as title' , 'lat' , 'long' ])->where('type' , 1)->get();
        foreach( $shops as $val ):
            if( isset($val->profile->logo) )
                $val['logo'] = $val->profile->logo;
            else
                $val['logo'] = null;
            if( isset($val->location->province->name) )
                $val['province'] = $val->location->province->name;
            else
                $val['province'] = null;

            if( isset($val->location->full_address) )
                $val['full_address'] = $val->location->full_address;
            else
                $val['full_address'] = null;
            $productCount = $val->products()->where('type' , 2)->get();

            $val['product_counts'] = $productCount->count();

        endforeach;
        $data = [
            'list' => $shops
        ];
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => $data ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    public function orders_get()
    {
        $user_id = $this->get('user_id');
        $this->load->eloquent('shop/Cart');
        $this->load->eloquent('shop/Product');
        $my_purchases = Cart::where('user_id' , $user_id)->where('status' , '!=' , 0)->get();
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => $my_purchases ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * حذف از سبد خرید کاربر
     */
    public function removeCartItem_get()
    {
        $this->load->eloquent('shop/Product');
        $this->load->eloquent('shop/Subscribe');
        $this->load->eloquent('shop/Cart');
        $cart_id = $this->get('cart_id');
        $product_id = $this->get('product_id');
        $product = Product::find($product_id);
        $Cart = Cart::find($cart_id);
        if( $Cart->type == 2 ) {
            // single flower cart
            foreach( $Cart->products as $val ):
                $Cart->products()->detach($val->id);
            endforeach;
            $Cart->mainCart->update(array(
                'single_cart_id' => null ,
            ));
            if( $Cart->delete() ):
                $res = array(
                    'status' => true ,
                    'msg' => 'OK' ,
                    'data' => array(
                        'removed_item' => $cart_id ,
                        'cart_id' => $cart_id ,
                    ) ,
                );
                // Set the response and exit
                $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
            endif;
        }//pack products
        else {
            $removedPrd = $Cart->products()->find($product_id);
            $Cart->products()->detach($product_id);
            if( $removedPrd->is_discount AND $removedPrd->discount_price != NULL )
                $itemPrice = $removedPrd->discount_price;
            else
                $itemPrice = $removedPrd->price;
            if( $Cart->total - ($itemPrice * $removedPrd->pivot->qty ) < 0 )
                $updatedTotal = 0;
            else
                $updatedTotal = $Cart->total - ($itemPrice * $removedPrd->pivot->qty );
            $Cart->update(array(
                'total' => $updatedTotal ,
            ));
            $sub = Subscribe::where([ 'product_id' => $product_id , 'cart_id' => $Cart->id ])->get();
            if( $sub )
                foreach( $sub as $val ):
                    $val->delete();
                endforeach;

            $res = array(
                'status' => true ,
                'msg' => 'OK' ,
                'data' => array(
                    'removed_item' => $product_id ,
                    'cart_id' => $Cart->id ,
                ) ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
        }
    }

    public function makeSingleCart_get()
    {

        $this->load->eloquent('shop/Color');
        $this->load->eloquent('shop/Product');
        $this->load->eloquent('shop/Cart');

        $decoration_id = $this->get('decoration_id');
        $ribbon_color = $this->get('ribbon_color');
        $user_id = $this->get('user_id');

        $Decoration = Product::find($decoration_id);
        if( !$Decoration AND $decoration_id != 0 ) {
            $res = array(
                'status' => false ,
                'msg' => 'تزئین یافت نشد.' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_NOT_FOUND);
        }
        $where = array(
            'user_id' => $user_id ,
            'status' => 0 ,
            'product_type' => 1
        );
        $mainCart = Cart::where($where)->first();
        $subCart = Cart::where([ 'user_id' => $user_id , 'product_type' => 2 , 'status' => 0 ])->first();
        $subCart->decoration_id = $decoration_id;
        $subCart->ribbon_color = $ribbon_color;

        $subCart->save();
        if( $mainCart ) {
            $mainCart->single_cart_id = $subCart->id;
            $mainCart->save();
            //updation total price based on optinal costs
            foreach( $subCart->products as $prd ):
                if( $prd->has_deco_cost )
                    $subCart->total += $prd->price;
            endforeach;
        }else {
            $subCart->product_type = 1;
        }
        $subCart->save();
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array(
                'cart_id' => $subCart->id ,
            ) ,
        );
        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    public function AddToCart_get()
    {

        $user_id = $this->get('user_id');
        $product_id = $this->get('product_id');
        $product_type = $this->get('product_type');
        $qty = $this->get('qty');
        if( $qty < 1 OR ! $qty ):
            $qty = 1;
        endif;
        $this->load->eloquent('shop/Product');
        $this->load->eloquent('shop/Cart');
        $cartItemRow = Product::find($product_id);
        if( !$cartItemRow ):
            $res = array(
                'status' => false ,
                'msg' => 'محصول یافت نشد' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_NOT_FOUND);
        endif;
        // برای شاخه ای ها باید حتما از یک فروشگاه کالا انتخاب شود
        $CartSingle = Cart::where([
                    'user_id' => $user_id ,
                    'status' => 0 ,
                    'product_type' => 2
                ])->first();
        if( $product_type == 2 ) {
            if( $CartSingle )
                foreach( $CartSingle->products as $val ):
                    if( $cartItemRow->user_id != $val->user_id ) {
                        $res = array(
                            'status' => false ,
                            'msg' => 'محصولات شاخه ای را باید از یک فروشگاه انتخاب نمایید.' ,
                        );
                        // Set the response and exit
                        $this->response($res , REST_Controller::HTTP_BAD_REQUEST);
                    }
                endforeach;
        }

        if( $cartItemRow->type == 1 AND $cartItemRow->stock_type == 3 ) {
            $res = array(
                'status' => false ,
                'msg' => 'محصول در حال حاضر موجود نیست.' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_BAD_REQUEST);
        };

        $data = [
            'user_id' => $user_id ,
            'product_type' => $cartItemRow->type ,
            'shop_id' => $cartItemRow->user_id ,
        ];
        if( $CartSingle AND $cartItemRow->type == 1 )
            $data['single_cart_id'] = $CartSingle->id;

        $where = [
            'user_id' => $user_id ,
            'status' => 0 ,
            'product_type' => $cartItemRow->type
        ];
        $Cart = Cart::where($where)->first();

        if( $Cart ) {
            $ProductObject = $Cart->products()->find($product_id);
            if( $ProductObject )
                $qty_plus = $qty - $ProductObject->pivot->qty;
            else
                $qty_plus = $qty;

            if( $cartItemRow->is_discount AND $cartItemRow->discount_price != NULL )
                $totalCartAmount = $Cart->total + ($cartItemRow->discount_price * $qty_plus );
            else
                $totalCartAmount = $Cart->total + ($cartItemRow->price * $qty_plus );
            $data['total'] = $totalCartAmount;
            $Cart->update($data);
            $Cart->products()->sync([ $cartItemRow->id => [ 'qty' => $qty /* , 'color' => $color */ ] ] , false);
        }
        else {

            if( $cartItemRow->is_discount AND $cartItemRow->discount_price != NULL )
                $totalCartAmount = $cartItemRow->discount_price * $qty;
            else
                $totalCartAmount = $cartItemRow->price * $qty;
            $totalCartAmount = $cartItemRow->price * $qty;
            $data['total'] = $totalCartAmount;
            $Cart = Cart::create($data);
            $Cart->products()->sync([ $cartItemRow->id => [ 'qty' => $qty ] ]);
        }
        $res = array(
            'status' => true ,
            'msg' => 'محصول به سبد خرید اضافه شد.' ,
            'data' => array(
                'item' => $cartItemRow ,
                'qty' => $qty ,
                'type' => $cartItemRow->type ,
                'cart_id' => $Cart->id ,
            ) ,
        );
        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK);
    }

    public function changePassword_get()
    {
        $this->load->sentinel();
        $user_id = $this->get('user_id');
        $user = $this->sentinel->getUserRepository()->find($user_id);
        $password = $this->get('password');
        $reminder = $this->sentinel->getReminderRepository()->create($user);
        $this->sentinel->getReminderRepository()->complete($user , $reminder->code , $password);
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array(
                'user_id' => $user_id ,
            ) ,
        );
        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    public function resetPassword_get()
    {
        $mobile = $this->get('mobile');
        $this->load->sentinel();
        $UserModel = $this->sentinel->getUserRepository();
        $User = $UserModel->findByCredentials([ 'mobile' => $mobile ]);
        $Token = sha1(str_random());
        if( !$User ):
            $res = array(
                'status' => false ,
                'msg' => 'کاربر یافت نشد.' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_NOT_FOUND);
        endif;
        $Reminder = $this->sentinel->getReminderRepository();
        $exist = $Reminder->exists($User);
        // Create reminders
        if( $User ) {
            // Check if reminder code already exist for user, if not so create reminder first
            if( !$exist ) {
                $new_reminder = $Reminder->create($User);
                // send reminder code to the user mobile number
                $message_sms = "کد فعال سازی بازیابی رمز عبور: " . $new_reminder->code;
                $smsParams = array( 'message' => $message_sms , 'rcpt_nm' => array( $mobile ) );
                if( $this->sendSms($smsParams) ) {
                    $UserModel->update($User , array( 'token' => $Token ));
                    $res = array(
                        'status' => true ,
                        'msg' => 'کد بازیابی به شماره همراه ارسال شد.' ,
                        'data' => array(
                            'user_id' => $User->id ,
                            'mobile' => $mobile ,
                            'token' => $Token ,
                        ) ,
                    );
                    // Set the response and exit
                    $this->response($res , REST_Controller::HTTP_OK);
                }
                else {
                    $res = array(
                        'status' => false ,
                        'msg' => 'اشکال در ارسال پیامک بازیابی.' ,
                    );
                    // Set the response and exit
                    $this->response($res , REST_Controller::HTTP_OK);
                }
            }
            else {
                // send reminder code to the user mobile number
                $message_sms = "کد فعال سازی بازیابی رمز عبور: " . $exist->code;
                $smsParams = array( 'message' => $message_sms , 'rcpt_nm' => array( $mobile ) );
                if( $this->sendSms($smsParams) ) {
                    $UserModel->update($User , array( 'token' => $Token ));
                    $res = array(
                        'status' => true ,
                        'msg' => 'کد بازیابی به شماره همراه ارسال شد.' ,
                        'data' => array(
                            'user_id' => $User->id ,
                            'mobile' => $mobile ,
                            'token' => $Token ,
                        ) ,
                    );
                    // Set the response and exit
                    $this->response($res , REST_Controller::HTTP_OK);
                }
            }
        }
    }

    /**
     * set reminder and reset password by email
     * @param type $user_id
     * @param type $reminder_code
     */
    public function resetPasswordByCode_get()
    {
        $this->load->sentinel();
        $reminder_code = $this->get('code');
        $password = $this->get('password');
        $token = $this->get('token');
        $userModel = $this->sentinel->getUserRepository();
        $user = $userModel->where([ 'token' => $token ])->first();
        $reminder = $this->sentinel->getReminderRepository();
        if( $reminder->exists($user , $reminder_code) ) {
            if( $reminder->complete($user , $reminder_code , $password) ) {
                // full activate user
                $mamad = $this->sentinel->getActivationRepository()->where('user_id' , $user->id)->first();
                $mamad->update([ 'completed' => 1 ]);
                $res = array(
                    'status' => true ,
                    'msg' => 'OK' ,
                    'data' => array(
                        'user_id' => $user->id ,
                    ) ,
                );
                // Set the response and exit
                $this->response($res , REST_Controller::HTTP_OK);
            }
            else {
                $res = array(
                    'status' => false ,
                    'msg' => 'خطا در بازیابی رمز عبور.' ,
                );
                // Set the response and exit
                $this->response($res , REST_Controller::HTTP_OK);
            }
        }
        else {
            $res = array(
                'status' => false ,
                'msg' => 'کد بازیابی نادرست است.' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_OK);
        }
    }

    public function search_get()
    {
        $q = $this->get('query');
        $this->load->eloquent('users/Province');
        $this->load->eloquent('users/User');
        $this->load->eloquent('users/User_profile');
        $this->load->eloquent('users/User_address');

        $shops = User::select([ 'id' , 'business_name' , 'username' , 'lat' , 'long' ])
                ->where('type' , 1)
                ->where(function($query) use ($q) {
                    $query->where('username' , 'like' , '%' . $q . '%')
                    ->orWhere('business_name' , 'like' , '%' . $q . '%');
                })
                ->get();
        $mainData = array();
        foreach( $shops as $val ):
            $mainData[] = array(
                'id' => $val->id ,
                'username' => $val->username ,
                'name' => $val->business_name ,
                'lat' => $val->lat ,
                'long' => $val->long ,
                'logo' => $val->profile->logo ,
                'province' => $val->location->province->name ,
            );
        endforeach;

        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array(
                'list' => $mainData ,
            ) ,
        );
        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK);
    }

    /**
     * افزودن به لیست علاقمندی‌ها
     */
    public function addToFavorites_get()
    {
        $this->load->eloquent('shop/Favorite');
        $this->load->eloquent('shop/Product');
        $this->load->sentinel();
        $p_id = $this->get('product_id');
        $u_id = $this->get('user_id');
        $User = $this->sentinel->getUserRepository()->find($u_id);
        if( $User->type == 1 ) {
            $res = array(
                'status' => false ,
                'msg' => 'برای این امکان باید با حساب خریدار ثبت‌نام شوید' ,
                'data' => array( 'result' => false ) ,
            );

            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_OK);
        }
        $params = array(
            'user_id' => $u_id ,
            'product_id' => $p_id ,
        );
        Favorite::updateOrCreate($params , $params);
        $res = array(
            'status' => true ,
            'msg' => 'OK' ,
            'data' => array( 'result' => true ) ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK); // OK (200) being the HTTP response code
    }

    /**
     * ارسال پیامک با استفاده از سرویس 
     * mediana.ir
     * @param type $params
     * params = array('message' => $message , 'rcpt_nm' => array($user->mobile));
     */
    public function sendSms( $params )
    {

        $url = "37.130.202.188/services.jspd";

        $param = array
            (
            'uname' => 'pishgamprint' ,
            'pass' => '123456' ,
            'from' => '5000145' ,
            'message' => $params['message'] ,
            'to' => json_encode($params['rcpt_nm']) ,
            'op' => 'send'
        );

        $handler = curl_init($url);
        curl_setopt($handler , CURLOPT_CUSTOMREQUEST , "POST");
        curl_setopt($handler , CURLOPT_POSTFIELDS , $param);
        curl_setopt($handler , CURLOPT_RETURNTRANSFER , true);
        $response2 = curl_exec($handler);

        $response2 = json_decode($response2);
        $res_code = $response2[0];
        $res_data = $response2[1];

        return $res_data;
    }

    /*
     * Form Validation callback to check that the provided email address or mobile is valid.
     */

    function mobile_validation( $mobile )
    {
        $this->load->sentinel();

        $credentials = [ 'mobile' => $mobile ];
        $User = $this->sentinel->getUserRepository()->where($credentials)->first();
        $activation = $this->sentinel->getActivationRepository();
        if( isset($User) ) {
            $is_activated = $activation->completed($User);
            if( !$is_activated ) {
                return $User;
            }
            else {
                return FALSE;
            }
        }
        return TRUE;
    }

    function username_validation( $login )
    {
        // check if is email and its validation
        $this->load->sentinel();
        $pattern = "/[a-zA-Z0-9_]/";
        if( !preg_match($pattern , $login) ):
            $this->form_validation->set_message('username_validation' , 'نام کاربری باید شامل حروف لاتین و اعداد باشد');
            return 2;
        endif;

        $credentials = [ 'username' => $login
        ];
        $User = $this->sentinel->getUserRepository()->where($credentials)->first();
        if( isset($User) ) {
            return FALSE;
        }
        return 1;
    }

    /**
     * تابع مربوط به پرداخت آنی،  صدا زدن تابع مربوط به بانک
     * @param int $invoice_id شناسه فاکتور مربوطه
     */
    public function gatewayPayment_get()
    {

        $this->load->eloquent('shop/Cart');
        $this->load->eloquent('shop/Product');
        $invoice_id = $this->get('invoice_id');
        $user_id = $this->get('user_id');
        $cart = Cart::find($invoice_id);
        if( $invoice_id == null || $cart->user_id != $user_id || $cart->pay_status == 1
        ) {
            $res = array(
                'status' => false ,
                'msg' => 'داده های اشتباه' ,
            );
            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_OK);
        }
        if( $address = urldecode($this->get('delivery_address')) ) {
            $cart->update([ 'delivery_address' => $address ]);
        }
        $amount_must_pay = 0;
        if( $cart->product_type == 1 )
            $singleCart = $cart->singleCart;
        foreach( $cart->products as $item )
        {
            if( $item->is_discount )
                $amount_must_pay += $item->discount_price * $item->pivot->qty;
            else
                $amount_must_pay += $item->price * $item->pivot->qty;
        }
        if( isset($singleCart) )
            $amount_must_pay += $singleCart->total;

        if( $this->user->cash > 0 ) {

            if( $this->user->cash > $amount_must_pay )
                $this->creditPayment($cart);
            else
                $amount_must_pay = $amount_must_pay - $this->user->cash;
        }
//آدرس بازگشت از بانک پس از انجام تراکنش
        $callBackUrl = base_url('api/get-api/verifyPayment');
//  شروع پرداخت بانک ملت
        $_SESSION['merchantId'] = 'CA10';
        $_SESSION['sha1Key'] = '22338240992352910814917221751200141041845518824222260';
        $_SESSION['admin_email'] = 'saeed.g71@gmail.com';
        $_SESSION['amount'] = $amount_must_pay * 10;
        $_SESSION['PayOrderId'] = $cart->id . time();
        $_SESSION['invoice_id'] = $cart->id;
        $_SESSION['fullname'] = 'مصطفی عابدینی';
        $_SESSION['email'] = 'saeed.g71@gmail.com';
        $revertURL = $callBackUrl;

        $client = new SoapClient('https://ikc.shaparak.ir/XToken/Tokens.xml' , array( 'soap_version' => SOAP_1_1 ));

        $params['amount'] = $_SESSION['amount'];
        $params['merchantId'] = 'CA10';
        $params['invoiceNo'] = $cart->id;
        $params['paymentId'] = $cart->id;
        $params['specialPaymentId'] = $cart->id;
        $params['revertURL'] = $revertURL;
        $params['description'] = "";

        $result = $client->__soapCall("MakeToken" , array( $params ));
        $_SESSION['token'] = $result->MakeTokenResult->token;
        $data['token'] = $_SESSION['token'];
        $data['merchantId'] = $_SESSION['merchantId'];
//        $res = array(
//            'status' => false ,
//            'msg' => 'OK' ,
//            'data' => array(
//                'url' => 'https://ikc.shaparak.ir/TPayment/Payment/index' ,
//                'post_data' => $data ,
//            ) ,
//        );
//        // Set the response and exit
//        $this->response($res , REST_Controller::HTTP_OK);
        $this->redirect_post('https://ikc.shaparak.ir/TPayment/Payment/index' , $data);
    }

    function redirect_post( $url , array $data )
    {

        echo '<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
	<title>در حال اتصال ...</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style type="text/css">
	#main {
	    background-color: #F1F1F1;
	    border: 1px solid #CACACA;
	    height: 90px;
	    left: 50%;
	    margin-left: -265px;
	    position: absolute;
	    top: 200px;
	    width: 530px;
	}
	#main p {
	    color: #757575;
	    direction: rtl;
	    font-family: Arial;
	    font-size: 16px;
	    font-weight: bold;
	    line-height: 27px;
	    margin-top: 30px;
	    padding-right: 60px;
	    text-align: right;
	}
    </style>
        <script type="text/javascript">
              function closethisasap() {
                document.forms["redirectpost"].submit();
            }
        </script>
    </head>
    <body onload="closethisasap();">';
        echo '<form name="redirectpost" method="post" action="' . $url . '">';

        if( !is_null($data) ) {
            foreach( $data as $k => $v )
            {
                echo '<input type="hidden" name="' . $k . '" value="' . $v . '"> ';
            }
        }

        echo' </form><div id="main">
<p>درحال اتصال به درگاه بانک</p></div>
    </body>
    </html>';

        exit;
    }

    public function creditPayment( $cart )
    {

        $referenceId = $cart->id . time();
//تغییر وضعیت پرداخت فاکتور مربوطه به پرداخت شده
        $data_new = array( 'status' => 1 , 'pay_at' => date('Y-m-d H:i:s') );
        $cart->update($data_new);
        if( $cart->product_type == 1 ) {
            if( isset($cart->singleCart) )
                $cart->singleCart->update($data_new);
        }
        //بروزرسانی موجودی و تعداد فروش کالاهای سبد خرید
        //$this->__updateQuantity($cart);
        //درصد فروش سایت
        $this->__sale_percent($cart , $referenceId);
        // درصد فروش معرف
        $this->load->eloquent('users/Reagent');
        if( $Reagent = Reagent::where('invited_user_id' , $this->user->id)->first() ):
            $this->__reagent_aff($cart , $referenceId , $Reagent);
        endif;
        // ارسال فاکتور به ایمیل
//            $this->__send_email_factor($cart , $results['trans'] , $coupon);
        //ارسال پیامک به خریدار
        $this->load->eloquent('settings/Setting');
        $site_name = Setting::findByCode('site_name')->value;
        $message_sms = "کاربر گرامی سفارش شما در سایت $site_name با موفقیت ثبت شد و پرداخت صورت گرفت. شماره پیگیری تراکنش: " . $referenceId;
        $smsParams = array( 'message' => $message_sms , 'rcpt_nm' => array( $cart->user->mobile ) );
        $this->sendSms($smsParams);
        //ارسال پیامک به مدیریت سایت
        $message_sms = 'یک سفارش جدید در فروشگاه ' . $site_name . ' ثبت و پرداخت شد.شناسه سفارش:  ' . $cart->id;
        $smsParams = array( 'message' => $message_sms , 'rcpt_nm' => array( $cart->shop->mobile ) );
        $this->sendSms($smsParams);

        // درج در جدول تراکنش ها
        //push single products to the cart
        if( $cart->single_cart_id ) {
            $subCart = Cart::find($cart->single_cart_id);
            $push = array();
            foreach( $subCart->products as $val ):
                $push[] = $val;
            endforeach;
            $cart->products->put('single' , $subCart);
        }
        foreach( $cart->products as $val ):
            $Class = get_class($val);
            //برای سبد خرید محصولات شاخه ای
            if( $Class == 'Cart' ) {
                if( $val->products->count() > 0 ) {
                    $transaction_data = array(
                        'user_id' => $cart->user_id ,
                        'shop_id' => $val->user_id ,
                        'price' => $cart->total ,
                        'invoice_id' => $cart->id ,
                        'transaction_states_id' => 1 ,
                        'trans_id' => $referenceId ,
                        'invoice_type' => 2 , // نوع محصول شاخه ای
                        'description' => "پرداخت فاکتور سفارش محصول شاخه ای از فروشگاه $site_name با شناسه فاکتور  " . $val->id . " و شماره پیگیری " . $referenceId
                    );
                    // صدا زدن تابع درج در پایگاه داده
                    Transaction::create($transaction_data);
                }
            }// برای سبد خرید محصولات آماده
            else {
                $transaction_data = array(
                    'user_id' => $cart->user_id ,
                    'shop_id' => $val->user_id ,
                    'price' => $val->price ,
                    'invoice_id' => $cart->id ,
                    'trans_id' => $referenceId ,
                    'transaction_states_id' => 1 ,
                    'invoice_type' => 1 , // برای سبد خرید محصولات آماده
                    'description' => "پرداخت فاکتور سفارش محصول آماده از فروشگاه $site_name با شناسه فاکتور  " . $val->id . " و شماره پیگیری " . $referenceId
                );
                // صدا زدن تابع درج در پایگاه داده
                Transaction::create($transaction_data);
            }
        endforeach;
        $this->load->eloquent('payment/Transaction');
        $updatedUserCash = User::find($this->user->id);
        if( $this->user->cash >= $_SESSION['amount'] / 10 )
            $masraf = $_SESSION['amount'] / 10;
        else
            $masraf = $this->user->cash;
        $updatedUserCash->update(array( 'cash' => $this->user->cash - $masraf ));
        $transaction_data = array(
            'user_id' => $this->user->id ,
            'shop_id' => $cart->shop_id ,
            'price' => $masraf ,
            'invoice_id' => $cart->id ,
            'trans_id' => $referenceId ,
            'transaction_states_id' => 1 ,
            'invoice_type' => 6 , // برداشت از حساب
            'description' => "برداشت از شارژ حساب کاربری برای پرداخت فاکتور سفارش محصول از فروشگاه $site_name با شناسه فاکتور  " . $cart->id
        );
        // صدا زدن تابع درج در پایگاه داده
        Transaction::create($transaction_data);
        $message = "    پرداخت شما با موفقیت انجام شد
                            شماره سفارش شما: " . $cart->id . "
                            شماره پیگیری تراکنش : " . $referenceId;
        $res = array(
            'status' => true ,
            'msg' => $message ,
        );

        // Set the response and exit
        $this->response($res , REST_Controller::HTTP_OK);
    }

    /**
     * تسویه حساب سایت با معرف و واریز وجه به حساب کاربری معرف
     * @param type $cart
     * @param type $results
     */
    public function __reagent_aff( $cart , $referenceId , $reagent )
    {
        $this->load->eloquent('users/User');
        $this->load->eloquent('payment/Transaction');
        $this->load->eloquent('shop/Cart');
        $User = User::find($reagent->user_id);
        $UserNewCash = ( $cart->total * REAGENT_PERCENT / 100 );
        if( $cart->single_cart_id ) {
            $UserNewCash += ( $cart->singleCart->total * REAGENT_PERCENT / 100 );
        }
        $User->update(array(
            'cash' => $User->cash + $UserNewCash ,
        ));
        $transaction_data = array(
            'user_id' => $User->id ,
            'shop_id' => $reagent->invited_user_id ,
            'price' => $UserNewCash ,
            'invoice_id' => $cart->id ,
            'trans_id' => $referenceId ,
            'transaction_states_id' => 1 ,
            'invoice_type' => 100 , // تسویه حساب با فروشگاه
            'description' => "واریز کارمزد خرید به حساب کاربری معرف برای فاکتور سفارش محصول از فروشگاه با شناسه فاکتور  " . $cart->id . " و شماره پیگیری بانکی " . $referenceId
        );
        // صدا زدن تابع درج در پایگاه داده
        Transaction::create($transaction_data);
        return true;
    }

    /*     * **************   public function verifyPayment_mellat_bank($invoice_id, $amount)   ********** */

    /**
     * تایید تراکنش پرداخت و انجام تسویه حساب
     * @param int $invoice_id شناسه فاکتور مربوطه
     * @param int $amount مبلغ تراکنش   
     */
    public function verifyPayment_post()
    {
        $results = $this->post();
        $this->load->eloquent('payment/Transaction');
        $this->load->eloquent('shop/Cart');
        $this->load->eloquent('shop/Product');
        $cart = Cart::find($_SESSION['invoice_id']);
        // در صورتی که پرداخت با موفقیت انجام شود:
        if( $results['resultCode'] == 100 ) {
            $referenceId = isset($results['referenceId']) ? $results['referenceId'] : 0;
            $client = new SoapClient('https://ikc.shaparak.ir/XVerify/Verify.xml' , array( 'soap_version' => SOAP_1_1 ));
            $params['token'] = $_SESSION['token'];
            $params['merchantId'] = $_SESSION ['merchantId'];
            $params['referenceNumber'] = $referenceId;
            $params['sha1Key'] = $_SESSION['sha1Key'];
            $result = $client->__soapCall("KicccPaymentsVerification" , array( $params ));
            $result = ($result->KicccPaymentsVerificationResult );

            if( floatval($result) > 0 && floatval($result) == floatval($_SESSION['amount']) ) {

//تغییر وضعیت پرداخت فاکتور مربوطه به پرداخت شده
                $data_new = array( 'status' => 1 , 'pay_at' => date('Y-m-d H:i:s') );
                $cart->update($data_new);
                if( $cart->product_type == 1 ) {
                    if( isset($cart->singleCart) )
                        $cart->singleCart->update($data_new);
                }
                //بروزرسانی موجودی و تعداد فروش کالاهای سبد خرید
                //$this->__updateQuantity($cart);
                //درصد فروش
                $this->__sale_percent($cart , $referenceId);
                // ارسال فاکتور به ایمیل
//            $this->__send_email_factor($cart , $results['trans'] , $coupon);
                //ارسال پیامک به خریدار
                $this->load->eloquent('settings/Setting');
                $site_name = Setting::findByCode('site_name')->value;
                $message_sms = "کاربر گرامی سفارش شما در سایت $site_name با موفقیت ثبت شد و پرداخت صورت گرفت. شماره پیگیری تراکنش: " . $referenceId;
                $smsParams = array( 'message' => $message_sms , 'rcpt_nm' => array( $cart->user->mobile ) );
                $this->sendSms($smsParams);
                //ارسال پیامک به مدیریت سایت
                $message_sms = 'یک سفارش جدید در فروشگاه ' . $site_name . ' ثبت و پرداخت شد.شناسه سفارش:  ' . $cart->id;
                $smsParams = array( 'message' => $message_sms , 'rcpt_nm' => array( $cart->shop->mobile ) );
                $this->sendSms($smsParams);

                // درج در جدول تراکنش ها
                //push single products to the cart
                if( $cart->single_cart_id ) {
                    $subCart = Cart::find($cart->single_cart_id);
                    $push = array();
                    foreach( $subCart->products as $val ):
                        $push[] = $val;
                    endforeach;
                    $cart->products->put('single' , $subCart);
                }
                foreach( $cart->products as $val ):
                    $Class = get_class($val);
                    //برای سبد خرید محصولات شاخه ای
                    if( $Class == 'Cart' ) {
                        if( $val->products->count() > 0 ) {
                            $transaction_data = array(
                                'user_id' => $cart->user_id ,
                                'shop_id' => $val->user_id ,
                                'price' => $cart->total ,
                                'invoice_id' => $cart->id ,
                                'transaction_states_id' => 1 ,
                                'trans_id' => $results['referenceId'] ,
                                'invoice_type' => 2 , // نوع محصول شاخه ای
                                'description' => "پرداخت فاکتور سفارش محصول شاخه ای از فروشگاه $site_name با شناسه فاکتور  " . $val->id . " و شماره پیگیری بانکی " . $referenceId
                            );
                            // صدا زدن تابع درج در پایگاه داده
                            Transaction::create($transaction_data);
                        }
                    }// برای سبد خرید محصولات آماده
                    else {
                        $transaction_data = array(
                            'user_id' => $cart->user_id ,
                            'shop_id' => $val->user_id ,
                            'price' => $val->price ,
                            'invoice_id' => $cart->id ,
                            'trans_id' => $results['referenceId'] ,
                            'transaction_states_id' => 1 ,
                            'invoice_type' => 1 , // برای سبد خرید محصولات آماده
                            'description' => "پرداخت فاکتور سفارش محصول آماده از فروشگاه $site_name با شناسه فاکتور  " . $val->id . " و شماره پیگیری بانکی " . $referenceId
                        );
                        // صدا زدن تابع درج در پایگاه داده
                        Transaction::create($transaction_data);
                    }
                endforeach;
                $msg = "    پرداخت شما با موفقیت انجام شد
                            شماره سفارش شما: " . $results['paymentId'] . "
                            شماره پیگیری تراکنش : " . $results['referenceId'];

                $data = array( 'msg' => $msg );
                $this->load->view('mobilemessege' , $data);
                return true;
                $res = array(
                    'status' => true ,
                    'msg' => $message ,
                );

                // Set the response and exit
                $this->response($res , REST_Controller::HTTP_OK);
            }
            else {
                $msg = $this->messeg2($result);

                $data = array( 'msg' => $msg );
                $this->load->view('mobilemessege' , $data);
                return true;
                $res = array(
                    'status' => false ,
                    'msg' => $msg ,
                );

                // Set the response and exit
                $this->response($res , REST_Controller::HTTP_OK);
            }
// در صورتی که پرداخت نا موفق باشد
        }
        else {
            $msg = $this->messeg($_POST['resultCode']);

//            $this->paymentDone_get($msg);
//            exit();
            $msg = "    پرداخت شما نا موفق بود. $msg .
                            شماره سفارش شما: " . $results['paymentId'] . " <p>شماره پیگیری تراکنش:  " . $results['referenceId'] . "</p>";

            $data = array( 'msg' => $msg );
            $this->load->view('mobilemessege' , $data);
            return true;
            $res = array(
                'status' => false ,
                'msg' => $message ,
            );

            // Set the response and exit
            $this->response($res , REST_Controller::HTTP_OK);
        }
    }

    function messeg2( $result )
    {
        switch( $result )
        {
            case '-20':
                return "در درخواست کارکتر های غیر مجاز وجو دارد";
                break;
            case '-30':
                return " تراکنش قبلا برگشت خورده است";
                break;
            case '-50':
                return " طول رشته درخواست غیر مجاز است";
                break;
            case '-51':
                return " در در خواست خطا وجود دارد";

                break;
            case '-80':
                return " تراکنش مورد نظر یافت نشد";
                break;
            case '-81':
                return " خطای داخلی بانک";
                break;
            case '-90':
                return " تراکنش قبلا تایید شده است";
                break;
        }
    }

    function messeg( $resultCode )
    {
        switch( $resultCode )
        {
            case 110:
                return " انصراف دارنده کارت";
                break;

            case 120:
                return"   موجودی کافی نیست";
                break;
            case 130:
            case 131:
            case 160:
                return"   اطلاعات کارت اشتباه است";
                break;
            case 132:
            case 133:
                return"   کارت مسدود یا منقضی می باشد";
                break;
            case 140:
                return" زمان مورد نظر به پایان رسیده است";
                break;
            case 200:
            case 201:
            case 202:
                return" مبلغ بیش از سقف مجاز";
                break;
            case 166:
                return

                        " بانک صادر کننده مجوز انجام  تراکنش را صادر نکرده";
                break;
            case 150:
            default:
                return " خطا بانک  $resultCode";
                break;
        }
    }

    /**
     * تسویه حساب سایت با فروشگاه و واریز وجه به حساب کاربری فروشنده
     * @param type $cart
     * @param type $results
     */
    public function __sale_percent( $cart , $referenceId )
    {
        $this->load->eloquent('users/User');
        $this->load->eloquent('payment/Transaction');
        $this->load->eloquent('shop/Cart');
        $User = User::find($cart->shop_id);
        $UserNewCash = ( $cart->total * (100 - $User->sale_percent) / 100 );
        if( $cart->single_cart_id ) {
            $UserNewCash += ( $cart->singleCart->total * (100 - $User->sale_percent) / 100 );
        }
        $User->update(array(
            'cash' => $User->cash + $UserNewCash ,
        ));
        $transaction_data = array(
            'user_id' => $User->id ,
            'shop_id' => $User->id ,
            'price' => $UserNewCash ,
            'invoice_id' => $cart->id ,
            'trans_id' => $referenceId ,
            'transaction_states_id' => 1 ,
            'invoice_type' => 10 , // تسویه حساب با فروشگاه
            'description' => "تسویه حساب با فروشگاه برای فاکتور سفارش محصول از فروشگاه با شناسه فاکتور  " . $cart->id . " و شماره پیگیری بانکی " . $referenceId
        );
        // صدا زدن تابع درج در پایگاه داده
        Transaction::create($transaction_data);
        return true;
    }

}
