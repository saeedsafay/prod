<?php


use Cartalyst\Sentinel\Sessions\SessionInterface;


class CISession implements SessionInterface
{
    /**
     * The CodeIgniter session driver.
     *
     * @var CI_Session
     */
    protected $CI;

    /**
     * The session key.
     *
     * @var string
     */
    protected $key = 'cartalyst_sentinel';

    /**
     * Create a new CodeIgniter Session driver.
     *
     * @param CI_Session $store
     * @param string $key
     * @return void
     */
    public function __construct($store, string $key = null)
    {
        $this->CI = $store;
        if (isset($key)) {
            $this->key = $key;
        }
    }

    /**
     * Put a value in the Sentinel session.
     *
     * @param mixed $value
     *
     * @return void
     */
    public function put($value): void
    {
        $this->CI->set_userdata($this->key, serialize($value));
    }

    /**
     * Returns the Sentinel session value.
     *
     * @return mixed
     */
    public function get()
    {
        $value = $this->CI->userdata($this->key);

        if ($value) {
            return unserialize($value);
        }
    }

    /**
     * Removes the Sentinel session.
     *
     * @return void
     */
    public function forget(): void
    {
        $this->CI->unset_userdata($this->key);
    }
}