import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:forumapp/constants/app_theme.dart';
import 'package:forumapp/controllers/post_controller.dart';
import 'package:forumapp/controllers/user_controller.dart';
import 'package:forumapp/views/widgets/post_data.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late TabController _tabController;
  final PostController _postController = Get.put(PostController());
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Load user's posts when page loads
    _postController.getAllPosts();
    _userController.getProfile();
    _userController.getUserPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Settings functionality can be added here
              Get.snackbar(
                'Settings',
                'Settings feature coming soon!',
                backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                colorText: AppTheme.primaryColor,
                snackPosition: SnackPosition.TOP,
              );
            },
            tooltip: 'Settings',
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
    Expanded(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(child: _buildProfileHeader()),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: AppTheme.primaryColor,
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: AppTheme.textSecondaryColor,
              labelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              unselectedLabelStyle: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              tabs: const [
                Tab(
                  icon: Icon(Icons.article_outlined),
                  text: 'Posts',
                ),
                Tab(
                  icon: Icon(Icons.comment_outlined),
                  text: 'Comments',
                ),
              ],
            ),
          ),
          ),
        ],
          // Tab Views
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildUserPostsTab(),
                _buildUserCommentsTab(),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String count, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildUserPostsTab() {
    return Obx(() {
      final userPosts = _userController.userPosts;
      
      if (_postController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (userPosts.isEmpty) {
        return _buildEmptyState(
          Icons.article_outlined,
          'No posts yet',
          'Start sharing your thoughts with the community!',
        );
      }
      
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: userPosts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PostData(post: userPosts[index]),
          );
        },
      );
    });
  }

  Widget _buildUserCommentsTab() {
    return Obx(() {
      // For now, we'll show a placeholder since we don't have user-specific comments
      // In a real app, you'd fetch comments made by the current user
      
      if (_postController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      
      return _buildEmptyState(
        Icons.comment_outlined,
        'No comments yet',
        'Join the conversation by commenting on posts!',
      );
    });
  }

  Widget _buildProfileHeader() {
    return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryColor.withOpacity(0.1),
                  AppTheme.backgroundColor,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [                  // Profile Avatar
                  Stack(
                    children: [
                      Obx(() => CircleAvatar(
                        radius: 60,
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                        child: Text(
                          _userController.getUserInitials(),
                          style: GoogleFonts.poppins(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      )),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                            onPressed: () {
                              // Avatar change functionality
                              Get.snackbar(
                                'Avatar',
                                'Avatar change feature coming soon!',
                                backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                                colorText: AppTheme.primaryColor,
                                snackPosition: SnackPosition.TOP,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                    // Username
                  Obx(() => Text(
                    "${_userController.profile['username'] ?? 'unknown'}",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimaryColor,
                    ),
                  )),
                  
                  Obx(() => Text(
                    _userController.profile['email'] ?? 'email not found',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AppTheme.textSecondaryColor,
                    ),
                  )),
                  
                  const SizedBox(height: 8),
                  
                  Obx(() => Text(
                    'Member since: ${_userController.profile['created_at']?.split('T')[0] ?? '-'}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppTheme.textSecondaryColor,
                    ),
                  )),
                  
                  const SizedBox(height: 20),
                    // Stats Row
                  Obx(() {
                    // Update user stats when posts change
                    // _userController.updateUserStats(_postController.posts.value);
                    
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard(
                          'Posts',
                          '${_userController.profile['total_posts'] ?? 0}',
                          Icons.article_outlined,
                        ),
                        _buildStatCard(
                          'Comments',
                          '${_userController.profile['total_comment'] ?? 0}',
                          Icons.comment_outlined,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          );
  }

  Widget _buildSavedPostsTab() {
    return Obx(() {
      final savedPosts = _userController.savedPosts;
      
      if (savedPosts.isEmpty) {
        return _buildEmptyState(
          Icons.bookmark_outline,
          'No saved posts',
          'Save interesting posts to read them later!',
        );
      }
      
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: savedPosts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PostData(post: savedPosts[index]),
          );
        },
      );
    });
  }

  Widget _buildEmptyState(IconData icon, String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppTheme.primaryLightColor,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

}