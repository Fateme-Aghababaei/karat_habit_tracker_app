import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:karat_habit_tracker_app/utils/routes/RouteNames.dart';
import 'package:karat_habit_tracker_app/view/setting_screen/setting_screen.dart';
import '../model/entity/brief_model.dart';
import '../model/entity/follower_following_model.dart';
import '../model/entity/user_model.dart';
import '../model/repositories/user_repository.dart';
import '../view/components/Sidebar/SideBarController.dart';
import '../view/profile_screen/searchScreen.dart';

class UserViewModel extends GetxController {
  final UserRepository _userRepository = UserRepository();

  // User Profile
  var userProfile = UserModel(badges: [], completedChallengesNum: 0, completedHabitsNum: 0, unreadNotifsNum:0,).obs;
  var userFriends=Follower_Following(followers: [], followings: []).obs;
  RxBool isLoadingUserProfile = false.obs;
  RxBool isLoadingFollowers = false.obs;
  RxBool isFollowing = false.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  final String? username;

  UserViewModel(this.username);

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    await fetchUserProfile(username,false);
    await fetchFollowerFollowing(username,false);
    checkIfFollowing();
  }

  void checkIfFollowing() {
    final box = GetStorage();
    String? myUsername = box.read('username');
    isFollowing.value = userFriends.value.followers.any((follow) => follow.username == myUsername);

  }
  // Get user profile
  Future<void> fetchUserProfile(String? username, bool fromEdit) async {
    try {
      isLoadingUserProfile(fromEdit?false:true);
      UserModel? profile = await _userRepository.getUserProfile(username);
      userProfile(profile);

    } catch (e) {
      print("Error fetching user profile: $e");
    } finally {
      isLoadingUserProfile(false);
    }
  }

  // Get followers and followings
  Future<void> fetchFollowerFollowing(String? username, bool fromfollow) async {
    try {
      isLoadingFollowers(fromfollow?false:true);
      Follower_Following? friends = await _userRepository.getFollowerFollowing(username);
      userFriends(friends);

    } catch (e) {
      print("Error fetching follower/following: $e");
    } finally {
      isLoadingFollowers(false);
    }
  }

  // Follow a user
  Future<void> followUser(String username) async {
    isLoading(true);
    errorMessage('');

    try {
      final result = await _userRepository.followUser(username);
      if (result == null) {
        errorMessage('مشکلی در دنبال کردن کاربر وجود دارد، لطفاً دوباره تلاش کنید.');
      }
      else {
        await fetchFollowerFollowing(username,true);
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> unfollowUser(String username) async {
    isLoading(true);
    errorMessage('');

    try {
      final result = await _userRepository.unfollowUser(username);
      if (result == null) {
        errorMessage('مشکلی در لغو دنبال کردن کاربر وجود دارد، لطفاً دوباره تلاش کنید.');
      }
      else {
        await fetchFollowerFollowing(username,true);
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> handleElevatedButton(UserViewModel userViewModel) async {
    if (username != null) {
      isLoading(true); // نمایش وضعیت بارگذاری

      if (isFollowing.value) {
        await unfollowUser(userProfile.value.username!);
      } else {
        await followUser(userProfile.value.username!);
      }

      isLoading(false); // پایان وضعیت بارگذاری
      // بررسی خطا و نمایش اسنک بار در صورت وجود
      if (errorMessage.isNotEmpty) {
        Get.snackbar('خطا', errorMessage.value,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8,
          margin: EdgeInsets.all(6.r),
          duration: const Duration(seconds: 3),
        );
      } else {
        isFollowing.value = !isFollowing.value; // تغییر وضعیت فالو
      }
    } else {
      final result = await Get.to(() => UserSearchPage(userSearchViewModel: userViewModel));
      if (result == true) {
        await userViewModel.fetchFollowerFollowing(null, true);
      }
    }
  }

  Future<void> logout() async {
    try {
      final response = await _userRepository.logout();
      if (response == null) {
        Get.snackbar('خطا', 'مشکلی در خروج از حساب کاربری وجود دارد، لطفاً دوباره تلاش کنید.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8,
          margin: EdgeInsets.all(6.0.r),
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.delete<SideBarController>(force: true);
        Get.offAllNamed(AppRouteName.signUpScreen);
      }
    } catch (e) {
      Get.snackbar('خطا', 'مشکلی در خروج از حساب کاربری وجود دارد، لطفاً دوباره تلاش کنید.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8,
        margin: EdgeInsets.all(6.0.r),
        duration: const Duration(seconds: 3),
      );
    }
  }


  Future<void> editProfile({
    required String firstName,
    required String username,
    required bool notifEnabled,
  }) async {
    try {
      isLoading(true);
      final result = await _userRepository.editProfile(
        firstName: firstName,
        username: username,
        notifEnabled: notifEnabled,
      );
      if (result == null) {
        Get.snackbar('خطا', 'مشکلی در ویرایش اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8,
          margin: EdgeInsets.all(6.0.r),
          duration: const Duration(seconds: 3),
        );
      } else {
        await fetchUserProfile(null,true);
        final box = GetStorage();
       box.write('username',username);
        Get.snackbar('', 'تغییرات با موفقیت اعمال شد.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.teal,
            colorText: Colors.white,
            borderRadius: 8,
            margin: EdgeInsets.all(4.0.r),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            duration: const Duration(seconds: 3));
        }
    } catch (e) {
      Get.snackbar('خطا','مشکلی در ویرایش اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8,
        margin: EdgeInsets.all(6.r),
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> changePhoto(String? path) async {
    try {
      isLoading(true);
      final result = await _userRepository.changePhoto(photo: path);
      if (result == null) {
        Get.snackbar('خطا', 'مشکلی در ویرایش اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          borderRadius: 8,
          margin: EdgeInsets.all(6.r),
          duration: const Duration(seconds: 3),
        );
      } else {
        await fetchUserProfile(null,true);
        Get.snackbar("", 'تغییرات با موفقیت اعمال شد.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.teal,
          colorText: Colors.white,
          borderRadius: 8,
          margin: EdgeInsets.all(4.0.r),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar('خطا', 'مشکلی در ویرایش اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        borderRadius: 8,
        margin: EdgeInsets.all(6.r),
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading(false);
    }
  }

  final RxList<Brief> userList = <Brief>[].obs; // لیستی که UI براساس آن آپدیت می‌شود.
  RxBool isSearched = false.obs;

  Future<void> searchUsersByUsername(String username) async {
    try {
      errorMessage.value = ''; // خالی کردن پیام خطا
      List<Brief>? users = await _userRepository.searchUsers(username);
      if (users != null ) {
        userList.assignAll(users);
      } else {
        errorMessage.value ="error";
      }
      isSearched.value=true;
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }
}
