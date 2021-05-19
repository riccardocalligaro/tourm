<?php

namespace App\Http\Controllers;

use App\Models\Ticket\Room;

class RoomsController extends Controller
{

    public function index()
    {
        return response()->json(Room::all());
    }
}
