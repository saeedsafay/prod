<?php
if ( ! defined('BASEPATH')) {
    exit('No direct script access allowed');
}

class Sms
{
    const VERIFICATION_ID = 30881;
    const FORGOT_VERIFICATION_ID = 40172;
    const ORDER_PLACED = 41930;
    const COUPON_CODE = 42437;

    // your sms.ir panel configuration
    private $APIURL;
    private $secretKey;
    private $APIKey;
    private $lineNumber;

    public $mobile;
    public $templateId;

    /**
     * Gets config parameters for sending request.
     * @param $mobile
     */
    public function __construct($mobile = null)
    {
        date_default_timezone_set("Asia/Tehran");
        $this->mobile = $mobile;
        $this->APIKey = "95c3094273c9b8769ee83451";
        $this->secretKey = "NovinNaghsh";
        $this->APIURL = "https://ws.sms.ir/";
        $this->lineNumber = "30004554554139";
    }

    /**
     * Gets API Ultra Fast Send Url.
     *
     * @return string Indicates the Url
     */
    protected function getAPIUltraFastSendUrl()
    {
        return "api/UltraFastSend";
    }

    /**
     * Gets API Ultra Fast Send Url.
     *
     * @return string Indicates the Url
     */
    protected function getAPIMessageSendUrl()
    {
        return "api/MessageSend";
    }

    /**
     * Gets Api Token Url.
     *
     * @return string Indicates the Url
     */
    protected function getApiTokenUrl()
    {
        return "api/Token";
    }


    /**
     * Ultra Fast Send Message.
     *
     * @param  array  $data  array structure of message data
     *
     * @return string Indicates the sent sms result
     */
    public function ultraFastSend($data)
    {
        $token = $this->getToken();

        if ($token == false) {
            return false;
        }

        $url = $this->APIURL.$this->getAPIUltraFastSendUrl();
        $UltraFastSend = $this->execute($data, $url, $token);

        $object = json_decode($UltraFastSend);

        if (is_object($object)) {
            return $object->Message;
        }
        return false;
    }

    /**
     * Normal Send Message.
     *
     * @param $message
     * @return string Indicates the sent sms result
     */
    public function messageSend($message)
    {
        $token = $this->getToken();

        if ($token == false) {
            return false;
        }
        $data = array(
            'Messages' => [$message],
            'MobileNumbers' => [$this->mobile],
            'LineNumber' => $this->lineNumber,
            'SendDateTime' => date("Y-m-d")."T".date("H:i:s"),
            'CanContinueInCaseOfError' => 'false'
        );

        $url = $this->APIURL.$this->getAPIMessageSendUrl();
        $messageSend = $this->execute($data, $url, $token);

        $object = json_decode($messageSend);

        if (is_object($object)) {
            return $object->Message;
        }
        return false;
    }

    /**
     * Gets token key for all web service requests.
     *
     * @return string Indicates the token key
     */
    private function getToken()

    {
        $postData = array(
            'UserApiKey' => $this->APIKey,
            'secretKey' => $this->secretKey,
            'System' => 'php_rest_v_2_0'
        );
        $postString = json_encode($postData);

        $ch = curl_init($this->APIURL.$this->getApiTokenUrl());
        curl_setopt(
            $ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json'
            )
        );
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postString);

        $result = curl_exec($ch);
        curl_close($ch);

        $response = json_decode($result);

        if (is_object($response) && $response->IsSuccessful == true) {
            return $response->TokenKey;
        }
        return false;
    }

    /**
     * Executes the main method.
     *
     * @param  array  $postData  array of json data
     * @param  string  $url  url
     * @param  string  $token  token string
     *
     * @return string Indicates the curl execute result
     */
    private function execute($postData, $url, $token)
    {
        $postString = json_encode($postData);

        $ch = curl_init($url);
        curl_setopt(
            $ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'x-sms-ir-secure-token: '.$token
            )
        );
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $postString);

        $result = curl_exec($ch);
        curl_close($ch);

        return $result;
    }

    public function send(array $params, int $templateId = self::VERIFICATION_ID)
    {
        try {
            // message data
            $data = array(
                "ParameterArray" => [$params],
                "Mobile" => $this->mobile,
                "TemplateId" => $templateId
            );

            return $this->ultraFastSend($data);
        } catch (Throwable $e) {
            throw $e;
            //            echo 'Error UltraFastSend : '.$e->getMessage();
        }
    }
}

