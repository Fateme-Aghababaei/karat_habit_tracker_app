
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../viewmodel/user_viewmodel.dart';

class SettingsController extends GetxController {
  final box = GetStorage();
  final ImagePicker _picker = ImagePicker();
  final UserViewModel userViewModel = Get.find<UserViewModel>();
  RxBool isNotifEnabled = true.obs;
  // وضعیت صدا
  RxBool isSoundOn = true.obs;


  @override
  void onInit() {
    super.onInit();
    isSoundOn.value = box.read('isSoundOn') ?? true;
    isNotifEnabled.value = box.read('isNotifEnabled') ?? true;
  }

  void toggleNotifEnabled(bool value) {
    isNotifEnabled.value = value;
    box.write('isNotifEnabled', value);
  }


  // تغییر وضعیت صدا و ذخیره در GetStorage
  void toggleSound(bool value) {
    isSoundOn.value = value;
    box.write('isSoundOn', value);
  }

  String? validateName(String? value) {
    if (value == null || value.trim()=='') {
      return 'لطفا نام خود را وارد کنید';
    }
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.trim()=='') {
      return 'لطفا نام کاربری خود را وارد کنید';
    }
    return null;
  }

  Future<void> requestCameraPermission() async {
    PermissionStatus cameraPermission = await Permission.camera.status;

    if (cameraPermission.isPermanentlyDenied) {
      await openAppSettings();
      return;
    }

    if (cameraPermission.isDenied) {
      cameraPermission = await Permission.camera.request();
      if (cameraPermission.isDenied) {
        Get.snackbar('دسترسی دوربین رد شد', 'برای استفاده از دوربین نیاز به مجوز دارید.',
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  Future<void> requestGalleryPermission() async {
    PermissionStatus galleryPermission = await Permission.storage.status;

    if (galleryPermission.isPermanentlyDenied) {
      await openAppSettings();
      return;
    }

    if (galleryPermission.isDenied) {
      galleryPermission = await Permission.storage.request();
      if (galleryPermission.isDenied) {
        Get.snackbar('دسترسی به گالری رد شد', 'برای استفاده از گالری نیاز به مجوز دارید.',
            snackPosition: SnackPosition.TOP);
      }
    }
  }

  Future<void> pickImageFromGallery() async {
    await requestGalleryPermission();

    if (await Permission.storage.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        userViewModel.changePhoto(image.path);
      }
    } else {
      Get.snackbar('دسترسی به گالری رد شد', 'برای استفاده از گالری نیاز به مجوز دارید.',
          snackPosition: SnackPosition.TOP);
    }
  }

  Future<void> captureImageWithCamera() async {
    await requestCameraPermission();

    if (await Permission.camera.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        userViewModel.changePhoto(image.path);
      }
    } else {
      Get.snackbar('دسترسی به دوربین رد شد', 'برای استفاده از دوربین نیاز به مجوز دارید.',
          snackPosition: SnackPosition.TOP);
    }
  }


  Future<void> showImagePicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library,size: 20,),
                title:  Text('انتخاب از گالری',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp),),
                onTap: () async {
                  await pickImageFromGallery();
                 Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera,size: 20),
                title:  Text('باز کردن دوربین',style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp),),
                onTap: () async {
                  await captureImageWithCamera();
                  Get.back();                },
              ),
              ListTile(
                leading: const Icon(Icons.delete,size: 20),
                title:  Text('حذف تصویر فعلی',style:userViewModel.userProfile.value.photo!=null
                    ? Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp)
                    :Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp,color: Theme.of(context).disabledColor),),
                onTap: () {
                  if(userViewModel.userProfile.value.photo!=null)
                    {userViewModel.changePhoto(null);
                    Get.back(); }
                  else{
                    null;
                  }
                                 },
              ),
            ],
          ),
        );
      },
    );
  }
}
