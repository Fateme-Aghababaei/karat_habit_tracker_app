import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/repositories/user_repository.dart';

class HabitViewModel extends GetxController {
  final UserRepository _userRepository = UserRepository();
  final RxBool isLoading = false.obs;
  final RxMap<String, dynamic> streakData = <String, dynamic>{}.obs;


  Future<void> updateStreak() async {
    isLoading.value = true;
    try {
      final result = await _userRepository.updateStreak();
      if (result != null && result['state'] != 'unchanged') {
        streakData.value = result;
        _showStreakUpdateModal(result);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _showStreakUpdateModal(Map<String, dynamic> result) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Streak Update',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Your streak has ${result['state']} to ${result['streak']}!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
