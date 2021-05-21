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

    public function ticketTypes()
    {
        return response()->json(TicketType::all());
    }

    public function checkTicket($code)
    {
        return response()->json(TicketType::where());
    }

}
