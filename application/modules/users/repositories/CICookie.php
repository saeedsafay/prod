<?php

use Cartalyst\Sentinel\Cookies\CookieInterface;


class CICookie implements CookieInterface
{

    /**
     * The CodeIgniter input object.
     *
     * @var CI_Input
     */
    protected $input;

    /**
     * The cookie options.
     *
     * @var array
     */
    protected $options = [
        'name' => 'cartalyst_sentinel',
        'domain' => '',
        'path' => '/',
        'prefix' => '',
        'secure' => false,
    ];

    /**
     * Create a new CodeIgniter cookie driver.
     *
     * @param CI_Input $input
     * @param string|array $options
     * @return void
     */
    public function __construct($input, $options = [])
    {
        $this->input = $input;

        if (is_array($options)) {
            $this->options = array_merge($this->options, $options);
        } else {
            $this->options['name'] = $options;
        }
    }

    /**
     * {@inheritDoc}
     */
    public function put($value): void
    {
        $options = array_merge($this->options, [
            'value' => json_encode($value),
            'expire' => 2628000,
        ]);

        $this->input->set_cookie($options);
    }

    /**
     * {@inheritDoc}
     */
    public function get()
    {
        $value = $this->input->cookie($this->options['name']);

        if ($value) {
            return json_decode($value);
        }
    }

    /**
     * {@inheritDoc}
     */
    public function forget(): void
    {
        $this->input->set_cookie([
            'name' => $this->options['name'],
            'value' => '',
            'expiry' => '',
        ]);
    }
}