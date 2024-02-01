import 'dart:ui';

import 'package:flutter/material.dart';
class AppColors {

  static const Color lightBackground = Colors.white;
  static const Color lightPrimary = Color.fromRGBO(59, 82, 73, 1);
  static const Color lightSecondary = Color.fromRGBO(190, 197, 173, 1);
  static const Color lightTertiary = Color.fromRGBO(164, 180, 148, 1);

  static const Color darkBackground = Colors.black12;
  static const Color darkPrimary = Color.fromRGBO(34, 51, 59, 1);
  static const Color darkSecondary = Color.fromRGBO(234, 224, 213, 1);
  static const Color darkTertiary = Color.fromRGBO(10, 9, 8, 1);

}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
      tertiary: AppColors.lightTertiary
    )
  );

  static ThemeData darkTheme = ThemeData(
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.dark().copyWith(
          primary: AppColors.darkPrimary,
          secondary: AppColors.darkSecondary,
          tertiary: AppColors.darkTertiary
      )
  );

}