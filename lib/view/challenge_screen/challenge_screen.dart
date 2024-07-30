import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';
import 'package:karat_habit_tracker_app/view/signup_screen/signup_controller.dart';

import '../components/BottomNavigationBar.dart';

class ChallengePage extends StatefulWidget {
  ChallengePage({super.key});

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar()
    );
  }
}
