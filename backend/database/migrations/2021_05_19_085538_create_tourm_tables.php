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
            $table->string('image_url');
            $table->string('title');
            $table->integer('n_visitors');
            $table->boolean('open_to_public');
            $table->boolean('highlighted');

            $table->string('beacon_id');
            $table->timestamps();

            $table->foreign('beacon_id')->references('uuid')->on('beacons')->onDelete('cascade');
        });

        Schema::create('audioguides', function (Blueprint $table) {
            $table->increments('id');
            $table->string('title');
            $table->unsignedInteger('room_id');

            $table->string('path');


            $table->foreign('room_id')->references('id')->on('rooms')->onDelete('cascade');
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
            $table->string('title');
            $table->string('subtitle');
            $table->string('image_url');
            $table->longText('body');
            $table->boolean('highlighted');
            $table->unsignedInteger('employee_id');
            $table->foreign('employee_id')->references('id')->on('employees')->onDelete('cascade');
            $table->timestamps();
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
            $table->string('uuid')->primary();
            $table->boolean('paid');
            $table->boolean('active');
            $table->unsignedInteger('ticket_type_id');

            $table->timestamps();

            $table->foreign('ticket_type_id')->references('id')->on('ticket_types')->onDelete('cascade');
        });

        Schema::create('users', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->string('email')->unique();
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->rememberToken();
            $table->timestamps();
        });

        Schema::table('users', function ($table) {
            $table->string('api_token', 80)->after('password')
                ->unique()
                ->nullable()
                ->default(null);
        });

        Schema::create('password_resets', function (Blueprint $table) {
            $table->string('email')->index();
            $table->string('token');
            $table->timestamp('created_at')->nullable();
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
        Schema::dropIfExists('audioguides');

        Schema::dropIfExists('rooms');
        Schema::dropIfExists('beacons');
        Schema::dropIfExists('tickets');
        Schema::dropIfExists('ticket_types');
        Schema::dropIfExists('languages');
        Schema::dropIfExists('employees');

        // laravel auth
        Schema::dropIfExists('users');
        Schema::dropIfExists('password_resets');


    }
}
