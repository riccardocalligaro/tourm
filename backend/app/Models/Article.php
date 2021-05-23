<?php


namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    use HasFactory;

    protected $table = 'articles';

    protected $casts = [
        'highlighted' => 'boolean'
    ];
}

class RoomArticles extends Model
{
    use HasFactory;

    protected $table = 'room_articles';

}
