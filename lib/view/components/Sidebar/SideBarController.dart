import 'package:get/get.dart';

import '../../../model/entity/user_model.dart';
import '../../../model/repositories/user_repository.dart';

class SideBarController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  var selectedIndex = 0.obs;
  // اطلاعات کاربر
  var firstName = ''.obs;
  var userName = ''.obs;
  var userPhoto = ''.obs;
  var userScore = 0.obs;

  Future<void> fetchUserBrief() async {
    try {
      UserModel? userBrief = await _userRepository.getUserBrief();
      if (userBrief != null) {
        firstName.value = userBrief.firstName ?? '';
        userName.value = userBrief.username ?? '';
        userPhoto.value = userBrief.photo ?? '';
        userScore.value = userBrief.score ?? 0;
      }
    } catch (e) {
      Get.snackbar('خطا', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }
  // فراخوانی اولیه در زمان ساخت کنترلر
  @override
  void onInit() {
    fetchUserBrief();
    super.onInit();
  }
}
