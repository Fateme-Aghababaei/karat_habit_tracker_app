import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

class TextFieldTheme {
  TextFieldTheme._();

  static InputDecorationTheme lightTheme = const InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: "IRANYekan",
        color: AppColors.lightDescription,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle:TextStyle(
        fontFamily: "IRANYekan",
        color: AppColors.lightPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: AppColors.lightBorder,
        ),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: AppColors.lightPrimary,
        ),

      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.redAccent,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.redAccent,
        ),
      ));


  static InputDecorationTheme darkTheme = const InputDecorationTheme();
}
