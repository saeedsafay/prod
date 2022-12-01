<?php

use Illuminate\Database\Capsule\Manager;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class CreateNewsletterTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Manager::schema()->create('newsletter', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('email', 256)->nullable(false)->index();
            $table->string('token', 64)->unique();
            $table->boolean('status')->default(0);
            $table->integer('user_id', false, true)->nullable()->index();
            $table->timestamps();
            $table->foreign('user_id')
                ->on('users')
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
        Manager::schema()->dropIfExists('newsletter');
    }
}
