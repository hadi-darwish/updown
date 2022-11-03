<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ApartmentController extends Controller
{

    public function createApartment(Request $request)
    {
        $apartment = Apartment::create($request->all());
        if ($apartment->save()) {
            return response()->json([
                'status' => 'success',
                'apartment' => $apartment,
            ], 201);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartment not created',
            ], 404);
        }
    }
}
