import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../viewmodel/user_viewmodel.dart';

class FollowersFollowingPage extends StatelessWidget {
  final UserViewModel userViewModel;

  FollowersFollowingPage({required this.userViewModel});
  @override
  Widget build(BuildContext context) {
    double halfScreenWidth = MediaQuery.of(context).size.width / 2;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => Get.back(),
              ),
            ],
          title: Text(
           userViewModel.userFriends.value.firstName ??'',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 14.sp,
            ),
          ),
          bottom:  TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            labelStyle:  TextStyle(
              fontFamily: "IRANYekan",
              fontWeight: FontWeight.w700,
            fontSize: 12.0.sp),
            unselectedLabelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12.0.sp
            ),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: [
              SizedBox(
                width: halfScreenWidth,
                child: const Tab(text: 'دنبال شونده'),
              ),
              SizedBox(
                width: halfScreenWidth,
                child: const Tab(text: 'دنبال کننده'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildFollowingList(),
            buildFollowersList(),
          ],
        ),
      ),
    );
  }

  Widget buildFollowingList() {
    return Obx(() {
      if (userViewModel.isLoadingFollowers.value) {
        return Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemCount: userViewModel.userFriends.value.followings?.length ?? 0,
        itemBuilder: (context, index) {
          final follow = userViewModel.userFriends.value.followings![index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: userViewModel.userProfile.value.photo != null
                  ? NetworkImage(userViewModel.userProfile.value.photo!)
                  : const AssetImage('assets/images/profile.png') as ImageProvider,
              backgroundColor:userViewModel.userProfile.value.photo != null
                  ?Colors.transparent: const Color(0xffFFB2A7),
            ),
            title: Text(follow.firstName),
            subtitle: Text(follow.username),
            trailing: IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                // Follow/unfollow action
              },
            ),
          );
        },
      );
    });
  }

  Widget buildFollowersList() {
    return Obx(() {
      if (userViewModel.isLoadingFollowers.value) {
        return Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        itemCount: userViewModel.userFriends.value.followers?.length ?? 0,
        itemBuilder: (context, index) {
          final follow = userViewModel.userFriends.value.followers![index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(follow.photo),
            ),
            title: Text(follow.firstName),
            subtitle: Text(follow.username),
            trailing: IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                // Follow/unfollow action
              },
            ),
          );
        },
      );
    });
  }
}
