import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Error extends StatelessWidget {
  final String? errorMessage;
  final String? errorDescription;


  const Error({
    super.key,
    this.errorMessage = 'متأسفیم، مشکلی رخ داده است!',
    this.errorDescription = 'ظاهراً در ارتباط شما با سرور مشکلی وجود دارد. لطفاً اتصال به اینترنت خود را بررسی کرده و دوباره تلاش کنید.',

  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 46.0.r),
              Image.asset(
                'assets/images/error.png', // مسیر ثابت تصویر
                width: screenWidth * 0.9,
                height: screenHeight * 0.4,
              ),
              SizedBox(height: 16.0.r),

              // متن خطا
              Text(
                errorMessage!,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0.r),

              // توضیح خطا
              Text(
                errorDescription!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),

              // دکمه بازگشت یا تلاش مجدد
              // ElevatedButton(
              //   onPressed: onRetry ?? () {
              //     Get.back();
              //   },
              //   style: ElevatedButton.styleFrom(
              //     minimumSize: Size(screenWidth * 0.4, 42.0.r),
              //   ),
              //   child: Text(
              //     'بازگشت',
              //     style: TextStyle(fontSize: 15.sp),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
