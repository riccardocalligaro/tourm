<?php


namespace Database\Factories;

use App\Models\Audioguide;
use App\Models\Room;
use Illuminate\Database\Eloquent\Factories\Factory;


class AudioguideFactory extends Factory
{


    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Audioguide::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition(): array
    {
        return [
            'title' => $this->faker->word,
            'room_id' => Room::inRandomOrder()->first()->id,
            'path' => 'audioguides/sample.mp3'
        ];
    }
}
