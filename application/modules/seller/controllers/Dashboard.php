<?php

(defined('BASEPATH')) or exit('No direct script access allowed');

use Illuminate\Support\Facades\Date;
use Morilog\Jalali\CalendarUtils;
use Morilog\Jalali\Jalalian;

/**
 * Shop Front Controller For managing products by users
 *
 * @author      Saeed Tavakoli <saeed.g71@gmail.com>
 * @copyright   Copyright (c) 2017
 * @license     MIT License
 * @link saeedtavakoli.ir author's personal website.
 */
class Dashboard extends Seller_Controller
{


    public function index()
    {
        $thisMonthDate = Jalalian::fromCarbon(Date::now())->subMonths(1)->toArray();
        $jalalianStartDate = implode(
            '-', CalendarUtils::toGregorian($thisMonthDate['year'], $thisMonthDate['month'], 1)
        );
        $thisMonthOrders = Order::query()->where('shop_id', $this->user->id)
            ->whereHas('cart', function ($q) use ($jalalianStartDate) {
                $q->where('status', 1)
                    ->whereBetween('pay_at', [
                        $jalalianStartDate.' 00:00:00',
                        Date::now()->format("Y-m-d H:i:s")
                    ]);
            })
            ->count();
        $todayOrders = Order::query()->where('shop_id', $this->user->id)
            ->whereHas('cart', function ($q) {
                $q->where('status', 1)
                    ->whereDate('pay_at', ">=", Date::today()->format("Y-m-d"));
            })
            ->count();
        $outOfStocks = Diversity_data::query()
            ->whereHas('product', function ($q) {
                $q->where('user_id', $this->user->id);
            })
            ->where('stock', 0)
            ->count();
        $inactiveVariants = Diversity_data::query()
            ->whereHas('product', function ($q) {
                $q->where('user_id', $this->user->id);
            })
            ->where('status', 0)
            ->count();
        $activeVariants = Diversity_data::query()
            ->whereHas('product', function ($q) {
                $q->where('user_id', $this->user->id);
            })
            ->where('status', 1)
            ->count();
        $nearlyOutOfStocks = Diversity_data::query()
            ->whereHas('product', function ($q) {
                $q->where('user_id', $this->user->id);
            })
            ->where('stock', '<', 10)
            ->where('stock', '!=', 0)
            ->count();

        $activeProducts = Product::query()->where('user_id', $this->user->id)
            ->where('status', 1)
            ->where('soft_delete', 0)
            ->count('id');
        $inactiveProducts = Product::query()->where('user_id', $this->user->id)
            ->where('status', 0)
            ->count('id');

        $mostVisitedProducts = Product::query()->where('user_id', $this->user->id)
            ->where('status', 1)
            ->orderByDesc('visit_counts')
            ->take(5)
            ->get(['id', 'title', 'visit_counts']);

        $comments = Comment::query()->whereHasMorph('commentable', 'Product', function ($q) {
            $q->where('user_id', $this->user->id);
        })->with('user','commentable')->orderByDesc('created_at')->take(5)->get();

        $this->smart->assign(array(
            'title' => 'داشبورد',
            'todayOrders' => $todayOrders,
            'thisMonthOrders' => $thisMonthOrders,
            'outOfStocks' => $outOfStocks,
            'nearlyOutOfStocks' => $nearlyOutOfStocks,
            'activeProducts' => $activeProducts,
            'inactiveProducts' => $inactiveProducts,
            'inactiveVariants' => $inactiveVariants,
            'activeVariants' => $activeVariants,
            'mostVisitedProducts' => json_encode($mostVisitedProducts->toArray()),
            'comments' => $comments,
        ));
        $this->smart->view('index');
    }

}
