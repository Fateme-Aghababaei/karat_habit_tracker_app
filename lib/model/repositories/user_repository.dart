import 'package:dio/dio.dart';
import 'package:karat_habit_tracker_app/model/constant.dart';
import '../entity/follower_following_model.dart';
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
      print(response.statusCode);
      if (response.statusCode == 200) {
        UserModel profile = UserModel.fromJson(response.data);
        print("Parsed user profile: $profile");
        return profile;
      } else {
        print(response.data['error']);
        return null;
      }
    } catch (e) {
      throw Exception('مشکلی در بارگذاری اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.');
    }
  }


  Future<Follower_Following?> getFollowerFollowing(String? username) async {
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
        Follower_Following friends = Follower_Following.fromJson(response.data);
        List<dynamic> followersJson = response.data['followers'];
        List<dynamic> followingsJson = response.data['followings'];
        List<Follow> followers = followersJson.map((json) => Follow.fromJson(json)).toList();
        List<Follow> followings = followingsJson.map((json) => Follow.fromJson(json)).toList();
        return friends;
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


