<?php


use Illuminate\Support\Facades\Date;
use Symfony\Contracts\EventDispatcher\Event;

/**
 * Class AddNewPaymentTransactionListener
 * @date 01-2021
 */
class AddNewPaymentTransactionListener
{

    /**
     * Add a new transaction record for the new payment request
     * @param  \Symfony\Contracts\EventDispatcher\Event  $event
     */
    public function handle(Event $event)
    {
        $doubleSpendingCheck = Transaction::where("trans_id", $event->transId)->first();
        if ($doubleSpendingCheck) {
            redirect("/");
        }
        try {
            Transaction::create([
                'user_id' => $event->userCart->user_id,
                'order_id' => $event->userCart->id,
                'amount' => $event->amount,
                'trans_id' => $event->transId,
                'transaction_state_id' => 0,
                "description" => $event->description,
                "created_at" => Date::now()
            ]);
        } catch (Throwable $e) {
            log_message("error", $e->getMessage());
            show_error($e->getMessage());
        }
    }
}