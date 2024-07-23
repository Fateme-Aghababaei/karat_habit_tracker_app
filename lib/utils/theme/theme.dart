import 'package:flutter/material.dart';
import 'CheckBoxTheme.dart';
import 'ElevatedBtnTheme.dart';
import 'OutlineBtnTheme.dart';
import 'TextFieldTheme.dart';
import 'SwitchTheme.dart';
import 'TextTheme.dart';
import 'colors.dart';


class AppTheme{
  AppTheme._();

  static final ThemeData lightTheme= ThemeData(
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
      backgroundColor:AppColors.lightBackground
    ),

    inputDecorationTheme: TextFieldTheme.lightTheme,
    outlinedButtonTheme: OutlineBtnTheme.lightTheme,
    checkboxTheme: CheckBoxTheme.lightTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white),

    switchTheme: TSwitchTheme.lightTheme
  );

  static final ThemeData darkTheme= ThemeData(
    useMaterial3: true,
    fontFamily: "IRANYekan",
    brightness: Brightness.dark,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: Colors.black,
  );

}

