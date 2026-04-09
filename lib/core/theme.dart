import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color backgroundColor = Color(0xFF0A0A12);
  static const Color cardColor = Color(0xFF161625);
  static const Color primaryNeonBlue = Color(0xFF00D2FF);
  static const Color primaryNeonPurple = Color(0xFF9D50BB);
  static const Color accentCyan = Color(0xFF00FFF2);
  static const Color accentPurple = Color(0xFFBD00FF);
  static const Color textColor = Color(0xFFE0E0E0);
  static const Color mutedTextColor = Color(0xFF9E9E9E);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryNeonBlue,
    colorScheme: const ColorScheme.dark(
      primary: primaryNeonBlue,
      secondary: accentCyan,
      surface: cardColor,
      onSurface: textColor,
    ),
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.outfit(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
      titleLarge: GoogleFonts.outfit(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: textColor,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        color: mutedTextColor,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.5,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryNeonBlue,
      foregroundColor: Colors.black,
    ),
    cardTheme: CardThemeData(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
      ),
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.5),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: primaryNeonBlue, width: 1.5),
      ),
      labelStyle: const TextStyle(color: mutedTextColor),
      hintStyle: const TextStyle(color: Colors.grey),
    ),
  );

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryNeonBlue, primaryNeonPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static BoxDecoration glassDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.05),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.white.withOpacity(0.1)),
  );
}
