import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';
import '../../../model/constant.dart';
import 'SideBarController.dart';

class SideBar extends StatelessWidget {
  final SideBarController controller = Get.find<SideBarController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child:Obx(() {
          return ListView(
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
                accountName: Text(
                  controller.firstName.value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
                accountEmail: Text(
                  '@${controller.userName.value}',
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: controller.userPhoto.value.isNotEmpty
                      ? NetworkImage('$baseUrl${controller.userPhoto.value}')
                      : const AssetImage('assets/images/profile.png') as ImageProvider,
                  backgroundColor: controller.userPhoto.value.isNotEmpty
                      ? Colors.transparent
                      : const Color(0xffFFB2A7),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                ),
              ),


            _buildDrawerItem(
              context: context,
              iconPath: 'assets/icon/today.svg',
              text: 'امروز',
              index: 0,
            ),
            _buildDrawerItem(
              context: context,
              iconPath: 'assets/icon/User.svg',
              text: 'حساب کاربری',
              index: 1,
            ),
            _buildDrawerItem(
              context: context,
              iconPath: 'assets/icon/Setting.svg',
              text: 'تنظیمات',
              index: 2,
            ),
            _buildDrawerItemWithBadge(
              context: context,
              iconPath: 'assets/icon/notif.svg',
              text: 'اعلان‌ها',
              index: 3,
              unreadCount: controller.unreadCount.value,
            ),
            _buildDrawerItem(
              context: context,
              iconPath: 'assets/icon/message-question.svg',
              text: 'سوالات متداول',
              index: 4,
            ),
            _buildDrawerItem(
              context: context,
              iconPath: 'assets/icon/info.svg',
              text: 'درباره ما',
              index: 5,
            ),
          ],
        );
        }),
      ),
    );
  }

  Widget _buildDrawerItem({required String iconPath, required String text, required int index, required BuildContext context}) {
    return Obx(() {
      return ListTile(
        leading: SvgPicture.asset(iconPath),
        title: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 15.sp,
        )),
        selected: controller.selectedIndex.value == index,
        onTap: () async {
          controller.updateIndex(index);
          if (index == 2) {
            controller.shouldRefreshChallengePage(true);
          } else {
            controller.shouldRefreshChallengePage(false);
          }
          Get.back(); // بستن منو بعد از انتخاب آیتم

          dynamic result;
          switch (index) {
            case 0:
              result = await Get.toNamed(AppRouteName.habitScreen); // به صفحه "امروز" بروید
              break;
            case 1:
              result = await Get.toNamed(AppRouteName.profileScreen, arguments: null); // به صفحه "حساب کاربری" بروید
              break;
            case 2:
              result = await Get.toNamed(AppRouteName.settingScreen, arguments: null); // به صفحه "تنظیمات" بروید
              break;
            case 3:
              result = await Get.toNamed('/notifications'); // به صفحه "اعلان‌ها" بروید
              break;
            case 4:
              result = await Get.toNamed(AppRouteName.faqScreen); // به صفحه "سوالات متداول" بروید
              break;
            case 5:
              result = await Get.toNamed(AppRouteName.aboutScreen); // به صفحه "درباره ما" بروید
              break;
          }

          if (result == true) {
            controller.fetchUserBrief();
          }
          if (result == true && controller.shouldRefreshChallengePage.value) {
            controller.refreshChallengePage();
          }
        },
      );
    });
  }

  Widget _buildDrawerItemWithBadge({
    required BuildContext context,
    required String iconPath,
    required String text,
    required int index,
    required int unreadCount,
  }) {
    return Obx(() {
      return ListTile(
        leading: SvgPicture.asset(iconPath),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15.sp),
            ),
            if (unreadCount > 0)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0.r, vertical: 1.5.r),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(12.0.r),
                ),
                child: Text(
                  '$unreadCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "IRANYekan_number"
                  ),
                ),
              ),
          ],
        ),
        selected: controller.selectedIndex.value == index,
        onTap: () async {
          controller.updateIndex(index);
          if (index == 2) {
            controller.shouldRefreshChallengePage(true);
          } else {
            controller.shouldRefreshChallengePage(false);
          }
          Get.back(); // بستن منو بعد از انتخاب آیتم

          dynamic result;
          switch (index) {
            case 0:
              result = await Get.toNamed(AppRouteName.habitScreen); // به صفحه "امروز" بروید
              break;
            case 1:
              result = await Get.toNamed(AppRouteName.profileScreen, arguments: null); // به صفحه "حساب کاربری" بروید
              break;
            case 2:
              result = await Get.toNamed(AppRouteName.settingScreen, arguments: null); // به صفحه "تنظیمات" بروید
              break;
            case 3:
              result = await Get.toNamed(AppRouteName.notifsScreen); // به صفحه "اعلان‌ها" بروید
              break;
            case 4:
              result = await Get.toNamed(AppRouteName.faqScreen); // به صفحه "سوالات متداول" بروید
              break;
            case 5:
              result = await Get.toNamed(AppRouteName.aboutScreen); // به صفحه "درباره ما" بروید
              break;
          }

          if (result == true) {
           await controller.fetchUser();
          }
          if (result == true && controller.shouldRefreshChallengePage.value) {
            controller.refreshChallengePage();
          }
        },
      );
    });
  }
}
