import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  final SideBarController sideBarController = Get.find();

  @override
  void onInit() {
    super.onInit();
    _loadTodayHabits();
  }

  Future<void> _loadTodayHabits() async {
      await loadUserHabits(todayDate);
  }

  void _loadHabitsFromStorage() {
    var storedHabits = _storage.read<List>('habits'); // خواندن لیست عادت‌ها به عنوان List<dynamic>
    if (storedHabits != null) {
      habits.assignAll(storedHabits.map((habit) => Habit.fromJson(habit)).toList());
    }
  }
  Future<void> updateStreak() async {
    isLoading.value = true;
    try {
      final result = await _userRepository.updateStreak();
      if (result != null && result['state'] != 'unchanged') {
        streakData.value = result;
        _showStreakUpdateModal(result);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _showStreakUpdateModal(Map<String, dynamic> result) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Streak Update',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Your streak has ${result['state']} to ${result['streak']}!',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text('Close'),
            ),
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
    isLoading(true);
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
    } finally {
      isLoading(false);
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
    required String today,
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
        habits.add(newHabit);

        // فقط اگر تاریخ مربوط به امروز باشد، در GetStorage ذخیره می‌کنیم
        if (today == todayDate) {
          _saveHabitsToStorage();
        }
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
    required String today,
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
        int index = habits.indexWhere((habit) => habit.id == id);
        if (index != -1) {
          habits[index] = updatedHabit;
          habits.refresh();  // Refresh the list to update the UI

          // فقط اگر تاریخ مربوط به امروز باشد، در GetStorage ذخیره می‌کنیم
          if (today == todayDate) {
            _saveHabitsToStorage();
          }
        }
      }
    } catch (e) {
      print("Error editing habit: $e");
    }
  }

  // Delete Habit
  Future<void> deleteHabit(int id, String today) async {
    try {
      await _habitRepository.deleteHabit(id);
      habits.removeWhere((habit) => habit.id == id);
      habits.refresh();

      // عادت‌های باقی‌مانده را در GetStorage ذخیره می‌کنیم
      if (today == todayDate) {
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
  Future<void> loadUserHabits(String date) async {
    isLoading(true);
    try {
      var loadedHabits = await _habitRepository.getUserHabits(date);
      if (loadedHabits != null) {
        habits.assignAll(loadedHabits);
        if (date == todayDate) {
          _saveHabitsToStorage();
        }
      } else {
        _loadHabitsFromStorage();
      }
    } catch (e) {
      print("Error loading habits: $e");
      _loadHabitsFromStorage();
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
