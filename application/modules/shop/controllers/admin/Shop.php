<?php

/**
 * Controller: Main Shop management
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 */


class Shop extends Admin_Controller
{

    /**
     * تعریف اعتبارسنجی داده ها
     * @var type
     */
    public $validation_rules = array(
        'index' => array(),
        'submit_product' => array(
            [
                'field' => 'title',
                'rules' => 'required|trim|required|htmlspecialchars|max_length[100]',
                'label' => 'عنوان محصول'
            ],
            ['field' => 'desc', 'rules' => 'trim', 'label' => 'شرح'],
            ['field' => 'price', 'rules' => 'required|htmlspecialchars|trim|numeric', 'label' => 'قیمت'],
            ['field' => 'old_price', 'rules' => 'trim|numeric', 'label' => 'قیمت قدیم'],
            ['field' => 'stock', 'rules' => 'required|htmlspecialchars|trim|numeric', 'label' => 'موجودی'],
            ['field' => 'product_category_id', 'rules' => 'numeric|required|htmlspecialchars', 'label' => 'دسته بندی'],
        ),
        'edit' => array(
            [
                'field' => 'title',
                'rules' => 'required|trim|required|htmlspecialchars|max_length[100]',
                'label' => 'عنوان آگهی'
            ],
            ['field' => 'desc', 'rules' => 'trim', 'label' => 'شرح'],
            ['field' => 'price', 'rules' => 'htmlspecialchars|trim|numeric', 'label' => 'قیمت'],
            ['field' => 'old_price', 'rules' => 'trim|numeric', 'label' => 'قیمت قدیم'],
            ['field' => 'product_category_id', 'rules' => 'numeric|required|htmlspecialchars', 'label' => 'دسته بندی'],
        ),
        'addCoupon' => array(
            [
                'field' => 'discount',
                'rules' => 'required|integer|htmlspecialchars|min[2]|max[100]',
                'label' => 'درصد تخفیف'
            ],
            [
                'field' => 'max_purchase_amount',
                'rules' => 'required|integer|htmlspecialchars|min[100000]',
                'label' => 'سقف مبلغ خرید'
            ],
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('Product');
    }

    /**
     * لیست محصولات
     */
    public function product_list()
    {
        $page = $this->input->get("page") ? $this->input->get("page", true) : 1;

        $products = Product::with("user", "product_type", "category", "child_category")
            ->orderBy('id', 'DESC')
            ->paginate(config("per_page"), '*', 'page', $page)->setPath(set_path());
        $this->smart->assign(
            [
                'pagination' => $products->toArray(),
                'title' => 'محصولات ثبت شده',
                'Products' => $products,
                'add_link' => site_url(ADMIN_PATH."/shop/shop/add-shop"),
            ]
        );
        $this->smart->view('shop/index');
    }

    public function orders()
    {
        $orders = Cart::query()->with('transaction')->where('status', 1)->latest('pay_at')->get();
        $orders->each(function ($item) {
            try {
                $item->total = $this->cartConcern->getCartTotal($item, 1);
            } catch(Exception $e) {
                log_exception($e);
            }
        });
        $this->smart->assign([
            'Orders' => $orders,
            'title' => 'لیست سفارشات ثبت شده'
        ]);
        $this->smart->view('shop/orders');
    }

    /**
     * نمایش آگهی
     * @param type $id
     */
    public function view_product($id)
    {
        $Ads = Product::with(["product_type", "category", "child_category", "user"])->find($id);
        $this->show_404_on(!$id);
        $this->show_404_on(!$Ads);
        $this->smart->assign(
            [
                'title' => 'محصول - '.$Ads->title,
                'Product' => $Ads,
            ]
        );
        $this->smart->view('shop/view');
    }

    /**
     * نمایش آیتم های سفارش
     * @param type $id
     */
    public function view_order($id)
    {
        $Cart = Cart::query()->with('delivery', 'varients')->find($id);
        $this->show_404_on(!$id);
        $this->show_404_on(!$Cart);
        $this->smart->assign(
            [
                'title' => 'نمایش موارد خرید شده ',
                'Cart' => $Cart,
                'delivery' => $Cart->delivery,
                'buyer' => $Cart->user,
                'id' => $id,
            ]
        );
        $this->smart->view('shop/view_order');
    }

    public function publication($id)
    {
        $Product = Product::find($id);
        if($Product->update(array('status' => 1))) {
            $this->message->set_message('وضعیت محصول با موفقیت تغییر یافت', 'success', 'تغییر وضعیت محصول',
                ADMIN_PATH.'/shop/shop/product-list'
            )->redirect();
        } else {
            $this->message->set_message('مشکلی رخ داد مجدد تلاش کنید', 'fail', 'تغییر وضعیت محصول',
                ADMIN_PATH.'/shop/shop/product-list'
            )->redirect();
        }
    }

    public function reject($id)
    {
        $Product = Product::find($id);
        if($Product->update(array('status' => 3))) {
            $this->message->set_message('وضعیت محصول با موفقیت تغییر یافت', 'success', 'تغییر وضعیت محصول',
                ADMIN_PATH.'/shop/shop/product-list'
            )->redirect();
        } else {
            $this->message->set_message('مشکلی رخ داد مجدد تلاش کنید', 'fail', 'تغییر وضعیت محصول',
                ADMIN_PATH.'/shop/shop/product-list'
            )->redirect();
        }
    }

    /**
     * تغییر وضعیت سفارش
     * @param type $ads_id
     */
    public function toggleStatus($id, $status)
    {
        /**
         * استاتوس = 2 محصول ارسال شد
         * استاتوس = 3 محصول تحویل مشتری شد
         * استاتوس = 1 مشتری سفارش را تایید و پرداخت کرد
         */
        $Cart = Cart::find($id);
        if($Cart->update(array('status' => $status))) {
            $this->message->set_message('وضعیت سفارش با موفقیت تغییر یافت', 'success', 'تغییر وضعیت سفارش',
                ADMIN_PATH.'/shop/shop/orders'
            )->redirect();
        } else {
            $this->message->set_message('مشکلی رخ داد مجدد تلاش کنید', 'fail', 'تغییر وضعیت سفارش',
                ADMIN_PATH.'/shop/shop/orders'
            )->redirect();
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
            'title' => 'ثبت فروشگاه جدید',
            'attr' => ['class' => 'uk-form-stacked'],
            'ads_category' => Category::parents()->get(),
            'prd_cats' => Category::all(),
            'action' => site_url(ADMIN_PATH.'/shop/shop/submit-product'),
        ]);
        $this->smart->view('shop/add_product');
    }


