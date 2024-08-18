import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karat_habit_tracker_app/utils/routes/AppRoutes.dart';
import '../../model/entity/challenge_model.dart';
import 'challenge_item.dart';

class AllChallengesPage extends StatelessWidget {
  final List<Challenge> challenges;

  AllChallengesPage({required this.challenges});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('چالش‌ها', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15.sp),),
        automaticallyImplyLeading: false,
        centerTitle: true,
          actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // تعداد ستون‌ها در هر سطر
                crossAxisSpacing: 8.0.r, // فاصله افقی بین آیتم‌ها
                mainAxisSpacing: 12.0.r, // فاصله عمودی بین آیتم‌ها
                childAspectRatio: 1.5, // نسبت ارتفاع به عرض آیتم‌ها
              ),
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                final challenge = challenges[index];
                return ChallengeItemWidget(challenge: challenge);
              },
            ),
          ),
        ),
      ),
    );
  }
}
