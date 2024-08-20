import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/entity/track_model.dart';

String calculateTimeDifference(String startDatetime, String endDatetime) {
  DateTime start = DateTime.parse(startDatetime);
  DateTime end = DateTime.parse(endDatetime);
  Duration difference = end.difference(start);

  // استخراج ساعت، دقیقه و ثانیه از Duration
  String hours = difference.inHours.toString().padLeft(2, '0');
  String minutes = (difference.inMinutes % 60).toString().padLeft(2, '0');
  String seconds = (difference.inSeconds % 60).toString().padLeft(2, '0');

  // ترکیب ساعت، دقیقه و ثانیه به فرمت hh:mm:ss
  String formattedDifference = "$hours:$minutes:$seconds";

  return formattedDifference;
}


Widget buildTrackItem(Track track, BuildContext context,) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5.0.r),
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(10.0.r),
      border: Border.all(
        color: Colors.grey.shade300, // رنگ حاشیه طوسی
        width: 1.0, // ضخامت حاشیه
      ),
    ),
    child: Row(
      children: [
        // نوار رنگی کنار
        Container(
          width: 6.0.r,
          height: 51.0.r,
          decoration: BoxDecoration(

            color: track.tag?.color != null
                ? Color(int.parse('0xFF${track.tag?.color}'))
                : Colors.grey.shade400,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0.r),
              bottomRight: Radius.circular(10.0.r),
            ),
          ),
        ),
        // محتویات داخل باکس
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.r, vertical: 8.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      track.name ?? 'بدون عنوان',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    Text(
                      calculateTimeDifference(
                        track.startDatetime,
                        track.endDatetime ,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: "IRANYekan_number",
                        fontSize: 12.sp,
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 3.0.r),
                Text(
                  track.tag?.name ?? 'بدون برچسب',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10.5.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
