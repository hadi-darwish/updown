<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;


return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('buildings', function (Blueprint $table) {

            $table->id();
            $table->string('name');
            $table->string('address');
            $table->integer('number_of_floors');
            $table->integer('number_of_apartments');
            $table->boolean('is_paid')->default(0);
            $table->boolean('is_banned')->default(0);
            $table->foreignId('owner_id')->constrained('users')->onDelete('cascade');
            $table->timestamps('created_at')->useCurrent();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('buildings');
    }
};
