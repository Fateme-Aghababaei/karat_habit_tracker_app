import 'package:flutter/material.dart';
import 'colors.dart';


class TSwitchTheme{
  TSwitchTheme._();

  static final  lightTheme= SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white; // رنگ دایره داخلی در حالت فعال
      }
      return const Color(0xFFE6E0E9); // رنگ دایره داخلی در حالت غیر فعال
    }),
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.lightPrimary; // رنگ پس‌زمینه در حالت فعال
      }
      return Color(0xFFF7C8B1); // رنگ پس‌زمینه در حالت غیر فعال
    }),
    trackOutlineColor: WidgetStateProperty.all(Colors.transparent),

  );


  static const  darkTheme= SwitchThemeData();


}