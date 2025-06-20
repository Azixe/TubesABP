import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:forumapp/constants/constants.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:forumapp/models/comment_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostController extends GetxController {
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<CommentModel>> comments = Rx<List<CommentModel>>([]);
  final isLoading = false.obs;
  final box = GetStorage();
  var totalLikes = 0.obs;

  @override
  void onInit() {
    getAllPosts();
    super.onInit();
  }

  Future getAllPosts() async {
    try {
      posts.value.clear();
      isLoading.value = true;
      var response = await http.get(Uri.parse('${url}feeds'), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      });
      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['feeds'];
        for (var item in content) {
          posts.value.add(PostModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }

  Future createPost({
    required String content,
  }) async {
    try {
      var data = {
        'content': content,
      };

      var response = await http.post(
        Uri.parse('${url}feed/store'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        print(json.decode(response.body));
      } else {
        Get.snackbar(
          'Error',
          json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getComments(id) async {
    try {
      comments.value.clear();
      isLoading.value = true;

      var response = await http.get(
        Uri.parse('${url}feed/comments/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body)['comments'];
        for (var item in content) {
          comments.value.add(CommentModel.fromJson(item));
        }
      } else {
        isLoading.value = false;
        print(json.decode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future createComment(id, body) async {
    try {
      isLoading.value = true;
      var data = {
        'body': body,
      };

      var request = await http.post(
        Uri.parse('${url}feed/comment/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
        body: data,
      );

      if (request.statusCode == 201) {
        isLoading.value = false;
        print(json.decode(request.body));
      } else {
        isLoading.value = false;
        print(json.decode(request.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future likeAndDislike(id) async {
    try {
      isLoading.value = true;
      var request = await http.post(
        Uri.parse('${url}feed/like/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );
      if (request.statusCode == 200 ||
          json.decode(request.body)['message'] == 'liked') {
        isLoading.value = false;
        print(json.decode(request.body));
      } else if (request.statusCode == 200 ||
          json.decode(request.body)['message'] == 'Unliked') {
        isLoading.value = false;
        print(json.decode(request.body));
      } else {
        isLoading.value = false;
        print(json.decode(request.body));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int?> getTotalLikes(int feed_id) async {
  try {
    isLoading.value = true;
    var response = await http.get(
      Uri.parse('${url}feed/totallikes/$feed_id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      final totalLikes = json.decode(response.body)['total_likes'];
      return totalLikes;
    } else {
      print('Error: ${json.decode(response.body)}');
      return null;
    }
  } catch (e) {
    isLoading.value = false;
    print('Exception: $e');
    return null;
  }
}

Future<int?> getTotalComment(int feed_id) async {
  try {
    isLoading.value = true;
    var response = await http.get(
      Uri.parse('${url}feed/totalcomment/$feed_id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${box.read('token')}',
      },
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      final totalLikes = json.decode(response.body)['total_comment'];
      return totalLikes;
    } else {
      print('Error: ${json.decode(response.body)}');
      return null;
    }
  } catch (e) {
    isLoading.value = false;
    print('Exception: $e');
    return null;
  }
}

Future<bool> deletePost(int postId) async {
    try {
      isLoading.value = true;
      
      var response = await http.delete(
        Uri.parse('${url}feed/$postId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${box.read('token')}',
        },
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Post deleted successfully',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        // Refresh posts list
        await getAllPosts();
        return true;
      } else if (response.statusCode == 403) {
        Get.snackbar(
          'Error',
          'You can only delete your own posts',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      } else if (response.statusCode == 404) {
        Get.snackbar(
          'Error',
          'Post not found',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      } else {
        final errorData = json.decode(response.body);
        Get.snackbar(
          'Error',
          errorData['message'] ?? 'Failed to delete post',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Network error occurred',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Delete post error: $e');
      return false;
    }
  }
}