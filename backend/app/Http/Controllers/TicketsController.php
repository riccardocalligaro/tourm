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
        $ticket_valid = Ticket::where(['paid' => true, 'uuid' => $code, 'active' => true])->get()->count() == 1;
        return response()->json(array('valid' => $ticket_valid));
    }

}
