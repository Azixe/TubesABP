import 'package:get/get.dart';
import 'package:forumapp/models/post_model.dart';

class UserController extends GetxController {
  // Current user data (this would normally come from authentication)
  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  
  // User statistics
  final RxInt userPostsCount = 0.obs;
  final RxInt userCommentsCount = 0.obs;
  final RxInt savedPostsCount = 0.obs;
  
  // User posts and saved posts
  final RxList<PostModel> userPosts = <PostModel>[].obs;
  final RxList<PostModel> savedPosts = <PostModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Inisialisasi dengan demo user data
    initializeDemoUser();
  }

  void initializeDemoUser() {
    // Ini data demo, dalam aplikasi nyata, ini akan berasal dari sistem autentikasi
    currentUser.value = User(
      id: 1,
      name: 'John Doe',
      username: 'johndoe',
      email: 'john.doe@example.com',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }

  // Get user's posts from all posts
  List<PostModel> getUserPosts(List<PostModel> allPosts) {
    if (currentUser.value == null) return [];
    
    final userId = currentUser.value!.id;
    final filteredPosts = allPosts.where((post) => post.userId == userId).toList();
    userPosts.value = filteredPosts;
    userPostsCount.value = filteredPosts.length;
    return filteredPosts;
  }

  // Get user's stats
  void updateUserStats(List<PostModel> allPosts) {
    if (currentUser.value == null) return;
    
    final userId = currentUser.value!.id;
    userPostsCount.value = allPosts.where((post) => post.userId == userId).length;
    // In a real app, you'd calculate comments count from a comments list
    userCommentsCount.value = 0; // Placeholder
    savedPostsCount.value = savedPosts.length;
  }

  // Save/unsave a post
  void toggleSavePost(PostModel post) {
    final index = savedPosts.indexWhere((savedPost) => savedPost.id == post.id);
    if (index >= 0) {
      // Post is already saved, remove it
      savedPosts.removeAt(index);
      Get.snackbar(
        'Removed from Saved',
        'Post removed from your saved list',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Post is not saved, add it
      savedPosts.add(post);
      Get.snackbar(
        'Saved',
        'Post saved to your list',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    savedPostsCount.value = savedPosts.length;
  }

  // Check if a post is saved
  bool isPostSaved(PostModel post) {
    return savedPosts.any((savedPost) => savedPost.id == post.id);
  }

  // Update user profile
  Future<void> updateUserProfile({
    String? name,
    String? username,
    String? email,
  }) async {
    if (currentUser.value == null) return;
    
    isLoading.value = true;
    
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    currentUser.value = User(
      id: currentUser.value!.id,
      name: name ?? currentUser.value!.name,
      username: username ?? currentUser.value!.username,
      email: email ?? currentUser.value!.email,
      createdAt: currentUser.value!.createdAt,
      updatedAt: DateTime.now(),
    );
    
    isLoading.value = false;
    
    Get.snackbar(
      'Profile Updated',
      'Your profile has been updated successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  // Get user avatar initials
  String getUserInitials() {
    if (currentUser.value?.name == null) return 'U';
    
    final nameParts = currentUser.value!.name!.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    } else {
      return nameParts[0][0].toUpperCase();
    }
  }

  // Get member since text
  String getMemberSinceText() {
    if (currentUser.value?.createdAt == null) return 'Member since recently';
    
    final memberSince = currentUser.value!.createdAt!;
    final now = DateTime.now();
    final difference = now.difference(memberSince);
    
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return 'Member since ${years} year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return 'Member since ${months} month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return 'Member since ${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return 'Member since today';
    }
  }
}
