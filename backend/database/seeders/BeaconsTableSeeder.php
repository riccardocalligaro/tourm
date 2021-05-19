<?php

namespace Database\Seeders;

use App\Models\Beacon;
use Illuminate\Database\Seeder;

class BeaconsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Beacon::factory()
            ->count(20)
            ->create();
    }
}
