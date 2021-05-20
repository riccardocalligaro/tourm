<?php


namespace Database\Factories;


use App\Models\Article;
use App\Models\Room;
use App\Models\RoomArticles;
use Illuminate\Database\Eloquent\Factories\Factory;

class RoomArticlesFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = RoomArticles::class;


    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition(): array
    {
        return [
            'room_id' => Room::inRandomOrder()->first()->id,
            'article_id' => Article::inRandomOrder()->first()->id,
            'created_at' => $this->faker->dateTimeThisMonth(),
            'updated_at' => $this->faker->dateTimeThisMonth()
        ];
    }
}
