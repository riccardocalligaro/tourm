<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class LanguagesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        DB::table('languages')->insert([
            [
                'name' => 'Italiano',
                'language_code' => 'it',
                'country_code' => 'IT',
            ],
            [
                'name' => 'English',
                'language_code' => 'en',
                'country_code' => 'US',
            ]
        ]);
    }
}
