<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class BuildingController extends Controller
{

    public function createBuilding(Request $request)
    {
        $building = Building::create($request->all());
        return response()->json($building, 201);
    }
}
