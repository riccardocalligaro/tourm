<?php


namespace Database\Factories;

use App\Models\Beacon;
use App\Models\Room;
use Illuminate\Database\Eloquent\Factories\Factory;

class RoomFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Room::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition(): array
    {
        return [
            'title' => $this->faker->word,
            'n_visitors' => $this->faker->numberBetween(0, 30),
            'open_to_public' => $this->faker->boolean(),
            'beacon_id' => Beacon::inRandomOrder()->first()->uuid,
            'created_at' => $this->faker->dateTimeThisMonth(),
            'updated_at' => $this->faker->dateTimeThisMonth(),
            'image_url' => 'images/villa_immagine.jpeg',
            'highlighted' => $this->faker->boolean(20)
        ];
    }
}
