import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../model/constant.dart';
import '../../model/entity/badge_model.dart';

class BadgeDetailsScreen extends StatelessWidget {
  final MyBadge badge;

  String formatToJalali(String dateTime) {
    DateTime gregorianDate = DateTime.parse(dateTime); // تبدیل رشته تاریخ به DateTime
    Jalali jalaliDate = Jalali.fromDateTime(gregorianDate); // تبدیل به تاریخ هجری شمسی

    // ساخت رشته خروجی به فرمت مورد نظر
    String formattedDate = '${jalaliDate.day} ${jalaliDate.formatter.mN} / ${jalaliDate.year}';

    return formattedDate;
  }

  const BadgeDetailsScreen({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( badge.title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network('$baseUrl${badge.image}',
             // Image.asset('assets/images/default_badge1.png',
                  height: MediaQuery.of(context).size.height * 0.44,
                  width: MediaQuery.of(context).size.width * 0.78,
                  ),
             // SizedBox(height: 20.r),

              Text(
                badge.description,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800
                ),
              ),
              SizedBox(height: 20.r),
              Text(
                "تاریخ دریافت : ${formatToJalali(badge.awardedAt)}",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontFamily: "IRANYekan_number",
                  fontSize: 13.5.sp
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
