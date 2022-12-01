<?php

/**
 * Part of the Sentinel package.
 *
 * NOTICE OF LICENSE
 *
 * Licensed under the 3-clause BSD License.
 *
 * This source file is subject to the 3-clause BSD License that is
 * bundled with this package in the LICENSE file.
 *
 * @package    Sentinel
 * @version    2.0.6
 * @author     Cartalyst LLC
 * @license    BSD License (3-clause)
 * @copyright  (c) 2011-2015, Cartalyst LLC
 * @link       http://cartalyst.com
 */

use Cartalyst\Sentinel\Activations\IlluminateActivationRepository;
use Cartalyst\Sentinel\Checkpoints\ActivationCheckpoint;
use Cartalyst\Sentinel\Checkpoints\ThrottleCheckpoint;
use Cartalyst\Sentinel\Hashing\NativeHasher;
use Cartalyst\Sentinel\Hashing\Sha256Hasher;
use Cartalyst\Sentinel\Native\InvalidArgumentException;
use Cartalyst\Sentinel\Persistences\IlluminatePersistenceRepository;
use Cartalyst\Sentinel\Roles\IlluminateRoleRepository;
use Cartalyst\Sentinel\Sentinel;
use Cartalyst\Sentinel\Throttling\IlluminateThrottleRepository;
use Cartalyst\Sentinel\Users\IlluminateUserRepository;
use Illuminate\Events\Dispatcher;

//use App\Modules\Users\ThirdParty\MirookActivationCheckpoint;
//use App\Modules\Users\MirookThrottleCheckpoint;

class Sentinel_loader
{

    /**
     * Configuration.
     *
     * @var array
     */
    protected $config;

    /**
     * The event dispatcher.
     *
     * @var Dispatcher
     */
    protected $dispatcher;

    /**
     * instance of codeigniter.
     * @var type CI
     */
    private $CI;

    /**
     * Constructor.
     *
     * @param  arry  $config
     * @return void
     */
    public function __construct($config = null)
    {
        if (is_string($config)) {
            $this->config = new Cartalyst\Sentinel\Native\ConfigRepository($config);
        } else {
            $this->config = $config ?: new Cartalyst\Sentinel\Native\ConfigRepository;
        }
        $this->CI = get_instance();
    }

    /**
     * Creates a sentinel instance.
     *
     * @return Sentinel
     */
    public function createSentinel()
    {
        //        require_once 'MirookPermission.php';
        $persistence = $this->createPersistence();
        $users = $this->createUsers();
        //        $users->setPermissionsClass('MirookPermission');
        $roles = $this->createRoles();
        $activations = $this->createActivations();
        $dispatcher = $this->getEventDispatcher();

        $sentinel = new Sentinel(
            $persistence, $users, $roles, $activations, $dispatcher
        );

        $ipAddress = $this->getIpAddress();

        $checkpoints = $this->createCheckpoints($activations, $ipAddress);

        foreach ($checkpoints as $key => $checkpoint) {
            $sentinel->addCheckpoint($key, $checkpoint);
        }

        $reminders = $this->createReminders($users);

        $sentinel->setActivationRepository($activations);

        $sentinel->setReminderRepository($reminders);

        return $sentinel;
    }

    /**
     * Create a throttle checkpoint.
     *
     * @param  string  $ipAddress
     * @return ThrottleCheckpoint
     */
    protected function createThrottleCheckpoint($ipAddress)
    {
        require_once 'MirookThrottleCheckpoint.php';
        $throttling = $this->createThrottling();

        return new MirookThrottleCheckpoint($throttling, $ipAddress);
    }

    /**
     * Creates a persistences repository.
     *
     * @return IlluminatePersistenceRepository
     */
    protected function createPersistence()
    {
        $session = $this->createSession();

        $cookie = $this->createCookie();

        $persistences = $this->config['persistences']['model'];

        return new IlluminatePersistenceRepository($session, $cookie, $persistences);
    }

    /**
     * Creates a session.
     *
     * @return CISession
     */
    protected function createSession()
    {
        require_once __DIR__.'/../repositories/CISession.php';

        //        return new NativeSession();

        return new CISession($this->CI->session);
    }

    /**
     * Creates a cookie.
     *
     * @return CICookie
     */
    protected function createCookie()
    {
        require_once __DIR__.'/../repositories/CICookie.php';
        return new CICookie($this->CI->input);
    }

