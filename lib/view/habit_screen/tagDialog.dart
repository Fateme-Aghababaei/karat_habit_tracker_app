import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/viewmodel/habit_viewmodel.dart';

import '../../viewmodel/track_viewmodel.dart';

class CreateTagDialog extends StatelessWidget {
  final TextEditingController tagNameController = TextEditingController();
  final RxInt selectedColorIndex = RxInt(-1);
  final HabitViewModel? habitViewModel; // دریافت HabitViewModel
  final TrackViewModel? trackViewModel ;
  CreateTagDialog({super.key,  this.habitViewModel, this.trackViewModel}); // سازنده اصلاح‌شده

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.red, Colors.orange, Colors.yellow,
      Colors.green, Colors.blue, Colors.purple,
      Colors.pink, Colors.brown, Colors.cyan,
      Colors.lime, Colors.amber, Colors.teal,
      Colors.indigo, Colors.deepPurple, Colors.grey,
    ];

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('افزودن برچسب', style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 16.0.r),
            Container(
              height:42,
              child: TextField(
                controller: tagNameController,
                decoration: InputDecoration(
                  hintText: 'نام برچسب',
                  filled: true,
                  fillColor: Theme.of(context).scaffoldBackgroundColor,
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
                    fontSize: 13.sp,
                    fontFamily: "IRANYekan_number"
                ),
              ),
            ),
            SizedBox(height: 16.0.r),
            GridView.builder(
              shrinkWrap: true,
              itemCount: colors.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 8.0.r,
                crossAxisSpacing: 8.0.r,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return Obx(() => GestureDetector(
                  onTap: () {
                    selectedColorIndex.value = index;
                  },
                  child: CircleAvatar(
                    radius: 10.0,
                    backgroundColor: colors[index],
                    child: selectedColorIndex.value == index
                        ? Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                ));
              },
            ),
            SizedBox(height: 24.0.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.33, 40.0.r)),
                  onPressed: () {
                    if (tagNameController.text.isNotEmpty && selectedColorIndex.value != -1) {
                      String colorHex = colors[selectedColorIndex.value].value.toRadixString(16).substring(2);
                      if (habitViewModel != null) {
                        habitViewModel!.addTag(tagNameController.text, colorHex);
                      } else if (trackViewModel != null) {
                        trackViewModel!.addTag(tagNameController.text, colorHex);
                      }
                     Get.back();
                    } else {
                      null;
                    }
               },
                  child: Text('ذخیره'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.33,40.0.r),backgroundColor: Colors.grey.shade400),
                  onPressed: () {
                   Get.back();
                  },
                  child: Text('لغو'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showCreateTagDialog(BuildContext context, HabitViewModel? habitViewModel, TrackViewModel? trackViewModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CreateTagDialog(
        habitViewModel: habitViewModel, // پاس دادن habitViewModel یا null
        trackViewModel: trackViewModel, // پاس دادن trackViewModel یا null
      );
    },
  );
}

