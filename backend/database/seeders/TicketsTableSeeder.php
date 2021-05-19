<?php

namespace Database\Seeders;

use App\Models\Ticket;
use App\Models\TicketType;
use Illuminate\Database\Seeder;

class TicketsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        TicketType::factory()
            ->count(3)
            ->create();

        Ticket::factory()
            ->count(50)
            ->create();
    }
}
