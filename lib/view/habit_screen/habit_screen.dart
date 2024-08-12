import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/view/components/Sidebar/Sidebar.dart';
import '../../viewmodel/habit_viewmodel.dart';
import '../components/BottomNavigationBar.dart';
import '../components/PersianHorizontalDatePicker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../components/Sidebar/SideBarController.dart';

class HabitPage extends StatelessWidget {
  final HabitViewModel habitViewModel = Get.put(HabitViewModel());
  final SideBarController Controller = Get.find<SideBarController>();

  HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    // هنگام ورود به برنامه API را فراخوانی می‌کنیم
    WidgetsBinding.instance.addPostFrameCallback((_) {
      habitViewModel.updateStreak();
    });

    return Scaffold(
      appBar: AppBar(
        titleSpacing: -8,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'کـارات',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Container(
              margin: EdgeInsets.only(left: 16.0),
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Obx(() {
                    return Text(
                      Controller.userScore.value.toString(), // مقدار امتیاز
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                      ),
                    );
                  }),
                  SizedBox(width: 4.0),
                  Image.asset(
                    'assets/images/profile.png', // مسیر آیکون امتیاز
                    width: 24.0,
                    height: 24.0,
                  ),
                ],
              ),
            ),

          ],
        ),
        // actions: [
        //   Builder(
        //     builder: (context) {
        //       return IconButton(
        //         icon: Icon(Icons.menu),
        //         onPressed: () => Scaffold.of(context).openDrawer(),
        //       );
        //     },
        //   ),
        // ],
      ),
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
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
