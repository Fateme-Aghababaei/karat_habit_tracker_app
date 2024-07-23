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
    displaySmall: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightDescription,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodyLarge: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightDescription,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightDescription,
      fontSize: 10,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightDescription,
      fontSize: 12,
      fontWeight: FontWeight.w300,
    ),
    labelMedium: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightText,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightText,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightText,
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
    titleSmall: TextStyle(
      fontFamily: "IRANYekan",
      color: AppColors.lightText,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: TextStyle(
        fontFamily: "IRANYekan",
        color: AppColors.lightText,
        fontSize: 18,
        fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(
        fontFamily: "IRANYekan",
        color: AppColors.lightText,
        fontSize: 18,
        fontWeight: FontWeight.w400),
    headlineSmall: TextStyle(
        fontFamily: "IRANYekan",
        color: AppColors.lightText,
        fontSize: 16,
        fontWeight: FontWeight.w400),
  );

  static TextTheme DarkTextTheme = TextTheme();
}
