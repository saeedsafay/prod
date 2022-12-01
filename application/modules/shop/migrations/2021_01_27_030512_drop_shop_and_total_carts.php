<?php

use Illuminate\Database\Capsule\Manager as Capsule;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class DropShopAndTotalCarts extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Capsule::schema()->table('product_carts', function (Blueprint $table) {
            $table->dropColumn(['shop_id', 'total', 'product_type']);
            $table->dropIndex('shop_id');
            $table->index('status');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Capsule::schema()->table('product_carts', function (Blueprint $table) {
            $table->integer('shop_id');
            $table->integer('total');
            $table->index('shop_id');
            $table->dropIndex('status');
        });
    }
}
