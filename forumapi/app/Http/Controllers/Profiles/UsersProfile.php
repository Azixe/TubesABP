<?php

namespace App\Http\Controllers\Profiles;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\PostRequest;
use App\Models\Feed;
use App\Models\Like;
use App\Models\Comment;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class UsersProfile extends Controller
{
    public function Profile(){
        $user = Auth::user();

        $totalPosts = $user->feeds()->count();
        $totalComment = $user->comments()->count();

        return response()->json([
            'profile' => [
                'id' => $user->id,
                'username' => $user->username,
                'email' => $user->email,
                'created_at' => $user->created_at->format('Y-m-d'),
                'total_posts' => $totalPosts,
                'total_comment' => $totalComment,
            ]
        ], 200);
    }
}
