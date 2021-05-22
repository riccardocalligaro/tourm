<?php

namespace App\Http\Controllers;


use App\Models\Audioguide;
use Illuminate\Support\Facades\DB;

class AudioguidesController extends Controller
{

    public function index()
    {
        return response()->json(Audioguide::all());
    }

    public function audioguidesByRoom($id)
    {
        return response()->json(DB::select('select * from audioguides where room_id = ?', [$id]));
    }

    public function audioguidesByBeacon($beacon_code)
    {
        return response()->json(DB::select('select * from audioguides inner join rooms on audioguides.room_id = rooms.id where beacon_id=?', [$beacon_code]));
    }


}
