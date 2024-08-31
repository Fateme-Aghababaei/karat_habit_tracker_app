import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TodayStatisticsWidget extends StatelessWidget {
  final int totalHabits;
  final int completedHabits;

  const TodayStatisticsWidget({
    Key? key,
    required this.totalHabits,
    required this.completedHabits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double completionRate = totalHabits == 0
        ? 0
        : completedHabits / totalHabits;

    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10.0.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 0.5,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("امروز", style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 13.sp
          ),),
          SizedBox(height: 12.0.r,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 45.0,
                lineWidth: 10.0,
                animation: true,
                percent: completionRate,
                center: Text(
                  "${(completionRate * 100).toInt()}%",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 13.sp,
                      fontFamily: "IRANYekan_number"

                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).primaryColor,
                backgroundColor: Color(0XFFF7C8B1).withOpacity(0.85),
              ),
              Column(
                children: [
                  Text(
                    "عادت‌های امروز",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12.sp
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    totalHabits.toString(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 12.sp,
                        fontFamily: "IRANYekan_number"

                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "عادت‌های انجام‌شده",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    completedHabits.toString(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 12.sp,
                      fontFamily: "IRANYekan_number"
                    ),
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
