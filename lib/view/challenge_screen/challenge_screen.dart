import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/utils/routes/AppRoutes.dart';
import 'package:karat_habit_tracker_app/viewmodel/challenge_viewmodel.dart';
import '../components/AppBar.dart';
import '../components/BottomNavigationBar.dart';
import '../components/Sidebar/Sidebar.dart';
import '../error_screen.dart';
import 'Participate_item.dart';
import 'addChallenge.dart';
import 'allChallenges.dart';
import 'add_challenge_controller.dart';
import 'challenge_item.dart';

class ChallengePage extends StatelessWidget {
  final ChallengeViewModel challengeViewModel = Get.put(ChallengeViewModel());
  ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(userScore: challengeViewModel.sideBarController.userScore),
      drawer: SideBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.r),
        child: Center(
          child: Obx(() {
            if (challengeViewModel.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
             if (challengeViewModel.fetchError.value) {
              return  FractionallySizedBox(widthFactor: 1.0.r, // اندازه عرض ویجت Error را به 80% عرض کانتینر تنظیم می‌کند
                  heightFactor: 0.9.r,child: const Error());
            }else {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SizedBox(height: 10.0.r,),
                    // بخش چالش‌های جدید
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'چالش‌های جدید',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to( AllChallengesPage(challengeViewModel: challengeViewModel,));
                          },
                          child: Text(
                            'مشاهده همه',
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.0.r),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.23,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: challengeViewModel.challenges.length > 5
                            ? 5
                            : challengeViewModel.challenges.length,
                        itemBuilder: (context, index) {
                          final challenge = challengeViewModel.challenges[
                          challengeViewModel.challenges.length - 1 - index];
                          return ChallengeItemWidget(challenge: challenge,challengeViewModel: challengeViewModel,);
                        },
                      ),
                    ),
                    SizedBox(height: 24.0.r),
                    // بخش چالش‌های من
                    Text(
                      'چالش‌های من',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(height: 8.0.r),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.32, // ارتفاع معین برای بخش "چالش‌های من"
                      child: challengeViewModel.participatedChallenges.isEmpty
                          ? const Center(child: Text('شما در هیچ چالشی شرکت نکرده‌اید.'))
                          : ListView.builder(
                        itemCount: challengeViewModel.participatedChallenges.length,
                        itemBuilder: (context, index) {
                          final challenge = challengeViewModel.participatedChallenges[index];
                          return ParticipatedChallengeItemWidget(challenge: challenge,challengeViewModel: challengeViewModel,);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0.r, vertical: 8.0.r),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(94.0.r),
            ),
            onPressed: () {
              _showAddChallengeBottomSheet(context);
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 1.obs),
    );
  }

  void _showAddChallengeBottomSheet(BuildContext context) {
    final controller = Get.put(AddChallengeController(challengeViewModel: challengeViewModel));
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddChallengeBottomSheet(controller: controller);
      },
    ).whenComplete(() {
      controller.resetForm();
    });
  }
}
