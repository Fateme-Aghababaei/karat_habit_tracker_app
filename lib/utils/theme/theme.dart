import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'CheckBoxTheme.dart';
import 'ElevatedBtnTheme.dart';
import 'OutlineBtnTheme.dart';
import 'TextFieldTheme.dart';
import 'SwitchTheme.dart';
import 'TextTheme.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: "IRANYekan",
      brightness: Brightness.light,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme: ElevatedBtnTheme.lightTheme,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.lightBackground, elevation: 0.0),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.lightBackground),
      inputDecorationTheme: TextFieldTheme.lightTheme,
      outlinedButtonTheme: OutlineBtnTheme.lightTheme,
      checkboxTheme: CheckBoxTheme.lightTheme,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: Colors.white),
      switchTheme: TSwitchTheme.lightTheme,
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        foregroundColor: const Color(0xFF178451),
        textStyle: const TextStyle(
          fontFamily: "IRANYekan",
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ) //
          ));

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "IRANYekan",
    brightness: Brightness.dark,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: Colors.black,
  );
}
