import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karat_habit_tracker_app/utils/theme/controller.dart';
import 'package:karat_habit_tracker_app/utils/routes/AppRoutes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karat_habit_tracker_app/view/components/Sidebar/SideBarController.dart';
import 'package:karat_habit_tracker_app/view/splash_screen.dart';

import 'model/repositories/notification/notification_service.dart';
import 'model/repositories/notification/work_manager_service.dart';



void main() async {
  // مطمئن شوید که flutter binding قبل از اجرا تنظیم شده است
  WidgetsFlutterBinding.ensureInitialized();

  // مقداردهی اولیه GetStorage برای استفاده از آن
  await GetStorage.init();

  // مقداردهی اولیه flutter_local_notifications
  final NotificationService notificationService = NotificationService();
  await notificationService.init();

  // مقداردهی اولیه Workmanager
  WorkManagerService().init();

  // تنظیم و برنامه‌ریزی وظایف Workmanager
  WorkManagerService().scheduleDailyTasks();
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
            home: SplashScreen(),
          );
        });
      },
    );
  }
}
