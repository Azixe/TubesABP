import 'package:flutter/material.dart';
import 'package:forumapp/views/post_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:forumapp/controllers/post_controller.dart';
import 'package:forumapp/controllers/user_controller.dart';
import 'package:forumapp/constants/app_theme.dart';

class PostData extends StatefulWidget {
  const PostData({super.key, required this.post,});

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
  }

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());
  final UserController _userController = Get.put(UserController());
  bool likedPost = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            // User info row with avatar
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                  child: Text(
                    widget.post.user!.name![0].toUpperCase(),
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.user!.name!,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                      Text(
                        widget.post.user!.email!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppTheme.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                // Menu dropdown for post owner
                Obx(() {
                  if (_userController.isCurrentUserPost(widget.post)) {
                    return PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'delete') {
                          _showDeleteConfirmation();
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red, size: 18),
                              SizedBox(width: 8),
                              Text('Delete Post', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                      child: Icon(
                        Icons.more_vert,
                        color: AppTheme.textSecondaryColor,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Post content
            Text(
              widget.post.content!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            
            const SizedBox(height: 16),
            const Divider(height: 1),
              // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Like button
                TextButton.icon(
                  onPressed: () async {
                    await _postController.likeAndDislike(widget.post.id);
                    await _postController.getAllPosts();
                  },
                  icon: Icon(
                    widget.post.liked! ? Icons.thumb_up : Icons.thumb_up_outlined,
                    color: widget.post.liked! ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
                    size: 20,
                  ),
                  label: Text(
                    '${widget.post.totalLikes ?? 0}',
                    style: GoogleFonts.poppins(
                      color: widget.post.liked! ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                
                // Comment button
                TextButton.icon(
                  onPressed: () {
                    Get.to(() => PostDetails(post: widget.post));
                  },
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: AppTheme.textSecondaryColor,
                    size: 20,
                  ),
                  label: Text(
                    '${widget.post.totalComment ?? 0} Comment',
                    style: GoogleFonts.poppins(
                      color: AppTheme.textSecondaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Delete Post',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this post? This action cannot be undone.',
          style: GoogleFonts.poppins(
            color: AppTheme.textSecondaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ),
          Obx(() => ElevatedButton(
                onPressed: _postController.isLoading.value
                    ? null
                    : () async {
                        Get.back(); // Close dialog first
                        final success = await _postController.deletePost(widget.post.id!);
                        if (success) {
                          // Post deleted successfully, no need for additional action
                          // as the controller already refreshes the posts list
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: _postController.isLoading.value
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        'Delete',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              )),
        ],
      ),
    );
  }
}