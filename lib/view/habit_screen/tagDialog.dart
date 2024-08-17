import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/viewmodel/habit_viewmodel.dart';

class CreateTagDialog extends StatelessWidget {
  final TextEditingController tagNameController = TextEditingController();
  final RxInt selectedColorIndex = RxInt(-1);
  final HabitViewModel habitViewModel; // دریافت HabitViewModel

  CreateTagDialog({super.key, required this.habitViewModel}); // سازنده اصلاح‌شده

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
            TextField(
              controller: tagNameController,
              decoration: InputDecoration(
                hintText: 'نام برچسب',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0.r),
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
                      // Add your logic to create a new tag with the name and selected color
                      print('Tag Name: ${tagNameController.text}');
                      print('Selected Color: ${colors[selectedColorIndex.value]}');
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('ذخیره'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.33,40.0.r),backgroundColor: Colors.grey.shade400),
                  onPressed: () {
                    if (tagNameController.text.isNotEmpty && selectedColorIndex.value != -1) {
                      // تبدیل رنگ انتخاب شده به رشته هگزادسیمال
                      String colorHex = colors[selectedColorIndex.value].value.toRadixString(16).substring(2);

                      // فراخوانی متد addTag و ارسال رنگ
                      habitViewModel.addTag(tagNameController.text, colorHex);

                      Navigator.of(context).pop();
                    }
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

void showCreateTagDialog(BuildContext context, HabitViewModel habitViewModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CreateTagDialog(habitViewModel: habitViewModel); // پاس دادن habitViewModel به دیالوگ
    },
  );
}
