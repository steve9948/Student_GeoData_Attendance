import 'package:flutter/material.dart';

class AppTheme {
  // Define colors for easy access and consistency
  static const Color primaryColor = Color(0xFF0D47A1); // A deep, professional blue
  static const Color secondaryColor = Color(0xFFFFC107); // A warm, inviting gold/amber
  static const Color accentColor = Color(0xFF757575); // A neutral grey for text/icons
  static const Color backgroundColor = Color(0xFFF5F7FA); // A very light grey for the background
  static const Color errorColor = Color(0xFFD32F2F); // A standard, clear red for errors

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      error: errorColor,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: accentColor),
      titleTextStyle: TextStyle(
        color: primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Modern Input Field Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryColor, width: 2.0),
      ),
      labelStyle: const TextStyle(color: accentColor),
    ),

    // Modern Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, // Text color
        backgroundColor: primaryColor,
        minimumSize: const Size(double.infinity, 52), // Full width
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 2,
        shadowColor: primaryColor.withOpacity(0.2),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // Outlined Button Theme for secondary actions
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 2),
        minimumSize: const Size(double.infinity, 52),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),

    // TabBar Theme
    tabBarTheme: TabBarThemeData(
      labelColor: primaryColor,
      unselectedLabelColor: accentColor,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: primaryColor, width: 3.0),
      ),
      labelStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

// Keep this extension, it's used in login_screen.dart for the error message background.
extension ColorSchemeValues on Color {
  Color withValues({int? alpha, int? red, int? green, int? blue}) {
    return Color.fromARGB(
      alpha ?? this.alpha,
      red ?? this.red,
      green ?? this.green,
      blue ?? this.blue,
    );
  }
}
