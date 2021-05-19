<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTourmTables extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('beacons', function (Blueprint $table) {
            $table->string('uuid')->primary();
            $table->string('name');
        });

        Schema::create('rooms', function (Blueprint $table) {
            $table->increments('id');
            $table->string('title');
            $table->integer('n_visitors');
            $table->boolean('open_to_public');
            $table->string('beacon_id');
            $table->timestamps();

            $table->foreign('beacon_id')->references('uuid')->on('beacons')->onDelete('cascade');
        });

        Schema::create('languages', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->char('language_code', 2);
            $table->char('country_code', 2);
        });

        Schema::create('audioguides', function (Blueprint $table) {
            $table->increments('id');
            $table->string('title');
            $table->unsignedInteger('language_id');
            $table->string('path');


            $table->foreign('language_id')->references('id')->on('languages')->onDelete('cascade');
        });

        Schema::create('room_audioguides', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('room_id')->index();
            $table->unsignedInteger('audioguide_id')->index();
            $table->timestamps();

            $table->foreign('room_id')->references('id')->on('rooms')->onDelete('cascade');
            $table->foreign('audioguide_id')->references('id')->on('audioguides')->onDelete('cascade');
        });

        // employees
        Schema::create('employees', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->string('surname');
            $table->string('email');
            $table->timestamps();
        });

        Schema::create('articles', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('language_id');
            $table->string('title');
            $table->longText('body');
            $table->unsignedInteger('employee_id');


            $table->foreign('language_id')->references('id')->on('languages')->onDelete('cascade');
            $table->foreign('employee_id')->references('id')->on('employees')->onDelete('cascade');
        });

        Schema::create('room_articles', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('room_id')->index();
            $table->unsignedInteger('article_id')->index();
            $table->timestamps();

            $table->foreign('room_id')->references('id')->on('rooms')->onDelete('cascade');
            $table->foreign('article_id')->references('id')->on('articles')->onDelete('cascade');
        });

        // ticket types
        Schema::create('ticket_types', function (Blueprint $table) {
            $table->increments('id');
            $table->string('title');
            $table->decimal('price');
            $table->integer('duration');

            $table->timestamps();
        });

        // ticket
        Schema::create('tickets', function (Blueprint $table) {
            $table->increments('id');
            $table->boolean('paid');
            $table->boolean('active');
            $table->string('email');
            $table->unsignedInteger('ticket_type_id');

            $table->timestamps();

            $table->foreign('ticket_type_id')->references('id')->on('ticket_types')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('room_audioguides');
        Schema::dropIfExists('room_articles');
        Schema::dropIfExists('articles');
        Schema::dropIfExists('rooms');
        Schema::dropIfExists('beacons');
        Schema::dropIfExists('audioguides');
        Schema::dropIfExists('tickets');
        Schema::dropIfExists('ticket_types');
        Schema::dropIfExists('languages');
        Schema::dropIfExists('employees');
    }
}
