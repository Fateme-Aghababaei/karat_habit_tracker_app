import 'package:flutter/material.dart';
import 'colors.dart';

class OutlineBtnTheme {
  OutlineBtnTheme._();

  static final lightTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF605D64),
    backgroundColor: AppColors.lightBackground,
    textStyle: const TextStyle(
        fontFamily: "IRANYekan", fontSize: 14, fontWeight: FontWeight.w400),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    side: const BorderSide(color: Color(0xFF938F96), width: 1),
  ));
  static const darkTheme = OutlinedButtonThemeData();
}
