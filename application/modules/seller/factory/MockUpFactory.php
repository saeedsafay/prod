<?php

require_once APPPATH.'modules/seller/interfaces/MockUpInterface.php';
require_once APPPATH.'modules/seller/handlers/MockupsHandler.php';

class MockUpFactory
{
    /**
     * The proper instance of handler class will be assigned to the $strategy
     * @var null
     */
    private $strategy = null;

    private $ci;
    /**
     * @var mixed
     */
    private $mockup_types;

    /**
     * MockUpFactory constructor.
     */
    public function __construct()
    {
        $this->ci = &get_instance();
        try {
            $this->mockup_types = config_item("import_seller")["mockup_types"];
        } catch (Throwable $e) {
            throw new InvalidArgumentException("Missing configurations for import_seller");
        }
        // make sure that the class is implementing the interface
        try {
            $handlerClass = config_item("import_seller")["handler_class"];
            if ( ! in_array(
                MockUpInterface::class, class_implements($handlerClass))
            ) {
                throw new OutOfBoundsException(
                    "$handlerClass class must implement the Interface: ".MockUpInterface::class
                );
            }
            $this->strategy = new $handlerClass();
        } catch (Throwable $e) {
            log_message("error", $e->getMessage()."\n".$e->getTraceAsString());
            throw new Exception($e->getMessage());
        }
    }

    /**
     * Dynamic call for the mockup interface methods
     * @param $method
     * @param $arguments
     * @return mixed
     * @throws \Exception
     */
    public function __call($method, $arguments)
    {
        try {
            return call_user_func_array([$this->strategy, $method], $arguments);
        } catch (Throwable $e) {
            log_message("error", $e->getMessage()."\n".$e->getTraceAsString());
            throw new Exception($e->getMessage());
        }
    }

}