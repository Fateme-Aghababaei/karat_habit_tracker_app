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
      cardColor: const Color(0XFFD2E3D8),
    canvasColor:AppColors.lightPrimary.withOpacity(0.2) ,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        onSurface: AppColors.lightText,
        primary: AppColors.lightPrimary,
        secondary: AppColors.lightSecond,
        secondaryFixed: AppColors.textButton,
        surface: AppColors.lightBackground,
        outline: Colors.grey.shade300,
        outlineVariant: const Color(0XFFCAC5CD),

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
      backgroundColor: AppColors.lightBackground,
      dialBackgroundColor:AppColors.lightPrimary.withOpacity(0.1) ,
      hourMinuteColor: WidgetStateColor.resolveWith((states) =>
      states.contains(WidgetState.selected) ? AppColors.lightPrimary.withOpacity(0.2): AppColors.lightDescription.withOpacity(0.2)), // رنگ کارت‌های ساعت و دقیقه
      hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
      states.contains(WidgetState.selected) ? AppColors.lightPrimary : AppColors.lightText.withOpacity(0.8)), // رنگ متن داخل کارت‌ها
    ),

  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: "IRANYekan",
    cardColor: const Color(0xFF445A4E),
    canvasColor:AppColors.lightPrimary.withOpacity(0.7) ,
    primaryColor: AppColors.lightPrimary,
    disabledColor: AppColors.darkDescription,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        onSurface: AppColors.darkText,
        primary: AppColors.lightPrimary,
        secondary: AppColors.lightSecond,
        secondaryFixed: AppColors.textButton,
        surface: AppColors.darkBackground,
        outline: Colors.grey.shade700,
        outlineVariant: Colors.grey.shade700


    ),
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: ElevatedBtnTheme.darkTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground, elevation: 0.0,scrolledUnderElevation: 0,
      actionsIconTheme: IconThemeData(color: AppColors.darkText)
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.darkBackground),
    inputDecorationTheme: TextFieldTheme.darkTheme,
    outlinedButtonTheme: OutlineBtnTheme.darkTheme,
    checkboxTheme: CheckBoxTheme.darkTheme,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: Colors.white),
    switchTheme: TSwitchTheme.darkTheme,
    dialogTheme: const DialogTheme(backgroundColor:AppColors.darkBackground ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textButton,
        )
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.darkBackground,
      dialBackgroundColor: Color(0XFFF7C8B1).withOpacity(0.9),
      hourMinuteColor: WidgetStateColor.resolveWith((states) =>
      states.contains(WidgetState.selected) ?Color(0XFFF7C8B1).withOpacity(0.9): AppColors.darkDescription.withOpacity(0.4)), // رنگ کارت‌های ساعت و دقیقه
      hourMinuteTextColor: WidgetStateColor.resolveWith((states) =>
      states.contains(WidgetState.selected) ? AppColors.lightPrimary : AppColors.darkText.withOpacity(0.8)), // رنگ متن داخل کارت‌ها
    ),
  );
}
