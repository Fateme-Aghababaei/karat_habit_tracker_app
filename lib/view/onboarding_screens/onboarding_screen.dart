import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isLastPage? null : AppBar(
        backgroundColor: Colors.white,
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
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: MediaQuery.of(context).size.width,
        child: isLastPage? authButtons() : FilledButton(onPressed: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }, child: const Text(
              'ادامه',
              style: TextStyle(color: Colors.white),
            )),
      ),

      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(15),
        child: PageView.builder(
          onPageChanged: (index) => setState(()=> isLastPage = index == controller.items.length - 1),
            itemCount: controller.items.length,
            controller: _pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.asset(controller.items[index].image, height: 300),
                      SmoothPageIndicator(controller: _pageController, count: 3)
                    ],
                  ),

                  const SizedBox(height: 15),
                  Text(controller.items[index].title),
                  const SizedBox(height: 15),
                  Text(controller.items[index].description),
                ],
              );
            },
          ),

          // Container(
          //   alignment: Alignment(0, 0.5),
          //     child: SmoothPageIndicator(controller: _pageController, count: 3)
          // ),
      )
    );
  }

  // sign up and login button
  Widget authButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FilledButton(
          onPressed: () {
            // Navigate to the sign up screen
          },
          child: const Text('ثبت نام', style: TextStyle(color: Colors.white)),
        ),
        OutlinedButton(
          onPressed: () {
            // Navigate to the login screen
          },
          child: const Text('ورود', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}