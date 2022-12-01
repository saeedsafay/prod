<?php

use Illuminate\Database\Capsule\Manager as Capsule;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateRedeemedCoupons extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Capsule::schema()->create('product_coupons_redeemed', function (Blueprint $table) {
            $table->bigIncrements('id')->unsigned();
            $table->boolean('status')->default(0);
            $table->integer('user_id', false, true)->nullable()->index();
            $table->integer('cart_id', false, true)->nullable()->index();
            $table->integer('product_coupon_id', false, true)->nullable(false)->index();
            $table->timestamps();
            $table->foreign('cart_id')
                ->on('product_carts')
                ->references('id')
                ->onDelete('set null')
                ->onUpdate('set null');
            $table->foreign('user_id')
                ->on('users')
                ->references('id')
                ->onDelete('set null')
                ->onUpdate('set null');
            $table->foreign('product_coupon_id')
                ->on('product_coupons')
                ->references('id')
                ->onDelete('cascade')
                ->onUpdate('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Capsule::schema()->dropIfExists('product_coupons_redeemed');
    }
}
