import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/view/components/Sidebar/Sidebar.dart';
import '../../viewmodel/habit_viewmodel.dart';
import '../components/AppBar.dart';
import '../components/BottomNavigationBar.dart';
import '../components/PersianHorizontalDatePicker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import '../components/Sidebar/SideBarController.dart';

class HabitPage extends StatelessWidget {
  final HabitViewModel habitViewModel = Get.put(HabitViewModel());
  final SideBarController sideBarController = Get.put(SideBarController());

  HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      habitViewModel.updateStreak();
    });

    return Scaffold(
      appBar: CustomAppBar(userScore: sideBarController.userScore),
    drawer: SideBar(),
      body: Padding(
        padding:  EdgeInsets.all(16.0.r),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.calendar_today_outlined,
                    color: Theme.of(context).colorScheme.secondaryFixed,
                  ),
                  onPressed: () async {
                    Jalali? picked = await showPersianDatePicker(
                      context: context,
                      initialDate: Jalali.now(),
                      firstDate: Jalali(1385, 8),
                      lastDate: Jalali(1450, 9),
                    );
                  },
                ),
              ),
              // SizedBox(height: 4.r), // فاصله بین آیکون و تقویم افقی
              buildPersianHorizontalDatePicker(
                startDate: DateTime.now().subtract(const Duration(days: 2)),
                endDate: DateTime.now().add(const Duration(days: 7)),
                initialSelectedDate: DateTime.now(),
                onDateSelected: (date) {},
                context: context,
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar( selectedIndex: 3.obs,),
    );
  }
}