    /**
     * مشاهده لیست کد های تخفیف تولید شده
     */
    public function couponGenerator()
    {
        $this->load->eloquent('Coupon');
        $this->smart->assign(array(
            'title' => 'کد تخفیف فروشگاه',
            'Coupons' => Coupon::all(),
        ));
        $this->smart->view('shop/coupons');
    }

    /**
     * مشاهده لیست کد های تخفیف تولید شده
     */
    public function groupDiscounts()
    {
        $this->load->eloquent('Group_discount');
        $saeed = Group_discount::where('id', '>', 0)->first();
        //        Carbon\Carbon::diffInDays()
        //        dd(Carbon\Carbon::now()->diffInDays($saeed->created_at->addDays($saeed->expire)) <= $saeed->expire);
        $this->smart->assign(array(
            'title' => 'تخفیف گروهی',
            'group_discounts' => Group_discount::all(),
        ));
        $this->smart->view('shop/group_discounts');
    }

    /**
     * ساخت یک کد تخفیف جدید
     * @param null $id
     */
    public function addCoupon($id = null)
    {
        $this->load->eloquent('Coupon');
        if($id) {
            $Coupon = Coupon::with('redeemed')->find($id);
            $this->smart->assign(array('Coupon' => $Coupon));
        }
        if($this->input->post('submit_btn')) {
            $data = [
                'discount' => $this->input->post('discount'),
                'max_purchase_amount' => $this->input->post('max_purchase_amount'),
                'validity_type' => $this->input->post('validity_type'),
                'user_id' => null,
            ];
            if(!$id) {
                if($this->input->post('code')) {
                    $data['code'] = $this->input->post('code');
                }
                $this->productConcern->generateCoupon($data);
            } elseif($id) {
                $Coupon->forceFill($data)->save();
            }
            $back_link = ADMIN_PATH.'/shop/shop/couponGenerator';
            $this->message->set_message(
                'کوپن جدید افزوده شد', 'success', 'ثبت کوپن تخفیف ', $back_link
            )->redirect();
        } else {
            $this->smart->assign([
                'title' => 'تولید کد تخفیف جدید',
                'edit_mode' => isset($id) ? 1 : 0,
            ]);
            $this->smart->view('shop/edit_coupon');
        }
    }

