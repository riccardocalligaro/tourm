<?php

namespace App\Http\Controllers;

use App\Models\Room;

class RoomsController extends Controller
{

    public function index()
    {
        return response()->json(Room::all());
    }
}
