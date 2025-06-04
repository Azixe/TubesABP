import 'package:flutter/material.dart';
import 'package:forumapp/views/post_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:forumapp/models/post_model.dart';
import 'package:forumapp/controllers/post_controller.dart';
import 'package:forumapp/constants/app_theme.dart';

class PostData extends StatefulWidget {
  const PostData({super.key, required this.post,});

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
  }

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());
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
          children: [
            // User info row with avatar
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
                    _postController.getAllPosts();
                  },
                  icon: Icon(
                    widget.post.liked! ? Icons.thumb_up : Icons.thumb_up_outlined,
                    color: widget.post.liked! ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
                    size: 20,
                  ),
                  label: Text(
                    'Like',
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
                    'Comment',
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
}