import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';

import '../../../model/entity/brief_model.dart';
import '../../../model/entity/user_model.dart';
import '../../../model/repositories/notification_repository.dart';
import '../../../model/repositories/user_repository.dart';
import '../../../viewmodel/challenge_viewmodel.dart';

class SideBarController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  var selectedIndex = 0.obs;
  var shouldRefreshChallengePage = false.obs;
  final NotificationRepository _notificationRepository = NotificationRepository();
  var unreadCount = 0.obs;

  // اطلاعات کاربر
  RxString firstName = ''.obs;
  RxString userName = ''.obs;
  RxString userPhoto = ''.obs;
  RxInt userScore = 0.obs;

  Future<void> fetchUserBrief() async {
    try {
      Brief userBrief = await _userRepository.getUserBrief();
      firstName.value = userBrief.firstName ;
      userName.value = userBrief.username;
      userPhoto.value = userBrief.photo! ;
      userScore.value = userBrief.score! ;

        } catch (e) {
      final box = GetStorage();
      final storedData = box.read('userBrief');
      if (storedData != null) {
        Brief userBrief = Brief.fromJson(storedData);
        firstName.value = userBrief.firstName;
        userName.value = userBrief.username;
        userPhoto.value = userBrief.photo ?? '';
        userScore.value = userBrief.score ?? 0;
      } else {
        Get.snackbar('خطا', 'مشکلی در بارگذاری اطلاعات وجود دارد، لطفاً دوباره تلاش کنید.');
      }
    }
  }
  Future<void> fetchUnreadNotificationsCount() async {
    try {
      final int count = await _notificationRepository.getUnreadNotificationsCount();
      unreadCount.value = count;
    } catch (e) {

    }
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
  void updateScore(int index) {
    userScore.value =userScore.value+ index;
  }
  void reduceScore(int index) {
    userScore.value =userScore.value- index;
  }
  void refreshChallengePage() {
    final ChallengeViewModel challengeViewModel = Get.put(ChallengeViewModel());
    challengeViewModel.onInit();

  }
  Future<void> fetchUser() async {
    await fetchUserBrief();
    await fetchUnreadNotificationsCount();
  }
  // فراخوانی اولیه در زمان ساخت کنترلر
  @override
  void onInit() {
    fetchUser();
    super.onInit();
  }
}
