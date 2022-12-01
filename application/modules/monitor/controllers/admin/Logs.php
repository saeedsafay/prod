<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of Transactions
 *
 * @author Saeed
 */
class Logs extends Admin_Controller
{

    public function __construct()
    {
        parent::__construct();
    }

    public function index()
    {
        try {
            $logs = new League\Flysystem\Adapter\Local(APPPATH."logs");
            $logFiles = $logs->listContents();
            $data = [];
            foreach ($logFiles as $log) {
                $handle = fopen($logs->applyPathPrefix($log['path']), "r");
                $logLines = "";
                if ($handle) {
                    while (($line = fgets($handle)) !== false) {
                        $logLines .= "<p style='text-align: left'>".$line."</p>";
                    }
                    fclose($handle);
                } else {
                    // error opening the file.
                }
                $data[] = [
                    "header" => $log,
                    "content" => $logLines,
                ];
            }
        } catch (Throwable $e) {
            log_message("error", $e->getMessage());
            show_error($e->getMessage());
        }
        krsort($data);
        $this->smart->assign([
            'title' => 'لاگ های سیستم',
            'logs' => $data
        ]);
        $this->smart->view('index');
    }

}
