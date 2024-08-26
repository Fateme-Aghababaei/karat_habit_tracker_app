import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../constant.dart';
import '../entity/notification_model.dart';

class NotificationRepository {


  Future<List<Notification>> getUserNotifications({int page = 1, int itemsPerPage = 7}) async {
    try {
      final response = await dio.get(
        'notification/get_user_notifications/',
        queryParameters: {
          'page': page,
          'item_per_page': itemsPerPage,
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((notification) => Notification.fromJson(notification)).toList();
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }

  Future<int> getUnreadNotificationsCount() async {
    try {
      final response = await dio.get('notification/get_unread_notifications_count/');

      if (response.statusCode == 200) {
        return response.data['count'];
      } else {
        throw Exception('Failed to load unread notifications count');
      }
    } catch (e) {
      throw Exception('Error during request: $e');
    }
  }



  Future<int> fetchIncompleteHabitsCount() async {
    final box = GetStorage();
    final token = box.read('auth_token');
    try {

      final response = await dio.get('habit/get_incomplete_habits_count/',options: Options(
        headers: {
          'Authorization': "Token ${token}",
        },
      ),);

      if (response.statusCode == 200) {
        return response.data['count'];
      }
      else{
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}
