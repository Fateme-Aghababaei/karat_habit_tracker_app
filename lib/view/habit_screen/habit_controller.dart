import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HabitBottomSheetController extends GetxController {
  // متغیر برای ذخیره تب انتخاب شده
  var selectedTab = 0.obs; // 0: عادت، 1: کار روزانه

  // کنترلرهای متن برای مدیریت ورودی‌های عنوان و توضیحات
  var titleController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;

  // متغیر برای ذخیره انتخاب روزهای تکرار
  var selectedDays = '0000000'.obs; // رشته‌ی 7 کاراکتری برای ذخیره انتخاب روزها

  // متغیر برای ذخیره تگ انتخاب شده
  var selectedTag = ''.obs;

  // متغیر برای ذخیره وضعیت انتخاب تمام روزها
  var allDaysSelected = false.obs;

  // متغیر برای مدیریت وضعیت دکمه "ذخیره"
  var isSaveButtonEnabled = false.obs;

  // متغیر برای ذخیره تاریخ انتخاب شده
  var selectedDate = ''.obs;
  // متغیر برای ذخیره تاریخ به صورت شمسی (فقط برای نمایش)
  var selectedShamsiDate = ''.obs;

  void setSelectedDate(String date) {
    selectedDate.value = date;
    updateSaveButtonState();
  }

  void setSelectedShamsiDate(String date) {
    selectedShamsiDate.value = date;
  }

  @override
  void onInit() {
    super.onInit();
    titleController.value.addListener(updateSaveButtonState);
    descriptionController.value.addListener(updateSaveButtonState);
    ever(selectedTab, (_) => updateSaveButtonState());
    ever(selectedDays, (_) => updateSaveButtonState());
    ever(selectedDate, (_) => updateSaveButtonState());
  }

  void updateSaveButtonState() {
    if (selectedTab.value == 0) {
      isSaveButtonEnabled.value =
          selectedDays.value.contains('1') && titleController.value.text.isNotEmpty;
    } else {
      isSaveButtonEnabled.value =
          titleController.value.text.isNotEmpty && selectedDate.value.isNotEmpty;
    }
  }

  void setAllDaysSelected(bool isSelected) {
    allDaysSelected.value = isSelected;
    if (isSelected) {
      selectedDays.value = '1111111';
    } else {
      selectedDays.value = '0000000';
    }
  }

  void setSelectedTab(int index) {
    selectedTab.value = index;
  }

  void toggleDaySelection(int index) {
    String current = selectedDays.value;
    if (current[index] == '1') {
      selectedDays.value = current.replaceRange(index, index + 1, '0');
    } else {
      selectedDays.value = current.replaceRange(index, index + 1, '1');
    }
  }

  void setSelectedTag(String tag) {
    selectedTag.value = tag;
  }

  void saveHabitOrTask() {
    // انجام عملیات ذخیره عادت یا کار روزانه
  }
}
