import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/view/components/Sidebar/Sidebar.dart';
import '../../model/entity/habit_model.dart';
import '../../viewmodel/habit_viewmodel.dart';
import '../components/AppBar.dart';
import '../components/BottomNavigationBar.dart';
import '../components/PersianHorizontalDatePicker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../components/Sidebar/SideBarController.dart';
import 'HabitBottomSheetContent.dart';
import 'habitItem.dart';
import 'habit_controller.dart';

class HabitPage extends StatelessWidget {
  final HabitViewModel habitViewModel = Get.put(HabitViewModel());
  final SideBarController sideBarController = Get.put(SideBarController());

  HabitPage({super.key});
  Rx<DateTime> startDate = DateTime.now().subtract(const Duration(days: 2)).obs;
  Rx<DateTime> endDate = DateTime.now().add(const Duration(days: 7)).obs;
  Rx<DateTime> initialSelectedDate = DateTime.now().obs;

  void updateDates(DateTime selectedDate) {
    initialSelectedDate.value = selectedDate;
    startDate.value = selectedDate.subtract(const Duration(days: 2));
    endDate.value = selectedDate.add(const Duration(days: 7));
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
     // habitViewModel.updateStreak();
    });

    return Scaffold(
      appBar: CustomAppBar(userScore: sideBarController.userScore),
      drawer: SideBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.r),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.69,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      color: Theme.of(context).colorScheme.secondaryFixed,
                    ),
                    onPressed: () async {
                      Jalali? picked = await showPersianDatePicker(
                        context: context,
                        initialDate: Jalali.now(),
                        firstDate: Jalali(1385, 8),
                        lastDate: Jalali(1450, 9),
                      );
                      if (picked != null) {
                        Gregorian gregorianDate = picked.toGregorian();
                        updateDates(gregorianDate.toDateTime());

                        String formattedDate = "${gregorianDate.year.toString().padLeft(4, '0')}-${gregorianDate.month.toString().padLeft(2, '0')}-${gregorianDate.day.toString().padLeft(2, '0')}";
                        habitViewModel.loadUserHabits(formattedDate);
                      }
                    },
                  ),
                ),
                Obx(() => buildPersianHorizontalDatePicker(
                  startDate: startDate.value,
                  endDate: endDate.value,
                  initialSelectedDate: initialSelectedDate.value,
                  onDateSelected: (date) {
                    String? formattedDate = date?.toIso8601String().split('T')[0];
                    habitViewModel.loadUserHabits(formattedDate!);
                  },
                  context: context,
                )),
                SizedBox(height: 12.0.r),
                Expanded(
                  child: Obx(() {
                    if (habitViewModel.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (habitViewModel.habits.isEmpty) {
                      return Center(child: Text('هیچ عادتی برای این روز وجود ندارد.',
                        style: Theme.of(context).textTheme.bodyLarge,));
                    }
                    return ListView.builder(
                      itemCount: habitViewModel.habits.length,
                      itemBuilder: (context, index) {
                        Habit habit = habitViewModel.habits[index];
                        return GestureDetector(
                          onTap: () {
                            habit.isCompleted
                            ?null
                            :_showBottomSheet(context,habit:habit);
                          },
                          child: buildHabitItem(habit, context,habitViewModel),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0.r, vertical: 16.0.r),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(94.0.r),
            ),
            onPressed: () {
              _showBottomSheet(context);
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 3.obs),
    );
  }

  void _showBottomSheet(BuildContext context, {Habit? habit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return HabitBottomSheetContent(habit: habit, habitViewModel: habitViewModel);
      },
    ).whenComplete(() {
      Get.delete<HabitBottomSheetController>(); // حذف کنترلر وقتی BottomSheet بسته شد
    });
  }

}
