<?php

use Illuminate\Database\Capsule\Manager as Capsule;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CouponAddMaxAmountField extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Capsule::schema()->table('product_coupons', function (Blueprint $table) {
            $table->bigInteger('max_purchase_amount');
            $table->tinyInteger('validity_type');
            $table->string('validity_from', 16);
            $table->string('validity_to', 16);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Capsule::schema()->table('product_coupons', function (Blueprint $table) {
            $table->dropColumn('max_purchase_amount');
        });
    }
}
