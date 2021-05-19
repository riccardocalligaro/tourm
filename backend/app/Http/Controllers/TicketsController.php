<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use App\Models\TicketType;

class TicketsController extends Controller
{

    public function tickets()
    {
        return response()->json(Ticket::all());
    }

    public function ticket_types()
    {
        return response()->json(TicketType::all());
    }

}
