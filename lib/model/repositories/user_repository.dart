import 'package:dio/dio.dart';
import 'package:karat_habit_tracker_app/model/constant.dart';

import '../entity/user_model.dart';

class UserRepository{
  Future<UserModel?> getUserProfile(String? username) async {
    try {
      Map<String, dynamic>? queryParams;
      if (username != null && username.isNotEmpty) {
        queryParams = {
          'username': username,
        };
      } else {
        queryParams = null;
      }
      Response response = await dio.get('profile/get_user/', queryParameters: queryParams);
      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        print(response.data['error']);
        return null;
      }
    } catch (e) {
      throw Exception('مشکلی در بارگذاری اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.');
    }
  }


  Future<List<List<Follow>>?> getFollowerFollowing(String? username) async {
    try {
      Map<String, dynamic>? queryParams;
      if (username != null && username.isNotEmpty) {
        queryParams = {
          'username': username,
        };
      } else {
        queryParams = null;
      }
      Response response = await dio.get(
        'profile/get_follower_following/',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        List<dynamic> followersJson = response.data['followers'];
        List<dynamic> followingsJson = response.data['followings'];
        List<Follow> followers = followersJson.map((json) => Follow.fromJson(json)).toList();
        List<Follow> followings = followingsJson.map((json) => Follow.fromJson(json)).toList();
        return [followers, followings];
      }
      else {
        print(response.data['error']);
        return null;
      }
    } catch (e) {
      throw Exception('مشکلی در بارگذاری اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.');
    }
  }


  Future<void> followUser(String username) async {
    try {
      final response = await dio.post(
        '$baseUrl/profile/follow/',
        data: {'username': username},
      );

      if (response.statusCode != 200) {
        print(response.data['error']);
        return;
      }
    } catch (e) {
      throw Exception('مشکلی در دنبال کردن کاربر وجود دارد، لطفاً دوباره تلاش کنید.');
    }
  }


  Future<void> unfollowUser(String username) async {
    try {
      final response = await dio.post(
        '$baseUrl/profile/unfollow/',
        data: {'username': username},
      );

      if (response.statusCode != 200) {
        print(response.data['error']);
        return;
      }
    } catch (e) {
      throw Exception('مشکلی در لغو دنبال کردن کاربر وجود دارد، لطفاً دوباره تلاش کنید.');
    }
  }

}


