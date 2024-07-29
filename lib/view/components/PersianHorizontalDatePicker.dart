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
    initialSelectedDate: initialSelectedDate,
    markedDates: markedDates,
    onDateSelected: onDateSelected,
    initialSelectedDayTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 13.sp),
    initialSelectedWeekDayTextStyle:Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize:10.sp),
    isPersianDate: true,
    datePickerHeight:62.r,
    contentPadding: const EdgeInsets.all(2),
    width: 56.r,
    weekDayTextStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 10.sp),
    dayTextStyle:  Theme.of(context).textTheme.bodySmall?.copyWith(fontSize:12.sp),
    selectedDayTextStyle:Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 13.sp) ,
    radius: 25,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    selectedBackgroundColor: Color(0XFFD9EADF),
    selectedTextColor: Theme.of(context).colorScheme.secondary,
    hasSelectedItemShadow: true,
    monthTextStyle:const TextStyle(color: Colors.transparent,fontSize: 0),

  );
}
