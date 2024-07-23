import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karat_habit_tracker_app/model/entity/onboarding_items.dart';
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
            ? null
            : AppBar(
                actions: [
                  TextButton(
                    onPressed: () {
                      _pageController.jumpToPage(2);
                    },
                    child: const Text('رد شدن'),
                  ),
                ],
              ),
        bottomSheet: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: MediaQuery.of(context).size.width,
          child: isLastPage
              ? authButtons()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40)),
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
        body: Container(
          margin: const EdgeInsets.all(15),
          child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = index == controller.items.length - 1),
            itemCount: controller.items.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        controller.items[index].image,
                        height: screenHeight * 0.6,
                        width: screenWidth * 0.8,
                      ),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                            activeDotColor: Theme.of(context).primaryColor,
                            dotHeight: 8),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(controller.items[index].title,
                      style: Theme.of(context).textTheme.headlineLarge,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center),
                  const SizedBox(height: 15),
                  Text(controller.items[index].description,
                      style: Theme.of(context).textTheme.displaySmall,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center),
                ],
              );
            },
          ),

          // Container(
          //   alignment: Alignment(0, 0.5),
          //     child: SmoothPageIndicator(controller: _pageController, count: 3)
          // ),
        ));
  }

  // sign up and login button
  Widget authButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            // Navigate to the sign up screen
          },
          child: const Text('ثبت نام'),
        ),
        OutlinedButton(
          onPressed: () {
            // Navigate to the login screen
          },
          child: const Text('ورود'),
        ),
      ],
    );
  }
}
