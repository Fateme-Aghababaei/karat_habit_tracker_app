import 'package:flutter/material.dart';
import 'colors.dart';

class TTextTheme {
  TTextTheme._();

  static const TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightPrimary,
      fontSize: 36,
      fontWeight: FontWeight.w800,
    ),
    displayMedium: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightPrimary,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),


    bodySmall: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightDescription,
      fontWeight: FontWeight.w400,
    ),

  titleSmall : TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightDescription,
      fontWeight: FontWeight.w300,
    ),
    bodyLarge: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightText,
      fontWeight: FontWeight.w700,
    ),
    bodyMedium: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightText,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightText,
      fontWeight: FontWeight.w300,
    ),
      titleLarge: TextStyle(
        fontFamily: "IRANYekan",
        color: AppColors.lightSecond,
        fontWeight: FontWeight.w700,
      )

  );

  static TextTheme DarkTextTheme = TextTheme();
}
