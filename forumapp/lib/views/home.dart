import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/post_field.dart';
import 'widgets/post_data.dart';
import 'package:forumapp/controllers/post_controller.dart';
import 'package:forumapp/constants/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:forumapp/views/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 36,
              child: Image.asset(
                'assets/images/chillntalk_logo.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'ChillNTalk',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Get.to(() => const ProfilePage());
            },
            tooltip: 'Profile',
          ),
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: AppTheme.primaryColor,
        onRefresh: () async {
          await _postController.getAllPosts();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Create post card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Start a discussion',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        PostField(
                          hintText: 'What do you want to ask?',
                          controller: _textController,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.send, size: 18),
                          label: Text(
                            'Post',
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () async {
                            if (_textController.text.trim().isNotEmpty) {
                              await _postController.createPost(
                                content: _textController.text.trim(),
                              );
                              _textController.clear();
                              _postController.getAllPosts();
                            } else {
                              Get.snackbar(
                                'Empty Post', 
                                'Please write something to post',
                                backgroundColor: Colors.redAccent.withOpacity(0.1),
                                colorText: Colors.red,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Posts section title
                Row(
                  children: [
                    const Icon(
                      Icons.forum_outlined, 
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Recent Discussions',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Posts list
                Obx(() {
                  if (_postController.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (_postController.posts.value.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.forum_outlined,
                              size: 64,
                              color: AppTheme.primaryLightColor,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No posts yet',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: AppTheme.textSecondaryColor,
                              ),
                            ),
                            Text(
                              'Be the first to start a discussion!',
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
                  
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _postController.posts.value.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: PostData(
                          post: _postController.posts.value[index],
                        ),
                      );
                    },
                  );
                }),
                
                // Add some bottom padding
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}