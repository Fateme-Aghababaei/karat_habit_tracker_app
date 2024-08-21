import 'dart:collection';
import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:get_storage/get_storage.dart';  // اضافه کردن GetStorage
import '../model/entity/tag_model.dart';
import '../model/entity/track_model.dart';
import '../model/repositories/track_repository.dart';

class TrackViewModel extends GetxController {

  final TrackRepository _trackRepository = TrackRepository();
  final box = GetStorage();
  var isLoading = false.obs;
  var tracksMap = <String, List<Track>>{}.obs;
  var currentTrack = Track(startDatetime: '', endDatetime: '').obs;
  var tagsList = <Tag>[].obs; // لیست تگ‌ها
  final RxBool isTextInputVisible = false.obs;
  final RxBool isStopwatchRunning = false.obs;
  final RxBool isAddPressed = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserTracks();
  }

  Future<void> _loadUserTracks() async {
    await getUserTracks();
  }

  // اضافه کردن Track
  Future<void> addTrack(String? name, String startDatetime,String endDatetime, {int? tagId}) async {
    try {
      final track = await _trackRepository.addTrack(name, startDatetime,endDatetime, tagId: tagId);
      if (track != null) {
        String dateKey = startDatetime.split('T')[0];
        if (tracksMap.containsKey(dateKey)) {
          tracksMap[dateKey]!.insert(0, track);  // اضافه کردن ترک جدید به ابتدای لیست
          tracksMap.refresh();
        } else {
          final newMap = LinkedHashMap<String, List<Track>>();
          newMap[dateKey] = [track];
          newMap.addAll(tracksMap);
          tracksMap.value = newMap;
        }

        _saveTracksToStorage();
      } else {
        Get.snackbar('Error', 'Failed to add track');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // ذخیره ترک‌ها در GetStorage
  void _saveTracksToStorage() {
    box.write('tracksMap', tracksMap);
  }

  // بازیابی ترک‌ها از GetStorage
  void _loadTracksFromStorage() {
    final storedTracks = box.read('tracksMap');
    if (storedTracks != null) {
      tracksMap.assignAll(storedTracks) ;
    }
  }

  // دریافت لیست Track ها
  Future<void> getUserTracks({int page = 1, int itemsPerPage = 3}) async {
    try {
      isLoading(true);
      final tracks = await _trackRepository.getUserTracks(page: page, itemsPerPage: itemsPerPage);
      if (tracks != null) {
         // پاک کردن Map قبل از اضافه کردن داده‌های جدید
        tracksMap.assignAll(tracks);

        if (itemsPerPage == 3) {
          _saveTracksToStorage();
        }

      } else {
        _loadTracksFromStorage();
      }
    } catch (e) {
      _loadTracksFromStorage();
    } finally {
      isLoading(false);
    }
  }

  // ویرایش Track
  Future<void> editTrack(int? id, String name, {int? tagId}) async {
    try {
      final track = await _trackRepository.editTrack(id!, name, tagId: tagId);
      if (track != null) {
        tracksMap.forEach((dateKey, trackList) {
          int index = trackList.indexWhere((element) => element.id == id);
          if (index != -1) {
            trackList[index] = track;
            tracksMap.refresh();

          }
        });
        _saveTracksToStorage();
      } else {
        Get.snackbar('Error', 'Failed to edit track');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // اتمام Track
  Future<void> finishTrack(int id, String endDatetime) async {
    try {
      isLoading(true);
      final track = await _trackRepository.finishTrack(id, endDatetime);
      if (track != null) {
        tracksMap.forEach((dateKey, trackList) {
          int index = trackList.indexWhere((element) => element.id == id);
          if (index != -1) {
            trackList[index] = track;
          }
        });
      } else {
        Get.snackbar('Error', 'Failed to finish track');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // دریافت یک Track خاص
  Future<void> getTrack(int? id) async {
    try {
      final track = await _trackRepository.getTrack(id!);
      if (track != null) {
        currentTrack(track);
      } else {
        Get.snackbar('Error', 'Track not found');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // دریافت لیست تگ‌ها
  Future<void> loadUserTags() async {

    try {
      var loadedTags = await _trackRepository.getUserTags();
      if (loadedTags != null) {
        tagsList.assignAll(loadedTags);
        _saveTagsToStorage();
      } else {
        tagsList.clear();
        _loadTagsFromStorage();
      }
    } catch (e) {
      print("Error loading tags: $e");
      _loadTagsFromStorage();
    }
  }

  Future<void> addTag(String name, String color) async {
    try {
      var newTag = await _trackRepository.addTag(name, color, "your_token_here");
      if (newTag != null) {
        tagsList.add(newTag);
        _saveTagsToStorage();
      }
    } catch (e) {
      print("Error adding tag: $e");
    }
  }

  void _loadTagsFromStorage() {
    var storedTags = box.read<List>('tags'); // خواندن لیست تگ‌ها به عنوان List<dynamic>
    if (storedTags != null) {
      print("gfgf");
      tagsList.assignAll(storedTags.map((tag) => Tag.fromJson(tag)).toList());
    }
  }
  void _saveTagsToStorage() {
    List<Map<String, dynamic>> tagList = tagsList.map((tag) => tag.toJson()).toList();
    box.write('tags', tagList);
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
