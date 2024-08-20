import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../model/entity/challenge_model.dart';
import 'package:intl/intl.dart';

import '../../model/entity/habit_model.dart';
import '../components/Sidebar/SideBarController.dart'; // برای مدیریت تاریخ

class SpecificChallengeController extends GetxController {
  final Rxn<Challenge> challenge;
  final bool isFromMyChallenges;
  final SideBarController sideBarController = Get.find();

  SpecificChallengeController({required this.challenge, required this.isFromMyChallenges});

  var username = ''.obs;
  var hasJoined = false.obs;
  var isOwner = false.obs;
  var canEdit = false.obs;
  var canJoin = false.obs;
  var canJoinButDisabled = false.obs; // اضافه کردن متغیر برای غیرفعال کردن دکمه
  var canSave = false.obs;

  List<Habit> originalHabits = [];

  @override
  void onInit() {
    super.onInit();
    originalHabits = List.from(challenge.value!.habits); // ذخیره عادات اولیه برای مقایسه بعدی
    _loadUserData();
    _checkConditions();
  }

  Future<void> _loadUserData() async {
    GetStorage box = GetStorage();
    username.value = box.read('username');

    // بررسی اینکه آیا کاربر شرکت کرده است یا نه
    hasJoined.value = challenge.value!.participants.any((participant) => participant.username == username.value);
    // بررسی اینکه آیا کاربر سازنده چالش است یا نه
    isOwner.value = challenge.value!.createdBy.username == username.value;

    _checkConditions();
  }

  void _checkConditions() {
    // بررسی زمان شروع چالش
    DateTime now = DateTime.now();
    DateTime startDate = DateFormat('yyyy-MM-dd').parse(challenge.value!.startDate);

    // بررسی اینکه آیا می‌تواند چالش را ادیت کند
    if (isOwner.value && challenge.value!.participants.length <= 1 && now.isBefore(startDate)) {
      canEdit.value = true;
    } else {
      canEdit.value = false;
    }

    // بررسی اینکه آیا می‌تواند در چالش شرکت کند
    if (!hasJoined.value && now.isBefore(startDate)) {
      if (sideBarController.userScore >= challenge.value!.price) {
        canJoin.value = true;
        canJoinButDisabled.value = false; // فعال کردن دکمه اگر امتیاز کافی باشد
      } else {
        canJoin.value = true;
        canJoinButDisabled.value = true; // غیرفعال کردن دکمه اگر امتیاز کافی نباشد
      }
    } else {
      canJoin.value = false;
      canJoinButDisabled.value = false;
    }
  }

  void editHabit(int index, String newName) {
    // challenge.habits[index].name = newName;
    canSave.value = true; // فعال‌سازی دکمه ذخیره تغییرات
  }

  void deleteHabit(int index) {
    challenge.value!.habits.removeAt(index);
    canSave.value = true; // فعال‌سازی دکمه ذخیره تغییرات
  }

  void addHabit(Habit habit) {
    challenge.value!.habits.add(habit);
    canSave.value = true; // فعال‌سازی دکمه ذخیره تغییرات
  }

  void joinChallenge() {
    // کدی برای پیوستن به چالش
    hasJoined.value = true;
    _checkConditions(); // به‌روزرسانی شرایط پس از پیوستن به چالش
  }

  String convertToJalali(String date) {
    // تقسیم تاریخ برای بدست آوردن سال، ماه و روز
    List<String> parts = date.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    final Jalali jalaliDate = Gregorian(year, month, day).toJalali();
    final f = jalaliDate.formatter;
    return '${f.d} ${f.mN}';
  }
}
