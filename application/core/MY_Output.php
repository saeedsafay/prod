<?php

class MY_Output extends CI_Output
{

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * @param  array  $data
     * @param  int  $status
     * @param  array  $headers
     * @return bool
     */
    public function jsonResponse($data = [], int $status = 200, array $headers = [])
    {
        $this->set_content_type("application/json");
        $this->set_status_header($status);
        $this->set_output(json_encode($data));
        return true;
    }
}