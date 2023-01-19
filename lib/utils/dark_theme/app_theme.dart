import 'package:expense_tracker/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  cardTheme: const CardTheme(color: Colors.black12),
  textTheme: GoogleFonts.mulishTextTheme()
      .apply(bodyColor: Colors.white70, displayColor: Colors.white),
  primaryColor: AppColors.primaryColor,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.secondaryColor),
);

final lightTheme = ThemeData(
    textTheme: GoogleFonts.mulishTextTheme()
        .apply(bodyColor: Colors.black, displayColor: Colors.black),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryColor),
    primaryColor: AppColors.primaryColor,
    brightness: Brightness.light,
    backgroundColor: Colors.white,
    scaffoldBackgroundColor: Colors.white);
