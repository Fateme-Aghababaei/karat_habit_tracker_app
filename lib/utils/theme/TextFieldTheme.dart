import 'package:flutter/material.dart';
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
      hintStyle: TextStyle(
        fontFamily: "IRANYekan",
        color: AppColors.lightDescription,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
      errorStyle: TextStyle(
        fontFamily: "IRANYekan",
          color: Colors.redAccent,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle:TextStyle(
        fontFamily: "IRANYekan",
        color: AppColors.lightPrimary,
        fontSize: 14,
        fontWeight: FontWeight.w700,
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
