import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/constant.dart';
import '../../viewmodel/user_viewmodel.dart';
import 'all_badges.dart';
import 'badge_detail.dart';

class BadgesWidget extends StatelessWidget {
  final UserViewModel userViewModel;

  const BadgesWidget({super.key, required this.userViewModel});

  @override
  Widget build(BuildContext context) {
    final badges = userViewModel.userProfile.value.badges;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
               "جوایز وافتخارات",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 13.sp),
            ),
            GestureDetector(
              onTap: () {
                 Get.to(() => BadgesGridScreen(badges: badges));
              },
              child: Text(
                "مشاهده همه",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.secondaryFixed),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.r),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.0.r ,vertical: 1),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8.0.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 2,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            children: [
              ...List.generate(3, (index) {
                Widget imageWidget;

                if (index < badges.length) {
                  imageWidget = GestureDetector(
                    onTap: () {
                      Get.to(() => BadgeDetailsScreen(badge: badges[index]));
                    },
                    child: Image.network(
                      '$baseUrl${badges[index].image}',
                      height: MediaQuery.of(context).size.height * 0.17,
                      fit: BoxFit.cover, // برای پر کردن فضای موجود
                    ),
                  );
                } else {
                  // عکس‌های پیش‌فرض برای ایندکس‌های مختلف
                  String defaultImage;
                  if (index == 0) {
                    defaultImage = 'assets/images/default_badge1.png'; // مسیر عکس اول
                  } else if (index == 1) {
                    defaultImage = 'assets/images/default_badge2.png'; // مسیر عکس دوم
                  } else {
                    defaultImage = 'assets/images/default_badge3.png'; // مسیر عکس سوم
                  }

                  imageWidget = Image.asset(
                    defaultImage,
                    height: MediaQuery.of(context).size.height * 0.16,
                    fit: BoxFit.cover, // برای پر کردن فضای موجود
                  );
                }

                return Expanded(
                  child: Row(
                    children: [
                      Expanded(child: imageWidget),
                      if (index < 2) // نمایش خط جدا کننده فقط بین عکس‌ها (نه بعد از آخرین عکس)
                        Container(
                          width: 1.0, // عرض خط جدا کننده
                          height: MediaQuery.of(context).size.height * 0.15,
                          color: Theme.of(context).colorScheme.outlineVariant, // رنگ خط جدا کننده
                          margin: EdgeInsets.symmetric(horizontal: 2.5.r), // فاصله بین خط و تصاویر
                        ),
                    ],
                  ),
                );
              }),
            ],
          ),
        )

      ],
    );
  }
}
