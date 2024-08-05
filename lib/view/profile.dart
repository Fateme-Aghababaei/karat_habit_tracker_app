import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../viewmodel/user_viewmodel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? username = Get.arguments;
    final UserViewModel userViewModel = Get.put(UserViewModel(username));

    return Scaffold(
      appBar: AppBar(
        title:
            Text(
              'مطهره وکیلی',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 13.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),

        centerTitle:true,
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // عملیات باز کردن منوی بیشتر
            }
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => Get.back(),
          ),
        ],

      ),
      body:
       // if (userViewModel.isLoadingUserProfile.value) {
         // return Center(child: CircularProgressIndicator());
       // } //else if (userViewModel.userProfile.value == null) {
          //return Center(child: Text("Error loading profile"));
       // }// else {
      Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
             Padding(
               padding: const EdgeInsets.only(right: 4.0),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   CircleAvatar(
                    radius: 40.0.r,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 16,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@mo.v2971',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14.sp
                        ),
                        textDirection: TextDirection.ltr ,
                      ),
                      SizedBox(height: 14,),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                '۳۵',
                                style:Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 14.sp
                                ),
                              ),
                              Text('دنبال‌کننده',style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp),),
                            ],
                          ),
                          SizedBox(width: 34,),
                          Column(
                            children: [
                              Text(
                                  '۱۰',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: 14.sp
                                  )
                              ),
                              Text('دنبال‌شونده',style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.sp)),
                            ],
                          ),
                        ],

                      ),
                    ],

                  ),




                //  SizedBox(width:2),


                ],
                           ),
             ),
            SizedBox(height: 20.0.r),
            ElevatedButton(
              onPressed: () {
                // عمل افزودن دوست جدید
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.maxFinite, 40.0.r), // اندازه دکمه
              ),
              child: Text(
                'اضافه کردن دوست جدید',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
