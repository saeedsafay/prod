<?php

use GuzzleHttp\Client;
use GuzzleHttp\Exception\GuzzleException;

class VisaMetric extends Public_Controller
{

    public function checkVisaMetricDates()
    {
        try {

            $client = new Client(['verify' => false]);
            $resBody['available_days'] = null;
            $response = $client->get("https://iranappointments.visametric.com/api/getDays", [
                'timeout' => 15.0,
                'decode_content' => 'application/json',
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept-Encoding' => 'application/json',
                    'Cache-Control' => 'no-cache',
                    'Referer' => 'https://iranappointments.visametric.com/schengen/fr/purposeofvisit',
                    'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36',
                ],
                'json' => [
                    "office" => 1,
                    "number" => 1,
                    "kvtid" => 1,
                ]
            ]);
            $resBody = json_decode($response->getBody()->getContents(), 1);
        } catch (GuzzleException $e) {
            log_message("error", "VISAMETRIC: ".$e->getMessage());
            return false;
        } catch (Throwable $e) {
            log_message("error", "VISAMETRIC: ".$e->getMessage());
            return false;
        }
        $now = \Illuminate\Support\Facades\Date::now("Asia/Tehran")->format("Ymd");

        $singleDizi = [];
        $hoursResBody = null;
        foreach ($resBody['available_days'] as $index => $single) {
            $availableHour = null;
            $single2 = $single;
            $single = str_replace("-", "", $single);
            if ($single >= $now && count($singleDizi) < 2) {
                $hoursResponse = $client->get("https://iranappointments.visametric.com/api/getHours", [
                    'timeout' => 15.0,
                    'decode_content' => 'application/json',
                    'headers' => [
                        'Content-Type' => 'application/json',
                        'Accept-Encoding' => 'application/json',
                        'Cache-Control' => 'no-cache',
                        'Referer' => 'https://iranappointments.visametric.com/schengen/fr/purposeofvisit',
                        'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36',
                    ],
                    'json' => [
                        "office" => 1,
                        "number" => 1,
                        "kvtid" => 1,
                        "date" => $single2
                    ]
                ]);
                $hoursResBody = json_decode($hoursResponse->getBody()->getContents(), 1);

                if ($hoursResBody['available_hours'] !== null) {
                    $singleDizi[] = $single;
                }
            }
        }
        $appointmentDate = null;
        if (count($singleDizi) > 0) {
            $hasDate = true;
            $min = (string)$singleDizi[0];
            $appointmentDate = date("Y-m-d", strtotime($min));
            $this->__send_appointment_email([
                'appointment_date' => $appointmentDate,
                'to' => "ali.taherizadeh73@yahoo.com",
                'cc' => 'saeed.g71@gmail.com',
            ]);
        } else {
            $hasDate = false;
        }

        dd([
            'hours_res_body' => $hoursResBody,
            'response_body' => $resBody,
            'single_dizi' => $singleDizi,
            'has_date' => $hasDate,
            'appointment_date' => $appointmentDate
        ]);
    }

    public function norderstedt()
    {
        $JanuaryURL = "https://timeacle.com/api/calendar/opendays/object/row/id/86/month/1/year/2021";
        $April = "https://timeacle.com/api/calendar/opendays/object/row/id/86/month/4/year/2021";
        return $this->norderstedtRequest($JanuaryURL) && $this->norderstedtRequest($April);
    }

    protected function norderstedtRequest($URL)
    {
        try {
            $client = new Client(['verify' => false]);
            $resBody['available_days'] = null;
            $response = $client->get($URL, [
                'timeout' => 15.0,
                'decode_content' => 'application/json',
                'headers' => [
                    'Content-Type' => 'application/json',
                    'Accept-Encoding' => 'application/json',
                    'Cache-Control' => 'no-cache',
                    'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36',
                ]
            ]);
            $resBody['available_days'] = json_decode($response->getBody()->getContents(), 1);
        } catch (GuzzleException $e) {
            print_r($e->getMessage(), 1);
        } catch (Throwable $e) {
            print_r($e->getMessage(), 1);
        }
        if ($resBody['available_days'] != null) {
            try {
                return $this->__send_appointment_email([
                    'appointment_date' => $resBody,
                    'to' => 'saeed.g71@gmail.com',
                    'cc' => "sarahsafaei72@gmail.com",
                ],
                    "Norderstedt Rathaus");
            } catch (Throwable $e) {
                print_r($e->getMessage(), 1);
            }
        }

        print_r([
            'datetime' => date("Y-m-d H:i"),
            'response_body' => $resBody,
        ], 1);
    }

    public function __send_appointment_email($data, $site_name = "VISAMETRIC APPOINTMENT")
    {
        $config = array(
            'mailtype' => 'html',
            'charset' => 'utf-8',
            'protocol' => 'sendmail',
            'priority' => 1
        );
        $this->load->library('email', $config);
        $this->email->set_newline("\r\n");

        $this->email->initialize($config);
        $this->email->from('appointment@'.getDomain());
        $this->email->to($data['to']);
        $this->email->cc($data['cc']);
        $this->email->set_header("Reply-To", "appointment@".getDomain());
        $this->email->set_header("X-Priority", 1);
        $this->email->subject('  - وقت جدید باز شد !!!!'.$site_name);

        $data['message'] = '  - وقت جدید باز شد !!!!'.$site_name.' '.print_r($data['appointment_date'], 1);
        $mailViewTpl = $this->load->theme('visaMetric.php', $data, true, 'views');
        $this->email->message($mailViewTpl);
        try {
            echo date("Y-m-d H:i")."\n";
            print_r($this->email->send(), 1);
        } catch (Throwable $e) {
            log_message("error", $e->getMessage());
            throw $e;
        }
    }


}