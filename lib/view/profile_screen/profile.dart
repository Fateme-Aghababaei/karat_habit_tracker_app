import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../viewmodel/user_viewmodel.dart';
import '../error_screen.dart';
import 'friends_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? username = Get.arguments;
    final UserViewModel userViewModel = Get.find<UserViewModel>();

    void handle_ElevatedButton() {
      if (username != null) {
        if (userViewModel.isFollowing.value) {
          userViewModel.unfollowUser(userViewModel.userProfile.value.username!);
          userViewModel.isFollowing.value = false;
        } else {
          userViewModel.followUser(userViewModel.userProfile.value.username!);
          userViewModel.isFollowing.value = true;
        }
      } else {
        print("search kon");
      }
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (popResult) {
        Get.delete<UserViewModel>();
      },
      child: Obx(() {
        if (userViewModel.isLoadingUserProfile.value ||
            userViewModel.isLoadingFollowers.value) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (userViewModel.userProfile.value.username == null) {
          Get.delete<UserViewModel>();
          return const ErrorPage();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Obx(() {
                return Text(
                  userViewModel.userProfile.value.firsName ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 14.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                );
              }),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // عملیات باز کردن منوی بیشتر
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            body: Padding(
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
                          backgroundImage:
                          userViewModel.userProfile.value.photo != null
                              ? NetworkImage(
                              userViewModel.userProfile.value.photo!)
                              : const AssetImage(
                              'assets/images/profile.png')
                          as ImageProvider,
                          backgroundColor: userViewModel
                              .userProfile.value.photo !=
                              null
                              ? Colors.transparent
                              : const Color(0xffFFB2A7),
                        ),
                        SizedBox(width: 16.0.r),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '@${userViewModel.userProfile.value.username}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                fontSize: 14.sp,
                              ),
                              textDirection: TextDirection.ltr,
                            ),
                            SizedBox(height: 14.0.r),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    // انتقال به صفحه FollowersFollowingPage و نمایش لیست دنبال‌کنندگان
                                    Get.to(() => FollowersFollowingPage(
                                        userViewModel: userViewModel));
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        '${userViewModel.userProfile.value.followersNum}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                            fontSize: 14.sp,
                                            fontFamily:
                                            "IRANYekan_number"),
                                      ),
                                      Text(
                                        'دنبال‌کننده',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 34.0.r),
                                InkWell(
                                  onTap: () {
                                    // انتقال به صفحه FollowersFollowingPage و نمایش لیست دنبال‌شونده‌ها
                                    Get.to(() => FollowersFollowingPage(
                                      userViewModel: userViewModel,
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        '${userViewModel.userProfile.value.followingsNum}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                            fontSize: 14.sp,
                                            fontFamily:
                                            "IRANYekan_number"),
                                      ),
                                      Text(
                                        'دنبال‌شونده',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12.sp),
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
                  ElevatedButton(
                    onPressed: () {
                      handle_ElevatedButton();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.maxFinite, 40.0.r), // اندازه دکمه
                    ),
                    child: Text(
                      username != null
                          ? (userViewModel.isFollowing.value
                          ? 'انفالو کردن'
                          : 'دنبال کردن')
                          : 'اضافه کردن دوست جدید',
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
