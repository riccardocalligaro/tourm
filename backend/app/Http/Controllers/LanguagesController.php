<?php

namespace App\Http\Controllers;

use App\Models\Ticket\Language;

class LanguagesController extends Controller
{

    public function index()
    {

        return response()->json(Language::all());
    }
}
