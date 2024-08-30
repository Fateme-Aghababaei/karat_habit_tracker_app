import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get_storage/get_storage.dart';
import 'model/repositories/notification_repository.dart';
import 'model/repositories/notification_service.dart';

Timer? periodicTimer;

Future<void> initializeService(Function(ServiceInstance) onStartCallback) async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStartCallback,
      isForegroundMode: false,
      autoStart: true,
      autoStartOnBoot: true,
      notificationChannelId: 'morning_reminder_channel',
      initialNotificationTitle: 'Background Service',
      initialNotificationContent: 'Service is running...',
      foregroundServiceNotificationId: 0,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStartCallback,
      onBackground: (service) {
        return true;
      },
    ),
  );

  service.startService();
}

Future<void> startPeriodicTimer() async {
  final box = GetStorage();

  // Cancel previous timer if active
  if (periodicTimer != null && periodicTimer!.isActive) {
    periodicTimer!.cancel();
  }

  final token = await box.read('auth_token');
  bool flag = false;

  periodicTimer = Timer.periodic(const Duration(minutes: 2), (timer) async {
    bool isNotifEnabled = box.read('isNotifEnabled') ?? true;

    if (!isNotifEnabled) {
      timer.cancel();
      print("Periodic timer cancelled due to notification disabled.");
      return;
    }

    final NotificationRepository notificationRepository = NotificationRepository();
    final now = DateTime.now();

    if (!flag && (now.hour == 12 || now.hour == 21)) {
      flag = true;
      int habitCount = await notificationRepository.fetchIncompleteHabitsCount();
      String body = now.hour == 9
          ? 'شما $habitCount وظیفه برای امروز دارید. با انرژی و انگیزه روزتان را آغاز کنید!'
          : 'شما هنوز $habitCount کار ناتمام دارید. قبل از پایان روز آنها را به اتمام برسانید!';

      await scheduleDailyNotifications(body, habitCount);
      print("Notifications scheduled successfully.");
    } else {
      print("It's not time yet.");
    }
  });
}
