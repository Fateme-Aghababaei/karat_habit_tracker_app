import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karat_habit_tracker_app/external/persian_horizontal_date_picker/datetime_extention.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class PersianHorizontalDatePicker extends StatefulWidget {
  final DateTime startDate; // Start date for the date picker
  final DateTime endDate; // End date for the date picker
  final DateTime? initialSelectedDate; // Initial selected date for the date picker
  final List<DateTime>? markedDates; // List of marked dates on the date picker
  final Function(DateTime? date) onDateSelected; // Callback function when a date is selected
  final bool? isPersianDate; // Flag to indicate if the date picker should display Persian dates
  final double? datePickerHeight; // Height of the date picker widget
  final double? margin; // Margin of the date picker widget
  final EdgeInsets? contentPadding; // Padding of the date picker widget content
  final double? width; // Width of the date picker widget
  final double? radius; // Radius of the date picker widget
  final Color? backgroundColor; // Background color of the date picker widget
  final Color? selectedBackgroundColor; // Background color of the selected date on the date picker widget
  final Color? textColor; // Text color of the date picker widget
  final Color? selectedTextColor; // Text color of the selected date on the date picker widget
  final TextStyle? weekDayTextStyle; // Text style for the week day labels on the date picker widget
  final TextStyle? selectedWeekDayTextStyle; // Text style for the selected week day label on the date picker widget
  final TextStyle? dayTextStyle; // Text style for the day labels on the date picker widget
  final TextStyle? selectedDayTextStyle; // Text style for the selected day label on the date picker widget
  final TextStyle? monthTextStyle; // Text style for the month label on the date picker widget
  final TextStyle? selectedMonthTextStyle; // Text style for the selected month label on the date picker widget
  final bool? hasSelectedItemShadow; // Flag to indicate if the selected date should have a shadow
  final Color? markedDotColor; // Color of the marked dots on the date picker widget
  final Color? selectedMarkedDotColor; // Color of the marked dots on the selected date on the date picker widget
  final TextStyle? initialSelectedDayTextStyle;
  final TextStyle? initialSelectedWeekDayTextStyle;
  final TextStyle? initialSelectedMonthTextStyle;

  const PersianHorizontalDatePicker({
    Key? key,
    required this.startDate,
    required this.endDate,
    this.initialSelectedDate,
    this.markedDates,
    required this.onDateSelected,
    this.isPersianDate = true,
    this.datePickerHeight = 112,
    this.margin = 8,
    this.contentPadding = const EdgeInsets.all(8),
    this.width = 84,
    this.radius = 56,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.textColor,
    this.selectedTextColor,
    this.weekDayTextStyle,
    this.selectedWeekDayTextStyle,
    this.dayTextStyle,
    this.selectedDayTextStyle,
    this.monthTextStyle,
    this.selectedMonthTextStyle,
    this.hasSelectedItemShadow = true,
    this.markedDotColor = Colors.blue,
    this.selectedMarkedDotColor = Colors.white,
    this.initialSelectedDayTextStyle,
    this.initialSelectedWeekDayTextStyle,
    this.initialSelectedMonthTextStyle,
  }) : super(key: key);

  @override
  State<PersianHorizontalDatePicker> createState() =>
      _PersianHorizontalDatePickerState();
}

