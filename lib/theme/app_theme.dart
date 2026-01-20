import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF8F9FA),
    cardColor: Colors.white,
    dividerColor: Colors.grey.shade300,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.black87),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    dividerColor: Colors.grey.shade700,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
  );
}
