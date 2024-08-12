import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/view/components/Sidebar/Sidebar.dart';
import '../../viewmodel/habit_viewmodel.dart';
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
              margin:  EdgeInsets.only(left: 22.0.r),
              padding:  EdgeInsets.only(left: 1.0.r, right: 6.0.r),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Obx(() {
                    return AnimatedFlipCounter(
                      duration: Duration(milliseconds: 400),
                      value: sideBarController.userScore.value,
                      padding:  EdgeInsets.all(1),
                      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontFamily: "IRANYekan_number",
                      ),
                    );
                  }),
                  SizedBox(width: 4.0.r),
                  Image.asset(
                    'assets/images/coin.png',
                    width: 28.0.r,
                    height: 28.0.r,
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
