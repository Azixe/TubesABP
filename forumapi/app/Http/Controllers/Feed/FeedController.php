<?php

namespace App\Http\Controllers\Feed;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Requests\PostRequest;
use App\Models\Feed;
use App\Models\Like;
use App\Models\Comment;
use Illuminate\Support\Facades\Auth;

class FeedController extends Controller
{
    public function index(){
        $feeds = Feed::with('user')->latest()->get();

        $feeds->transform(function ($feed) {
        $feed->total_likes = $feed->likes()->count(); // tambahkan total_likes
        $feed->total_comment = $feed->comments()->count();
        return $feed;
        });

        return response([
            'feeds' => $feeds
        ], 200);
    }
    public function store(PostRequest $request){
        $request->validated();

        auth()->user()->feeds()->create([
            'content' => $request->content
        ]);

        return response([
            'message' => 'succes',
        ], 201);
    }

    public function likePost($feed_id){
        //memilih post dengan feed_id
        $feed = Feed::whereId($feed_id)->first();

        if(!$feed){
            return response([
                'message' => '404 not found'
            ], 500);
        }

        // Unlike post
        $unlike_post = Like::where('user_id', auth()->id())->where('feed_id', $feed_id)->delete();
        if ($unlike_post) {
            return response([
                'message' => 'Unliked'
            ], 200);
        }

        // Like post
        $like_post = Like::create([
            'user_id' => auth()->id(),
            'feed_id' => $feed_id
        ]);
        if ($like_post) {
            return response([
                'message' => 'liked'
            ], 200);
        }
    }

    public function comment(Request $request, $feed_id){
        $request->validate([
            'body' => 'required'
        ]);

        $comment = Comment::create([
            'user_id' => auth()->id(),
            'feed_id' => $feed_id,
            'body' => $request->body
        ]);

        return response([
            'message' => 'success'
        ], 201);
    }

    public function getComments($feed_id){
        $comments = Comment::with('feed')->with('user')->whereFeedId($feed_id)->latest()->get();

        return response([
            'comments' => $comments
        ], 200);
    }

    public function totalLikes($feed_id){
    $total_likes = Like::where('feed_id', $feed_id)->count();

    return response([
            'total_likes' => $total_likes
        ], 201);
    }

    public function totalComment($feed_id){
    $total_comment = Comment::where('feed_id', $feed_id)->count();

    return response([
            'total_comment' => $total_comment
        ], 201);
    }

    public function getUserPost(Request $request) {
        $user = Auth::user();

        $posts = Feed::where('user_id', $user->id)->latest()->get();

        return response()->json([
            'posts' => $posts
        ]);
    }

    public function deletePost($feed_id) {
        $feed = Feed::find($feed_id);
        $likes = Like::where('feed_id', $feed_id);
        if (!$feed) {
            return response([
                'message' => 'Post not found'
            ], 404);
        }
        
        // Check if the user owns this post
        if ($feed->user_id !== auth()->id()) {
            return response([
                'message' => 'Unauthorized. You can only delete your own posts.'
            ], 403);
        }
        
        if ($likes) {
            $likes->delete();
        }
        // Delete the post
        $feed->delete();
        
        return response([
            'message' => 'Post deleted successfully'
        ], 200);
    }
}
