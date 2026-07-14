import 'package:flutter/material.dart';
import 'app_color.dart';

class AppTheme {

  static ThemeData lightTheme = ThemeData(

    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.background,

    fontFamily: 'Roboto',

    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
    ),

    inputDecorationTheme: InputDecorationTheme(

      filled: true,

      fillColor: Colors.white,

      contentPadding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: AppColors.accent,
          width: 2,
        ),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(

      style: ElevatedButton.styleFrom(

        backgroundColor: AppColors.primary,

        foregroundColor: Colors.white,

        minimumSize: Size(double.infinity, 58),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),

        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}