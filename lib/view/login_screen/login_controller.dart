import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/entity/user_model.dart';
import '../../model/repositories/account_repository.dart';
import '../../utils/routes/RouteNames.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  AccountRepository repo=AccountRepository();

  String? validateEmail(String? value) {
    if (value == null || value.trim()=='') {
      return 'لطفا پست الکترونیک خود را وارد کنید';
    } else if (!value.contains('@')) {
      return 'لطفا یک پست الکترونیک معتبر وارد کنید';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim()=='') {
      return 'لطفا رمز عبور خود را وارد کنید';
    } else if (value.length < 6) {
      return 'رمز عبور باید حداقل 6 کاراکتر باشد';
    }
    return null;
  }

  void registerUser() async {
    UserModel user=UserModel(
        email: emailController.text.trim().toLowerCase()
        ,password: passwordController.text.trim());
    repo.signIn(user);
    try{
      String? errorMassage= await repo.signIn(user);
      if(errorMassage==null){
        Get.offNamed(AppRouteName.habitScreen);
      }
      else{
        Get.snackbar('خطا', errorMassage,
          snackPosition: SnackPosition.TOP, // نمایش در بالای صفحه
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 10,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 3),);
      }
    }
    catch(e){}
  }
}
