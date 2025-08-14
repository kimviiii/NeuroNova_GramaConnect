import 'package:flutter/material.dart';

class AppColors {
  // Sri Lankan Government App Color Scheme
  static const Color primary = Color(0xFF800000); // Maroon
  static const Color surface = Color(0xFFFFF5E1); // Light Cream
  static const Color accent = Color(0xFF00B8A9); // Teal Accent
  static const Color success = Color(0xFF1E8E3E); // Success Green
  static const Color warning = Color(0xFFF9AB00); // Warning Orange
  static const Color error = Color(0xFFD93025); // Error Red
  static const Color text = Color(0xFF202124); // Text Dark
  static const Color muted = Color(0xFF5F6368); // Muted Grey
  static const Color white = Color(0xFFFFFFFF); // Pure White

  // Additional colors for government styling
  static const Color primaryLight = Color(0xFFA33333);
  static const Color primaryDark = Color(0xFF600000);
  static const Color surfaceDark = Color(0xFFF5E6C8);
  static const Color accentLight = Color(0xFF33C4B6);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.accent,
        onSecondary: AppColors.white,
        surface: AppColors.surface,
        onSurface: AppColors.text,
        error: AppColors.error,
        onError: AppColors.white,
        outline: AppColors.muted,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.surface,

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 2,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: AppColors.white),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        color: AppColors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.muted),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.muted),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        labelStyle: const TextStyle(color: AppColors.muted),
        hintStyle: TextStyle(color: AppColors.muted.withValues(alpha: 0.7)),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Icon Theme
      iconTheme: const IconThemeData(
        color: AppColors.muted,
        size: 24,
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        displayMedium:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        displaySmall:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.bold),
        headlineLarge:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.w600),
        headlineMedium:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.w600),
        headlineSmall:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.w600),
        titleLarge:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.w600),
        titleMedium:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.w500),
        titleSmall:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: AppColors.text),
        bodyMedium: TextStyle(color: AppColors.text),
        bodySmall: TextStyle(color: AppColors.muted),
        labelLarge:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.w500),
        labelMedium:
            TextStyle(color: AppColors.text, fontWeight: FontWeight.w500),
        labelSmall: TextStyle(color: AppColors.muted),
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.white;
        }),
        checkColor: WidgetStateProperty.all(AppColors.white),
        side: const BorderSide(color: AppColors.muted, width: 2),
      ),

      // Snack Bar Theme
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.primary,
        contentTextStyle: TextStyle(color: AppColors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        onPrimary: AppColors.white,
        secondary: AppColors.accent,
        onSecondary: AppColors.white,
        surface: Color(0xFF1A1A1A),
        onSurface: AppColors.white,
        error: AppColors.error,
        onError: AppColors.white,
        outline: AppColors.muted,
      ),

      scaffoldBackgroundColor: const Color(0xFF121212),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 2,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
