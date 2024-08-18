import '../constant.dart';
import '../entity/challenge_model.dart';

class ChallengeRepository {

  // اضافه کردن چالش جدید
  Future<Challenge?> addChallenge({
    required String name,
    required String description,
    required String startDate,
    required String endDate,
    String? photo,
  }) async {
    try {
      final response = await dio.post(
        'challenge/add_challenge/',
        data: {
          'name': name,
          'description': description,
          'start_date': startDate,
          'end_date': endDate,
          'photo': photo,
        },
      );

      if (response.statusCode == 200) {
        return Challenge.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to add challenge: $e');
    }
  }

  // افزودن عادت به چالش
  Future<Challenge?> appendHabit({
    required int challengeId,
    required int habitId,
  }) async {
    try {
      final response = await dio.post(
        'challenge/append_habit/',
        data: {
          'challenge_id': challengeId,
          'habit_id': habitId,
        },
      );

      if (response.statusCode == 200) {
        return Challenge.fromJson(response.data);
      } else if (response.statusCode == 404) {
        throw Exception(response.data['error']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to append habit to challenge: $e');
    }
  }

  // ویرایش چالش
  Future<Challenge?> editChallenge({
    required int id,
    required String name,
    required String description,
    required String startDate,
    required String endDate,
    String? photo,
  }) async {
    try {
      final response = await dio.post(
        'challenge/edit_challenge/',
        data: {
          'id': id,
          'name': name,
          'description': description,
          'start_date': startDate,
          'end_date': endDate,
          'photo': photo,
        },
      );

      if (response.statusCode == 200) {
        return Challenge.fromJson(response.data);
      } else if (response.statusCode == 400) {
        throw Exception(response.data['error']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to edit challenge: $e');
    }
  }

  // حذف عادت از چالش
  Future<Challenge?> removeHabit({
    required int challengeId,
    required int habitId,
  }) async {
    try {
      final response = await dio.post(
        'challenge/remove_habit/',
        data: {
          'challenge_id': challengeId,
          'habit_id': habitId,
        },
      );

      if (response.statusCode == 200) {
        return Challenge.fromJson(response.data);
      } else if (response.statusCode == 404) {
        throw Exception(response.data['error']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to remove habit from challenge: $e');
    }
  }

  // شرکت در چالش
  Future<Challenge?> participateInChallenge({
    required int challengeId,
  }) async {
    try {
      final response = await dio.post(
        'challenge/participate/',
        queryParameters: {
          'id': challengeId,
        },
      );

      if (response.statusCode == 200) {
        return Challenge.fromJson(response.data);
      } else if (response.statusCode == 404 || response.statusCode == 400 || response.statusCode == 409) {
        throw Exception(response.data['error']);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to participate in challenge: $e');
    }
  }

  // دریافت چالش‌ها
  Future<List<Challenge>?> getActiveChallenges() async {
    try {
      final response = await dio.get('challenge/get_active_challenges/');
      print(response.data);
      if (response.statusCode == 200) {
        List<Challenge> challenges = (response.data as List).map((item) => Challenge.fromJson(item)).toList();
        return challenges;
      } else {
        return null;
      }
    } catch (e) {
       throw Exception('Error fetching challenges: $e');
    }
  }

  // دریافت چالش‌های شرکت کرده
  Future<List<Challenge>?> getParticipatedChallenges() async {
    try {
      final response = await dio.get('challenge/get_participated_challenges/',queryParameters:{'active':true});
      if (response.statusCode == 200) {
        List<Challenge> challenges = (response.data as List).map((item) => Challenge.fromJson(item)).toList();

        return challenges;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching participated challenges: $e');
    }
  }

  // حذف چالش
  Future<void> deleteChallenge(int id) async {
    try {
      final response = await dio.delete(
        'challenge/delete_challenge/',
        queryParameters: {
          'id': id,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete challenge');
      }
    } catch (e) {
      throw Exception('Failed to delete challenge: $e');
    }
  }

  Future<Challenge?> getChallengeByIdOrCode({int? id, String? code,})
  async {
    try {
      final queryParams = <String, dynamic>{};
      if (id != null) {
        queryParams['id'] = id;
      } else if (code != null) {
        queryParams['code'] = code;
      } else {
        throw Exception('Either id or code must be provided');
      }

      final response = await dio.get(
        'challenge/get_challenge/',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        return Challenge.fromJson(response.data);
      } else if (response.statusCode == 404) {
        throw Exception('Challenge not found');
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to fetch challenge: $e');
    }
  }
}
