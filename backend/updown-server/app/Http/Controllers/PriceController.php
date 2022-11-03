<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

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
}
