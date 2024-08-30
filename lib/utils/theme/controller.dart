import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karat_habit_tracker_app/utils/theme/theme.dart';

class ThemeController extends GetxController {
  Rx<ThemeData> currentTheme = AppTheme.lightTheme.obs;
  final GetStorage _storage = GetStorage();
  final String _themeKey = 'isDarkMode';

  @override
  void onInit() {
    super.onInit();
    // Load theme from storage
    bool isDarkMode = _storage.read(_themeKey) ?? false; // Default to false (light theme) if null
    currentTheme.value = isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  void changeTheme(bool isDarkMode) {
    if (isDarkMode) {
      currentTheme.value = AppTheme.darkTheme;
    } else {
      currentTheme.value = AppTheme.lightTheme;
    }
    // Save the theme preference in storage
    _storage.write(_themeKey, isDarkMode);
  }
}
