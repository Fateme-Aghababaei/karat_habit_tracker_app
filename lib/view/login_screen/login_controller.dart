import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/entity/account_model.dart';
import '../../model/repositories/account_repository.dart';
import '../../utils/routes/RouteNames.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool  isLoading = false.obs;
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
    isLoading.value = true;
    AccountModel user = AccountModel(
        email: emailController.text.trim().toLowerCase()
        , password: passwordController.text.trim());

    repo.signIn(user);

    try {
      String? errorMassage = await repo.signIn(user);
      isLoading.value = false;

      if (errorMassage == null) {
        Get.offNamed(AppRouteName.profileScreen);
      } else {
        Get.snackbar('خطا', errorMassage,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8,
          margin: EdgeInsets.all(6.r),
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('خطا',
        ' ظاهرا در ارتباط شما با سرور مشکلی وجود دارد، لطفا دوباره تلاش کنید.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8,
        margin: EdgeInsets.all(6.r),
        duration: const Duration(seconds: 3),
      );
    }
  }
}
