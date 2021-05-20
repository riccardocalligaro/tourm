<?php

namespace App\Http\Controllers;

use App\Models\Article;
use App\Models\Ticket\Audioguide;
use Illuminate\Support\Facades\DB;

class ArticlesController extends Controller
{

    public function index()
    {
        return response()->json(Article::all());
    }


    public function roomArticles($room_id)
    {
        return response()->json(DB::select('select
        employees.name, employees.surname,
        articles.id, articles.title, articles.body
        from articles
        inner join room_articles on room_articles.room_id = ?
        inner join employees on articles.employee_id = employees.id', [$room_id]));
    }


}
