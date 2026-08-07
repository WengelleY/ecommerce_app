import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBrown = Color(0xff8B5E3C);
  static const Color darkBrown = Color(0xff4A2C1B);
  static const Color mediumBrown = Color(0xffA67B5B);
  static const Color lightBrown = Color(0xffD7B899);
  static const Color cream = Color(0xffFDF6EC);

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: cream,

    colorScheme: ColorScheme.fromSeed(seedColor: primaryBrown),

    appBarTheme: const AppBarTheme(
      backgroundColor: darkBrown,
      foregroundColor: Colors.white,

      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBrown,

        foregroundColor: Colors.white,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,

      elevation: 3,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,

      fillColor: Colors.white,

      border: OutlineInputBorder(),
    ),
  );
}
