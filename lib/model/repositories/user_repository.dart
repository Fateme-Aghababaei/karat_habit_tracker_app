import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karat_habit_tracker_app/model/constant.dart';
import '../entity/follower_following_model.dart';
import '../entity/user_model.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';



class UserRepository {
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
      Response response = await dio.get(
          'profile/get_user/', queryParameters: queryParams);
      if (response.statusCode == 200) {
        UserModel profile = UserModel.fromJson(response.data);
        return profile;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(
          'مشکلی در بارگذاری اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.');
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
        return friends;
      }
      else {
        return null;
      }
    } catch (e) {
      print(e);
      throw Exception(
          'مشکلی در بارگذاری اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.');
    }
  }


  Future<String?> followUser(String username) async {
    print(username);
    try {
      final response = await dio.post(
        'profile/follow/',
        data: {'username': username},
      );
      print(response.realUri);
      print('Data sent: ${response.requestOptions.data}');
      if (response.statusCode != 200) {
        return null;
      }
    } catch (e) {
      throw Exception(
          'مشکلی در دنبال کردن کاربر وجود دارد، لطفاً دوباره تلاش کنید.');
    }
    return "";
  }


  Future<String?> unfollowUser(String username) async {
    try {
      final response = await dio.post(
        'profile/unfollow/',
        data: {'username': username},
      );

      if (response.statusCode != 200) {
        return null;
      }
    } catch (e) {
      throw Exception(
          'مشکلی در لغو دنبال کردن کاربر وجود دارد، لطفاً دوباره تلاش کنید.');
    }
    return "";
  }

  Future<String?> logout() async {
    try {
      final box = GetStorage();

      final response = await dio.get(
        'profile/logout/',);

      if (response.statusCode != 200) {
        return null;
      }
      else {
        dio.options.headers.remove("Authorization");
        box.remove('auth_token');
      }
    } catch (e) {
      throw Exception(
          'مشکلی در خروج از حساب کاربری وجود دارد، لطفاً دوباره تلاش کنید.');
    }
    return "";
  }

  Future<String?> editProfile({
    required String firstName,
    required String username,
    required bool notifEnabled,
  }) async {
    try {
      final response = await dio.post(
        'profile/edit_profile/',
        data: {
          'first_name': firstName,
          'username': username,
          'notif_enabled': notifEnabled,
        },
      );
      if (response.statusCode != 200) {
        return null;
      }
    } catch (e) {
      throw Exception(
          'مشکلی در ویرایش اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.');
    }
    return "";
  }


  Future<File> compressImage(String filePath) async {
    final directory = await getTemporaryDirectory();
    final targetPath = path.join(directory.path,
        '${path.basenameWithoutExtension(filePath)}_compressed.jpg');

    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      filePath,
      targetPath,
      quality: 90, // کیفیت فشرده‌سازی
      minWidth: 900, // حداقل عرض تصویر پس از فشرده‌سازی
      minHeight: 800, // حداقل ارتفاع تصویر پس از فشرده‌سازی
    );

    return File(compressedFile!.path);
  }

  Future<String?> changePhoto({String? photo}) async {
    try {
      FormData formData;

      if (photo != null) {
        File file = File(photo);

        int fileSize = await file.length();
        print('Original File size: $fileSize bytes');

        if (fileSize > 1024 * 1024) {
          file = await compressImage(photo);
          print('Compressed File size: ${await file.length()} bytes');
        }

        formData = FormData.fromMap({
          'photo': await MultipartFile.fromFile(
              file.path, filename: path.basename(file.path)),
        });
      } else {
        formData = FormData.fromMap({
          'photo': null, // یا داده مناسب برای حذف عکس
        });
      }

      final response = await dio.post(
        'profile/change_photo/',
        data: formData,
      );
      if (response.statusCode != 200) {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(
          'مشکلی در ویرایش اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.');
    }
    return "";
  }

  Future<Map<String, dynamic>?> updateStreak() async {
    try {
      final response = await dio.get(
        'profile/update_streak/',);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print("Error updating streak: $e");
      return null;
    }
  }

  Future<UserModel?> getUserBrief() async {
    try {

      Response response = await dio.get(
          'profile/get_user_brief/', queryParameters: {'username':null});
      if (response.statusCode == 200) {
        UserModel profileBrief = UserModel.fromJson(response.data);
        return profileBrief;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(
          'مشکلی در بارگذاری اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.');
    }
  }

}
