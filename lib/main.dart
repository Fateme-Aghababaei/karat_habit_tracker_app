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
import 'package:path/path.dart';

import 'model/repositories/notification_repository.dart';
import 'model/repositories/notification_service.dart';


Timer? periodicTimer; // تعریف تایمر به عنوان متغیر گلوبال

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initializeNotifications();
  await initializeService();

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

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: false,
      autoStart: true,
      autoStartOnBoot: true,
      notificationChannelId: 'morning_reminder_channel',
      initialNotificationTitle: 'Background Service',
      initialNotificationContent: 'Service is running...',
      foregroundServiceNotificationId: 0,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: (service) {
        return true;
      },
    ),
  );

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  await GetStorage.init();

  final box = GetStorage();

  // راه‌اندازی تایمر پریودیک در شروع سرویس
  startPeriodicTimer();
}

Future<void> startPeriodicTimer() async {
  final box = GetStorage();

  // اطمینان از اینکه اگر تایمر قبلی فعال است، لغو شود
  if (periodicTimer != null && periodicTimer!.isActive) {
    periodicTimer!.cancel();
  }
  final token=await box.read('auth_token');
  bool flag=false;
  periodicTimer = Timer.periodic(const Duration(minutes: 15), (timer) async {
    // چک کردن وضعیت نوتیفیکیشن
    bool isNotifEnabled = box.read('isNotifEnabled') ?? true;

    if (!isNotifEnabled) {
      timer.cancel(); // اگر نوتیفیکیشن غیرفعال شد، تایمر را لغو کنید
      print("Periodic timer cancelled within the loop due to notification disabled.");
      return;
    }

    final NotificationRepository notificationRepository = NotificationRepository();
    final now = DateTime.now();

    if (!flag&&(now.hour == 9 || now.hour == 21)) {
      flag=true;
      int habitCount = await notificationRepository.fetchIncompleteHabitsCount();
      String body=now.hour == 9? 'شما $habitCount وظیفه برای امروز دارید. با انرژی و انگیزه روزتان را آغاز کنید!': 'شما هنوز $habitCount کار ناتمام دارید. قبل از پایان روز آنها را به اتمام برسانید!';
      await scheduleDailyNotifications(body, habitCount);
      print("Notifications scheduled successfully.");
    } else {
      print("It's not time yet.");
    }
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
