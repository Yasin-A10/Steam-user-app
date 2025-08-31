import 'package:steam/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = AppColors.orange;
  static const Color backgroundColor = AppColors.white;

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        surface: backgroundColor,
      ),

      fontFamily: 'IRANYekanX',

      scaffoldBackgroundColor: backgroundColor,

      appBarTheme: AppBarTheme(
        surfaceTintColor: AppColors.white,
        foregroundColor: AppColors.myBlack,
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(left: 8),
        shape: LinearBorder.bottom(side: BorderSide(color: AppColors.myGrey4)),
        elevation: 8,
        titleTextStyle: const TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: AppColors.myBlack,
        ),
      ),

      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.white),
    );
  }
}
