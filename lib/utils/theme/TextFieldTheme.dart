import 'package:flutter/material.dart';
import 'colors.dart';


class TextFieldTheme{
  TextFieldTheme._();

  static  InputDecorationTheme lightTheme= const InputDecorationTheme(
      labelStyle: TextStyle(
        fontFamily: "IRANYekan",
        color: AppColors.lightText,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFFAEA9B1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: AppColors.lightPrimary,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(
          width: 1,
          color: Colors.redAccent,
        ),
      )

  );

  static  InputDecorationTheme darkTheme=const InputDecorationTheme();


}