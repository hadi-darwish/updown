<?php

namespace App\Http\Controllers;

use App\Models\Travel;
use App\Models\User;
use App\Models\Visit;
use Illuminate\Http\Request;
use  Illuminate\Database\Eloquent;
use Auth;
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
        //ask charbel
        $user_id = Auth::user()->id;
        $travel = new Travel();
        $travel->user_id = $user_id;
        $travel->apartment_id = $request->apartment_id;
        $travel->save();
    }

    public function getTravels($id)
    {
        //ask charbel
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
        //ask charbel
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
            $visit->save();
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Visit not created',
            ], 404);
        }
    }


    public function updateVisit(Request $request)
    {
        try {
            $visit = Visit::where(
                'user_id',
                $request->host_id
            );
        } catch (Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Visit not found',
            ], 404);
        }
        $visit->update($request->all());
        return response()->json([
            'status' => 'success',
            'visit' => $visit,
        ]);
    }
}
