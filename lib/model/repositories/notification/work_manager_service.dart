import 'package:get_storage/get_storage.dart';
import 'package:workmanager/workmanager.dart';
import '../notification_repository.dart';
import 'notification_service.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final NotificationService notificationService = NotificationService();
    await notificationService.init();

    final box = GetStorage();
    final bool isNotifEnabled = box.read('isNotifEnabled') ?? true;
    final NotificationRepository notificationRepository = NotificationRepository();

    if (isNotifEnabled) {
      try {
        final int count = await notificationRepository.fetchIncompleteHabitsCount();

        String title;
        String body;

        if (task == 'morningHabitCheck') {
          title = 'یادآوری';
          body = 'شما $count وظیفه برای امروز دارید. با انرژی و انگیزه روزتان را آغاز کنید!';
        } else if (task == 'eveningHabitCheck') {
          title = 'یادآوری';
          body = 'شما هنوز $count کار ناتمام دارید. قبل از پایان روز آنها را به اتمام برسانید!';
        } else {
          return Future.value(false);  // وظیفه نامعتبر
        }

        if (count > 0) {
          await notificationService.showNotification(
            task == 'morningHabitCheck' ? 0 : 1, // شناسه متفاوت برای هر نوتیفیکیشن
            title,
            body,
          );
        }
      } catch (e) {
        // چاپ خطا در کنسول به جای نشان دادن نوتیفیکیشن
        print('Error during habit count fetch: $e');
      }
    }

    return Future.value(true);
  });
}

class WorkManagerService {
  static final WorkManagerService _instance = WorkManagerService._internal();

  factory WorkManagerService() {
    return _instance;
  }

  WorkManagerService._internal();

  void init() {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: true,
    );
  }

  void scheduleDailyTasks() {
    // وظیفه برای ساعت 9 صبح
    Workmanager().registerPeriodicTask(
      "morningHabitCheck",  // uniqueWorkName
      "morningHabitCheck",
      frequency: const Duration(hours: 24),
      initialDelay: const Duration(hours: 9), // شروع از ساعت 9 صبح
    );

    // وظیفه برای ساعت 9 شب
    Workmanager().registerPeriodicTask(
      "eveningHabitCheck",  // uniqueWorkName
      "eveningHabitCheck",
      frequency: const Duration(hours: 24),
      initialDelay: const Duration(seconds: 10), // شروع از ساعت 9 شب
    );
  }
}
