<?php

namespace App\Http\Controllers;

use App\Models\Apartment;
use App\Models\Building;
use App\Models\Price;
use App\Models\ResidesIn;
use App\Models\Visit;
use Illuminate\Http\Request;
use  Illuminate\Database\Eloquent;
use Auth;

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

    public function getAllBuildings()
    {
        try {
            $buildings = Building::all();
            return response()->json([
                'status' => 'success',
                'buildings' => $buildings,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Buildings not found',
            ], 404);
        }
    }

    public function deleteBuilding($id)
    {
        $building = Building::find($id);
        if (!$building) {
            return response()->json([
                'status' => 'error',
                'message' => 'Building not found',
            ], 404);
        }
        try {
            $building->delete();
            return response()->json([
                'status' => 'success',
                'message' => 'Building deleted',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Building not deleted',
            ], 404);
        }
    }

    public function updateBuilding(Request $request, $id)
    {
        $building = Building::find($id);
        if (!$building) {
            return response()->json([
                'status' => 'error',
                'message' => 'Building not found',
            ], 404);
        }
        try {
            $building->update($request->all());
            return response()->json([
                'status' => 'success',
                'building' => $building,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 404);
        }
    }

    public function triggerBanBuilding($id)
    {
        $building = Building::find($id);
        if (!$building) {
            return response()->json([
                'status' => 'error',
                'message' => 'Building not found',
            ], 404);
        }
        try {
            $building->update(['is_banned' => !$building->is_banned]);
            return response()->json([
                'status' => 'success',
                'building' => $building,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 404);
        }
    }

    public function triggerPaidBuilding($id)
    {
        $building = Building::find($id);
        if (!$building) {
            return response()->json([
                'status' => 'error',
                'message' => 'Building not found',
            ], 404);
        }
        try {
            $building->update(['is_paid' => !$building->is_paid]);
            return response()->json([
                'status' => 'success',
                'building' => $building,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 404);
        }
    }
    public function addPrice(Request $request)
    {
        $building = Building::find($request->building_id);
        if (!$building) {
            return response()->json([
                'status' => 'error',
                'message' => 'Building not found',
            ], 404);
        }
        try {
            $prices = new Price();
            $prices->building_id = $request->building_id;
            $prices->tax = $request->tax;
            $prices->price_per_travel = $request->price_per_travel;
            $prices->start_date = $request->start_date;
            $prices->end_date = $request->end_date;
            $prices->save();

            return response()->json([
                'status' => 'success',
                'building' => $building,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 404);
        }
    }
}
