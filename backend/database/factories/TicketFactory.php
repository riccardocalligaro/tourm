<?php


namespace Database\Factories;


use App\Models\Ticket;
use App\Models\TicketType;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

class TicketFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Ticket::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition(): array
    {
        return [
            'uuid' => Str::uuid(),
            'paid' => $this->faker->boolean,
            'active' => $this->faker->boolean,
            'ticket_type_id' => TicketType::inRandomOrder()->first()->id,
            'created_at' => $this->faker->dateTimeThisMonth(),
            'updated_at' => $this->faker->dateTimeThisMonth()
        ];
    }
}
