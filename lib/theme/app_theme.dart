import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get hellTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red[900],
      scaffoldBackgroundColor: Colors.black,
      colorScheme: ColorScheme.dark(
        primary: Colors.red[900]!,
        secondary: Colors.deepOrangeAccent,
        background: Colors.black,
        surface: Colors.grey[900]!,
        error: Colors.redAccent,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.red[900],
        foregroundColor: Colors.white,
        elevation: 4,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          color: Colors.white70,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.red,
        textTheme: ButtonTextTheme.primary,
      ),
      iconTheme: const IconThemeData(
        color: Colors.deepOrangeAccent,
      ),
    );
  }
} 