    /**
     * Creates a user repository.
     *
     * @return IlluminateUserRepository
     */
    protected function createUsers()
    {
        $hasher = $this->createHasher();

        require_once __DIR__.'/../models/User.php';
        $model = "User";

        $roles = $this->config['roles']['model'];

        $persistences = $this->config['persistences']['model'];

        if (class_exists($roles) && method_exists($roles, 'setUsersModel')) {
            forward_static_call_array([$roles, 'setUsersModel'], [$model]);
        }

        if (class_exists($persistences) && method_exists($persistences, 'setUsersModel')) {
            forward_static_call_array([$persistences, 'setUsersModel'], [$model]);
        }

        return new IlluminateUserRepository($hasher, $this->getEventDispatcher(), $model);
    }

    /**
     * Creates a hasher.
     *
     * @return NativeHasher
     */
    protected function createHasher()
    {
        return new Sha256Hasher;
    }

    /**
     * Creates a role repository.
     *
     * @return IlluminateRoleRepository
     */
    protected function createRoles()
    {
        $model = $this->config['roles']['model'];

        $users = $this->config['users']['model'];

        if (class_exists($users) && method_exists($users, 'setRolesModel')) {
            forward_static_call_array([$users, 'setRolesModel'], [$model]);
        }

        return new IlluminateRoleRepository($model);
    }

    /**
     * Creates an activation repository.
     *
     * @return IlluminateActivationRepository
     */
    protected function createActivations()
    {
        require_once FCPATH.'application/modules/users/repositories/ActivationRepository.php';
        $model = $this->config['activations']['model'];

        $expires = $this->config['activations']['expires'];

        return new ActivationRepository($model, $expires);
    }

    /**
     * Returns the client's ip address.
     *
     * @return string
     */
    protected function getIpAddress()
    {
        return $this->CI->input->ip_address();
    }

    /**
     * Create an activation checkpoint.
     *
     * @param  IlluminateActivationRepository  $activations
     * @return ActivationCheckpoint
     */
    protected function createActivationCheckpoint(IlluminateActivationRepository $activations)
    {
        require_once 'MirookActivationCheckpoint.php';
        return new MirookActivationCheckpoint($activations);
    }

    /**
     * Create activation and throttling checkpoints.
     *
     * @param  IlluminateActivationRepository  $activations
     * @param  string  $ipAddress
     * @return array
     * @throws \InvalidArgumentException
     */
    protected function createCheckpoints(IlluminateActivationRepository $activations, $ipAddress)
    {
        $activeCheckpoints = $this->config['checkpoints'];

        $activation = $this->createActivationCheckpoint($activations);

        $throttle = $this->createThrottleCheckpoint($ipAddress);

        $checkpoints = [];

        foreach ($activeCheckpoints as $checkpoint) {
            if ( ! isset($$checkpoint)) {
                throw new InvalidArgumentException("Invalid checkpoint [{$checkpoint}] given.");
            }

            $checkpoints[$checkpoint] = $$checkpoint;
        }

        return $checkpoints;
    }

    /**
     * Create a throttling repository.
     *
     * @return IlluminateThrottleRepository
     */
    protected function createThrottling()
    {
        $model = $this->config['throttling']['model'];

        foreach (['global', 'ip', 'user'] as $type) {
            ${"{$type}Interval"} = $this->config['throttling'][$type]['interval'];

            ${"{$type}Thresholds"} = $this->config['throttling'][$type]['thresholds'];
        }

        return new IlluminateThrottleRepository(
            $model, $globalInterval, $globalThresholds, $ipInterval, $ipThresholds, $userInterval, $userThresholds
        );
    }

    /**
     * Returns the event dispatcher.
     *
     * @return Dispatcher
     */
    protected function getEventDispatcher()
    {
        if ( ! $this->dispatcher) {
            $this->dispatcher = new Dispatcher;
        }

        return $this->dispatcher;
    }

    /**
     * Create a reminder repository.
     *
     * @param  IlluminateUserRepository  $users
     * @return \ReminderRepository
     */
    protected function createReminders(IlluminateUserRepository $users)
    {
        require_once FCPATH.'application/modules/users/repositories/ReminderRepository.php';
        $model = $this->config['reminders']['model'];

        $expires = 120;// $this->config['reminders']['expires'];

        return new ReminderRepository($users, $model, $expires);
    }

}
