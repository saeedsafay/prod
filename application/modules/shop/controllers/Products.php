<?php

use Illuminate\Database\Eloquent\ModelNotFoundException;

(defined('BASEPATH')) or exit('No direct script access allowed');

require_once APPPATH.'modules/shop/concerns/SearchConcerns.php';

/**
 * Shop Front Controller
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2016
 * @license     MIT License
 * @link saeedtavakoli.ir author's personal website.
 */
class Products extends Public_Controller
{

    public $validation_rules = array(
        'makeSingleCartAction' => array(
            ['field' => 'decoration_id', 'rules' => 'numeric|required|htmlspecialchars', 'label' => 'نوع تزئین'],
        ),
        'comment' => array(
            ['field' => 'comment', 'rules' => 'required|htmlspecialchars|trim', 'label' => 'متن نظر'],
        )
    );

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent([
            'Keyword',
        ]);
    }

    /**
     * صفحه اصلی فروشگاه
     */
    public function index()
    {
        $this->smart->assign(
            array(
                'title' => 'صفحه اصلی',
                'cats' => Category::all(),
            ));
        $this->smart->view('home');
    }

    /**
     * List of the products by the given slugs from categories
     * @param  string  $productTypeSlug
     * @param  null  $categorySlug
     * @param  null  $childCatSlug
     * @param  int  $page
     */
    public function general_products($productTypeSlug, $categorySlug = null, $childCatSlug = null)
    {
        $productTypeSlug = urldecode($productTypeSlug);
        $filters = explode('?', $_SERVER['REQUEST_URI']);
        $this->load->eloquent('users/User_address');
        $this->load->eloquent('users/User');
        // Params for filtering results
        $page = $this->input->get("page") ? $this->input->get("page") : 1;
        $params['thematic_category_id'] = $this->input->get('thematic_category_id');
        $params['sort'] = $this->input->get('sort');
        $params['child_category_slug'] = urldecode($childCatSlug);
        $params['stock_type'] = $this->input->get('stock_type');
        $params['per_page'] = $this->input->get('per_page') ? $this->input->get('per_page') : 32;
        $params['free_shipping'] = $this->input->get('free_shipping');
        $params['province_id'] = $this->input->get('province_id');
        $params['county_id'] = $this->input->get('county_id');
        $params['cat_id'] = $this->input->get('cat_id');
        $params['region_id'] = $this->input->get('region_id');
        $params['neighbourhood_id'] = $this->input->get('neighbourhood_id');
        $params['dynamic_filter'] = $this->input->get('dynamic_filter');
        $params['price']['min'] = $this->input->get('min_price');
        $params['price']['max'] = $this->input->get('max_price');

        if ($params['child_category_slug'] !== "") {
            try {
                $childCategory = Category::query()
                    ->where('slug', $params['child_category_slug'])
                    ->whereHas('parentCat', function ($q) use ($categorySlug) {
                        return $q->where('slug', urldecode($categorySlug));
                    })
                    ->with(['parentCat', 'product_type', 'filters'])
                    ->firstOrFail();
                $params['child_category'] = $childCategory;
            } catch (ModelNotFoundException $e) {
                show_404("content");
            } catch (Throwable $e) {
                $this->monolog->error("category not found for the slug = '$childCatSlug'");
                show_error($e->getMessage());
            }
        } else {
            $params['child_category'] = null;
        }

        // Sort By Default
        $orderBy = array('visit_counts', 'DESC');
        if ($params['sort'] != '') {
            switch ($params['sort']) {
                case 'lowPrice':
                    $orderBy[0] = 'price';
                    $orderBy[1] = 'asc';
                    break;
                case 'highPrice':
                    $orderBy[0] = 'price';
                    $orderBy[1] = 'desc';
                    break;
                case 'newest':
                    $orderBy[0] = 'created_at';
                    $orderBy[1] = 'desc';
                    break;
                case 'mostVisited':
                    $orderBy[0] = 'visit_counts';
                    $orderBy[1] = 'desc';
                    break;
                case 'sold':
                    $orderBy[0] = 'sold_count';
                    $orderBy[1] = 'desc';
                    break;
            }
        }


        $productType = null;
        $productTypeFilters = [];

        // Get current product type given by the parameter
        try {
            $productType = Product_type::with("mainCategories", "categories")
                ->where('slug', $productTypeSlug)->firstOrFail();
        } catch (ModelNotFoundException $e) {
            log_message('debug', 'Product type not found where slug = '.$productTypeSlug);
            redirect('content');
        }

        if (isset($childCategory)) {
            if ($childCategory->parent_id == null) {
                $this->smart->assign(['parentCatList' => true, 'p_cat' => $childCategory]);
            } else {
                // Form business card category, we need extra form in fe
                /**************************************************
                 * START FOR NOVIN NAGHSH FORM
                 */
                if ($childCategory->has_order_form) {
                    try {
                        if ( ! $jsonData = cache('json_data_category_'.$childCategory->id)) {
                            $jsonData = cache_set('json_data_category_'.$childCategory->id,
                                $this->productConcern->categoryVariantsPayLoad($childCategory));
                        }
                        $this->smart->assign(['hasForm' => true, 'jsonData' => json_encode($jsonData)]);
                    } catch (Throwable $e) {
                        $this->smart->assign(['hasForm' => false]);
                    }
                }
                /**************************************************
                 * END FOR NOVIN NAGHSH FORM
                 * ************************************************
                 */
                $productTypeFilters = $childCategory->filters()->where("show_filter", 1)->get();
            }
        } else {
            $this->smart->assign(['ProductTypeList' => true, 'p_cats' => $productType->mainCategories]);
        }
        $p_type_id = $productType->id;

        // Get products for needed categories
        $products = Product::getGeneralProducts($p_type_id, $orderBy, $params, $page);

        // Now init the configs for pagination class
        $this->load->eloquent(['users/Province', 'users/City', 'users/County']);
        $title = $p_type_id == 0 ? 'لیست محصولات' : 'لیست کالاهای '.$productType->title;
        $title .= isset($childCategory) ? " | ".$childCategory->title : "";
        $this->smart->assign(
            array(
                'title' => $title,
                'Product_type' => $productType,
                'Products' => $products->isEmpty() ? false : $products->items(),
                'currentCategory' => isset($childCategory) ? $childCategory : null,
                'Categories' => $productType->categories,
                'product_type_filters' => $productTypeFilters, // DYNAMIC FILTERS FOR PRODUCT TYPE
                'dynamic_filter_values' => $this->input->get('dynamic_filter'),
                'staticFilters' => $params,
                'stock_type' => $params['stock_type'],
                'min_price' => $params['price']['min'],
                'max_price' => $params['price']['max'],
                'filters' => isset($filters[1]) ? $filters[1] : '',
                //                'most_visited' => Product::getPopularProducts(4, 0),
                'product_types' => Product_type::all(),
                'current_product_type' => $p_type_id != 0 ? $productType->title : 'همه',
                'slug' => $productTypeSlug,
                'currentOrder' => isset($params['sort']) ? $params['sort'] : '',
                'pagination' => $products->toArray(),
            )
        );
        $this->smart->view('list_general_products');
    }


    public function shops($page = 0)
    {
        $this->checkAuth(false);

        $params['province_id'] = $this->input->get('province_id');
        $params['county_id'] = $this->input->get('county_id');
        $params['region_id'] = $this->input->get('region_id');
        $params['neighbourhood_id'] = $this->input->get('neighbourhood_id');
        $params['business_name'] = $this->input->get('business_name');

        // Around me filters
        $params['coordinates'] = array();
        if ($this->input->get('h_lat')) {
            $h_lat = $this->input->get('h_lat');
            $h_lon = $this->input->get('h_lon');
            $this->load->library('GeoLocation');
            $this->load->library('AddressGeoLocation');
            $addressObj = new AddressGeoLocation;
            $around_address = $addressObj->getAddress(
                $h_lat, $h_lon
            );
            $this->smart->assign(array(
                'around_address' => $around_address,
            ));

            $myLocation = GeoLocation::fromDegrees($h_lat, $h_lon);
            $coordinates = $myLocation->boundingCoordinates(3, 'km');
            $params['coordinates']['min_lat'] = $coordinates[0]->getLatitudeInDegrees();
            $params['coordinates']['max_lat'] = $coordinates[1]->getLatitudeInDegrees();
            $params['coordinates']['min_lon'] = $coordinates[0]->getLongitudeInDegrees();
            $params['coordinates']['max_lon'] = $coordinates[1]->getLongitudeInDegrees();
        }

        $shops = User::getShops($params, 20, $this->config->item('per_page') * ($page));
        //Pagination configs
        $config["base_url"] = base_url()."shop/products/shops";
        $config["total_rows"] = $shops['total']->count();
        $config['last_link'] = '>>';
        $config['first_link'] = '<<';
        $config["uri_segment"] = 4;
        // Now init the configs for pagination class
        $this->pagination->initialize($config);
        $this->smart->assign(
            [
                'title' => 'لیست گل‌فروشی‌ها ',
                'Shops' => $shops['requested']->isEmpty() ? false : $shops['requested'],
                'Provinces' => Province::all(),
                'province_id' => $params['province_id'],
                'county_id' => $params['county_id'],
                'region_id' => $params['region_id'],
                'neighbourhood_id' => $params['neighbourhood_id'],
                'business_name_filter' => $params['business_name'],
                'paging' => $this->pagination->create_links(),
            ]
        );
        $this->smart->view('list_shops');
    }

    /**
     * Product detail page
     * @param $id
     * @param  null  $slug  product slug
     * @return bool
     */
    public function view_product($id, $slug = null)
    {
        try {
            if ( ! $product = cache('product_'.$id)) {
                $product = cache_set('product_'.$id, $this->productConcern->getProductById($id), 3600);
            }
        } catch (Throwable $e) {
            log_exception($e);
            show_error($e->getMessage(), $e->getCode());
            return false;
        }
        if ( ! $id || ! $product || $product->status != 1 || $product->soft_delete == 1) {
            show_404();
        } elseif ($product->slug != urldecode($slug)) {
            redirect(site_url($product->link));
        }


        try {
            $jsonPayLoad = array(
                'formInitData' => [],
                'has_qty_input' => ! $product->child_category->variants_as_package,
                'variants' => $this->productConcern->getProductVariants($product)
            );
            $buyBoxVariant = $product->varients->first();
            // for checked input in first loading of the page
            $buyBoxValueIds = [];
            if ($buyBoxVariant) {
                foreach ($buyBoxVariant->fields as $buyBoxField) {
                    $buyBoxValueIds[] = $buyBoxField->value->id;
                }
            }

            $showFilters = [];
            foreach ($product->filters as $filter) {
                $showFilters[$filter->product_filter_id]["title"] = $filter->parentFilter->label;
                $showFilters[$filter->product_filter_id]['values'][] = $filter->toArray();
            }
        } catch (Throwable $e) {
            log_exception($e);
            show_error($e->getMessage(), $e->getCode());
            return false;
        }

        load_events('shop', 'ProductIsViewedEvent');
        event(new ProductIsViewedEvent($product));

        try {
            if ( ! $related = cache('related_product_'.$id)) {
                $related = cache_set('related_product_'.$id,
                    $related = $this->productConcern->getRelatedByCategory($product->child_category));
            }
        } catch (Throwable $e) {
            log_exception($e);
        }

        $this->smart->assign(
            [
                'title' => 'مشخصات، قیمت و خرید '.$product->title,
                'product' => $product,
                'showFilters' => $showFilters,
                'has_qty_input' => ! $product->child_category->variants_as_package,
                'jsonPayLoad' => json_encode($jsonPayLoad),
                'keywords' => $product->keywords,
                'related' => $related,
                'diversity_data' => $product->varients,
                'buyBoxValueIds' => $buyBoxValueIds,
                'respectiveVariants' => $product->child_category->diversities->toArray(),
                'buyBoxVariant' => $buyBoxVariant,
                //                    'most_visited' => product::getPopularAds(4 , 0 , 10) ,
            ]
        );
        $this->smart->view('product_view');
    }


    public function comment()
    {

        $this->checkAuth(true);
        $referer = explode('/', $_SERVER["HTTP_REFERER"]);
        $productId = null;
        foreach ($referer as $segment) {
            if (strpos($segment, "NPI") !== false) {
                $productId = (int)substr($segment, 4);
            }
        }
        if ( ! $productId) {
            log_message("error",
                "Error Finding product ID for submitting comments. REFERER: {$_SERVER["HTTP_REFERER"]}");
            redirect('/');
        }
        if ($this->formValidate()) {
            $data = [
                "comment" => $this->input->post('comment'),
                "status" => 0,
                "user_id" => $this->user->id,
            ];
            $product = Product::find($productId);
            if ($product->comments()->create($data)) {
                $this->message->set_message('نظر شما با موفقیت ثبت گردید و پس از تایید نمایش داده می شود.', 'success',
                    'ارسال نظر')->redirect();
            } else {
                $this->message->set_message('ثبت نظر با مشکل مواجه شد. مجدد تلاش کنید', 'fail',
                    'ارسال نظر')->redirect();
            }
        } else {
            $this->message->set_message('خطا در داده های ورودی. '.validation_errors(), 'fail', 'ثبت نظر')->redirect();
        }
    }


    /**
     * نمایش صفحه لیست تخفیف ها
     * @param  string  $slug
     */
    public function view_festival($slug = null)
    {
        $this->checkAuth(false);
        $this->load->eloquent('Wonder_category');
        $wonder_cat = Wonder_category::where('slug', urldecode($slug))->with('wonder', 'wonder.product')->first();

        $this->smart->assign(
            [
                'title' => $wonder_cat->title,
                'data' => $wonder_cat,
            ]
        );
        $this->smart->view('wonders');
    }

    /**
     * @return bool
     */
    public function AddToCart()
    {

        $productVariantId = $this->input->post('product_varient_id', true);
        $qty = $this->input->post('qty', true) ? $this->input->post('qty', true) : 1;

        try {
            $diversityData = Diversity_data::whereKey($productVariantId)
                ->with('fields.value')
                ->with([
                    'product' => function ($q) {
                        $q->select(
                            "id", "slug", "user_id", "title", "product_category_id", "product_child_category_id",
                            "product_type_id", "pic"
                        );
                    },
                    "product.category:id,slug,title",
                    "product.child_category:id,slug,variants_as_package",
                    "product.product_type:id,title,slug"
                ])->firstOrFail();
        } catch (Throwable $e) {
            log_exception($e);
            $code = ! $e->getCode() ? 500 : $e->getCode();
            return $this->output->jsonResponse([
                'error' => 'خطای سیستمی. لطفا به پشتیبانی اطلاع دهید.'
            ], $code);
        }

        if ($diversityData === null || ! $diversityData->status || $diversityData->stock == 0 ||
            $diversityData->stock < $qty) {
            return $this->output->jsonResponse([
                'success' => false,
                'error' => 'محصول در حال حاضر به تعداد مورد درخواست شما موجود نیست'
            ], 422);
        }

        if ( ! $diversityData->product) {
            return $this->output->jsonResponse([
                'error' => 'کالای مورد نظر در پایگاه داده وجود ندارد'
            ], 404);
        }

        try {
            $variantPivotData = [];
            if ($this->input->post("files")) {
                foreach ($this->input->post("files") as $file) {
                    $variantPivotData['files'][$file['id']] = $file['returned_name'];
                }
                $variantPivotData['files'] = json_encode($variantPivotData['files']);
            }
            $variantPivotData['is_package'] = $diversityData->product->child_category->variants_as_package;
            $variantPivotData['printing_desc'] = $this->input->post('description', true);
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطای سیستمی. لطفا به پشتیبانی اطلاع دهید.'
            ], $e->getCode());

        }

        try {
            if ( ! isset($this->user->id)) {
                load_events('shop', 'SessionCartItemAddedEvent');
                event(new SessionCartItemAddedEvent($diversityData, $variantPivotData, $qty));
            } else {
                load_events('shop', 'CartItemAddedEvent');
                event(new CartItemAddedEvent($this->user->id, $diversityData, $variantPivotData, $qty));
            }
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطای سیستمی. لطفا به پشتیبانی اطلاع دهید.'
            ], 500);
        }

        return $this->output->jsonResponse([
            'item' => [
                'id' => $diversityData->id,
                'title' => $diversityData->product->title,
                'price' => $diversityData->price,
            ],
            'link' => site_url($diversityData->product->link),
            'image' => str_replace(PUBLICPATH, "/", config("import_seller")['product_pic_prefix_dir']).
                $diversityData->thumbnail,
            'qty' => $qty,
        ]);
    }

    /**
     * صفحه سبد خرید
     */
    public function cart()
    {
        $this->smart->assign([
            'title' => 'سبد خرید',
        ]);
        $this->smart->view('cart');
    }


    public function cart_delivery_address()
    {
        $this->load->eloquent('users/User_address');

        $this->cartConcern->checkDiscountMaxPurchase();
        if (isset($this->user->id)) {
            $addresses = User_address::with('province', 'county')->user($this->user->id)->get();
            $this->smart->assign([
                'title' => 'انتخاب آدرس تحویل',
                'addresses' => $addresses,
                'provinces' => Province::all()
            ]);
            $this->smart->view('cart_delivery_address');
        } else {
            $this->session->set_userdata('requested_url', '/shop/cart');
            $this->message->set_message(
                'کاربر گرامی برای تکمیل فرآیند خرید، لطفا وارد حساب کاربری خود شوید یا ثبت نام کنید. سپس به صفحه تکمیل پرداخت هدایت خواهید شد.',
                'success',
                'تکمیل خرید',
                '/users/login'
            )->redirect();
        }
    }

    /**
     * @return bool
     */
    public function removeCartItem()
    {
        $variantId = $this->input->post('variant_id');
        try {
            if (isset($this->user->id)) {
                $Cart = Cart::where([
                    'user_id' => $this->user->id,
                    'status' => 0
                ])->first();
                $Cart->varients()->detach($variantId);
                $count = $Cart->varients->count();

            } else {
                $sessionCart = $this->session->userdata('session_cart');
                foreach ($sessionCart as $key => $item) {
                    if ($item['diversity_data']->id == $variantId) {
                        unset($sessionCart[$key]);
                        $this->session->set_userdata('session_cart', $sessionCart);
                        $count = count($sessionCart);
                        break;
                    }
                }
            }
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'success' => false,
                'error' => 'خطای سیستمی. لطفا به پشتیبانی اطلاع دهید.'
            ], $e->getCode());
        }

        return $this->output->jsonResponse([
            'response' => 1,
            'count' => $count
        ]);
    }

    /**
     * افزودن آجاکسی محصول به لیست علاقمندی های کاربر لاگین شده
     */
    public function addFavorite()
    {
        $this->load->eloquent('Favorite');
        $p_id = $this->input->post('product_id');
        // seller account type does not have permission for this action
        if (isset($this->user->id)) {
            if ($this->user->type == 1) {
                die(json_encode(array('response' => 404)));
            }
            $params = array(
                'user_id' => $this->user->id,
                'product_id' => $p_id,
            );
            Favorite::updateOrCreate($params, $params);
            die(json_encode(array
            (
                'response' => 1
            )));
        } else {
            die(json_encode(array('response' => 0)));
        }
    }


    /**
     * متد آپلود تصویر به  روش ایجکس
     */
    public function uploadImages()
    {
        $images = [];
        foreach ($_FILES as $index => $file) {
            if ( ! empty($file['name'])) {
                try {
                    $images[$index] = $this->input->imageFile($index, 'orders', ['jpg', 'jpeg', 'cdr', 'png', 'pdf']);
                    if (is_array($images[$index])) {
                        return $this->output->jsonResponse([
                            'status' => false,
                            'error' => $images[$index][0]->__toString()
                        ], 422);
                    }
                } catch (Throwable $e) {
                    return $this->output->jsonResponse([
                        'status' => false,
                        "error" => "File: $index: ".$e->getMessage()
                    ], $e->getCode());
                }
            }
        }
        return $this->output->jsonResponse([
            'status' => true,
            'content' => $images
        ]);
    }

    public function getFiltersByCategory()
    {
        $productCategoryId = $this->input->get('product_category_id');

        try {
            $filters = Filter::whereHas("child_category", function ($q) use ($productCategoryId) {
                $q->whereKey($productCategoryId);
            })->with('values')->get();
        } catch (Throwable $e) {
            log_message("error", $e->getMessage());
            return $this->output->jsonResponse([
                'errors' => "خطای سروری، لطفا به پشتیبانی اطلاع دهید"
            ], $e->getCode());
        }

        if ($filters->isEmpty()) {
            return $this->output->jsonResponse([
                'filters' => []
            ], 422);
        }

        return $this->output->jsonResponse([
            'filters' => $filters
        ]);
    }

    /**
     * @return bool
     */
    public function apply_coupon()
    {
        $couponCode = $this->input->post('code');

        try {
            $coupon = Coupon::query()->where('code', $couponCode)->first();
            if ( ! $coupon || $coupon->status
                || (isset($this->user->id) && $coupon->user_id && $coupon->user_id != $this->user->id)
            ) {
                return $this->output->jsonResponse([
                    'error' => 'کد تخفیف نامعتبر است',
                ], 422);
            }
            $this->cartConcern->applyDiscountCode($coupon);

            return $this->output->jsonResponse([
                'message' => 'کد تخفیف اعمال شد',

            ]);
        } catch (InvalidArgumentException $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => $e->getMessage(),
            ], 422);
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطای سرور. لطفا به پشتیبانی اطلاع دهید'
            ], 500);
        }

    }

    public function revoke_coupon()
    {

        try {
            if (isset($this->user->id)) {
                Cart::activeCart($this->user->id)->first()->update(['product_coupons_id' => null]);
            } else {
                $this->session->unset_userdata('session_cart_discount');
            }

            return $this->output->jsonResponse([
                'message' => 'تخفیف حذف شد',
            ]);
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطای سرور. لطفا به پشتیبانی اطلاع دهید'
            ], 500);
        }
    }

    public function getCats()
    {
        $p_id = $this->input->get('product_type_id');

        try {
            $categories = Category::query()->whereHas("product_type", function ($q) use ($p_id) {
                $q->whereKey($p_id);
            })->where('parent_id', null)->get();
        } catch (Throwable $e) {
            log_message("error", $e->getMessage());
            return $this->output->jsonResponse([
                'error' => "خطای سروری، لطفا به پشتیبانی اطلاع دهید."
            ], 500);
        }

        return $this->output->jsonResponse([
            'cats' => $categories
        ]);
    }

    public function getChildCats()
    {
        $cat_id = $this->input->get('parent_cat_id');

        try {
            $parentCat = Category::with("children")->find($cat_id);
        } catch (Throwable $e) {
            log_message("error", $e->getMessage());
            return $this->output->jsonResponse([
                'error' => "خطای سروری، لطفا به پشتیبانی اطلاع دهید."
            ], 500);
        }
        return $this->output->jsonResponse([
            'cats' => $parentCat->children
        ]);
    }

    public function getDiversityInfo()
    {
        $varient_id = $this->input->post('varient');
        $product_id = $this->input->post('product_id');

        try {
            $Field = Diversity_data_field::where('diversity_value_id', $varient_id)
                ->where('product_id', $product_id)
                ->with('varient.fields.value.parentDiversity', 'value')
                ->first();
        } catch (Throwable $e) {
            log_message('error', 'Error querying diversity data field: '.$e->getMessage());
            return $this->output->jsonResponse(['error' => 'An error was encountered.'], 500);
        }

        return $this->output->jsonResponse($Field->toArray());
    }

    public function testmail()
    {

        try {
            list($path, $orderEmail) = Modules::find('OrderEmail', 'shop', 'notifications/');
            Modules::load_file($orderEmail, $path);

            $orderEmail = new OrderEmail($this->user->email, Cart::query()->with('varients', 'user')->where('status', 0)
                ->where('user_id', $this->user->id)->first()->toArray());
            dd(send_email($orderEmail->toMailable()));
        } catch (Throwable $e) {
            log_exception($e);
        }

    }

}
