import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import '../model/entity/track_model.dart';
import '../model/repositories/track_repository.dart';

class TrackViewModel extends GetxController {
  final TrackRepository _trackRepository = TrackRepository();

  var isLoading = false.obs;
  var tracksMap = <String, List<Track>>{}.obs;
  var currentTrack = Track().obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserTracks();
  }

  Future<void> _loadUserTracks() async {
    await getUserTracks();
  }

  // اضافه کردن Track
  Future<void> addTrack(String name, String startDatetime, {int? tagId}) async {
    try {
      isLoading(true);
      final track = await _trackRepository.addTrack(name, startDatetime, tagId: tagId);
      if (track != null) {
        // فرض بر این است که تاریخ startDatetime در قالب 'YYYY-MM-DD' است.
        String dateKey = startDatetime.split('T')[0];
        if (tracksMap.containsKey(dateKey)) {
          tracksMap[dateKey]!.add(track);
        } else {
          tracksMap[dateKey] = [track];
        }
      } else {
        Get.snackbar('Error', 'Failed to add track');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // ویرایش Track
  Future<void> editTrack(int id, String name, {int? tagId}) async {
    try {
      isLoading(true);
      final track = await _trackRepository.editTrack(id, name, tagId: tagId);
      if (track != null) {
        tracksMap.forEach((dateKey, trackList) {
          int index = trackList.indexWhere((element) => element.id == id);
          if (index != -1) {
            trackList[index] = track;
          }
        });
      } else {
        Get.snackbar('Error', 'Failed to edit track');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
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
  Future<void> getTrack(int id) async {
    try {
      isLoading(true);
      final track = await _trackRepository.getTrack(id);
      if (track != null) {
        currentTrack(track);
      } else {
        Get.snackbar('Error', 'Track not found');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // دریافت لیست Track ها
  Future<void> getUserTracks({int page = 1, int itemsPerPage = 7}) async {
    try {
      isLoading(true);
      final tracks = await _trackRepository.getUserTracks(page: page, itemsPerPage: itemsPerPage);
      if (tracks != null) {
        tracksMap.clear(); // پاک کردن Map قبل از اضافه کردن داده‌های جدید
        tracks.forEach((date, trackList) {
          tracksMap[date] = trackList; // اضافه کردن داده‌های جدید به Map
        });
      } else {
        Get.snackbar('Error', 'Failed to load tracks');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
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
