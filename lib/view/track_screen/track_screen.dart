import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/view/components/Sidebar/Sidebar.dart';
import 'package:karat_habit_tracker_app/view/track_screen/trackItem.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../../model/entity/track_model.dart';
import '../../viewmodel/track_viewmodel.dart';
import '../components/AppBar.dart';
import '../components/BottomNavigationBar.dart';
import '../components/Sidebar/SideBarController.dart';
import 'BottomSheetContent.dart';

class TrackPage extends StatelessWidget {
  final SideBarController sideBarController = Get.put(SideBarController());
  final TrackViewModel trackViewModel = Get.put(TrackViewModel());

  TrackPage({super.key});

  final StopWatchTimer stopWatchTimer = StopWatchTimer(); // ایجاد یک نمونه از استاپ‌واچ

  DateTime? startTime;
  DateTime? endTime;

  bool isBottomSheetOpen = false;

  void startTimer() {
    startTime = DateTime.now();
    stopWatchTimer.onStartTimer();
    trackViewModel.isStopwatchRunning(true);
  }

  void stopTimer() {
    stopWatchTimer.onStopTimer();
    endTime = DateTime.now();
    trackViewModel.isStopwatchRunning(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(userScore: sideBarController.userScore),
      drawer: SideBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.65,
          child: Center(
            child: Obx(() {
              // if (trackViewModel.isLoading.value) {
              //   return CircularProgressIndicator();
              // }
               if (trackViewModel.tracksMap.isEmpty) {
                return Text(
                  'هنوز رکوردی را ثبت نکرده‌اید',
                  style: Theme.of(context).textTheme.bodyLarge,
                );
              } else {
                return ListView.builder(
                  itemCount: trackViewModel.tracksMap.length,
                  itemBuilder: (context, index) {
                    String date = trackViewModel.tracksMap.keys.elementAt(index);
                    List<Track> tracks = trackViewModel.tracksMap[date]!;
                    if (tracks.isEmpty) return SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trackViewModel.convertToJalali(date), // تاریخ روز
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 16.sp,
                            fontFamily: "IRANYekan_number",
                          ),
                        ),
                        ...tracks.map((track) {
                          return GestureDetector(
                              key: ValueKey(track.id),
                            onTap: () {
                              _showBottomSheet(context, track: track, withTimer: false); // باز کردن BottomSheet با حالت ویرایش
                            },
                            child: buildTrackItem(track, context),
                          );
                        }),
                        SizedBox(height: 12.0.r,)
                      ],
                    );
                  },
                );
              }
            }),
          ),
        ),
      ),
      floatingActionButton: Obx(() {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 32.0.r, vertical: 16.0.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // دکمه‌ها را به دو طرف می‌چسباند
            children: [
              Row(
                children: [
                  FloatingActionButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(94.0),
                    ),
                    heroTag: "add",
                    onPressed: () {
                      if (trackViewModel.isStopwatchRunning.value) {
                        stopTimer(); // توقف تایمر و ذخیره زمان پایان
                        _showBottomSheet(context, withTimer: true);
                      } else {
                        isBottomSheetOpen = true;
                        _showBottomSheet(context, withTimer: false);
                      }
                    },
                    child: Icon(
                      trackViewModel.isStopwatchRunning.value ? Icons.stop : Icons.add,
                    ),
                  ),
                  SizedBox(width: 8.0.r), // فاصله بین دکمه‌ها
                  if (!trackViewModel.isStopwatchRunning.value && !trackViewModel.isTextInputVisible.value)
                    FloatingActionButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(94.0),
                        side: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.0,
                        ),
                      ),
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      heroTag: "play",
                      onPressed: isBottomSheetOpen
                          ? null
                          : () {
                        stopWatchTimer.onResetTimer(); // ریست کردن تایمر
                        startTimer(); // شروع تایمر از صفر
                        trackViewModel.isTextInputVisible.value = true;
                      },
                      child: Icon(Icons.play_arrow_rounded, color: Theme.of(context).primaryColor, size: 28.sp,),
                    ),
                ],
              ),
              if (trackViewModel.isStopwatchRunning.value)
                Padding(
                  padding: EdgeInsets.only(left: 10.0.r),
                  child: StreamBuilder<int>(
                    stream: stopWatchTimer.rawTime,
                    initialData: stopWatchTimer.rawTime.value,
                    builder: (context, snapshot) {
                      final value = snapshot.data;
                      final displayTime = StopWatchTimer.getDisplayTime(value!, milliSecond: false);
                      return Text(
                        displayTime,
                        style:Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 22.sp,
                          fontFamily: "IRANYekan_number",
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      }),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: 2.obs,),
    );
  }

  void _showBottomSheet(BuildContext context, {required bool withTimer, Track? track, }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return BottomSheetContent(
          track: track,
          startTime: withTimer ? startTime : null,
          endTime: withTimer ? endTime : null,
          elapsedTime: withTimer ? stopWatchTimer.rawTime.value : 0,
          trackViewModel: trackViewModel,
        );
      },
    ).whenComplete(() {
      isBottomSheetOpen = false;

      if (!trackViewModel.isAddPressed.value) {
        trackViewModel.isTextInputVisible.value = false;
        stopWatchTimer.onStopTimer();
      } else {
        trackViewModel.isAddPressed.value = false;
      }
    });
  }
}
