import 'package:flutter/material.dart';
import 'colors.dart';


class CheckBoxTheme{
  CheckBoxTheme._();

  static final  lightTheme= CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
          return AppColors.lightPrimary; // رنگ پس‌زمینه اگر تیک‌خورده باشد
        }
        return AppColors.lightBackground; // رنگ پس‌زمینه اگر تیک‌نخورده باشد
      },
    ),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
          return Colors.white; // رنگ تیک اگر تیک‌خورده باشد
        }
        return Colors.transparent; // رنگ تیک اگر تیک‌نخورده باشد
      },
    ),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return BorderSide.none; // وقتی تیک خورده است، بوردر نداریم
      }
      return const BorderSide(color: AppColors.lightDescription); // رنگ بوردر وقتی تیک‌نخورده است
    }
    ),
  );

  static final  darkTheme= CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    fillColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColors.lightPrimary; // رنگ پس‌زمینه اگر تیک‌خورده باشد
      }
      return AppColors.darkBackground; // رنگ پس‌زمینه اگر تیک‌نخورده باشد
    },
    ),
    checkColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.white; // رنگ تیک اگر تیک‌خورده باشد
      }
      return Colors.transparent; // رنگ تیک اگر تیک‌نخورده باشد
    },
    ),
    side: WidgetStateBorderSide.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return BorderSide.none; // وقتی تیک خورده است، بوردر نداریم
      }
      return  BorderSide(color: AppColors.darkDescription); // رنگ بوردر وقتی تیک‌نخورده است
    }
    ),
  );


}