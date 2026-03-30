<?php

namespace Database\Factories;

use Faker\Factory as FakerFactory;
use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Post>
 */
class PostFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        $faker = FakerFactory::create('en_US');

        $title = $faker->realText(50);
        $title = preg_replace('/[\r\n]+/', ' ', $title);
        $title = trim(preg_replace('/[.?!]$/', '', $title));
        if (strlen($title) > 70) {
            $title = trim(substr($title, 0, 70));
            $title = preg_replace('/[.?!]$/', '', $title);
        }

        $bodyText = $faker->realText(2200);
        $bodyText = preg_replace('/[\r\n]+/', ' ', $bodyText);
        $bodyText = trim($bodyText);
        $paragraphs = explode('\n\n', wordwrap($bodyText, 700, '\n\n', true));
        $body = '<p>'.implode('</p><p>', array_map('trim', $paragraphs)).'</p>';

        $plainBody = strip_tags($body);
        $readingSpeed = 200;
        $words = str_word_count($plainBody);
        $readingTime = ceil($words / $readingSpeed);

        $excerpt = trim($faker->realText(170));
        $excerpt = preg_replace('/[\r\n]+/', ' ', $excerpt);
        $excerpt = rtrim($excerpt, ' ,;:.!?').'.';

        return [
            'title' => $title,
            'excerpt' => $excerpt,
            'body' => $body,
            'image_path' => $faker->randomElement(['/images/posts/picture2.jpg', '/images/posts/picture.jpg']),
            'slug' => Str::slug($title),
            'is_published' => true,
            'user_id' => 1,
            'category_id' => $faker->numberBetween(1, 15),
            'read_time' => $readingTime,
            'change_user_id' => 1,
        ];
    }
}
