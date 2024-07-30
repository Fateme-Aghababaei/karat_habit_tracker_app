import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/model/entity/user_model.dart';
import 'package:karat_habit_tracker_app/model/repositories/account_repository.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'لطفا تکرار رمز عبور خود را وارد کنید';
    } else if (value != passwordController.text) {
      return 'رمز عبور و تکرار آن مطابقت ندارند';
    }
    return null;
  }

  void registerUser() async {
    UserModel user=UserModel(email: emailController.text,password: passwordController.text);
    repo.signup(user);
    try{
      String? errorMassage= await repo.signup(user);
      if(errorMassage==null){

      }
      else{
        Get.snackbar('Error', errorMassage);
      }
    }
    catch(e){}
  }

}
