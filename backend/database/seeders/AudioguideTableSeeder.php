<?php

namespace Database\Seeders;

use App\Models\Audioguide;
use Illuminate\Database\Seeder;

class AudioguideTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Audioguide::factory()
            ->count(10)
            ->create();
    }
}
