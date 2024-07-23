import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:karat_habit_tracker_app/utils/theme/controller.dart';
import 'package:karat_habit_tracker_app/view/onboarding_screens/onboarding_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeController _themeController =
      Get.put<ThemeController>(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("fa", "IR"),
        ],
        locale: const Locale("fa", "IR"),
        debugShowCheckedModeBanner: false,
        theme: _themeController.currentTheme.value,
        home: const onBoardingScreen(),
      );
    });
  }
}
