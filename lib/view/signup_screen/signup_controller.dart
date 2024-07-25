import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
}
