import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:karat_habit_tracker_app/model/entity/challenge_model.dart';

import '../../model/constant.dart';
import '../../utils/theme/controller.dart';
import '../../utils/theme/theme.dart';
import '../../viewmodel/challenge_viewmodel.dart';
import 'SpecificChallengePage.dart';

class ChallengeItemWidget extends StatelessWidget {
  final Challenge challenge;
  final ChallengeViewModel challengeViewModel;
  final ThemeController themeController = Get.put(ThemeController());

   ChallengeItemWidget({super.key, required this.challenge, required this.challengeViewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.0.r),
      child: GestureDetector(
        onTap: () {
          // نمایش جزئیات چالش
          challengeViewModel.selectedChallenge.value=challenge;
          Get.to(() => SpecificChallengePage(
            challengeViewModel: challengeViewModel,
            challenge:challengeViewModel.selectedChallenge ,
            isFromMyChallenges: false,  // یا false بسته به نیاز
          ));
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.62,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0.r),
            image: DecorationImage(
              image: challenge.photo != null
                  ? NetworkImage('$baseUrl${challenge.photo}')
                  : const AssetImage('assets/images/challenge.png') as ImageProvider,
              fit: BoxFit.fill
            ),
          ),
          child: Stack(
            children: [
              // Overlay نیمه شفاف
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0.r),
                  color:themeController.currentTheme.value == AppTheme.darkTheme? Colors.black87.withOpacity(0.6):Colors.black.withOpacity(0.45), // رنگ سیاه با شفافیت 55%
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0.r,horizontal: 12.0.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge.name,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white,fontSize: 14.sp),
                        ),
                        SizedBox(height: 2.0.r),
                        Text(
                          challenge.participants.isEmpty
                              ? 'بدون شرکت کننده'
                              : '${challenge.participants.length} نفر شرکت کننده',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white,fontSize: 11),
                        ),
                      ],
                    ),
                    if (challenge.participants.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: List.generate(
                          challenge.participants.length > 3 ? 3 : challenge.participants.length,
                              (index) => Transform.translate(
                            offset: Offset(index * -10.0.r, 0), // جابجایی افقی برای هم‌پوشانی
                            child: CircleAvatar(
                                radius: 12.0.r,
                                backgroundImage: challenge.participants[challenge.participants.length - 1 - index].photo != null
                                    ? NetworkImage('$baseUrl${challenge.participants[challenge.participants.length - 1 - index].photo}')
                                    : const AssetImage('assets/images/profile.png') as ImageProvider,
                                backgroundColor: challenge.participants[challenge.participants.length - 1 - index].photo != null
                                    ? Colors.transparent
                                    : const Color(0xFFF3B9A6)
                            ),
                          ),
                        ).reversed.toList(), // معکوس کردن لیست برای نمایش از آخر به اول
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
