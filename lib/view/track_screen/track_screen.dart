import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/view/components/Sidebar/Sidebar.dart';
import 'package:karat_habit_tracker_app/view/track_screen/trackItem.dart';
import '../../model/entity/track_model.dart';
import '../../viewmodel/track_viewmodel.dart';
import '../components/BottomNavigationBar.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import '../components/Sidebar/SideBarController.dart';

class TrackPage extends StatelessWidget {
  final SideBarController sideBarController = Get.put(SideBarController());
  final TrackViewModel trackViewModel = Get.put(TrackViewModel());

  TrackPage({super.key});

  final RxBool isTextInputVisible = false.obs; // وضعیت نمایش اینپوت
  final RxBool isBottomSheetOpen = false.obs; // وضعیت باز بودن باتم شیت

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -8,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'کـارات',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Container(
              margin: EdgeInsets.only(left: 22.0.r),
              padding: EdgeInsets.only(left: 1.0.r, right: 6.0.r),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Obx(() {
                    return AnimatedFlipCounter(
                      duration: Duration(milliseconds: 400),
                      value: sideBarController.userScore.value,
                      padding: EdgeInsets.all(1),
                      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontFamily: "IRANYekan_number",
                      ),
                    );
                  }),
                  SizedBox(width: 4.0.r),
                  Image.asset(
                    'assets/images/coin.png',
                    width: 28.0.r,
                    height: 28.0.r,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: SideBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Center(
          child: Obx(() {
            if (trackViewModel.tracksMap.isEmpty) {
              return Text(
                'تابحال چیزی ثبت نکردی',
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
                        return buildTrackItem(track,context);
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
      floatingActionButton: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  FloatingActionButton(
                    heroTag: "btn1",
                    onPressed: () {
                      isBottomSheetOpen.value = true;
                      _showBottomSheet(context);
                    },
                    child: Icon(Icons.add),
                  ),
                  SizedBox(width: 10.w), // فاصله بین دکمه‌ها
                  FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: isBottomSheetOpen.value
                        ? null
                        : () {
                      isTextInputVisible.value = !isTextInputVisible.value;
                    },
                    child: Icon(Icons.star),
                  ),
                ],
              ),
              if (isTextInputVisible.value)
                Padding(
                  padding: EdgeInsets.only(right: 10.0.w),
                  child: Container(
                    width: 200.w, // عرض ورودی متن
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'ورودی خود را وارد کنید',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() => isBottomSheetOpen.value ? SizedBox.shrink() : CustomBottomNavigationBar()),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0.r),
          height: MediaQuery.of(context).size.height * 0.4, // کاهش ارتفاع به 40% صفحه
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FloatingActionButton(
                    heroTag: "btn1_top",
                    onPressed: () {
                      // عملکرد دکمه بالای باتم شیت
                    },
                    child: Icon(Icons.add),
                  ),
                  SizedBox(width: 16.w), // فاصله بین دکمه‌ها
                  FloatingActionButton(
                    heroTag: "btn2_top",
                    onPressed: () {
                      isTextInputVisible.value = !isTextInputVisible.value;
                    },
                    child: Icon(Icons.star),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: Text('محتوای باتم شیت شما'),
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      isBottomSheetOpen.value = false;
    });
  }
}
