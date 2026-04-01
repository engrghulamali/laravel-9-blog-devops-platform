<?php

namespace Database\Seeders;
use App\Models\Post;
use App\Models\HighlightPost;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class HighlightPostSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        if (Post::count() == 0) {
            Post::factory(10)->create();
        }
        $postsId = Post::inRandomOrder()->take(3)->get();

        foreach ($postsId as $postId) {
            HighlightPost::create([
                'post_id' => $postId->id,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
