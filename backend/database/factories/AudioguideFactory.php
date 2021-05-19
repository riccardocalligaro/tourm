<?php


namespace Database\Factories;

use App\Models\Audioguide;
use App\Models\Beacon;
use App\Models\Language;
use App\Models\Room;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;

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
            'language_id' => Language::inRandomOrder()->first()->id,
            'room_id' => Room::inRandomOrder()->first()->id,
            'path' => asset('audioguides/sample.mp3')
        ];
    }
}
