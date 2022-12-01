<?php

use Symfony\Contracts\EventDispatcher\Event;

class NewsletterMemberAdded extends Event
{
    public const NAME = 'newsletter.member.added';

    public $newsletter;

    /**
     * NewsletterMemberAdded constructor.
     * @param $newsletter
     */
    public function __construct($newsletter)
    {
        $this->newsletter = $newsletter;
    }
}