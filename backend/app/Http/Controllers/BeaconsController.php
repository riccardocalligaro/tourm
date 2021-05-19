<?php

namespace App\Http\Controllers;

use App\Models\Beacon;

class BeaconsController extends Controller
{

    public function index()
    {
        return response()->json(Beacon::all());
    }
}
