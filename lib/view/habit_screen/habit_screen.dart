import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../components/BottomNavigationBar.dart';
import '../components/PersianHorizontalDatePicker.dart';

class HabitPage extends StatefulWidget {
  const HabitPage({super.key});

  @override
  State<HabitPage> createState() => _HabitPageState();
}

class _HabitPageState extends State<HabitPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildPersianHorizontalDatePicker(
            startDate: DateTime.now().subtract(Duration(days: 2)),
        endDate: DateTime.now().add(Duration(days: 14)),
        initialSelectedDate: DateTime.now(),
        onDateSelected: (date) {}, context: context
            )
          // Handle date selection
          ]
        ),
      ),
        bottomNavigationBar: CustomBottomNavigationBar(),
    );


  }
}
