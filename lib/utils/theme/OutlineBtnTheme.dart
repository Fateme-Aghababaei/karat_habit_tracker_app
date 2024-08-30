import 'package:flutter/material.dart';
import 'colors.dart';

class OutlineBtnTheme {
  OutlineBtnTheme._();

  static final lightTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    foregroundColor: AppColors.lightPrimary,
    backgroundColor: AppColors.lightBackground,
    textStyle: const TextStyle(
        fontFamily: "IRANYekan", fontSize: 14, fontWeight: FontWeight.w400),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    side: const BorderSide(color: AppColors.lightPrimary, width: 1),
  ));
  static final darkTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.lightPrimary,
        backgroundColor: AppColors.darkBackground,
        textStyle: const TextStyle(
            fontFamily: "IRANYekan", fontSize: 14, fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        side: const BorderSide(color: AppColors.lightPrimary, width: 1),
      )
  );
}
