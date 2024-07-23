import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/utils/theme/theme.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> currentTheme =AppTheme.lightTheme.obs;

  void changeTheme(bool isDarkMode) {
    if (isDarkMode) {
      currentTheme.value = AppTheme.darkTheme;
    } else {
      currentTheme.value = AppTheme.lightTheme;
    }
  }
}