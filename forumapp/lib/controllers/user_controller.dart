import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forumapp/constants/constants.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:forumapp/models/comment_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  // Current user data (this would normally come from authentication)
  final RxBool isLoading = false.obs;
  final box = GetStorage();
  final RxMap<String, dynamic> profile = <String, dynamic>{}.obs;
  final RxList<PostModel> userPosts = <PostModel>[].obs;
  
  // User statistics
  final RxInt userPostsCount = 0.obs;
  final RxInt userCommentsCount = 0.obs;
  final RxInt savedPostsCount = 0.obs;
  
  // User posts and saved posts
  final RxList<PostModel> savedPosts = <PostModel>[].obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future<void> getProfile() async {
  isLoading.value = true;
  final response = await http.get(
    Uri.parse('${url}profiles'),
    headers: {
      'Authorization': 'Bearer ${box.read('token')}',
      'Accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    profile.value = data['profile'];
    print("Profile data: ${profile.value}");
  } else {
    print("Gagal mengambil profil: ${response.body}");
  }

  isLoading.value = false;
}


  Future<void> getUserPosts() async {
  final response = await http.get(Uri.parse('${url}profile/user'), 
    headers: {
      'Authorization': 'Bearer ${box.read('token')}',
    });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    userPosts.value = data['posts'];
  } else {
    print('Failed to load user posts: ${response.body}');
  }
}

  String getUserInitials() {
    final username = profile['username'] ?? '';
    if (username.isEmpty) return '?';
    return username[0].toUpperCase();
  }

  // // Get user's stats
  // void updateUserStats(List<PostModel> allPosts) {
  //   if (currentUser.value == null) return;
    
  //   final userId = currentUser.value!.id;
  //   userPostsCount.value = allPosts.where((post) => post.userId == userId).length;
  //   // In a real app, you'd calculate comments count from a comments list
  //   userCommentsCount.value = 0; // Placeholder
  //   savedPostsCount.value = savedPosts.length;
  // }

}
