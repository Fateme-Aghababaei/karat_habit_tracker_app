import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:karat_habit_tracker_app/model/entity/challenge_model.dart';

import '../../model/constant.dart';
import '../../viewmodel/challenge_viewmodel.dart';
import 'SpecificChallengePage.dart';

class ParticipatedChallengeItemWidget extends StatelessWidget {
  final Challenge challenge;
  final ChallengeViewModel challengeViewModel;
  const ParticipatedChallengeItemWidget({super.key, required this.challenge, required this.challengeViewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.0.r,top: 4.0.r ,bottom: 4.0.r ),
      child: GestureDetector(
        onTap: () {
          // نمایش جزئیات چالش
          challengeViewModel.selectedChallenge.value=challenge;
          Get.to(() => SpecificChallengePage(
            challengeViewModel: challengeViewModel,
            challenge:challengeViewModel.selectedChallenge ,
            isFromMyChallenges: true,  // یا false بسته به نیاز
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0.r),
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              color: Colors.grey.shade300, // بوردر طوسی کمرنگ
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 4.0.r, right: 6.0.r, top: 8.0.r, bottom: 8.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40.0.r, // عرض عکس (می‌توانید اندازه را تنظیم کنید)
                      height: 40.0.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0.r), // گوشه‌های کمی گرد. اگر گوشه‌ها کاملاً صاف باید مقدار 0 بگذارید
                        image: DecorationImage(
                          image: challenge.photo != null
                              ? NetworkImage('$baseUrl${challenge.photo}')
                              : const AssetImage('assets/images/challenge.png') as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                        color:challenge.photo != null?Colors.grey.shade400: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    SizedBox(width: 10.0.r),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge.name,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13.sp
                          ),
                        ),
                        SizedBox(height: 4.0.r),
                        Text(
                          challenge.participants.isEmpty
                              ? 'بدون شرکت کننده'
                              : '${challenge.participants.length} نفر شرکت کننده',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp
                          ),
                        ),
                      ],
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
                              : Color(0xFFF3B9A6)
                        ),
                      ),
                    ).reversed.toList(), // معکوس کردن لیست برای نمایش از آخر به اول
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
