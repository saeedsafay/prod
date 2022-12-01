<?php

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;

(defined('BASEPATH')) or exit('No direct script access allowed');

/**
 * CMS Canvas
 *
 * @author      Mark Price
 * @copyright   Copyright (c) 2012
 * @license     MIT License

 */
class Dashboard extends Admin_Controller
{

    function index()
    {
        $this->load->eloquent('shop/Cart');
        $this->load->eloquent('shop/Diversity_data');

        $last_week = Carbon\Carbon::parse('last week')->format('Y-m-d H:i:s');
        $sale_this_week = Cart::where('status', 1)->where('pay_at', '>=', $last_week)->with('varients')->get();

        $saleThisWeekSum = 0;
        foreach ($sale_this_week as $val):
            foreach ($val->varients as $order):
                $saleThisWeekSum += $order->pivot->unit_price * $order->pivot->qty;
            endforeach;
        endforeach;

        $today = Carbon\Carbon::parse('today')->format('Y-m-d H:i:s');
        $sale_today = Cart::where('status', 1)->where('pay_at', '>=', $today)->with('varients')->get();

        $saleTodaySumb = 0;
        foreach ($sale_today as $val):
            foreach ($val->varients as $order):
                $saleTodaySumb += $order->pivot->unit_price * $order->pivot->qty;
            endforeach;
        endforeach;
        $this->smart->assign(
            [
                'title' => 'داشبورد مدیریتی',
                'saleThisWeek' => $saleThisWeekSum,
                'saleToday' => $saleTodaySumb,
                'server_info' => $this->request("get", "regions/ir-thr-at1/servers")['data'],
                'server_images' => $this->request("get", "regions/ir-thr-at1/images?type=server")['data'],
                //                    'form_dropdown' => form_dropdown('filter[group_id]', option_array_value($Groups, 'id', 'name', array('' => '')), set_filter('users', 'group_id'), 'data-md-selectize')
            ]
        );
        $this->smart->view('index');
    }

    private function toUrl($uri)
    {
        return $_ENV["API_URL_ECC"].$uri;
    }

    private function request($method, $uri)
    {
        try {
            $client = new Client();
            return json_decode($client->request($method, $this->toUrl($uri),
                [
                    'timeout' => 4.0,
                    "headers" => ["Authorization" => $_ENV['ARVAN_API_KEY']],
                ])->getBody()->getContents(), 1);
        } catch (GuzzleException $e) {
            log_message("error", $e->getMessage());
            return false;
        } catch (Throwable $e) {
            log_message("error", $e->getMessage());
            return false;
        }
    }

}
