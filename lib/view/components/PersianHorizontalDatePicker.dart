import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../external/persian_horizontal_date_picker/persian_horizontal_date_picker.dart';

Widget buildPersianHorizontalDatePicker({
  required DateTime startDate,
  required DateTime endDate,
  DateTime? initialSelectedDate,
  List<DateTime>? markedDates,
  required Function(DateTime? date) onDateSelected,
  required BuildContext context,
}) {
  return PersianHorizontalDatePicker(
    startDate: startDate,
    endDate: endDate,
    margin: 0,
    initialSelectedDate: initialSelectedDate,
    markedDates: markedDates,
    onDateSelected: onDateSelected,
    initialSelectedDayTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12.sp,fontFamily: "IRANYekan_number"),
    initialSelectedWeekDayTextStyle:Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize:9.sp),
    isPersianDate: true,
   datePickerHeight:54.0.r,
    contentPadding: const EdgeInsets.all(2),
    width: 52.0.r,
    weekDayTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 9.sp),
    dayTextStyle:  Theme.of(context).textTheme.bodySmall?.copyWith(fontFamily: "IRANYekan_number"),
    selectedDayTextStyle:Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 12.sp,fontFamily: "IRANYekan_number") ,
    radius: 30,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //  selectedBackgroundColor: Color(0XFFD9EADF),
    selectedTextColor: Theme.of(context).colorScheme.secondary,
    hasSelectedItemShadow: false,
    monthTextStyle:const TextStyle(color: Colors.transparent,fontSize: 0),

  );
}
