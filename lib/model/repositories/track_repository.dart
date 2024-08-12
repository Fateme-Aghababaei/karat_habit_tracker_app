

import '../constant.dart';
import '../entity/track_model.dart';

class TrackRepository{

  Future<Track?> addTrack(String name, String startDatetime, {int? tagId}) async {
    try {
      final response = await dio.post(
        'track/add_track/',
        data: {
          'name': name,
          'tag': tagId,
          'start_datetime': startDatetime,
        },
      );

      if (response.statusCode == 200) {
        return Track.fromJson(response.data);
      } else {
        final errorMessage = response.data['error'] ?? 'An unknown error occurred';
        throw Exception(errorMessage);  // بازگرداندن استثناء
      }
    } catch (e) {
      print('Error editing track: $e');
      return null;    }
  }
  Future<Track?> editTrack(int id, String name, {int? tagId}) async {
    try {
      final response = await dio.post(
        'track/edit_track/',
        data: {
          'id': id,
          'name': name,
          'tag': tagId,
        },
      );

      if (response.statusCode == 200) {
        return Track.fromJson(response.data);
      } else {
        final errorMessage = response.data['error'] ?? 'An unknown error occurred';
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

  Future<Track?> getTrack(int id) async {
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



}

