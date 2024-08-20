import 'package:karat_habit_tracker_app/model/entity/tag_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class Statistics {
  final String date;
  final int totalHabits;
  final int completedHabits;
  final int totalTrackDuration;
  final int totalScore;
  final List<Habit> habits;
  final List<Track> tracks;

  Statistics({
    required this.date,
    required this.totalHabits,
    required this.completedHabits,
    required this.totalTrackDuration,
    required this.totalScore,
    required this.habits,
    required this.tracks,
  });

  factory Statistics.fromRawJson(String str) => Statistics.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Statistics.fromJson(Map<String, dynamic> json) {
    try {
      return Statistics(
        date: json["date"],
        totalHabits: json["total_habits"],
        completedHabits: json["completed_habits"],
        totalTrackDuration: json["total_track_duration"],
        totalScore: json["total_score"],
        habits: List<Habit>.from(json["habits"].map((x) => Habit.fromJson(x))),
        tracks: List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
      );
    } catch (e) {
      print('Error parsing Statistics: $e');
      rethrow; // This will propagate the error up the call stack
    }
  }

  Map<String, dynamic> toJson() => {
    "date": date,
    "total_habits": totalHabits,
    "completed_habits": completedHabits,
    "total_track_duration": totalTrackDuration,
    "total_score": totalScore,
    "habits": List<dynamic>.from(habits.map((x) => x.toJson())),
    "tracks": List<dynamic>.from(tracks.map((x) => x.toJson())),
  };
}

class Habit {
  final Tag? tag;
  final int completedHabits;

  Habit({
    required this.tag,
    required this.completedHabits,
  });

  factory Habit.fromRawJson(String str) => Habit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
    tag: json["tag"] == null ? null : Tag.fromJson(json["tag"]),
    completedHabits: json["completed_habits"],
  );

  Map<String, dynamic> toJson()  {
  final Map<String, dynamic> data = { "completed_habits": completedHabits,};
  data["tag"] = tag?.id;
  return data;
  }
}



class Track {
  final Tag? tag;
  final int totalTrackDuration;

  Track({
    required this.tag,
    required this.totalTrackDuration,
  });

  factory Track.fromRawJson(String str) => Track.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Track.fromJson(Map<String, dynamic> json) => Track(
    tag: json["tag"] == null ? null : Tag.fromJson(json["tag"]),
    totalTrackDuration: json["total_track_duration"],
  );

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = {"total_track_duration": totalTrackDuration};
  if ( tag!= null) {
  data["tag"] = tag?.id;
  }
  return data;

  }

}
