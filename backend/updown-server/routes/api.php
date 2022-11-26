<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ApartmentController;
use App\Http\Controllers\PriceController;
use App\Http\Controllers\BuildingController;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;


Route::post('register', [AuthController::class, 'register']);
Route::post('login', [AuthController::class, 'login']);
Route::post('guest', [UserController::class, 'enterGuest']);
Route::post('rm', [UserController::class, 'getUserBuilding']);
Route::post('building_user', [UserController::class, 'getUserResideIn']);
Route::post('travel', [UserController::class, 'createTravel']);

Route::group(['middleware' => 'auth:api'], function () {
    Route::get('user', [AuthController::class, 'user']);
    Route::post('logout', [AuthController::class, 'logout']);
    Route::get('users', [UserController::class, 'getAllUsers']);
    Route::get('user/{id}', [UserController::class, 'getUser']);
    Route::delete('user', [UserController::class, 'deleteUser']);
    Route::put('user/{id}', [UserController::class, 'updateUser']);
    Route::get('apartments', [ApartmentController::class, 'getAllApartments']);
    Route::get('apartment/{id}', [ApartmentController::class, 'getApartment']);
    Route::delete('apartment/{id}', [ApartmentController::class, 'deleteApartment']);
    Route::put('apartment/{id}', [ApartmentController::class, 'updateApartment']);
});
