import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';
import '../../../model/constant.dart';
import 'SideBarController.dart';



class SideBar extends StatelessWidget {

  final SideBarController Controller = Get.find<SideBarController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(() {
              return UserAccountsDrawerHeader(
                accountName: Text(
                  Controller.firstName.value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),

                ),
                accountEmail: Text(
                  '@${Controller.userName.value}',
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: Controller.userPhoto.value.isNotEmpty
                      ? NetworkImage('$baseUrl${Controller.userPhoto.value}')
                      : const AssetImage('assets/images/profile.png') as ImageProvider,
                  backgroundColor:Controller.userPhoto.value.isNotEmpty
                      ? Colors.transparent
                      : const Color(0xffFFB2A7),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                ),
              );
            }),

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
            _buildDrawerItem(
              context: context,
              iconPath: 'assets/icon/notif.svg',
              text: 'اعلان ها',
              index: 3,
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
        ),
      ),
    );
  }

  Widget _buildDrawerItem({required String iconPath, required String text, required int index, required BuildContext context}) {
    return Obx(() {
      return ListTile(
        leading: SvgPicture.asset(iconPath),
        title: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 15.sp
        )),
        selected: Controller.selectedIndex.value == index,
        onTap: () async {
          Controller.updateIndex(index);
          Get.back(); // بستن منو بعد از انتخاب آیتم

          dynamic result;
          switch (index) {
            case 0:
              result = await Get.toNamed(AppRouteName.habitScreen); // به صفحه "امروز" بروید
              break;
            case 1:
              result = await Get.toNamed(AppRouteName.profileScreen ,arguments: null); // به صفحه "حساب کاربری" بروید
              break;
            case 2:
              result = await Get.toNamed(AppRouteName.settingScreen,arguments: null); // به صفحه "تنظیمات" بروید
              break;
            case 3:
              result = await Get.toNamed('/notifications'); // به صفحه "اعلان‌ها" بروید
              break;
            case 4:
              result = await Get.toNamed('/faq'); // به صفحه "سوالات متداول" بروید
              break;
            case 5:
              result = await Get.toNamed('/about'); // به صفحه "درباره ما" بروید
              break;
          }

          if (result == true) {
            Controller.fetchUserBrief();
          }
        },
      );
    });
  }
}
