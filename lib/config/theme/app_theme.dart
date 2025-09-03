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
        toolbarHeight: 80,
        surfaceTintColor: AppColors.white,
        foregroundColor: AppColors.myBlack,
        centerTitle: true,
        actionsPadding: const EdgeInsets.only(left: 8),
        shape: LinearBorder.bottom(side: BorderSide(color: AppColors.myGrey5)),
        elevation: 8,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.myBlack,
          fontFamily: 'IRANYekanX',
        ),
      ),

      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.white),
    );
  }
}
