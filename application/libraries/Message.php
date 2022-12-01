<?php

class Message
{
    /**
     * @var string
     */
    private $link_url;

    /**
     * @param $message
     * @param $type
     * @param $title
     * @param $link_url
     * @return $this
     */
    public function set_message($message, $type, $title, $link_url = null)
    {
        $ci = &get_instance();
        $this->link_url = $link_url ? $link_url : $_SERVER['HTTP_REFERER'];
        if (strpos($this->link_url, base_url()) === false) {
            $this->link_url = site_url($this->link_url);
        }
        $ci->session->set_flashdata('message_'.$this->link_url, array(
            'message' => $message,
            'type' => $type,
            'title' => $title,
            'link_url' => $link_url
        ));
        return $this;
    }

    public function redirect()
    {
        redirect($this->link_url);
    }

    /**
     *
     * @return boolean
     */
    public function get_message()
    {
        $ci = &get_instance();
        if (is_array($flashdata = $ci->session->flashdata('message_'.current_url()))) {
            return $flashdata;
        } else {
            return false;
        }
    }

}
