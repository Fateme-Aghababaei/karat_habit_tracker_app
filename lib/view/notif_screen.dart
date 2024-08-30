import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';
import './error_screen.dart';

import '../viewmodel/notificatio_viewmodel.dart';

class NotificationPage extends StatelessWidget {
  final NotificationViewModel notificationViewModel = Get.put(NotificationViewModel());

  NotificationPage({super.key});

  String convertToJalali(String dateTime) {
    DateTime date = DateTime.parse(dateTime);
    Jalali jalaliDate = Jalali.fromDateTime(date);
    String year = (jalaliDate.year % 100).toString().padLeft(2, '0'); // اضافه کردن 0 به سمت چپ اگر سال کمتر از 10 باشد
    return '$year/${jalaliDate.month}/${jalaliDate.day}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => Get.back(result: true),
          ),
        ],
        title: Text(
          "اعلان‌ها",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: 15.sp,
          ),
        ),
      ),
      body: Obx(() {
        if (notificationViewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (notificationViewModel.errorMessage.isNotEmpty) {
          return  const Error();
        } else if (notificationViewModel.notifications.isEmpty) {
          return Center(child: Text('هیچ اعلانی وجود ندارد.'));
        } else {
          return Padding(
            padding:  EdgeInsets.all(8.0.r),
            child: ListView.builder(
              itemCount: notificationViewModel.notifications.length,
              itemBuilder: (context, index) {
                final notification = notificationViewModel.notifications[index];
                return ListTile(
                  title: Text(notification.title,style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 13.5),),
                  subtitle: Text(notification.description,style:Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.5,color: Colors.grey.shade600)),
                  trailing: Text(
                    convertToJalali(notification.createdAt),
                    style: Theme.of(context).textTheme.titleMedium ?.copyWith(fontSize: 13,fontFamily: "IRANYekan_number"),
                  ),
                  leading: Icon(Icons.notifications, color: Theme.of(context).primaryColor,size: 22,),
                  onTap: () {
                    // هر کاری که می‌خواهید برای هر نوتیفیکیشن انجام دهید.
                  },
                );
              },
            ),
          );
        }
      }),
    );
  }
}
