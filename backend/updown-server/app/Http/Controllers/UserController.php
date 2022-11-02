<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use  Illuminate\Database\Eloquent;

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
}
