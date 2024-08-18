import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karat_habit_tracker_app/model/entity/challenge_model.dart';

import '../../model/constant.dart';

class ParticipatedChallengeItemWidget extends StatelessWidget {
  final Challenge challenge;

  const ParticipatedChallengeItemWidget({super.key, required this.challenge});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 6.0.r,top: 4.0.r ,bottom: 4.0.r ),
      child: GestureDetector(
        onTap: () {
          // نمایش جزئیات چالش
          // Get.toNamed(AppRoutes.challengeDetailPage, arguments: challenge);
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
                    CircleAvatar(
                      backgroundImage: challenge.photo != null
                          ? NetworkImage('$baseUrl${challenge.photo}')
                          : const AssetImage('assets/images/challenge.jpg') as ImageProvider,
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
