import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../../model/entity/habit_model.dart';
import '../../viewmodel/habit_viewmodel.dart';

class HabitBottomSheetController extends GetxController {
  var selectedTab = 0.obs;
  var titleController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var selectedDays = '0000000'.obs;
  var selectedTag = Rxn<int>();
  var allDaysSelected = false.obs;
  var isSaveButtonEnabled = false.obs;
  var selectedDate = ''.obs;
  var selectedShamsiDate = ''.obs;
  final Habit? habit;
  final HabitViewModel habitViewModel;

  HabitBottomSheetController(this.habitViewModel, {this.habit});

  @override
  void onInit() {
    super.onInit();

    final habit = this.habit;
    if (habit != null) {
      titleController.value.text = habit.name ;
      descriptionController.value.text = habit.description ?? '';
      selectedDays.value = habit.repeatedDays ?? '0000000';
      selectedTag.value = habit.tag?.id;
      selectedDate.value = habit.dueDate ?? '';

      // Convert the saved date to Jalali and set it for display
      if (selectedDate.value.isNotEmpty) {
        final gregorianDate = DateTime.parse(selectedDate.value);
        final jalaliDate = Gregorian.fromDateTime(gregorianDate).toJalali();
        selectedShamsiDate.value =
        '${jalaliDate.year}/${jalaliDate.month.toString().padLeft(2, '0')}/${jalaliDate.day.toString().padLeft(2, '0')}';
      }

      if (selectedDays.value == '1111111') {
        allDaysSelected.value = true;
      }

      // Update the tab based on whether it's a daily task or a habit
      if (habit.isRepeated ) {
        selectedTab.value = 1;
      } else {
        selectedTab.value = 0;
      }
    }

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



  void saveHabitOrTask() {
    if (habit == null) {
      _addHabit();
    } else {
      _editHabit();
    }
  }

  void _addHabit() {
    habitViewModel.addHabit(
        name:titleController.value.text,
        description:descriptionController.value.text==''?null:descriptionController.value.text,
        tagId: selectedTag.value,
        dueDate:selectedDate.value,
        isRepeated:selectedTab.value==0?true:false,
        repeatedDays:selectedTab.value==0?selectedDays.value:null,
        today: DateTime.now().toIso8601String().split('T')[0]) ;
    print('Adding new habit');
    Get.back();
  }

  void _editHabit() {
    habitViewModel.editHabit(
        id: habit!.id,
        name:titleController.value.text,
        description:descriptionController.value.text==''?null:descriptionController.value.text,
        tagId: selectedTag.value,
        dueDate:selectedDate.value,
        isRepeated:selectedTab.value==0?true:false,
        repeatedDays:selectedTab.value==0?selectedDays.value:null,
        today: DateTime.now().toIso8601String().split('T')[0]) ;
    print('Editing existing habit');
    Get.back();
  }
}