class _PersianHorizontalDatePickerState
    extends State<PersianHorizontalDatePicker> {
  late AutoScrollController _scrollController;
  late ValueNotifier<DateTime?> _selectedDateValueNotifier;

  @override
  void initState() {
    _scrollController = AutoScrollController(axis: Axis.horizontal);
    _selectedDateValueNotifier =
        ValueNotifier<DateTime?>(widget.initialSelectedDate);
    if (widget.initialSelectedDate != null) {
      _scrollToInitialFocusedDate();
    }
    super.initState();
  }

  @override
  void dispose() {
    _selectedDateValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
      widget.isPersianDate! ? TextDirection.rtl : TextDirection.ltr,
      child: SizedBox(
        height: widget.hasSelectedItemShadow!
            ? widget.datePickerHeight! + 32
            : widget.datePickerHeight,
        child: ValueListenableBuilder(
          valueListenable: _selectedDateValueNotifier,
          builder: (context, selectedDate, child) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: widget.endDate.dateDifference(widget.startDate) + 1,
              itemBuilder: (context, index) {
                DateTime itemDate = widget.startDate.add(Duration(days: index));
                bool isMarked = widget.markedDates != null
                    ? widget.markedDates!
                    .where((element) => element.isSameDate(itemDate))
                    .isNotEmpty
                    : false;
                bool isActive =
                _isDatePickerItemSelected(itemDate, selectedDate);
                bool isInitialSelected = _isDatePickerItemSelected(itemDate, widget.initialSelectedDate);

                final TextStyle weekDayTextStyle = isActive
                    ? widget.selectedWeekDayTextStyle ?? TextStyle(fontSize: 12.sp, color: widget.selectedTextColor)
                    : isInitialSelected
                    ? widget.initialSelectedWeekDayTextStyle ?? TextStyle(fontSize: 12.sp, color: widget.selectedTextColor)
                    : widget.weekDayTextStyle ?? TextStyle(fontSize: 12.sp, color: widget.textColor);

                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: _scrollController,
                  index: index,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: widget.hasSelectedItemShadow! ? 32 : 0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (!_isDatePickerItemSelected(
                            itemDate, selectedDate)) {
                          _setSelectedDate(itemDate);
                          _scrollToIndex(index);
                        }
                      },
                      child: Container(
                        width: widget.width,
                        margin:
                        EdgeInsets.symmetric(horizontal: widget.margin!),
                        decoration: ShapeDecoration(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(widget.radius!),
                          ),
                          color: isActive
                              ? widget.selectedBackgroundColor
                              : widget.backgroundColor,
                          shadows: widget.hasSelectedItemShadow! && isActive
                              ? [
                            BoxShadow(
                              color: widget.selectedBackgroundColor!,
                              blurRadius: 25,
                              spreadRadius: -12,
                              offset: const Offset(0, 16),
                            ),
                          ]
                              : [],
                        ),
                        child: Padding(
                          padding: widget.contentPadding!,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.isPersianDate!
                                    ? itemDate.getJalaliWeekDay()
                                    : itemDate.getGregorianWeekDay(),
                                style: weekDayTextStyle,
                              ),
                              Text(
                                widget.isPersianDate!
                                    ? itemDate.getJalaliDay()
                                    : itemDate.getGregorianDay(),
                                style: isInitialSelected
                                    ? widget.initialSelectedDayTextStyle ??
                                    TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: widget.selectedTextColor,
                                    )
                                    : isActive
                                    ? widget.selectedDayTextStyle ??
                                    TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: widget.selectedTextColor,
                                    )
                                    : widget.dayTextStyle ??
                                    TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: widget.textColor,
                                    ),
                              ),

                              if (isMarked)
                                Container(
                                  width: 6.0.r,
                                  height: 6.0.r,
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? widget.selectedMarkedDotColor
                                        : widget.markedDotColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }


  // Check if the itemDate is the same as the selectedDate
  bool _isDatePickerItemSelected(DateTime itemDate, DateTime? selectedDate) {
    if (selectedDate == null) return false;
    return itemDate.isSameDate(selectedDate);
  }

  // Set the selected date and update the state
  void _setSelectedDate(DateTime? date) {
    setState(() {
      _selectedDateValueNotifier.value = date;
      widget.onDateSelected(date);
    });
  }

  // Scroll to the specified index in the list
  void _scrollToIndex(int index) {
    _scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.middle,
    );
  }

  // Scroll to the initial focused date when the widget is built
  void _scrollToInitialFocusedDate() {
    int index = widget.initialSelectedDate!.dateDifference(widget.startDate);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.middle,
      );
    });
  }
}
