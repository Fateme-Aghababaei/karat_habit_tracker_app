import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class ElevatedBtnTheme {
  ElevatedBtnTheme._();

  static final lightTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: AppColors.lightPrimary,
    textStyle: const TextStyle(
        fontFamily: "IRANYekan", fontSize: 15, fontWeight: FontWeight.w400),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ));
  static final darkTheme = ElevatedButtonThemeData();
}
