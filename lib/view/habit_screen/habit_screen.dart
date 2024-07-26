import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';
import 'package:karat_habit_tracker_app/view/signup_screen/signup_controller.dart';

import '../components/BottomNavigationBar.dart';

class HabitPage extends StatefulWidget {
  HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: CustomBottomNavigationBar()
    );
  }
}
