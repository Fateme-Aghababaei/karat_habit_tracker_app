import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karat_habit_tracker_app/utils/theme/controller.dart';
import 'package:karat_habit_tracker_app/utils/routes/AppRoutes.dart';
import 'package:karat_habit_tracker_app/view/habit_screen/habit_screen.dart';
import 'package:karat_habit_tracker_app/view/signup_screen/signup_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeController _themeController =
      Get.put<ThemeController>(ThemeController());

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(() {
          return GetMaterialApp(
            getPages: routes,
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
            home:  SignUpPage(),
          );
        });
      },
    );
  }
}
