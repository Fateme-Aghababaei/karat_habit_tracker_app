import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/constant.dart';
import '../../viewmodel/user_viewmodel.dart';
import 'friends_screen.dart';

class ProfileHeader extends StatelessWidget {
  final UserViewModel userViewModel;
  final String? username;

  const ProfileHeader({
    super.key,
    required this.userViewModel,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 4.0.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40.0.r,
                backgroundImage: userViewModel.userProfile.value.photo != null
                    ? NetworkImage('$baseUrl${userViewModel.userProfile.value.photo!}')
                    : const AssetImage('assets/images/profile.png')
                as ImageProvider,
                backgroundColor: userViewModel.userProfile.value.photo != null
                    ? Colors.transparent
                    : Theme.of(context).primaryColor.withOpacity(0.3),
              ),
              SizedBox(width: 16.0.r),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '@${userViewModel.userProfile.value.username}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 15.sp,
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                  SizedBox(height: 14.0.r),
                  Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent, // غیرفعال کردن افکت ریسپل
                        highlightColor: Colors.transparent, // غیرفعال کردن افکت هایلایت
                        hoverColor: Colors.transparent,
                        onTap: () async {
                          bool? result = await Get.to(() => FollowersFollowingPage(
                              userViewModel: userViewModel,initialTabIndex: 0,));
                          if (result == true) {
                            // بازخوانی اطلاعات پروفایل و لیست دوستان
                            await userViewModel.fetchUserProfile(username,true);
                            await userViewModel.fetchFollowerFollowing(username, true);
                          }
                        },
                        child: Column(
                          children: [
                            Obx(() => Text(
                              '${userViewModel.userFriends.value.followers.length}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                fontSize: 14.sp,
                                fontFamily: "IRANYekan_number",
                              ),
                            )),
                            Text(
                              'دنبال‌کننده',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 34.0.r),
                      InkWell(
                        splashColor: Colors.transparent, // غیرفعال کردن افکت ریسپل
                        highlightColor: Colors.transparent, // غیرفعال کردن افکت هایلایت
                        hoverColor: Colors.transparent,
                        onTap: () async {
                          bool? result = await Get.to(() => FollowersFollowingPage(
                              userViewModel: userViewModel,initialTabIndex: 1,));
                          if (result == true) {
                            // بازخوانی اطلاعات پروفایل و لیست دوستان
                            await userViewModel.fetchUserProfile(username,true);
                            await userViewModel.fetchFollowerFollowing(username, true);
                          }
                        },
                        child: Column(
                          children: [
                            Obx(() => Text(
                              '${userViewModel.userFriends.value.followings.length}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                fontSize: 14.sp,
                                fontFamily: "IRANYekan_number",
                              ),
                            )),
                            Text(
                              'دنبال‌شونده',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0.r),
        Obx(() => ElevatedButton(
          onPressed: () {
            if (!userViewModel.isLoading.value) {
              userViewModel.handleElevatedButton(userViewModel);
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.maxFinite, 40.0.r),
          ),
          child: userViewModel.isLoading.value
              ? const CircularProgressIndicator(
            strokeWidth: 1,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
              : Text(
            username != null
                ? (userViewModel.isFollowing.value
                ? 'حذف از دوستان'
                : 'دنبال کردن')
                : 'اضافه کردن دوست جدید',
          ),
        )),
      ],
    );
  }
}
