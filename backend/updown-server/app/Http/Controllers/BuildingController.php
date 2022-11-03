<?php

namespace App\Http\Controllers;

use App\Models\Building;
use Illuminate\Http\Request;
use  Illuminate\Database\Eloquent;

class BuildingController extends Controller
{

    public function createBuilding(Request $request)
    {
        $building = Building::create($request->all());
        if (
            $building->save()
        ) {
            return response()->json([
                'status' => 'success',
                'building' => $building,
            ], 201);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Building not created',
            ], 404);
        }
    }

    public function getBuilding($id)
    {

        $building = Building::find($id);
        if (!$building) {
            return response()->json([
                'status' => 'error',
                'message' => 'Building not found',
            ], 404);
        }
        return response()->json([
            'status' => 'success',
            'building' => $building,
        ]);
    }
}
