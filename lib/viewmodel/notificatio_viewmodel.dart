import 'package:get/get.dart';
import '../model/entity/notification_model.dart';
import '../model/repositories/notification_repository.dart';

class NotificationViewModel extends GetxController {
  final NotificationRepository _notificationRepository = NotificationRepository();

  // متغیرهای مرتبط با UI
  var notifications = <Notification>[].obs;

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // دریافت لیست اعلان‌ها
  Future<void> fetchUserNotifications({int page = 1, int itemsPerPage = 7}) async {
    try {
      isLoading(true);
      errorMessage('');
      final List<Notification> fetchedNotifications = await _notificationRepository.getUserNotifications(
        page: page,
        itemsPerPage: itemsPerPage,
      );
      notifications.assignAll(fetchedNotifications);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  // دریافت تعداد اعلان‌های خوانده نشده


  // متدی برای تازه‌سازی اطلاعات
  Future<void> refreshNotifications() async {
    await fetchUserNotifications();
  }

  // فراخوانی اولیه در زمان ساخت کنترلر
  @override
  void onInit() {
    super.onInit();
    refreshNotifications();
  }
}
