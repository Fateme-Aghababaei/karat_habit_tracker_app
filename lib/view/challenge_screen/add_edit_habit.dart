import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/entity/challenge_model.dart';
import '../../model/entity/habit_model.dart';
import '../../viewmodel/challenge_viewmodel.dart';
import 'habit_controller.dart';

class HabitChallengeContent extends StatelessWidget {
  final Habit? habit;
  final Rx<DateTime> today;
  final Rxn<Challenge> challenge;
  final ChallengeViewModel challengeViewModel;
  const HabitChallengeContent({super.key, this.habit, required this.today, required this.challengeViewModel, required this.challenge});



  @override
  Widget build(BuildContext context) {
    final HabitChallengeController controller = Get.put(HabitChallengeController(habit: habit,today,challenge));
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.0.r),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 12.0.r),
                // تب بار
                Obx(() => Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17.0.r),
                    border: Border.all(
                      color: controller.selectedTab.value == 1
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).primaryColor,
                      width: 1.0.r,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.setSelectedTab(1),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0.r),
                            decoration: BoxDecoration(
                              color: controller.selectedTab.value == 1
                                  ? Theme.of(context).colorScheme.secondary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(16.0.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "کار روزانه",
                                style: controller.selectedTab.value == 1
                                    ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                )
                                    : Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => controller.setSelectedTab(0),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0.r),
                            decoration: BoxDecoration(
                              color: controller.selectedTab.value == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(16.0.r),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "عادت",
                                style: controller.selectedTab.value == 0
                                    ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontSize: 13.sp,
                                  color: Colors.white,
                                )
                                    : Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(height: 16.0.r),
                // فیلدهای عنوان و توضیحات
                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'عنوان',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 12.sp),
                    ),
                    SizedBox(height: 4.0.r,),
                    TextField(
                      textInputAction: TextInputAction.next,
                      controller: controller.titleController.value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0XFFCAC5CD),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Color(0XFFCAC5CD),
                              width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                          fontFamily: "IRANYekan_number"
                      ),
                      onChanged: (_) {
                        controller.updateSaveButtonState();
                      },
                    ),
                  ],
                )),
                SizedBox(height: 8.0.r),
                Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'توضیحات',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 12.sp),
                    ),
                    SizedBox(height: 4.0.r,),
                    TextField(
                      textInputAction: TextInputAction.done,
                      controller: controller.descriptionController.value,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Color(0XFFCAC5CD),
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                              color: Color(0XFFCAC5CD),
                              width: 1.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13.sp,
                          fontFamily: "IRANYekan_number"
                      ),
                      maxLines: 2,
                    ),
                  ],
                )),
                SizedBox(height: 8.0.r),
                Obx(() => controller.selectedTab.value == 0
                    ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'تکرار عادت در:',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 12.sp),
                        ),
                        Obx(() {
                          return Checkbox(
                            value: controller.allDaysSelected.value,
                            onChanged: (value) {
                              controller.setAllDaysSelected(value!);
                            },
                          );
                        }),
                      ],
                    ),
                    Wrap(
                      spacing: 4.0.r, // فاصله افقی بین چیپ‌ها
                      runSpacing: 2.0.r, // فاصله عمودی بین خطوط چیپ‌ها
                      children: [
                        _buildDayChip("شنبه", 0, context,controller),
                        _buildDayChip("یکشنبه", 1, context,controller),
                        _buildDayChip("دوشنبه", 2, context,controller),
                        _buildDayChip("سه‌شنبه", 3, context,controller),
                        _buildDayChip("چهارشنبه", 4, context,controller),
                        _buildDayChip("پنجشنبه", 5, context,controller),
                        _buildDayChip("جمعه", 6, context,controller),
                      ],
                    ),
                  ],
                )
                    : const SizedBox.shrink()),

                SizedBox(height: 16.0.r),
                if (habit == null) ...[
                  Obx(() => ElevatedButton(
                    onPressed: controller.isSaveButtonEnabled.value
                        ? () async {
                      // ذخیره عادت جدید یا ویرایش شده
                      Habit? newHabit = await controller.saveHabitOrTask();

                      if (newHabit != null) {
                        // اضافه کردن عادت به چالش
                         challengeViewModel.appendHabitToChallenge(
                          challengeId: challenge.value!.id,
                          habitId: newHabit.id,
                        );

                        // اضافه کردن عادت به لیست عادات در صفحه SpecificChallengePage
                        challenge.value!.habits.add(newHabit);

                        // به روز رسانی لیست عادات در صفحه
                        challenge.refresh();

                        // بستن Bottom Sheet
                        Get.back();
                      }
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.maxFinite, 40.0.r),
                        backgroundColor: controller.selectedTab.value == 0
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).colorScheme.secondary
                    ),
                    child: Text("ذخیره"),
                  )),
                ] else ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => ElevatedButton(
                        onPressed: controller.isSaveButtonEnabled.value
                            ? () async {
                          Habit? updatedHabit = await controller.saveHabitOrTask();

                          if (updatedHabit != null) {
                            int index = challenge.value!.habits.indexWhere((habit) => habit.id == updatedHabit.id);
                            if (index != -1) {
                              challenge.value!.habits[index] = updatedHabit;
                            }
                            challenge.refresh();
                            Get.back();
                          }
                        }
                            : null,

                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQuery.of(context).size.width * 0.45, 40.0.r),
                            backgroundColor: controller.selectedTab.value == 0
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).colorScheme.secondary
                        ),
                        child: Text("ذخیره"),
                      )),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                             challengeViewModel.removeHabitFromChallenge(
                              challengeId: challenge.value!.id,
                              habitId: habit!.id,
                            );
                            // حذف عادت از لیست عادات چالش در صفحه فعلی
                            challenge.value!.habits.removeWhere((h) => h.id == habit!.id);
                            // به‌روزرسانی UI
                            challenge.refresh();

                            // بستن Bottom Sheet
                            Get.back();
                          } catch (e) {
                            // مدیریت خطاها
                            print("Error deleting habit: $e");
                            Get.snackbar('خطا', 'عملیات به درستی انجام نشد، لطفاً دوباره تلاش کنید.');

                          }
                        },

                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQuery.of(context).size.width * 0.45, 40.0.r),
                            backgroundColor: Colors.redAccent), // رنگ دکمه حذف قرمز
                        child: Text("حذف"),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDayChip(String day, int index, BuildContext context, HabitChallengeController controller) {
    return Obx(() {
      bool isSelected = controller.selectedDays.value[index] == '1';
      return GestureDetector(
        onTap: () {
          controller.toggleDaySelection(index);
        },
        child: Chip(
          label: Text(
            day,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 12.sp,
            ),
          ),
          backgroundColor: isSelected
              ? const Color(0XFFD2E3D8)
              : Theme.of(context).scaffoldBackgroundColor,
          side: BorderSide(
            color: isSelected ? const Color(0XFFD2E3D8) : Colors.grey.shade300,
          ),
        ),
      );
    });
  }
}