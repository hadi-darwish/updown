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

    public function getApartment($id)
    {
        $apartment = Apartment::find($id);
        if (!$apartment) {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartment not found',
            ], 404);
        }
        return response()->json([
            'status' => 'success',
            'apartment' => $apartment,
        ]);
    }

    public function getAllApartments()
    {
        try {
            $apartments = Apartment::all();
            return response()->json([
                'status' => 'success',
                'apartments' => $apartments,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartments not found',
            ], 404);
        }
    }

    public function deleteApartment($id)
    {
        $apartment = Apartment::find($id);
        if (!$apartment) {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartment not found',
            ], 404);
        }
        try {
            $apartment->delete();
            return response()->json([
                'status' => 'success',
                'message' => 'Apartment deleted',
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartment not deleted',
            ], 404);
        }
    }

    public function updateApartment(Request $request, $id)
    {
        $apartment = Apartment::find($id);
        if (!$apartment) {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartment not found',
            ], 404);
        }
        $apartment->fill($request->all());
        if ($apartment->save()) {
            return response()->json([
                'status' => 'success',
                'apartment' => $apartment,
            ]);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartment not updated',
            ], 404);
        }
    }

    public function triggerBanApartment($id)
    {
        $apartment = Apartment::find($id);
        if (!$apartment) {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartment not found',
            ], 404);
        }
        $apartment->is_banned = !$apartment->is_banned;
        if ($apartment->save()) {
            return response()->json([
                'status' => 'success',
                'apartment' => $apartment,
            ]);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartment not updated',
            ], 404);
        }
    }

    public function triggerPaidApartment($id)
    {
        $apartment = Apartment::find($id);
        if (!$apartment) {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartment not found',
            ], 404);
        }
        $apartment->is_paid = !$apartment->is_paid;
        if ($apartment->save()) {
            return response()->json([
                'status' => 'success',
                'apartment' => $apartment,
            ]);
        } else {
            return response()->json([
                'status' => 'error',
                'message' => 'Apartment not updated',
            ], 404);
        }
    }
}
