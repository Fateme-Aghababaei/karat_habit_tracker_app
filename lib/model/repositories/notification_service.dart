import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get_storage/get_storage.dart';
import 'notification_repository.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void initializeTimeZones() {
}

Future<void> initializeNotifications() async {
   const AndroidInitializationSettings initializationSettingsAndroid =
   AndroidInitializationSettings('@mipmap/ic_launcher'); // نام فایل آیکون خودتان را وارد کنید

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  // Request notification permission for Android 13+ (if applicable)
  if (Platform.isAndroid && await _isAndroid13OrHigher()) {
    await _requestNotificationPermission();
  }
}

Future<void> _requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.request();
  if (status != PermissionStatus.granted) {
    // Handle the case where the user denies the permission.
    print("Notification permission denied");
  }
}

Future<bool> _isAndroid13OrHigher() async {
  return Platform.isAndroid && (await _getAndroidSdkVersion()) >= 33;
}

Future<int> _getAndroidSdkVersion() async {
  var release = await Process.run('getprop', ['ro.build.version.sdk']);
  return int.parse(release.stdout.trim());
}

Future<void> scheduleDailyNotifications(String body, int habitCount) async {

  if (habitCount==0) return;
  await flutterLocalNotificationsPlugin.show(
    0,
    'یادآوری ',
    body,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'morning_reminder_channel',
        'Morning Reminder',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );
}

