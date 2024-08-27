import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/constant.dart';
import '../model/entity/habit_model.dart';
import '../model/entity/tag_model.dart';
import '../model/repositories/habit_repository.dart';
import '../model/repositories/user_repository.dart';
import '../view/components/Sidebar/SideBarController.dart';

class HabitViewModel extends GetxController {
  final UserRepository _userRepository = UserRepository();
  final HabitRepository _habitRepository = HabitRepository();
  final RxBool isLoading = false.obs;
  final RxMap<String, dynamic> streakData = <String, dynamic>{}.obs;
  var tags = <Tag>[].obs;
  var habits = <Habit>[].obs;
  var selectedHabit = Rxn<Habit>();
  final GetStorage _storage = GetStorage();
  final String todayDate = DateTime.now().toIso8601String().split('T')[0];
  Rx<String> initialSelectedDate = DateTime.now().toIso8601String().split('T')[0].obs;
  final SideBarController sideBarController =   Get.find<SideBarController>();
  final BuildContext context;
  HabitViewModel(this.context);
  @override
  void onInit() {
    super.onInit();
    _loadTodayHabits();
  }

  Future<void> _loadTodayHabits() async {
      await loadUserHabits(todayDate,true);
      await loadUserTags();
       await updateStreak();
  }

  void _loadHabitsFromStorage() {
    var storedHabits = _storage.read<List>('habits'); // خواندن لیست عادت‌ها به عنوان List<dynamic>
    if (storedHabits != null) {
      habits.assignAll(storedHabits.map((habit) => Habit.fromJson(habit)).toList());
    }
  }
  Future<void> updateStreak() async {
    try {
      final result = await _userRepository.updateStreak();

      if (result != null && result['state'] != 'unchanged') {
        streakData.value = result;

        // ابتدا دیالوگ بروزرسانی استریک را نمایش بده
         _showStreakUpdateModal(result);

        // چک کردن اینکه نشان جدیدی وجود دارد یا خیر
        if (result['has_new_badges'] == true) {
          // دریافت نشان‌های جدید
          final newBadges = await _userRepository.getNewBadges();
          if (newBadges != null && newBadges.isNotEmpty) {
            // نمایش نشان‌های جدید
            for (var badge in newBadges) {
              await Get.dialog(
                AlertDialog(
                  title: Column(
                    children: [
                      Text(
                        '🎉تبریک',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8.r),
                      Text(
                        'شما یک نشان جدید دریافت کردید!',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.network(
                          '$baseUrl${badge.image}',
                          height: MediaQuery.of(context).size.height * 0.24
                      ),
                      SizedBox(height: 8.0.r),
                      Text(
                        badge.description ?? 'توضیحی موجود نیست',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.r),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back(); // Close the current modal
                      },
                      child: Text(
                        'بستن',
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void _showStreakUpdateModal(Map<String, dynamic> result) {
    Get.bottomSheet(
      Container(
        padding:  EdgeInsets.only(left: 4.0.r,right: 4.0.r, bottom: 12.0.r),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // دکمه ضربدر در بالا گوشه سمت راست
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ),
            Text(
              '${result['streak']} روز توالی',
              style: TextStyle(
                fontFamily: "IRANYekan_number",
                fontSize: 26.sp
              ),
            ),
            SizedBox(height: 16.0.r),
            // Stack for Image and Icon Overlay
                Image.asset(
                  'assets/images/k.png', // مسیر تصویر آتش‌ها
                ),
            SizedBox(height: 16.0.r),
            Text(
              '1 روز به توالی شما افزوده شد',
              style: TextStyle(
                fontSize: 18,
                fontFamily: "IRANYekan_number",
                color: Colors.grey.shade700, // رنگ دلخواه شما
              ),
            ),
            SizedBox(height: 16),
            // نوار پایین برای استریک

          ],
        ),
      ),
    );
  }


  void _loadTagsFromStorage() {
    var storedTags = _storage.read<List>('tags'); // خواندن لیست تگ‌ها به عنوان List<dynamic>
    if (storedTags != null) {
      tags.assignAll(storedTags.map((tag) => Tag.fromJson(tag)).toList());
    }
  }
  void _saveTagsToStorage() {
    List<Map<String, dynamic>> tagList = tags.map((tag) => tag.toJson()).toList();
    _storage.write('tags', tagList);
  }
  // Load User Tags
  Future<void> loadUserTags() async {
    try {
      var loadedTags = await _habitRepository.getUserTags();
      if (loadedTags != null) {
        tags.assignAll(loadedTags);
        _saveTagsToStorage();
      } else {
        tags.clear();
        _loadTagsFromStorage();
      }
    } catch (e) {
      print("Error loading tags: $e");
      _loadTagsFromStorage();
    }
  }

  // Add New Tag
  Future<void> addTag(String name, String color) async {
    try {
      var newTag = await _habitRepository.addTag(name, color, "your_token_here");
      if (newTag != null) {
        tags.add(newTag);
        _saveTagsToStorage();
      }
    } catch (e) {
      print("Error adding tag: $e");
    }
  }

  // Add New Habit
  Future<void> addHabit({
    required String name,
    required String? description,
    required int? tagId,
    required String? dueDate,
    required bool isRepeated,
    required String? repeatedDays,
  }) async {
    try {
      var newHabit = await _habitRepository.addHabit(
        name: name,
        description: description,
        tagId: tagId,
        dueDate: dueDate,
        isRepeated: isRepeated,
        repeatedDays: repeatedDays,
      );
      if (newHabit != null) {
        loadUserHabits(initialSelectedDate.value,false);

      }
    } catch (e) {
      print("Error adding habit: $e");
    }
  }

  // Edit Existing Habit
  Future<void> editHabit({
    required int id,
    required String name,
    required String? description,
    required int? tagId,
    required String? dueDate,
    required bool isRepeated,
    required String? repeatedDays,
  }) async {
    try {
      var updatedHabit = await _habitRepository.editHabit(
        id: id,
        name: name,
        description: description,
        tagId: tagId,
        dueDate: dueDate,
        isRepeated: isRepeated,
        repeatedDays: repeatedDays,
      );

      if (updatedHabit != null) {
        loadUserHabits(initialSelectedDate.value,false);
      }
    } catch (e) {
      print("Error editing habit: $e");
    }
  }

  // Delete Habit
  Future<void> deleteHabit(int id) async {
    try {
      await _habitRepository.deleteHabit(id);
      habits.removeWhere((habit) => habit.id == id);
      habits.refresh();

      // عادت‌های باقی‌مانده را در GetStorage ذخیره می‌کنیم
      if (initialSelectedDate == todayDate) {
        _saveHabitsToStorage();
      }
    } catch (e) {
      print("Error deleting habit: $e");
    }
  }

  // Get Habit by ID
  Future<void> getHabit(int? id) async {
    try {
      var habit = await _habitRepository.getHabit(id!);
      if (habit != null) {
        selectedHabit.value = habit;
      }
    } catch (e) {
      print("Error fetching habit: $e");
    }
  }

  // Get User Habits for a specific date
  final RxBool fetchError = false.obs; // متغیر برای نمایش خطا

  Future<void> loadUserHabits(String date, bool init) async {
    isLoading(init?true :false);
    fetchError(false); // قبل از شروع فچ کردن داده‌ها، مطمئن شوید که خطا روی false تنظیم شده است
    try {
      var loadedHabits = await _habitRepository.getUserHabits(date);
      if (loadedHabits != null) {
        habits.assignAll(loadedHabits);
        if (date == todayDate) {
          _saveHabitsToStorage();
        }
      } else if (loadedHabits == null && date == todayDate) {
        _loadHabitsFromStorage();
      } else {
        fetchError(true); // در صورت نبودن عادت‌ها، خطا را روی true تنظیم کنید
      }
    } catch (e) {
      print("Error loading habits: $e");
      if (date == todayDate) {
        _loadHabitsFromStorage();
      }
      else{fetchError(true);}
    } finally {
      isLoading(false);
    }
  }


  // Complete a Habit
  Future<void> completeHabit(int id, String dueDate,String today) async {
    try {
      var completedHabit = await _habitRepository.completeHabit(id, dueDate);
      if (completedHabit != null) {
        int index = habits.indexWhere((habit) => habit.id == id);
        if (index != -1) {
          habits[index] = completedHabit;
          habits.refresh();  // Refresh the list to update the UI
          if (today == todayDate) {
            _saveHabitsToStorage();
          }
          sideBarController.updateScore(completedHabit.score);
        }
      }
    } catch (e) {
      print("Error completing habit: $e");
    }
  }

  // ذخیره کردن عادت‌ها در GetStorage
  void _saveHabitsToStorage() {
    List<Map<String, dynamic>> habitList = habits.map((habit) => habit.toJson()).toList();
    _storage.write('habits', habitList);
  }
}
