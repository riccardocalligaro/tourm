<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $this->call(BeaconsTableSeeder::class);
        $this->call(RoomsTableSeeder::class);
        $this->call(LanguagesTableSeeder::class);
        $this->call(AudioguideTableSeeder::class);

    }
}
