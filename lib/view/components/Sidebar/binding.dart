import 'package:get/get.dart';
import 'SideBarController.dart';

class SideBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SideBarController>(SideBarController(), permanent: true);
  }
}
