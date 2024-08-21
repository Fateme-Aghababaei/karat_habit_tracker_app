import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/entity/track_model.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../viewmodel/track_viewmodel.dart';
import '../habit_screen/tagDialog.dart';

class BottomSheetContent extends StatefulWidget {
  final DateTime? startTime;
  final DateTime? endTime;
  final int elapsedTime;
  final TrackViewModel trackViewModel;
  final Track? track;
  final Rx<DateTime> startTimeRx;
  final Rx<DateTime> endTimeRx;

  BottomSheetContent({
    super.key,
    this.startTime,
    this.endTime,
    this.track,
    required this.elapsedTime,
    required this.trackViewModel,
  })  : startTimeRx = (startTime ?? DateTime.now()).obs,
        endTimeRx = (endTime ?? DateTime.now()).obs;

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  late TextEditingController nameController;
  Rx<int?> selectedTagId = Rx<int?>(null);

  @override
  void initState() {
    super.initState();

    // مقداردهی اولیه فیلدهای متنی و انتخابی در حالت ویرایش
    nameController = TextEditingController(text: widget.track?.name ?? "");
    selectedTagId.value = widget.track?.tag?.id;

    if (widget.track != null) {
      // تبدیل زمان‌های دریافت شده به فرمت DateTime
      widget.startTimeRx.value = DateTime.parse(widget.track!.startDatetime);
      widget.endTimeRx.value = DateTime.parse(widget.track!.endDatetime);
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    if (widget.track == null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(isStartTime ? widget.startTimeRx.value : widget.endTimeRx.value),
      );

      if (pickedTime != null) {
        final DateTime currentDate = widget.startTimeRx.value;
        final DateTime newDateTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          pickedTime.hour,
          pickedTime.minute,
          currentDate.second,
        );

        if (isStartTime) {
          widget.startTimeRx.value = newDateTime;
        } else {
          widget.endTimeRx.value = newDateTime;
        }
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.toIso8601String().split('.')[0]}";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(94.0),
                      ),
                      heroTag: "add_top",
                      onPressed: () async {
                        String name = nameController.text.isEmpty ? "بدون عنوان" : nameController.text;
                        if (widget.track != null) {
                          // حالت ویرایش
                          await widget.trackViewModel.editTrack(
                            widget.track!.id,
                            name,
                            tagId: selectedTagId.value,
                          );
                        } else {
                          // حالت افزودن
                          await widget.trackViewModel.addTrack(
                            name,
                            _formatDateTime(widget.startTimeRx.value),
                            _formatDateTime(widget.endTimeRx.value),
                            tagId: selectedTagId.value,
                          );
                        }

                        widget.trackViewModel.isTextInputVisible.value = false;
                        widget.trackViewModel.isAddPressed.value = true;
                        Get.back();
                      },
                      child: Icon(widget.track != null ? Icons.check : Icons.add),
                    ),
                    SizedBox(width: 8.0.r),
                    FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(94.0),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.0,
                        ),
                      ),
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      heroTag: "play_top",
                      onPressed: () {
                        widget.trackViewModel.isTextInputVisible.value = false;
                        widget.trackViewModel.isAddPressed.value = true;
                        Get.back();
                      },
                      child: Icon(
                        Icons.close,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                if (widget.elapsedTime > 0)
                  Padding(
                    padding: EdgeInsets.only(left: 10.0.r),
                    child: Text(
                      StopWatchTimer.getDisplayTime(widget.elapsedTime, milliSecond: false),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 22.sp,
                        fontFamily: "IRANYekan_number",
                      ),
                    ),
                  ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 28.0.r),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'توضیحات',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13.sp),
                      ),
                      SizedBox(height: 6.0.r),
                      TextField(
                        textInputAction: TextInputAction.done,
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          hintText: 'در حال کار بر روی ...',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Color(0XFFCAC5CD),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                                color: Color(0XFFCAC5CD),
                                width: 1.0),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 15.sp,
                          decoration: TextDecoration.none,
                          decorationThickness: 0,
                        ),
                      ),
                      SizedBox(height: 16.0.r),
                      Text(
                        'برچسب',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13.sp),
                      ),
                      SizedBox(height: 4.0.r),
                      Obx(() {
                        return Wrap(
                          spacing: 4.0.r,
                          runSpacing: 4.0.r,
                          children: [
                            for (var tag in widget.trackViewModel.tagsList)
                              GestureDetector(
                                onTap: () {
                                  selectedTagId.value = selectedTagId.value == tag.id ? null : tag.id;
                                },
                                child: Obx(() => Chip(
                                  label: Text(
                                    tag.name ?? "",
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  avatar: CircleAvatar(
                                    backgroundColor: Color(int.parse('0xFF${tag.color}')),
                                    radius: 5,
                                  ),
                                  backgroundColor: selectedTagId.value == tag.id
                                      ? Color(0XFFD2E3D8)
                                      : Theme.of(context).scaffoldBackgroundColor,
                                  side: BorderSide(
                                    color: selectedTagId.value == tag.id
                                        ? Color(0XFFD2E3D8)
                                        : Colors.grey.shade300,
                                  ),
                                )),
                              ),
                            GestureDetector(
                              child: Chip(
                                label: Text(
                                  'برچسب جدید',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 12.sp,
                                  ),
                                ),
                                avatar: const Icon(Icons.add),
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0.r),
                                  side: BorderSide(color: Colors.grey.shade300),
                                ),
                              ),
                              onTap: () {
                                showCreateTagDialog(context, null, widget.trackViewModel);
                              },
                            ),
                          ],
                        );
                      }),
                      SizedBox(height: 16.0.r),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'زمان شروع',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13.sp),
                              ),
                              SizedBox(height: 4.0.r),
                              GestureDetector(
                                onTap: widget.track != null
                                    ? null
                                    : () => _selectTime(context, true),
                                child: Obx(() => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 8.0.r),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.0.r),
                                  ),
                                  child: Text(
                                    TimeOfDay.fromDateTime(widget.startTimeRx.value).format(context),
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontFamily: "IRANYekan_number",
                                      fontSize: 16.sp,
                                      letterSpacing: 5,
                                    ),
                                  ),
                                )),
                              ),
                            ],
                          ),
                          SizedBox(width: 30.0.r),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'زمان پایان',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13.sp),
                              ),
                              SizedBox(height: 4.0.r),
                              GestureDetector(
                                onTap: widget.track != null
                                    ? null
                                    : () => _selectTime(context, false),
                                child: Obx(() => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 8.0.r),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.0.r),
                                  ),
                                  child: Text(
                                    TimeOfDay.fromDateTime(widget.endTimeRx.value).format(context),
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontFamily: "IRANYekan_number",
                                      fontSize: 16.sp,
                                      letterSpacing: 5,
                                    ),
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
