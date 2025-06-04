import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:forumapp/constants/app_theme.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key, required this.hintText, required this.controller, required this.obscureText,
  });

final String hintText;
final TextEditingController controller;
final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        style: GoogleFonts.poppins(color: AppTheme.textPrimaryColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.dividerColor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.dividerColor, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(color: AppTheme.textSecondaryColor.withOpacity(0.7)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          prefixIcon: _getPrefixIcon(),
        ),
      ),
    );
  }
  
  Widget? _getPrefixIcon() {
    if (hintText.toLowerCase().contains('password')) {
      return const Icon(Icons.lock_outline, color: AppTheme.primaryColor);
    } else if (hintText.toLowerCase().contains('email')) {
      return const Icon(Icons.email_outlined, color: AppTheme.primaryColor);
    } else if (hintText.toLowerCase().contains('name') || hintText.toLowerCase().contains('username')) {
      return const Icon(Icons.person_outline, color: AppTheme.primaryColor);
    } else if (hintText.toLowerCase().contains('comment')) {
      return const Icon(Icons.comment_outlined, color: AppTheme.primaryColor);
    }
    return null;
  }
}