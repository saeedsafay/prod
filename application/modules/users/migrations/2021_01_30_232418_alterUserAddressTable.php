<?php

use Illuminate\Database\Capsule\Manager;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class AlterUserAddressTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        return true;
        Manager::schema()->table('users_address', function (Blueprint $table) {
            $table->text('extra_desc');
            $table->renameColumn('full_address', 'delivery_address');
            $table->string('mobile', 15);
            $table->softDeletes();
        });
        Manager::schema()->table('product_carts', function (Blueprint $table) {
            $table->dropColumn('delivery_address');
            $table->integer('delivery_address_id', false, true)->nullable()->index();
            $table->foreign('delivery_address_id')
                ->on('users_address')
                ->references('id')
                ->onDelete('set null')
                ->onUpdate('set null');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
