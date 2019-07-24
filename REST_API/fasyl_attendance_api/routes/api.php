<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/


Route::post('user_login', 'AuthController@user_login');
Route::post('user_register', 'AuthController@user_register');
Route::post('manager_login', 'AuthController@manager_login');
Route::post('manager_register', 'AuthController@manager_register');

Route::middleware('auth:api')->group(function () {
    Route::get('user', 'AuthController@details');
    Route::get('getManagerUsers', 'AuthController@getManagerUser');
    Route::get('logout', 'AuthController@logout');

    Route::apiResource('tasks', 'TaskController');
});
