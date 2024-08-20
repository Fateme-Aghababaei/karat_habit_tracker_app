import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../viewmodel/challenge_viewmodel.dart';

class AddChallengeController extends GetxController {
  final ChallengeViewModel challengeViewModel;

  AddChallengeController({required this.challengeViewModel});

  final ImagePicker _picker = ImagePicker();

  // کنترلر‌های TextField‌ها
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // متغیرهای تاریخ

  var selectedShamsiEndDate = ''.obs;
  var selectedEndDate = ''.obs;
  var selectedShamsiStartDate = ''.obs; // تاریخ شمسی برای نمایش به کاربر
  var selectedStartDate = ''.obs; // تاریخ میلادی برای استفاده داخلی
  // متغیر تصویر
  var selectedImagePath = ''.obs;

  // وضعیت فعال بودن دکمه ذخیره
  var isSaveButtonEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(() {
      updateSaveButtonState();
    });
    descriptionController.addListener(() {
      updateSaveButtonState();
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  void updateSaveButtonState() {
    isSaveButtonEnabled.value = nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
       selectedShamsiStartDate.value.isNotEmpty &&
        selectedShamsiEndDate.value.isNotEmpty;
  }


  Future<void> pickStartDate(BuildContext context) async {
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1385, 8),
      lastDate: Jalali(1450, 9),
    );
    if (picked != null) {
      // ذخیره تاریخ شمسی برای نمایش به کاربر
      String formattedJalaliDate = "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
      selectedShamsiStartDate.value = formattedJalaliDate;

      // تبدیل تاریخ شمسی به میلادی و ذخیره آن برای استفاده داخلی
      Gregorian gregorianDate = picked.toGregorian();
      String formattedGregorianDate = "${gregorianDate.year.toString().padLeft(4, '0')}-${gregorianDate.month.toString().padLeft(2, '0')}-${gregorianDate.day.toString().padLeft(2, '0')}";
      selectedStartDate.value = formattedGregorianDate;
      updateSaveButtonState();
    }
  }


  Future<void> pickEndDate(BuildContext context) async {
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate: Jalali.now(),
      firstDate: Jalali(1385, 8),
      lastDate: Jalali(1450, 9),
    );
    if (picked != null) {
      String formattedJalaliDate = "${picked.year}/${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}";
      selectedShamsiEndDate.value = formattedJalaliDate;
      Gregorian gregorianDate = picked.toGregorian();
      String formattedGregorianDate = "${gregorianDate.year.toString().padLeft(4, '0')}-${gregorianDate.month.toString().padLeft(2, '0')}-${gregorianDate.day.toString().padLeft(2, '0')}";
      selectedEndDate.value = formattedGregorianDate;
      updateSaveButtonState();
    }
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
        selectedImagePath.value = image.path;
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
        selectedImagePath.value = image.path;
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
                leading: const Icon(Icons.photo_library, size: 20),
                title: Text(
                  'انتخاب از گالری',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp),
                ),
                onTap: () async {
                  await pickImageFromGallery();
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, size: 20),
                title: Text(
                  'باز کردن دوربین',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp),
                ),
                onTap: () async {
                  await captureImageWithCamera();
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete,size: 20),
                title:  Text('حذف تصویر فعلی',style:selectedImagePath.value.isNotEmpty
                    ? Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp)
                    :Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14.sp,color: Theme.of(context).disabledColor),),
                onTap: () {
                  if(selectedImagePath.value.isNotEmpty)
                  {
                    selectedImagePath.value='';
                    Get.back();
                  }
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

  void saveChallenge() {

    challengeViewModel.addChallenge(
      name: nameController.text,
      description: descriptionController.text,
      startDate: selectedStartDate.value,
      endDate: selectedEndDate.value,
      photo: selectedImagePath.value.isNotEmpty ? selectedImagePath.value : null,
    );
    Get.back(); // بسته شدن باتم شیت
  }

  void resetForm() {
    nameController.clear();
    descriptionController.clear();
    selectedStartDate.value = '';
    selectedEndDate.value = '';
    selectedImagePath.value = '';
    selectedShamsiEndDate.value='';
    selectedShamsiStartDate.value='';
    isSaveButtonEnabled.value = false;
  }
}
