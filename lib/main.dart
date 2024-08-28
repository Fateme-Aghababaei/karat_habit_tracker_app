import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karat_habit_tracker_app/utils/theme/controller.dart';
import 'package:karat_habit_tracker_app/utils/routes/AppRoutes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karat_habit_tracker_app/view/splash_screen.dart';
import 'DeepLink.dart';
import 'background_service.dart';
import 'model/repositories/notification_service.dart';


Timer? periodicTimer;

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  await GetStorage.init();

  // Initialize the periodic timer
  startPeriodicTimer();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeNotifications();
  await initializeService(onStart);

  final box = GetStorage();

  // Listener برای تغییرات isNotifEnabled
  box.listenKey('isNotifEnabled', (value) {
    if (value != null) {
      if (value == false) {
        // متوقف کردن تایمر پریودیک اگر نوتیفیکیشن غیرفعال شود
        if (periodicTimer != null && periodicTimer!.isActive) {
          periodicTimer!.cancel();
          print("Periodic timer cancelled due to notification disabled.");
        }
      } else if (value == true) {
        // راه‌اندازی مجدد تایمر پریودیک اگر نوتیفیکیشن فعال شود
        startPeriodicTimer();
        print("Periodic timer started due to notification enabled.");
      }
    }
  });

  runApp(MyApp());
}





class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController _themeController =
      Get.put<ThemeController>(ThemeController());
  final AppLinksDeepLink _appLinksDeepLink = AppLinksDeepLink.instance;

  @override
  Widget build(BuildContext context) {
    _appLinksDeepLink.initDeepLinks();
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
