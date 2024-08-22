import 'package:flutter/material.dart';
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
      disabledColor: AppColors.lightDescription,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        onSurface: AppColors.lightText,
        primary: AppColors.lightPrimary,
        secondary: AppColors.lightSecond,
        secondaryFixed: AppColors.textButton,
        surface: AppColors.lightBackground
      ),
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: TTextTheme.lightTextTheme,
      elevatedButtonTheme: ElevatedBtnTheme.lightTheme,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.lightBackground, elevation: 0.0,scrolledUnderElevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.lightBackground),
      inputDecorationTheme: TextFieldTheme.lightTheme,
      outlinedButtonTheme: OutlineBtnTheme.lightTheme,
      checkboxTheme: CheckBoxTheme.lightTheme,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: Colors.white),
      switchTheme: TSwitchTheme.lightTheme,
      dialogTheme: const DialogTheme(backgroundColor:AppColors.lightBackground ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        foregroundColor: AppColors.textButton,
      )
          ),
    timePickerTheme: TimePickerThemeData(
      hourMinuteColor: WidgetStateColor.resolveWith((states) =>
      states.contains(WidgetState.selected) ? AppColors.lightPrimary.withOpacity(0.2): AppColors.lightDescription.withOpacity(0.2)), // رنگ کارت‌های ساعت و دقیقه
      hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
      states.contains(WidgetState.selected) ? AppColors.lightPrimary : AppColors.lightText.withOpacity(0.8)), // رنگ متن داخل کارت‌ها
    ),

  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "IRANYekan",
    brightness: Brightness.dark,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: Colors.black,
  );
}
