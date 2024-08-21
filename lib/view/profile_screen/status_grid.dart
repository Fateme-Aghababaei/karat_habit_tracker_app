import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karat_habit_tracker_app/view/profile_screen/status_card.dart';

import '../../viewmodel/user_viewmodel.dart';

class StatusGrid extends StatelessWidget {
  final UserViewModel userViewModel;

  const StatusGrid({
    super.key,
    required this.userViewModel,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> statusItems = [
      {
        'image': 'assets/images/fire.png',
        'value': userViewModel.userProfile.value.streak,
        'label': 'توالی',
      },
      {
        'image': 'assets/images/coin.png',
        'value': userViewModel.userProfile.value.score,
        'label': 'سکه‌ها',
      },
      {
        'image': 'assets/images/puzzle.png',
        'value': userViewModel.userProfile.value.completedChallengesNum,
        'label': 'چالش شرکت کرده',
      },
      {
        'image': 'assets/images/dart.png',
        'value': userViewModel.userProfile.value.completedHabitsNum,
        'label': 'عادت تکمیل شده',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0.r,
        crossAxisSpacing: 12.0.r,
        childAspectRatio: 2,
      ),
      itemCount: statusItems.length,
      itemBuilder: (context, index) {
        return StatusCard(item: statusItems[index]);
      },
    );
  }
}
