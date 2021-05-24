<?php


namespace Database\Factories;


use App\Models\Article;
use App\Models\Employee;
use Illuminate\Database\Eloquent\Factories\Factory;

class ArticleFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Article::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition(): array
    {
        return [
            'title' => $this->faker->word,
            'subtitle' => $this->faker->realTextBetween(5, 25),
            'image_url' => 'images/villa_immagine.jpeg',
            'body' => $this->faker->text,
            'highlighted' => $this->faker->boolean(20),
            'employee_id' => Employee::inRandomOrder()->first()->id,
            'created_at' => $this->faker->dateTimeThisMonth(),
            'updated_at' => $this->faker->dateTimeThisMonth()
        ];
    }
}
