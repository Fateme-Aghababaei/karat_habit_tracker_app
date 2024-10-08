import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karat_habit_tracker_app/model/entity/onboarding_items.dart';
import 'package:karat_habit_tracker_app/utils/routes/AppRoutes.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onBoardingScreen extends StatefulWidget {
  const onBoardingScreen({super.key});

  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  // controller to keep track of which page we are on
  final controller = OnboardingItems();
  final _pageController = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: isLastPage
            ? AppBar()
            : AppBar(
                actions: [
                  TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(3);
                    },
                    child:  Text('رد شدن',
                      style:   TextStyle(
                        fontFamily: "IRANYekan",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                      ),),
                  ),
                ],
              ),
        bottomSheet: Padding(
          padding: EdgeInsets.only(bottom: 20.0.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0.r, vertical: 10.0.r),
            width: screenWidth,
            child: isLastPage
                ? authButtons()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.maxFinite, 40.0.r)),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text(
                      'ادامه',
                    ),
                  ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(30.0.r),
          child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = index == controller.items.length - 1),
            itemCount: controller.items.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        controller.items[index].image,
                        height: screenHeight * 0.36,
                        width: screenWidth * 0.8,
                      ),
                      SizedBox(height: 28.0.r),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: 4,
                        effect: ExpandingDotsEffect(
                            activeDotColor: Theme.of(context).primaryColor,
                            dotHeight: 5.5.r),
                      )
                    ],
                  ),
                  SizedBox(height: 80.0.r),
                  Text(controller.items[index].title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 18.sp
                      ),
                      //overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center),
                  SizedBox(height: 24.0.r),
                  Text(controller.items[index].description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 16.sp
                      ),
                      textAlign: TextAlign.center),
                ],
              );
            },
          ),
        ));
  }

  // sign up and login button
  Widget authButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(double.maxFinite, 40.0.r)),
          onPressed: () {
           Get.offNamed(AppRouteName.signUpScreen);
          },
          child: const Text('ثبت نام'),
        ),
        SizedBox(height: 8.0.r),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              minimumSize: Size(double.maxFinite, 40.0.r)),
          onPressed: () {
           Get.offNamed(AppRouteName.loginScreen);
          },
          child: const Text('ورود'),
        ),
      ],
    );
  }
}
