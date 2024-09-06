import '../constant.dart';
import '../entity/habit_model.dart';
import '../entity/tag_model.dart';

class HabitRepository{

  Future<Tag?> addTag(String name, String color, String token) async {
    try {
      final response = await dio.post(
        'habit/add_tag/',
        data: {
          'name': name,
          'color': color,
        },
      );

      if (response.statusCode == 200) {
        return Tag.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to add tag: $e');
    }
  }

  Future<List<Tag>?> getUserTags() async {
    try {
      final response = await dio.get(
        'habit/get_user_tags/',
      );

      if (response.statusCode == 200) {
        List<Tag> tags = [];
        for (var tagData in response.data) {
          tags.add(Tag.fromJson(tagData));
        }
        return tags;
      } else {
        return [];      }
    } catch (e) {
      print('Error getting tags: $e');
      return null;
    }
  }

  Future<Habit?> addHabit({
    required String name,
    required String? description,
    required int? tagId,
    required String? dueDate,
    required bool isRepeated,
    required String? repeatedDays,
  }) async {
    try {
      final data = {
        'name': name,
        'description': description,
        'is_repeated': isRepeated,
      };
      if (dueDate != null) {
        data['due_date'] = dueDate;
      }
      if (tagId != null) {
        data['tag'] = tagId;
      }
      if (repeatedDays != null) {
        data['repeated_days'] =repeatedDays;
      }
      // داده‌ها را قبل از ارسال چاپ کنید
      print('Data to be sent: $data');
      final response = await dio.post(
        'habit/add_habit/',
        data: data
      );

      if (response.statusCode == 200) {
        return Habit.fromJson(response.data);
      } else {
        final errorMessage = response.data['error'] ?? 'عملیات به درستی انجام نشد، لطفاً دوباره تلاش کنید.';
        throw Exception(errorMessage);

      }
    } catch (e) {
      return null;
    }
  }

  Future<Habit?> editHabit({
    required int id,
    required String name,
    required String? description,
    required int? tagId,
    required String? dueDate,
    required bool isRepeated,
    required String? repeatedDays,
  }) async {
    try {
      final data = {
        'id': id,
        'name': name,
        'description': description,
        'is_repeated': isRepeated,
      };
      if (dueDate != null) {
        data['due_date'] = dueDate;
      }
      if (tagId != null) {
        data['tag'] = tagId;
      }
      if (repeatedDays != null) {
        data['repeated_days'] =repeatedDays;
      }
      final response = await dio.post(
        'habit/edit_habit/',
        data: data
      );
    print(response.data);
      if (response.statusCode == 200) {
        return Habit.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to edit habit: $e');
    }
  }

  Future<Habit?> getHabit(int id) async {
    try {
      final response = await dio.get(
        'habit/get_habit/',
        queryParameters: {
          'id': id,
        },
      );

      if (response.statusCode == 200) {
        return Habit.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to get habit: $e');
    }
  }

  Future<void> deleteHabit(int id) async {
    try {
      final response = await dio.delete('habit/delete_habit/', queryParameters: {'id': id});
print(response.statusMessage);
print(response.statusCode);
      if (response.statusCode != 200) {
        throw Exception('Failed to delete habit');
      }
      else{
        throw Exception();
      }
    } catch (e) {
      throw Exception('Failed to delete habit');
    }
  }

  Future<List<Habit>?> getUserHabits(String date) async {
    try {
      final response = await dio.get('habit/get_user_habits/', queryParameters: {'date': date});

      if (response.statusCode == 200) {
        List<Habit> habits = (response.data as List).map((item) => Habit.fromJson(item)).toList();
        return habits;
      }
      else{
        return null;
      }
    } catch (e) {
      print('Error fetching user habits: $e');
      return null;
    }
  }

  Future<Habit?> completeHabit(int id, String dueDate) async {
    try {
      final response = await dio.post('habit/complete_habit/', data: {
        'id': id,
        'due_date': dueDate,
      });

      if (response.statusCode == 200) {
        return Habit.fromJson(response.data);
      }
      else{
        return null;
      }
    } catch (e) {
      throw Exception('Error completing habit: $e');
    }
  }
}