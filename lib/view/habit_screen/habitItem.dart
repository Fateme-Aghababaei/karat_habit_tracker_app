import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import '../../model/entity/habit_model.dart';
import 'package:get/get.dart';
import '../../viewmodel/habit_viewmodel.dart';

Widget buildHabitItem(Habit habit, BuildContext context, HabitViewModel habitViewModel) {
  RxBool checked = habit.isCompleted.obs;
  final GetStorage storage = GetStorage();
  final AudioPlayer audioPlayer = AudioPlayer();

  return Container(
    margin: EdgeInsets.symmetric(vertical: 4.5.r),
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(10.0.r),
      border: Border(
        top: BorderSide(color: Theme.of(context).colorScheme.outline, // رنگ حاشیه طوسی
            width: 1.0),
       left: BorderSide(color: Theme.of(context).colorScheme.outline, // رنگ حاشیه طوسی
           width: 1.0),
        bottom: BorderSide(color: Theme.of(context).colorScheme.outline, // رنگ حاشیه طوسی
            width: 1.0),
        right:BorderSide(color: Theme.of(context).colorScheme.outline, // رنگ حاشیه طوسی
        width: 0.5),
      ),
    ),
    child: Row(
      children: [
        // نوار رنگی کنار
        Container(
          width: 6.2.r,
          height: 68.0.r,
          decoration: BoxDecoration(
            color: habit.fromChallenge != null
                ? const Color(0XFF8D70FE) // اگر از چالش است، رنگ بنفش
                : habit.tag?.color != null
                ? Color(int.parse('0xFF${habit.tag?.color}'))
                : Colors.grey.shade400,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0.r),
              bottomRight: Radius.circular(20.0.r),
            ),
          ),
        ),
        // محتویات داخل باکس
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.r, vertical: 6.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Text(
                  habit.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 11.5.sp,
                    decoration: checked.value ? TextDecoration.lineThrough : null,
                  ),
                )),
                SizedBox(height: 4.0.r),
                Text(
                  habit.description ?? 'بدون توضیحات',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 2.0.r),
                Text(
                  habit.fromChallenge != null ? 'چالش' : (habit.tag?.name ?? 'بدون برچسب'), // مقدار ثابت "چالش" در صورت وجود from_challenge
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        Obx(
              () => Checkbox(
            value: checked.value,
            onChanged: (value) async {
              if (value!) {
                bool shouldPlaySound = storage.read('isSoundOn') ?? true;

                // تلاش برای کامل کردن عادت
                bool success = await habitViewModel.completeHabit(habit.id, habit.dueDate!, DateTime.now().toIso8601String().split('T')[0]);

                if (success) {
                  // اگر عملیات موفق بود، چک‌باکس تیک بخورد
                  checked.value = true;

                  if (shouldPlaySound) {
                    // Play sound using just_audio
                    try {
                      await audioPlayer.setAsset('assets/sounds/check_sound.mp3');
                      await audioPlayer.play();
                    } catch (e) {
                      print("Error playing sound: $e");
                    }
                  }
                } else {
                  // اگر عملیات ناموفق بود، چک‌باکس تغییری نکند
                  checked.value = false;
                }
              }
            },
            activeColor: habit.fromChallenge != null
                ? const Color(0XFF8D70FE)
                : habit.isRepeated
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.secondary,
            side: BorderSide(
              color: habit.fromChallenge != null
                  ? const Color(0XFF8D70FE)
                  : habit.isRepeated
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
        )
      ],
    ),
  );
}
