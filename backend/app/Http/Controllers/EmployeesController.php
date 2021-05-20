<?php

namespace App\Http\Controllers;

use App\Models\Employee;

class EmployeesController extends Controller
{

    public function index()
    {
        return response()->json(Employee::all());
    }

}
