<?php

namespace App\Http\Controllers;

use App\Models\Ticket\Audioguide;
use Illuminate\Support\Facades\DB;

class AudioguidesController extends Controller
{

    public function index()
    {
        return response()->json(Audioguide::all());
    }

    public function audioguidesByRoom($language_code, $id)
    {
        return response()->json(DB::select('select audioguides.id, title, path
        from languages
        inner join audioguides on audioguides.language_id = languages.id
        where languages.language_code = ? and room_id = ?', [$language_code, $id]));
    }

}
