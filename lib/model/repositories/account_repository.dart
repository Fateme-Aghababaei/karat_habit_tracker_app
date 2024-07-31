import 'package:dio/dio.dart';
import 'package:karat_habit_tracker_app/model/constant.dart';

import '../entity/user_model.dart';

class AccountRepository{
Future<String?> signup(AccountModel user) async {
  Response  response=await dio.post('profile/signup/',data: user);
  print(response.data);
  if(response.statusCode==200){
    return null;
  }else {
    return response.data['error'];
  }
}

Future<String?> signIn(AccountModel user) async {
  Response  response=await dio.post('profile/login/',data: user);
  print(response.data);
  if(response.statusCode==200){
    dio.options.headers["Authorization"]="Token ${response.data['token']}";
    return null;
  }else {
    return response.data['error'];
  }
}
}

