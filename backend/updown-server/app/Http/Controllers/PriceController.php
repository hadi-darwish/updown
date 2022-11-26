<?php

namespace App\Http\Controllers;

use App\Models\Building;
use App\Models\Price;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;

class PriceController extends Controller
{
    public function createPrice(Request $request)
    {
        $price = Price::create($request->all());
        if ($price->save()) {
            return response()->json([
                'status' => 'success',
                'price' => $price,
            ], 201);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Price not created',
            ], 404);
        }
    }

    public function updatePrice(Request $request)
    {
        $price = Building::find($request->building_id)->prices->last();
        if (!$price) {
            $prices = new Price();
            $prices->building_id = $request->building_id;
            $prices->tax = 0;
            $prices->price_per_travel = 0;
            $prices->start_date = Carbon::now();
            $prices->end_date = Carbon::now()->addMonth();
            if ($prices->save()) {
                $prices->update($request->all());
                return response()->json([
                    'status' => 'success',
                    'price' => $price,
                ]);
            } else {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Price not created',
                ], 404);
            }
        } else {
            $price->update($request->all());
            return response()->json([
                'status' => 'success',
                'price' => $price,
            ]);
        }
    }
}
