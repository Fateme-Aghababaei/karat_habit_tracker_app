import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../viewmodel/habit_viewmodel.dart';
import '../components/BottomNavigationBar.dart';
import '../components/PersianHorizontalDatePicker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class HabitPage extends StatelessWidget {
  final HabitViewModel habitViewModel = Get.put(HabitViewModel());

  HabitPage({super.key});

  @override
  Widget build(BuildContext context) {
    // هنگام ورود به برنامه API را فراخوانی می‌کنیم
    WidgetsBinding.instance.addPostFrameCallback((_) {
      habitViewModel.updateStreak();
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
