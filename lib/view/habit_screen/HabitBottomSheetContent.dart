import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/view/habit_screen/tagDialog.dart';
import '../../model/entity/habit_model.dart';
import '../../viewmodel/habit_viewmodel.dart';
import 'habit_controller.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class HabitBottomSheetContent extends StatelessWidget {
  final Habit? habit;
  final HabitViewModel habitViewModel;
   final Rx<DateTime> today;
  const HabitBottomSheetContent({super.key, this.habit, required this.habitViewModel, required this.today});



  @override
  Widget build(BuildContext context) {
    final HabitBottomSheetController controller = Get.put(HabitBottomSheetController(habit: habit,habitViewModel,today));
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0.r),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.0.r),
              // تب بار
              Obx(() => Align(
                alignment: Alignment.center,
                child: Container(
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
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(
                          color:Theme.of(context).colorScheme.outlineVariant,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            width: 1.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:  BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
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
                        borderSide:  BorderSide(
                          color: Theme.of(context).colorScheme.outlineVariant,
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

                      Row(
                        children: [
                          Obx(() {
                            return Transform.translate(
                              offset:  Offset(-8.0.r, 0),
                              child: Checkbox(
                                value: controller.allDaysSelected.value,
                                onChanged: (value) {
                                  controller.setAllDaysSelected(value!);
                                },
                              ),
                            );
                          }),
                          Text(
                            'هرروز',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: 13.sp),
                          ),

                        ],
                      ),
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
              // انتخاب تگ‌ها
              SizedBox(height: 8.0.r,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               // mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text(
                    'برچسب',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 12.sp),
                  ),
                  SizedBox(height: 5.0.r),
                  Obx(() {
                    return Wrap(
                      spacing: 4.0.r, // فاصله افقی بین تگ‌ها
                      runSpacing: 4.0.r, // فاصله عمودی بین خطوط تگ‌ها
                      children: [
                        for (var tag in habitViewModel.tags)
                          GestureDetector(
                            onTap: () {
                              controller.selectedTag.value =
                              controller.selectedTag.value == tag.id
                                  ? null
                                  : tag.id;
                            },
                            child: Obx(() => Chip(
                              label: Text(
                                tag.name ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                              avatar: CircleAvatar(
                                backgroundColor:
                                Color(int.parse('0xFF${tag.color}')),
                                radius: 5,
                              ),
                              backgroundColor:
                              controller.selectedTag.value == tag.id
                                  ? Theme.of(context).cardColor
                                  : Theme.of(context)
                                  .scaffoldBackgroundColor,
                              side: BorderSide(
                                color: controller.selectedTag.value == tag.id
                                    ? Theme.of(context).cardColor // رنگ نارنجی یا رنگ اصلی تم
                                    : Theme.of(context).colorScheme.outline
                                     // رنگ پیش‌فرض برای تگ‌های دیگر
                              ),
                            )),
                          ),
                        GestureDetector(
                          onTap: () {
                            showCreateTagDialog(context,habitViewModel,null);
                          },
                          child: Chip(
                            label: Text(
                              'برچسب جدید',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                            avatar: const Icon(Icons.add),
                            backgroundColor: Theme.of(context)
                                .scaffoldBackgroundColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(6.0.r),
                              side: BorderSide(
                                  color: Theme.of(context).colorScheme.outline),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              SizedBox(height: 10.0.r),
              // تنظیم تاریخ انجام (بسته به تب انتخابی)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                    controller.selectedTab.value == 0
                        ? "تنظیم تاریخ پایان عادت"
                        : "تنظیم تاریخ انجام",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12.sp),
                  )),
                  SizedBox(height: 8.0.r),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => TextField(
                          controller: TextEditingController(
                            text: controller.selectedShamsiDate.value.isEmpty
                                ? 'انتخاب تاریخ'
                                : controller.selectedShamsiDate.value,
                          ),
                          decoration: InputDecoration(
                            hintText: 'انتخاب تاریخ',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:  BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                  color:Theme.of(context).colorScheme.outlineVariant,
                                  width: 1.0),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide:  BorderSide(
                                color: Theme.of(context).colorScheme.outlineVariant,
                                width: 1.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.calendar_month_outlined,color: Theme.of(context).colorScheme.secondaryFixed,),
                              onPressed: () async {
                                Jalali? picked = await showPersianDatePicker(
                                  context: context,
                                  initialDate: Jalali.now(),
                                  firstDate: Jalali(1385, 8),
                                  lastDate: Jalali(1450, 9),
                                );
                                if (picked != null) {
                                  // تبدیل تاریخ به میلادی و ذخیره آن
                                  Gregorian gregorianDate = picked.toGregorian();
                                  String formattedGregorianDate =
                                      "${gregorianDate.year.toString().padLeft(4, '0')}-${gregorianDate.month.toString().padLeft(2, '0')}-${gregorianDate.day.toString().padLeft(2, '0')}";
                                  controller.selectedDate(formattedGregorianDate);

                                  // نمایش تاریخ شمسی در TextField
                                  String formattedJalaliDate =
                                      "${picked.year.toString().padLeft(4, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
                                  controller.selectedShamsiDate(formattedJalaliDate);
                                }
                              },
                            ),
                          ),
                          readOnly: true, // Prevent user from manually editing the date
                          onTap: () async {
                            Jalali? picked = await showPersianDatePicker(
                              context: context,
                              initialDate: Jalali.now(),
                              firstDate: Jalali(1385, 8),
                              lastDate: Jalali(1450, 9),
                            );
                            if (picked != null) {
                              // تبدیل تاریخ به میلادی و ذخیره آن
                              Gregorian gregorianDate = picked.toGregorian();
                              String formattedGregorianDate =
                                  "${gregorianDate.year.toString().padLeft(4, '0')}-${gregorianDate.month.toString().padLeft(2, '0')}-${gregorianDate.day.toString().padLeft(2, '0')}";
                              controller.selectedDate(formattedGregorianDate);

                              // نمایش تاریخ شمسی در TextField
                              String formattedJalaliDate =
                                  "${picked.year.toString().padLeft(4, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
                              controller.selectedShamsiDate(formattedJalaliDate);
                            }
                          },
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13.sp,
                              fontFamily: "IRANYekan_number"

                          ),
                        )),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 16.0.r),
              if (habit == null) ...[
                Obx(() => ElevatedButton(
                  onPressed: controller.isSaveButtonEnabled.value
                      ? () {
                    controller.saveHabitOrTask();
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
                          ? () {
                        controller.saveHabitOrTask();
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
                       await habitViewModel.deleteHabit(habit!.id);
                        Get.back();
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
    );
  }

  Widget _buildDayChip(String day, int index, BuildContext context, HabitBottomSheetController controller) {
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
              ? Theme.of(context).cardColor
              : Theme.of(context).scaffoldBackgroundColor,
          side: BorderSide(
            color: isSelected ? Theme.of(context).cardColor : Theme.of(context).colorScheme.outline,
          ),
        ),
      );
    });
  }
}