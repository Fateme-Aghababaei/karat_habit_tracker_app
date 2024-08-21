import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';
import 'package:karat_habit_tracker_app/viewmodel/streak_viewmodel.dart';
import '../model/constant.dart';
import 'components/Sidebar/SideBarController.dart';

class SplashScreen extends StatelessWidget {
  final box = GetStorage();

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1), () {
        checkLoginStatus();
      });
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/carrot.png',
             // height: screenHeight * 0.5,
              width: screenWidth * 0.56,
            ),
           SizedBox(height:10.r),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                   'کـــارات',
                  textStyle: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 36.sp,),
                  speed: const Duration(milliseconds: 110),
                ),

              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 0),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            SizedBox(height:50.r),

          ],
        ),
      ),
    );
  }

  void checkLoginStatus() {
    final token = box.read('auth_token');
    if (token != null) {
      dio.options.headers["Authorization"] = "Token ${token}";
      Get.offNamed(AppRouteName.habitScreen);
    } else {
      Get.offNamed(AppRouteName.onBoardingScreen);
    }
  }
}
