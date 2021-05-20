<?php

namespace Database\Seeders;

use App\Models\Article;
use App\Models\RoomArticles;
use Illuminate\Database\Seeder;

class ArticlesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Article::factory()
            ->count(40)
            ->create();

        RoomArticles::factory()
            ->count(70)
            ->create();
    }
}
