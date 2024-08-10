import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/constant.dart';
import '../../viewmodel/user_viewmodel.dart';
import '../error_screen.dart';
import 'friends_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? username = Get.arguments;
    final UserViewModel userViewModel = Get.find<UserViewModel>();

    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true); // ارسال نتیجه به صفحه قبلی
        return true; // اجازه به خروج از صفحه
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Obx(() {
            return Text(
              userViewModel.userProfile.value.firstName ?? '',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16.sp,
              ),
              overflow: TextOverflow.ellipsis,
            );
          }),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () =>Get.back(result: true), // بازگشت به صفحه قبل با نتیجه true
            ),
          ],
        ),
        body: Obx(() {
          if (userViewModel.isLoadingUserProfile.value ||
              userViewModel.isLoadingFollowers.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (userViewModel.userProfile.value.id == null) {
            return const Error();
          } else {
            return _buildProfileContent(context, userViewModel, username);
          }
        }),
      ),
    );
  }

  Widget _buildProfileContent(
      BuildContext context, UserViewModel userViewModel, String? username) {
    return Padding(
      padding: EdgeInsets.all(16.0.r),
      child: Column(
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
                      : const Color(0xffFFB2A7),
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
                          onTap: () async {
                            bool? result = await Get.to(() => FollowersFollowingPage(
                                userViewModel: userViewModel));
                            if (result == true) {
                              // بازخوانی اطلاعات پروفایل و لیست دوستان
                              await userViewModel.fetchUserProfile(username,false);
                              await userViewModel.fetchFollowerFollowing(username, false);
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
                          onTap: () async {
                            bool? result = await Get.to(() => FollowersFollowingPage(
                                userViewModel: userViewModel));
                            if (result == true) {
                              // بازخوانی اطلاعات پروفایل و لیست دوستان
                              await userViewModel.fetchUserProfile(username,false);
                              await userViewModel.fetchFollowerFollowing(username, false);
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
                userViewModel.handleElevatedButton();
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
      ),
    );
  }
  }