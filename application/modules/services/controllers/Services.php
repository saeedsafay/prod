<?php

(defined('BASEPATH')) or exit('No direct script access allowed');


class Services extends Public_Controller
{

    public function __construct()
    {
        parent::__construct();
        $this->load->eloquent('users/Province');
    }

    public function getCounties()
    {
        try {
            if ( ! $province_id = $this->input->get('province_id')) {
                exit;
            }
            $counties = Province::query()->with('county')->findOrFail($province_id);
            return $this->output->jsonResponse([
                'data' => $counties
            ]);
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطای سرور'
            ], 500);
        }
    }


    public function getRegions()
    {
        try {
            if ( ! $county_id = $this->input->get('county_id')) {
                exit;
            }

            $regoins = Location_county::query()->with('regions')->findOrFail($county_id);
            return $this->output->jsonResponse([
                'data' => $regoins
            ]);
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطای سرور'
            ], 500);
        }
    }

    public function getNeighbourhood()
    {
        try {
            if ( ! $region_id = $this->input->get('region_id')) {
                exit;
            }

            $neighbourhoods = Location_region::query()->with('neighbourhoods')->findOrFail($region_id);
            return $this->output->jsonResponse([
                'data' => $neighbourhoods
            ]);
        } catch (Throwable $e) {
            log_exception($e);
            return $this->output->jsonResponse([
                'error' => 'خطای سرور'
            ], 500);
        }
    }

}