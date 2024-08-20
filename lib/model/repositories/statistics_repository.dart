import 'package:karat_habit_tracker_app/model/entity/statistics_model.dart';

import '../constant.dart';

class StatisticsRepository {

  Future<List<Statistics>?> fetchStatistics() async {
    try {
      final response = await dio.get(
        'profile/statistics/',
      );

      if (response.statusCode == 200) {
        print(response.data);
        List<dynamic> data = response.data;
        return data.map((json) => Statistics.fromJson(json)).toList();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to load statistics: $e');
    }
  }
}
