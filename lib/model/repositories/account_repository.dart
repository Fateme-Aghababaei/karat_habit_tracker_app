import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karat_habit_tracker_app/model/constant.dart';

import '../entity/account_model.dart';

class AccountRepository{
  Future<String?> signup(AccountModel user) async {
    try {
      Response response = await dio.post('profile/signup/', data: user.toJson());
      print(response.data);
      if (response.statusCode == 200) {
        dio.options.headers["Authorization"] = "Token ${response.data['token']}";
        final box = GetStorage();
        box.write('username', response.data['username']);
        return null;
      } else {
        return response.data['error'];
      }
    } catch (e) {
      print("Error during signup: $e");
      return "ظاهرا در ارتباط شما با سرور مشکلی وجود دارد، لطفا دوباره تلاش کنید.";
    }
  }

  Future<String?> signIn(AccountModel user) async {
    try {
      Response response = await dio.post('profile/login/', data: user.toJson());
      print(response.data);

      if (response.statusCode == 200) {
        dio.options.headers["Authorization"] = "Token ${response.data['token']}";
        final box = GetStorage();
        box.write('username', response.data['username']);
        return null;
      } else {
        return response.data['error'];
      }
    } catch (e) {
      print("Error during sign in: $e");
      return "ظاهرا در ارتباط شما با سرور مشکلی وجود دارد، لطفا دوباره تلاش کنید.";
    }
  }
}