    /**
     * ساخت یک کد تخفیف جدید
     */
    public function addGroupDiscount($id = null)
    {
        $this->load->eloquent('Group_discount');
        if($id) {
            $Discount = Group_discount::find($id);
            $this->smart->assign(array('Discount' => $Discount));
        }
        $slugify = new Slugify();
        if($this->input->post('submit_btn')) {
            $data = [
                'discount' => $this->input->post('discount'),
                'status' => $this->input->post('status'),
                'expire' => $this->input->post('expire'),
                'slug' => $slugify->slugify($this->input->post('slug')),
            ];
            if($group_discount = Group_discount::updateOrCreate(['id' => $id], $data)):

                $group_discount->products()->sync($this->input->post('products'), true);
                $back_link = ADMIN_PATH.'/shop/shop/groupDiscounts';
                $this->message->set_message(
                    'تخفیف گروهی ثبت شد', 'success', 'ثبت تخفیف گروهی ', $back_link
                )->redirect();
            endif;
        } else {
            $this->smart->assign([
                'title' => 'افزودن تخفیف جدید',
                'edit_mode' => isset($id) ? 1 : 0,
                'products' => Product::all(),
            ]);
            $this->smart->view('shop/edit_discountGroup');
        }
    }


    ///////////////////shipping ///////////////////////////

    /**
     * ثبت ویژگی جدید برای محصول
     */
    public function shipping_edit($id = null)
    {
        $this->load->eloquent('Shipping');
        if($id) {
            $Shipping = Shipping::find($id);
            $this->smart->assign(array('Shipping' => $Shipping));
        }
        if($this->input->post('submit_btn')) {
            $data = [
                'shipping' => $this->input->post('shipping'),
                'price' => $this->input->post('price'),
            ];
            if(Shipping::updateOrCreate(['id' => $id], $data)):
                $back_link = ADMIN_PATH.'/shop/shop/shipping-list';
                $this->message->set_message(
                    'حمل و نقل افزوده شد', 'success', 'ثبت حمل و نقل', $back_link
                )->redirect();
            endif;
        } else {
            $this->smart->assign([
                'title' => isset($id) ? $Shipping->shipping : 'افزودن حمل و نقل',
                'edit_mode' => isset($id) ? 1 : 0,
            ]);
            $this->smart->view('shop/shipping/edit');
        }
    }

    public function shipping_list()
    {
        $this->load->eloquent('Shipping');
        $this->smart->assign([
            'title' => 'حمل و نقل محصول',
            'Shipping' => Shipping::all(),
        ]);
        $this->smart->view('shop/shipping/index');
    }

    /**
     * حذف آگهی
     * @param type $ads_id
     */
    public function shipping_delete($id = null)
    {
        $this->load->eloquent('Shipping');
        if($Shipping = Shipping::find($id)) {

            $url = ADMIN_PATH.'/shop/shop/shipping-list';
            if($Shipping->delete()) {
                $this->message->set_message('حمل و نقل مربوطه حذف گردید', 'success', 'حذف حمل و نقل ',
                    $url
                )->redirect();
            }
        } else {
            show_404();
        }
    }

    //////////////////////////////////END SHIPPING ///////////////////////////

    /**
     * حذف محصول
     * @param type $product_id
     */
    public function delete($product_id = null)
    {
        if($Prd = Product::find($product_id)) {
            if($Prd->update(['soft_delete' => 1])) {
                foreach ($Prd->filters as $filter_value):
                    $filter_value->delete();
                endforeach;
                $url = '/shop/shop/product-list';
                $this->message->set_message('محصول مربوطه حذف گردید', 'success', 'حذف محصول ',
                    ADMIN_PATH.$url
                )->redirect();
            }
        } else {
            show_404();
        }
    }

    public function getChildCats()
    {
        $cat_id = $this->input->post('id');
        echo json_encode(array('result' => Category::where('parent_id', $cat_id)->get()));
        exit();
    }

}
