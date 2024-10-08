import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final RxInt selectedIndex ;
  final List<String> routeNames = [
    AppRouteName.statisticsScreen,
    AppRouteName.challengeScreen,
    AppRouteName.trackScreen,
    AppRouteName.habitScreen,
  ];

   CustomBottomNavigationBar({super.key,required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent, // تنظیم splashColor به transparent
      ),
      child: Obx(() {
        return BottomNavigationBar(
          currentIndex: selectedIndex.value,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 0.6.r, // ضخامت خط طوسی
                    color: Theme.of(context).colorScheme.outline, // رنگ خط طوسی
                  ),
                  selectedIndex.value == 0
                      ? Container(
                    height: 4.0.r,
                    width: 40.0.r,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6.0.r),
                        bottomRight: Radius.circular(6.0.r),
                      ),
                    ),
                  )
                      : Container(height: 4.0.r),
                  SizedBox(height: 10.0.r),
                  SvgPicture.asset(
                    'assets/icon/bar-chart.svg',
                    color: selectedIndex.value == 0
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
                  SizedBox(height: 4.0.r)
                ],
              ),
              label: 'گزارش عملکرد',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 0.6.r, // ضخامت خط طوسی
                    color: Theme.of(context).colorScheme.outline, // رنگ خط طوسی
                  ),
                  selectedIndex.value == 1
                      ? Container(
                    height: 4.0.r,
                    width: 40.0.r,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6.0.r),
                        bottomRight: Radius.circular(6.0.r),
                      ),
                    ),
                  )
                      : Container(height: 4.0.r),
                  SizedBox(height: 10.0.r),
                  SvgPicture.asset(
                    'assets/icon/puzzle-piece.svg',
                    color: selectedIndex.value == 1
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
                  SizedBox(height: 4.0.r)
                ],
              ),
              label: 'چالش‌ها',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 0.6.r, // ضخامت خط طوسی
                    color: Theme.of(context).colorScheme.outline, // رنگ خط طوسی
                  ),
                  selectedIndex.value == 2
                      ? Container(
                    height: 4.0.r,
                    width: 40.0.r,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6.0.r),
                        bottomRight: Radius.circular(6.0.r),
                      ),
                    ),
                  )
                      : Container(height: 4.0.r),
                  SizedBox(height: 10.0.r),
                  SvgPicture.asset(
                    'assets/icon/clock-stopwatch.svg',
                    color: selectedIndex.value == 2
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
                  SizedBox(height: 4.0.r)
                ],
              ),
              label: 'ردیابی',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 0.6.r, // ضخامت خط طوسی
                    color: Theme.of(context).colorScheme.outline, // رنگ خط طوسی
                  ),
                  selectedIndex.value == 3
                      ? Container(
                    height: 4.0.r,
                    width: 40.0.r,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(6.0.r),
                        bottomRight: Radius.circular(6.0.r),
                      ),
                    ),
                  )
                      : Container(height: 4.0.r),
                  SizedBox(height: 10.0.r),
                  SvgPicture.asset(
                    'assets/icon/target.svg',
                    color: selectedIndex.value == 3
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
                  SizedBox(height: 4.0.r)
                ],
              ),
              label: 'عادت‌ها',
            ),
          ],
          selectedIconTheme: IconThemeData(
            size: 24.sp,
          ),
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).disabledColor,
          onTap: (index) {
            if (selectedIndex.value != index) {
              selectedIndex.value = index;
              Get.offNamed(routeNames[index]);
            }
          },
          enableFeedback: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          selectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 12.5.sp,
          ),
          unselectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 12.sp,
          ),
        );
      }),
    );
  }
}
