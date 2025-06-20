<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthenticationController;
use App\Http\Controllers\Feed\FeedController;
use App\Http\Controllers\Profiles\UsersProfile;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::get('/feeds', [FeedController::class, 'index'])->middleware('auth:sanctum');
Route::post('/feed/store', [FeedController::class, 'store'])->middleware('auth:sanctum');
Route::delete('/feed/{feed_id}', [FeedController::class, 'deletePost'])->middleware('auth:sanctum');
Route::post('/feed/like/{feed_id}', [FeedController::class, 'likePost'])->middleware('auth:sanctum');
Route::post('/feed/comment/{feed_id}', [FeedController::class, 'comment'])->middleware('auth:sanctum');
Route::get('/feed/comments/{feed_id}', [FeedController::class, 'getComments'])->middleware('auth:sanctum');
Route::get('/feed/totalcomment/{feed_id}', [FeedController::class, 'totalComment'])->middleware('auth:sanctum');
Route::get('/feed/totallikes/{feed_id}', [FeedController::class, 'totalLikes'])->middleware('auth:sanctum');
Route::get('/profiles', [UsersProfile::class, 'Profile'])->middleware('auth:sanctum');
Route::get('/profile/user', [FeedController::class, 'getUserPost'])->middleware('auth:sanctum');

Route::get('/test',function(){
    return response([
        'message' => 'Api is working'
    ], 200);
});

Route::post('register', [AuthenticationController::class, 'register']);
Route::post('login', [AuthenticationController::class, 'login']);