import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/entity/challenge_model.dart';
import '../../model/entity/habit_model.dart';
import '../../model/repositories/habit_repository.dart';

class HabitChallengeController extends GetxController {
  var selectedTab = 0.obs;
  var titleController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var selectedDays = '0000000'.obs;
  var allDaysSelected = false.obs;
  var isSaveButtonEnabled = false.obs;
  final Habit? habit;
  var updatedHabit = Rxn<Habit>();
  final Rx<DateTime> today;
  final HabitRepository habitRepository = HabitRepository();
  final Rxn<Challenge> challenge;


  HabitChallengeController(this.today, this.challenge, {this.habit});

  @override
  @override
  void onInit() {
    super.onInit();

    final habit = this.habit;
    if (habit != null) {
      titleController.value.text = habit.name;
      descriptionController.value.text = habit.description ?? '';
      selectedDays.value = habit.repeatedDays ?? '0000000';
      selectedTab.value = habit.isRepeated ? 0 : 1;



      if (selectedDays.value == '1111111') {
        allDaysSelected.value = true;
      }
    }

    titleController.value.addListener(updateSaveButtonState);
    descriptionController.value.addListener(updateSaveButtonState);
    ever(selectedTab, (_) => updateSaveButtonState());
    ever(selectedDays, (_) => updateSaveButtonState());
  }

  void updateSaveButtonState() {
    if (selectedTab.value == 0) {
      isSaveButtonEnabled.value =
          selectedDays.value.contains('1') && titleController.value.text.isNotEmpty;
    } else {
      isSaveButtonEnabled.value =
          titleController.value.text.isNotEmpty ;
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



  Future<Habit?> saveHabitOrTask() {
    if (habit == null) {
       return _addHabit();
    } else {
       return _editHabit();
    }
  }

  Future<Habit?>  _addHabit() async {
    try {
      var updatedHabit = await habitRepository.addHabit(
        name:titleController.value.text,
        description:descriptionController.value.text==''?null:descriptionController.value.text,
        tagId: null,
        dueDate:challenge.value!.endDate,
        isRepeated:selectedTab.value==0?true:false,
        repeatedDays:selectedTab.value==0?selectedDays.value:null,
      );

      if (updatedHabit != null) {
        return updatedHabit;
      }
    } catch (e) {
      print("Error adding habit: $e");
      Get.snackbar('خطا', 'عملیات به درستی انجام نشد، لطفاً دوباره تلاش کنید.');
      return null;
    }
    return null;

  }

  Future<Habit?> _editHabit() async {
    print(habit!.id);
    try {
      Habit? updatedHabit = await habitRepository.editHabit(
        id: habit!.id,
        name:titleController.value.text,
        description:descriptionController.value.text==''?null:descriptionController.value.text,
        tagId: null,
        dueDate:challenge.value!.endDate,
        isRepeated:selectedTab.value==0?true:false,
        repeatedDays:selectedTab.value==0?selectedDays.value:null,
      );

      if (updatedHabit != null) {
       return updatedHabit;
      }
    } catch (e) {
      print("Error editing habit: $e");
      Get.snackbar('خطا', 'عملیات به درستی انجام نشد، لطفاً دوباره تلاش کنید.');
      return null;
    }
    return null;
  }

}
