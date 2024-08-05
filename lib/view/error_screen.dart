import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/routes/RouteNames.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // تصویر خطا
              // Image.asset(
              //   'assets/images/error.png', // مسیر ثابت تصویر
              //   width: 150.w,
              //   height: 150.h,
              // ),
              // SizedBox(height: 24.h),

              // متن خطا
              Text(
                'مشکلی پیش آمده!',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),

              // توضیح خطا
              Text(
                'لطفاً دوباره تلاش کنید یا با پشتیبانی تماس بگیرید.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),

              // دکمه بازگشت
              ElevatedButton(
                onPressed: () {
                 Get.toNamed(AppRouteName.loginScreen);
                },
                child: Text(
                  'بازگشت',
                  style: TextStyle(fontSize: 16.sp),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(150.w, 40.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
