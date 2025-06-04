import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Light blue theme colors
  static const Color primaryColor = Color(0xFF03A9F4); // Light blue
  static const Color primaryLightColor = Color(0xFF4FC3F7); // Lighter blue
  static const Color accentColor = Color(0xFF29B6F6); // Accent blue
  static const Color backgroundColor = Color(0xFFF8F9FA); // Soft white background
  static const Color cardColor = Color(0xFFFFFFFF); // Card white
  static const Color textPrimaryColor = Color(0xFF212121); // Dark grey for text
  static const Color textSecondaryColor = Color(0xFF757575); // Secondary text
  static const Color dividerColor = Color(0xFFEEEEEE); // Divider color

  // Create the theme data
  static ThemeData lightTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        surface: cardColor,
        onSurface: textPrimaryColor,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.w500),
          headlineMedium: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.w500),
          headlineSmall: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.w500),
          titleLarge: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(color: textPrimaryColor, fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: textSecondaryColor, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(color: textPrimaryColor),
          bodyMedium: TextStyle(color: textPrimaryColor),
          bodySmall: TextStyle(color: textSecondaryColor),
          labelLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          labelMedium: TextStyle(color: textSecondaryColor),
          labelSmall: TextStyle(color: textSecondaryColor),
        ),
      ),
      
      // App Bar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white, 
          fontSize: 20, 
          fontWeight: FontWeight.w500
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(
            fontSize: 16, 
            fontWeight: FontWeight.w500, 
            letterSpacing: 0.5
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dividerColor, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: dividerColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        hintStyle: TextStyle(color: textSecondaryColor.withOpacity(0.7)),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: cardColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: dividerColor,
        thickness: 1,
        space: 1,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: primaryColor,
        size: 24,
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
}
