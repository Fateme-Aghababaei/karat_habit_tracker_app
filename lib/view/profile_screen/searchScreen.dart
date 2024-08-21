import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../model/constant.dart';
import '../../utils/routes/RouteNames.dart';
import '../error_screen.dart';
import '../../viewmodel/user_viewmodel.dart';

class UserSearchPage extends StatelessWidget {
  final UserViewModel userSearchViewModel;
  final TextEditingController _searchController = TextEditingController();

  UserSearchPage({super.key, required this.userSearchViewModel});

  @override
  Widget build(BuildContext context) {
    // گرفتن یوزرنیم از استوریج
    final box = GetStorage();
    final String? currentUsername = box.read('username'); // فرض می‌کنیم یوزرنیم در استوریج با کلید 'username' ذخیره شده باشد

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => Get.back(result: true),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text('جستجوی کاربران', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontSize: 14.sp,
    )),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                if (value.isEmpty) {
                  userSearchViewModel.userList.clear(); // لیست کاربران را خالی کنید
                  userSearchViewModel.isSearched.value=false;
                } else {
                  userSearchViewModel.searchUsersByUsername(value);
                }
              },
              onSubmitted: (value) {
                if (value.isEmpty) {
                  userSearchViewModel.userList.clear(); // لیست کاربران را خالی کنید
                  userSearchViewModel.isSearched.value=false;

                } else {
                  userSearchViewModel.searchUsersByUsername(value);
                }
              },
              decoration: InputDecoration(
                hintText: 'نام کاربری را وارد کنید...',
                prefixIcon: GestureDetector(
                  onTap: () {
                    if (_searchController.text.isEmpty) {
                      userSearchViewModel.userList.clear(); // لیست کاربران را خالی کنید
                      userSearchViewModel.isSearched.value=false;
                    } else {
                      userSearchViewModel.searchUsersByUsername(_searchController.text);
                    }
                  },
                  child:  Icon(Icons.search,color:Theme.of(context).primaryColor,),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                // اگر خطا وجود داشته باشد
                if (userSearchViewModel.errorMessage.isNotEmpty) {
                  return const Error();
                }
                // اگر لیست خالی باشد
                if (userSearchViewModel.userList.isEmpty&&userSearchViewModel.isSearched.value) {
                  return Center(child: Text('کاربری با این نام پیدا نشد'));
                }
                // نمایش لیست کاربران
                return ListView.builder(
                  itemCount: userSearchViewModel.userList.length,
                  itemBuilder: (context, index) {
                    final user = userSearchViewModel.userList[index];
                    // اگر یوزرنیم برابر با یوزرنیم خودمان باشد، آن را نمایش نمی‌دهیم
                    if (user.username == currentUsername) {
                      return const SizedBox.shrink(); // آیتم خالی
                    }
                    return GestureDetector(
                      onTap: () async {
                       await await Get.toNamed(AppRouteName.profileScreen, arguments: user.username);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 24.0.r,
                          backgroundImage: user.photo != null
                              ? NetworkImage('$baseUrl${user.photo}')
                              : const AssetImage('assets/images/profile.png') as ImageProvider,
                          backgroundColor: user.photo != null
                              ? Colors.transparent
                              : Theme.of(context).primaryColor.withOpacity(0.3),
                        ),
                        title: Text(user.firstName),
                        subtitle: Text(user.username),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
