<?php


use Illuminate\Support\Facades\Date;
use Symfony\Contracts\EventDispatcher\Event;

class UpdateFailedPaymentTransactionListener
{


    public function handle(Event $event)
    {
        log_message("error",
            "Payment verify post data with error status = {$event->status}, trans_id = {$event->transaction->trans_id}, order_id = {$event->transaction->order_id}");
        $event->transaction->update([
            "transaction_state_id" => $event->status,
            "payment_track_id" => $event->trackId,
            "description" => $event->message,
            "updated_at" => Date::now()
        ]);
        return true;
    }
}