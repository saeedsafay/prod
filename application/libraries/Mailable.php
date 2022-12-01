<?php
(defined('BASEPATH')) or exit('No direct script access allowed');

/**
 * Class Mailable create a mailable instance for sending mails using send_mail() helper
 * @author Saeid Tavakoli
 * @date 01-2021
 */
class Mailable
{
    public function __construct()
    {
    }

    /**
     * @var array
     */
    protected $variables;

    /**
     * @var string
     */
    protected $route;
    /**
     * @var string
     */
    protected $subject;
    /**
     * @var string
     */
    protected $view;

    public function variables(array $variables = [])
    {
        $this->variables = $variables;
        return $this;
    }

    public function route(string $route)
    {
        $this->route = $route;
        return $this;
    }

    public function subject(string $subject)
    {
        $this->subject = $subject;
        return $this;
    }

    public function view(string $view)
    {
        $this->view = $view;
        return $this;
    }

    public function getVariables()
    {
        return $this->variables;
    }

    public function getRoute()
    {
        return $this->route;
    }

    public function getSubject()
    {
        return $this->subject;
    }

    public function getView()
    {
        return $this->view;
    }

}