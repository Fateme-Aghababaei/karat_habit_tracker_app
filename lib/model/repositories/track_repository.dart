

import '../constant.dart';
import '../entity/tag_model.dart';
import '../entity/track_model.dart';

class TrackRepository{

  Future<Track?> addTrack(String? name, String startDatetime,String endDatetime, {int? tagId}) async {
    try {
      final data = {
        'name': name,
        'start_datetime': startDatetime,
        'end_datetime': endDatetime
      };
      if (tagId != null) {
        data['tag'] = tagId.toString();
      }

      final response = await dio.post(
        'track/add_track/',
        data: data,
      );

      if (response.statusCode == 200) {
        return Track.fromJson(response.data);
      } else {
        final errorMessage = response.data['error'] ?? 'عملیات به درستی انجام نشد، لطفاً دوباره تلاش کنید.';
        throw Exception(errorMessage);  // بازگرداندن استثناء
      }
    } catch (e) {
      print('Error editing track: $e');
      return null;    }
  }
  Future<Track?> editTrack(int id, String name, {int? tagId}) async {
    try {
      final data = {
        'id': id,
        'name': name,
      };
      if (tagId != null) {
        data['tag'] = tagId.toString();
      }

      final response = await dio.post(
        'track/edit_track/',
        data:data
      );

      if (response.statusCode == 200) {
        return Track.fromJson(response.data);
      } else {
        final errorMessage = response.data['error'] ?? 'عملیات به درستی انجام نشد، لطفاً دوباره تلاش کنید.';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error editing track: $e');
      return null;
    }
  }

  Future<Track?> finishTrack(int id, String endDatetime) async {
    try {
      final response = await dio.post(
        'track/finish_track/',
        data: {
          'id': id,
          'end_datetime': endDatetime,
        },
      );
      if (response.statusCode == 200) {
        return Track.fromJson(response.data);
      } else {
        final errorMessage = response.data['error'] ?? 'An unknown error occurred';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error finishing track: $e');
      return null;
    }
  }

  Future<Track?> getTrack(int? id) async {
    try {
      final response = await dio.get(
        'track/get_track/',
        queryParameters: {
          'id': id,
        },
      );
      if (response.statusCode == 200) {
        return Track.fromJson(response.data);
      } else {
        final errorMessage = response.data['error'] ?? 'An unknown error occurred';
        throw Exception(errorMessage);
      }
    } catch (e) {
      print('Error getting track: $e');
      return null;
    }
  }

  Future<Map<String, List<Track>>?> getUserTracks({int page = 1, int itemsPerPage = 7}) async {
    try {
      final response = await dio.get(
        'track/get_user_tracks/',
        queryParameters: {
          'page': page,
          'item_per_page': itemsPerPage,
        },
      );

      if (response.statusCode == 200) {
        Map<String, List<Track>> tracksMap = {};

        for (var dayData in response.data) {
          String date = dayData['date'];
          List<Track> tracks = [];

          for (var trackData in dayData['tracks']) {
            tracks.add(Track.fromJson(trackData));
          }

          tracksMap[date] = tracks;
        }

        return tracksMap;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user tracks: $e');
      return null;
    }
  }

  Future<List<Tag>?> getUserTags() async {
    try {
      final response = await dio.get(
        'habit/get_user_tags/',
      );

      if (response.statusCode == 200) {
        List<Tag> tags = [];
        for (var tagData in response.data) {
          tags.add(Tag.fromJson(tagData));
        }
        return tags;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting tags: $e');
      return null;
    }
  }
  Future<Tag?> addTag(String name, String color, String token) async {
    try {
      final response = await dio.post(
        'habit/add_tag/',
        data: {
          'name': name,
          'color': color,
        },
      );

      if (response.statusCode == 200) {
        return Tag.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Failed to add tag: $e');
    }
  }
}



