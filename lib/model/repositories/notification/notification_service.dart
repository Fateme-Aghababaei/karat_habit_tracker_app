import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Create the notification channel for Android 8.0+
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'dailyHabitCheckChannel', // id
      'Daily Habit Check', // name
      description: 'Channel for daily habit check notifications', // description
      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> showNotification(int id, String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'dailyHabitCheckChannel', // id کانال نوتیفیکیشن
      'Daily Habit Check', // نام کانال
      channelDescription: 'Channel for daily habit check notifications',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,         // شناسه نوتیفیکیشن
      title,      // عنوان نوتیفیکیشن
      body,       // متن نوتیفیکیشن
      platformChannelSpecifics, // تنظیمات پلتفرم نوتیفیکیشن
    );
  }
}
