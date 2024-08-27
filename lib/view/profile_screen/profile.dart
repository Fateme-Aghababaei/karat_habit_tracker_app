import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../model/constant.dart';
import '../../viewmodel/user_viewmodel.dart';
import 'badge_widget.dart';
import 'profile_header.dart';
import 'status_grid.dart';
import '../error_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final String? username = Get.arguments;
    final UserViewModel userViewModel = Get.find<UserViewModel>();

    return WillPopScope(
      onWillPop: () async {
        Get.back(result: true);
        return true;
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
              onPressed: () => Get.back(result: true),
            ),
          ],
        ),
        body: Obx(() {
          if (userViewModel.isLoadingUserProfile.value || userViewModel.isLoadingFollowers.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (userViewModel.userProfile.value.id == null) {
            return const Error();
          } else {
            return Padding(
              padding: EdgeInsets.all(16.0.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ProfileHeader(userViewModel: userViewModel, username: username),
                  SizedBox(height: 20.0.r),
                  StatusGrid(userViewModel: userViewModel),
                  SizedBox(height: 30.0.r),
                  BadgesWidget(userViewModel: userViewModel),
                  SizedBox(height: 20.0.r),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await showBadgesModal(userViewModel,context);
                      },
                      child: Text("Show Badges"),
                    ),
                  ),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  Future<void> showBadgesModal(UserViewModel userViewModel, BuildContext context) async {
    final badges = userViewModel.userProfile.value.badges;
    for (var badge in badges) {
      await Get.dialog(
        AlertDialog(
          title: Column(
            children: [
              Text(
                '🎉تبریک',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.r),
              Text(
                'شما یک نشان جدید دریافت کردید!',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network('$baseUrl${badge.image}', height: MediaQuery.of(context).size.height * 0.24),
              SizedBox(height: 8.0.r),
              Text(
                badge.description ?? 'توضیحی موجود نیست',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.r),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the current modal
              },
              child: Text(
                'بستن',
              ),
            ),
          ],
        ),
      );
    }
  }

}
