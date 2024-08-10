import 'package:get/get.dart';
import '../../viewmodel/user_viewmodel.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<UserViewModel>(() => UserViewModel(Get.arguments as String?));
  }

}
