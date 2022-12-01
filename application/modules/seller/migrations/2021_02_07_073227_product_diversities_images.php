<?php

use Illuminate\Database\Capsule\Manager;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;

class ProductDiversitiesImages extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Manager::schema()->table("product_diversity_data", function (Blueprint $table) {
            $table->integer('product_image_id')->nullable()->index();
            $table->foreign('product_image_id')
                ->on('product_images')
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
        Manager::schema()->table("product_diversity_data", function (Blueprint $table) {
            $table->dropColumn('product_image_id');
            $table->dropForeign('product_image_id');
        });
    }
}
