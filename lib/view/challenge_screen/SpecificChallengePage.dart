import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/constant.dart';
import '../../model/entity/challenge_model.dart';
import '../../model/entity/habit_model.dart';
import '../../viewmodel/challenge_viewmodel.dart';
import 'SpecificChallengeController.dart';
import 'add_edit_habit.dart';
import 'habit_controller.dart';

class SpecificChallengePage extends StatelessWidget {
  final Rxn<Challenge> challenge;
  final bool isFromMyChallenges;
  final SpecificChallengeController controller;
  final ChallengeViewModel challengeViewModel;


  SpecificChallengePage({
    super.key,
    required this.challenge,
    required this.isFromMyChallenges, required this.challengeViewModel,
  }) : controller = Get.put(SpecificChallengeController(challenge: challenge, isFromMyChallenges: isFromMyChallenges));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(challenge.value!.name, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 15.sp)),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0.r),
                        image: DecorationImage(
                          image: challenge.value!.photo != null
                              ? NetworkImage('$baseUrl${challenge.value!.photo}')
                              : const AssetImage('assets/images/challenge.png') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2), // رنگ سایه با شفافیت 20%
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.0.r),
                Text(
                  'امتیاز مورد نیاز : ${challenge.value!.price}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontFamily: "IRANYekan_number",
                  ),
                ),
                Text(
                  'تاریخ شروع : ${controller.convertToJalali(challenge.value!.startDate)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 12.5.sp,
                    fontFamily: "IRANYekan_number",
                  ),
                ),
                Text(
                  'تاریخ پایان : ${controller.convertToJalali(challenge.value!.endDate)}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 12.5.sp,
                    fontFamily: "IRANYekan_number",
                  ),
                ),

                SizedBox(height: 10.0.r),
                Text('جوایز دریافتی:', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  fontFamily: "IRANYekan_number",
                ),),
                SizedBox(height: 2.0.r),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.military_tech, color: Colors.orange),
                    Text('دریافت ${challenge.value!.score} سکه در صورت تکمیل چالش'
                      ,style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 12.5.sp,
                          fontFamily: "IRANYekan_number",
                          fontWeight: FontWeight.w400
                      ),),
                  ],
                ),
                SizedBox(height: 10.0.r),
                Text('توضیحات: ', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  fontFamily: "IRANYekan_number",
                ),),
                SizedBox(height: 4.0.r,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0.r,vertical: 6.0.r),
                  width: double.maxFinite,
                  constraints: BoxConstraints(
                    minHeight: 60.0.r, // حداقل ارتفاع 60 ریم
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8.0.r),
                    border: Border.all(color: Theme.of(context).colorScheme.outline),
                  ),
                  child: Text(challenge.value!.description,style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 12.5.sp,
                      fontFamily: "IRANYekan_number",
                      fontWeight: FontWeight.w400
                  ),),
                ),
                SizedBox(height: 10.0.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'در این چالش انجام می‌دهیم:',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        fontFamily: "IRANYekan_number",
                      ),
                    ),
                    Obx(() {
                      if (controller.canEdit.value) {
                        return
                           GestureDetector(
                            onTap: (){
                              _showBottomSheet(context);
                            },
                            child: Text(
                              '+ عادت جدید ',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 12.0.sp,
                                color: Theme.of(context).colorScheme.secondaryFixed,
                              ),
                            ),
                          );

                      } else {
                        return SizedBox.shrink(); // اگر شرایط برقرار نباشد، دکمه نمایش داده نمی‌شود
                      }
                    }),
                  ],
                ),
                SizedBox(height: 6.0.r),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8.0.r),
                    border: Border.all(color:Theme.of(context).colorScheme.outline),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (challenge.value!.habits.isEmpty) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                            alignment: Alignment.center,
                            child: Text(
                              'هنوز عادتی برای این چالش ایجاد نشده است.',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 12.5.sp,
                                fontFamily: "IRANYekan_number",
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            shrinkWrap: true, // استفاده از اندازه کوچک‌شده برای جلوگیری از مشکل overflow
                            physics: NeverScrollableScrollPhysics(), // غیرفعال کردن اسکرول داخل لیست
                            itemCount: challenge.value!.habits.length,
                            itemBuilder: (context, index) {
                              Habit habit = challenge.value!.habits[index];
                              return GestureDetector(
                                onTap: controller.canEdit.value
                                    ? () {
                                  _showBottomSheet(context,habit: habit);
                                }
                                    : null,
                                child: ListTile(
                                  title: Text(habit.name,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 12.5.sp,
                                    fontFamily: "IRANYekan_number",
                                  )),
                                  subtitle: Text(habit.description??'بدون توضیحات',style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontSize: 12.0.sp,
                                    fontFamily: "IRANYekan_number",
                                  )),
                                  leading:  Icon(
                                    Icons.check,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
                            },

                          );
                        }
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 10.0.r),

                // بخش "لینک دعوت"
                Text('لینک دعوت:', style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 13.sp,
                  fontFamily: "IRANYekan_number",
                ),),
                SizedBox(height: 2.0.r),
                Container(
                  padding: EdgeInsets.all(12.0.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8.0.r),
                    border: Border.all(color: Theme.of(context).colorScheme.outline),
                  ),
                  child: SelectableText(
                    maxLines: 1,
                   // overflow: TextOverflow.ellipsis,
                    textDirection: TextDirection.ltr,
                    '${baseUrl}challenge/get_challenge/?code=${challenge.value!.shareCode}' ,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 13.sp,
                      fontFamily: "IRANYekan_number",
                    ),
                  ),
                ),

                SizedBox(height: 24.0.r),

                Obx(() {
                  if (controller.canEdit.value) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.maxFinite, 40.0.r),
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        challengeViewModel.deleteChallenge(challenge.value!.id);
                        Get.back();
                      },
                      child: Text('حذف چالش'),
                    );
                  } else if (!controller.hasJoined.value) {
                    // نمایش دکمه شرکت در چالش فقط اگر کاربر قبلاً در چالش شرکت نکرده باشد
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.maxFinite, 40.0.r),
                      ),
                      onPressed: controller.canJoin.value && !controller.canJoinButDisabled.value
                          ? () async {
                        try {
                          await challengeViewModel.participateInChallenge(challengeId: challenge.value!.id);
                          controller.joinChallenge();
                        } catch (error) {
                          Get.snackbar(
                            'خطا',
                            error.toString(),
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                          );
                        }
                      }
                          : null, // دکمه غیر فعال می‌شود اگر شرایط شرکت در چالش برقرار نباشد یا امتیاز کافی نباشد
                      child: Text('شرکت در چالش'),
                    );
                  } else {
                    return SizedBox.shrink(); // اگر کاربر قبلاً در چالش شرکت کرده باشد، دکمه نمایش داده نمی‌شود
                  }
                }),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, {Habit? habit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return  HabitChallengeContent(
          habit: habit,
          today: Rx<DateTime>(DateTime.now()),
          challenge: challenge,
          challengeViewModel: challengeViewModel,
        );
      },
    ).whenComplete(() {
      Get.delete<HabitChallengeController>(); // حذف کنترلر وقتی BottomSheet بسته شد
    });
  }
}
