<?php

namespace App\Http\Controllers;

use App\Models\Apartment;
use App\Models\Building;
use App\Models\ResidesIn;
use App\Models\Travel;
use App\Models\User;
use App\Models\Visit;
use Illuminate\Http\Request;
use  Illuminate\Database\Eloquent;
use Auth;
use Carbon\Carbon;
use Illuminate\Support\Str;

class UserController extends Controller
{

    public function getUser($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found',
            ], 404);
        }

        return response()->json([
            'status' => 'success',
            'user' => $user,
        ]);
    }



    public function getAllUsers()
    {
        $users = User::all();

        return response()->json([
            'status' => 'success',
            'users' => $users,
        ]);
    }

    public function deleteUser($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found',
            ], 404);
        }

        $user->delete();

        return response()->json([
            'status' => 'success',
            'message' => 'User deleted',
        ]);
    }

    public function updateUser(Request $request, $id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found',
            ], 404);
        }

        $user->update($request->all());

        return response()->json([
            'status' => 'success',
            'user' => $user,
        ]);
    }

    public function createUser(Request $request)
    {
        $user = User::create($request->all());

        return response()->json([
            'status' => 'success',
            'user' => $user,
        ]);
    }

    public function banUser($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found',
            ], 404);
        }

        $user->update([
            'is_banned' => 1,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'User banned',
        ]);
    }

    public function triggerBanUser($id)

    {
        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found',
            ], 404);
        }

        $user->update([
            'is_banned' => !$user->is_banned,
        ]);

        return response()->json([
            'status' => 'success',
            'message' => 'User banned',
        ]);
    }

    public function createTravel(Request $request)
    {

        $user_id = Auth::user()->id;
        $travel = new Travel();
        $travel->user_id = $user_id;
        $travel->apartment_id = $request->apartment_id;
        $travel->save();
    }

    public function getTravels($id)
    {

        $user = User::find($id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found',
            ], 404);
        }

        $travels = $user->travels();

        return response()->json([
            'status' => 'success',
            'travels' => $travels,
        ]);
    }

    public function getTravelsByApartment(Request $request)
    {

        $user = User::find($request->user_id);

        if (!$user) {
            return response()->json([
                'status' => 'error',
                'message' => 'User not found',
            ], 404);
        }

        $travels = $user->travels()->where('apartment_id', $request->apartment_id);

        return response()->json([
            'status' => 'success',
            'travels' => $travels,
        ]);
    }

    public function createVisit()
    {
        try {
            $userId = Auth::user()->id;
            $visit = new Visit();
            $visit->user_id = $userId;
            $visit->code = Str::random(7);
            $visit->expiry_date = Carbon::now()->addDays(1);
            $visit->save();
            return response()->json([
                'status' => 'success',
                'visit' => $visit,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Visit not created',
            ], 404);
        }
    }


    public function enterGuest(Request $request)
    {
        try {
            $user = User::find($request->host_id);
            $visits = $user->visits()
                ->where('code', $request->code)
                ->where('expiry_date', '>', Carbon::now())
                ->get();
            if (count($visits) <= 0) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Visit not found',
                ], 404);
            }
            try {

                $visit = $visits[0];
                $visit = Visit::find($visit->id);
                if (Auth::user()) {
                    $visit->visitor_email =
                        Auth::user()->email;
                } else {
                    $visit->visitor_email = $request->visitor_email;
                }

                $visit->save();
            } catch (Exception $e) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Visit not updated',
                ], 404);
            }
            return response()->json([
                'status' => 'success',
                'visit' => $visit,
            ]);
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Visit not found',
            ], 404);
        }
    }


    public function getUserBuilding(Request $request)
    {
        $apartments = Apartment::where('owner_id', $request->user_id)
            ->get();
        $building = $apartments[0]->building()->get();
        return response()->json([
            'status' => 'success',
            'building' => $building,
        ]);
    }

    public function getUserResideIn(Request $request)
    {
        $resides = ResidesIn::where('user_id', $request->user_id)
            ->get()[0];

        $building = Apartment::where('id', $resides->apartment_id)->first()->building()->first();
        return response()->json([
            'status' => 'success',
            'resides' => $building,
        ]);
    }
}
