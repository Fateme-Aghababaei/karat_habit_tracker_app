import 'package:flutter/material.dart';
import 'package:karat_habit_tracker_app/utils/routes/AppRoutes.dart';
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
        bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 1.obs,)
    );
  }
}
