import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/viewmodel/track_viewmodel.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../model/entity/track_model.dart';

class BottomSheetContent extends StatefulWidget {
  final DateTime? startTime;
  final DateTime? endTime;
  final int elapsedTime;
  final TrackViewModel trackViewModel;
  final Track? track;
  final Rx<TimeOfDay> startTimeRx;
  final Rx<TimeOfDay> endTimeRx;

  BottomSheetContent({
    super.key,
    this.startTime,
    this.endTime,
    this.track,
    required this.elapsedTime,
    required this.trackViewModel,
  })  : startTimeRx = TimeOfDay.fromDateTime(startTime ?? DateTime.now()).obs,
        endTimeRx = TimeOfDay.fromDateTime(endTime ?? DateTime.now()).obs;

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
      // تبدیل زمان‌های دریافت شده به فرمت TimeOfDay
      widget.startTimeRx.value = _parseTime(widget.track!.startDatetime);
      widget.endTimeRx.value = _parseTime(widget.track!.endDatetime);
    }
  }

  TimeOfDay _parseTime(String dateTimeString) {
    String timePart = dateTimeString.split('T')[1];
    List<String> timeParts = timePart.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    if (widget.track == null) {
      final picked = await showPersianTimePicker(
        context: context,
        initialTime: isStartTime ? widget.startTimeRx.value : widget.endTimeRx.value,
      );

      if (picked != null) {
        if (isStartTime) {
          widget.startTimeRx.value = picked;
        } else {
          widget.endTimeRx.value = picked;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.trackViewModel.loadUserTags();
    });

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
                        String? name = nameController.text.isEmpty ? "بدون عنوان" : nameController.text;
                        if (widget.track != null) {
                          // حالت ویرایش
                          await widget.trackViewModel.editTrack(widget.track!.id, name, tagId: selectedTagId.value);
                        } else {
                          // حالت افزودن
                          String startDatetime = "${DateTime.now().toString().split(' ')[0]}T${widget.startTimeRx.value.hour.toString().padLeft(2, '0')}:${widget.startTimeRx.value.minute.toString().padLeft(2, '0')}:00";
                          String endDatetime = "${DateTime.now().toString().split(' ')[0]}T${widget.endTimeRx.value.hour.toString().padLeft(2, '0')}:${widget.endTimeRx.value.minute.toString().padLeft(2, '0')}:00";
                          await widget.trackViewModel.addTrack(name, startDatetime, endDatetime, tagId: selectedTagId.value);
                        }

                        widget.trackViewModel.isTextInputVisible.value = false;
                        widget.trackViewModel.isAddPressed.value = true;
                        Get.back();
                      },
                      child: Icon(widget.track != null ? Icons.check : Icons.add), // تغییر آیکون به "تیک" در حالت ویرایش
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
                        controller: nameController,  // اضافه کردن کنترلر برای دریافت مقدار
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
                          spacing: 4.0.r, // فاصله افقی بین تگ‌ها
                          runSpacing: 4.0.r, // فاصله عمودی بین خطوط تگ‌ها
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
                                        ? Color(0XFFD2E3D8) // رنگ نارنجی یا رنگ اصلی تم
                                        : Colors.grey.shade300, // رنگ پیش‌فرض برای تگ‌های دیگر
                                  ),
                                )),
                              ),
                            Chip(
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
                                    ? null // اگر در حالت ویرایش است، قابلیت ویرایش غیرفعال شود
                                    : () => _selectTime(context, true),
                                child: Obx(() => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 8.0.r),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.0.r),
                                  ),
                                  child: Text(
                                    widget.startTimeRx.value.format(context),
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
                                    ? null // اگر در حالت ویرایش است، قابلیت ویرایش غیرفعال شود
                                    : () => _selectTime(context, false),
                                child: Obx(() => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 16.0.r, vertical: 8.0.r),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8.0.r),
                                  ),
                                  child: Text(
                                    widget.endTimeRx.value.format(context),
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

