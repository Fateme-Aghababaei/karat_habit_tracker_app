import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';
import '../../model/constant.dart';
import '../../viewmodel/user_viewmodel.dart';
import '../error_screen.dart';

class FollowersFollowingPage extends StatelessWidget {
  final UserViewModel userViewModel;
  final int initialTabIndex; // Add this parameter to determine initial tab index

  const FollowersFollowingPage({
    super.key,
    required this.userViewModel,
    this.initialTabIndex = 0, // Default to the first tab if not specified
  });

  @override
  Widget build(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width / 2;
    return DefaultTabController(
      length: 2,
      initialIndex: initialTabIndex, // Set the initial index here
      child: Scaffold(
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
            userViewModel.userFriends.value.firstName ?? '',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 15.sp,
            ),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
                fontFamily: "IRANYekan",
                fontWeight: FontWeight.w700,
                fontSize: 12.0.sp),
            unselectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 12.0.sp,
            ),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              SizedBox(
                width: halfScreenWidth,
                child: const Tab(text: 'دنبال کننده'),
              ),
              SizedBox(
                width: halfScreenWidth,
                child: const Tab(text: 'دنبال شونده'),
              ),
            ],
          ),
        ),
        body: userViewModel.userFriends.value.username == null
            ? const Error()
            : TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0.r),
              child: buildFollowersList(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0.r),
              child: buildFollowingList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFollowingList() {
    return Obx(() {
      return ListView.builder(
        itemCount: userViewModel.userFriends.value.followings.length,
        itemBuilder: (context, index) {
          final follow = userViewModel.userFriends.value.followings[index];
          final box = GetStorage();
          String? myUsername = box.read('username');
          return GestureDetector(
            onTap: () async {
              var username = follow.username == myUsername ? null : follow.username;
              dynamic result = await Get.toNamed(AppRouteName.profileScreen, arguments: username);
              if (result == true) {
                userViewModel.fetchFollowerFollowing(userViewModel.username, false);
              }
            },

            child: ListTile(
              key: ValueKey(follow.username),
              leading: CircleAvatar(
                radius: 24.r,
                backgroundImage: follow.photo != null
                    ? NetworkImage('$baseUrl${follow.photo!}')
                    : const AssetImage('assets/images/profile.png') as ImageProvider,
                backgroundColor: follow.photo != null
                    ? Colors.transparent
                    : Theme.of(context).primaryColor.withOpacity(0.3),
              ),
              title: Text(follow.firstName,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 14.sp
              ),),
              subtitle: Text(follow.username,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12.sp
              ),),

            ),
          );

        },
      );
    });
  }

  Widget buildFollowersList() {
    return Obx(() {
      return ListView.builder(
        itemCount: userViewModel.userFriends.value.followers.length ,
        itemBuilder: (context, index) {
          final follow = userViewModel.userFriends.value.followers[index];
          final box = GetStorage();
          String? myUsername = box.read('username');
          return GestureDetector(
            onTap: () async {
              var username = follow.username == myUsername ? null : follow.username;
              dynamic result = await Get.toNamed(AppRouteName.profileScreen, arguments: username);
              if (result == true) {
                userViewModel.fetchFollowerFollowing(userViewModel.username, false);
              }
            },

            child: ListTile(
              leading: CircleAvatar(
                radius: 24.r,
                backgroundImage: follow.photo != null
                    ? NetworkImage('$baseUrl${follow.photo!}')
                    : const AssetImage('assets/images/profile.png')
                as ImageProvider,
                backgroundColor: follow.photo != null
                    ? Colors.transparent
                    : Theme.of(context).primaryColor.withOpacity(0.3),
              ),
              title: Text(follow.firstName,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14.sp
              ),),
              subtitle: Text(follow.username,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 12.sp
              ),),

            ),
          );
        },
      );
    });
  }


}
