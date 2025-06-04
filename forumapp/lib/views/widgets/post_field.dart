import 'package:flutter/material.dart';
import 'package:forumapp/constants/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

class PostField extends StatelessWidget {
  const PostField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: 3,
        minLines: 2,
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: AppTheme.textPrimaryColor,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: AppTheme.textSecondaryColor.withOpacity(0.7),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 14.0,
          ),
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 12.0, right: 8.0),
            child: Icon(
              Icons.chat_bubble_outline,
              color: AppTheme.primaryColor,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
