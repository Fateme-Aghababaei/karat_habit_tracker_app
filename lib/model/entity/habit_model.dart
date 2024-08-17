import 'dart:convert';

import 'package:karat_habit_tracker_app/model/entity/tag_model.dart';


class Habit {
  final int id;
  final int? fromChallenge;
  final String name;
  final String? description;
  final String? startDate;
  final String? dueDate;
  final int score;
  final bool isRepeated;
  final bool isCompleted;
  final String? repeatedDays;
  final String? completedDate;
  final Tag? tag;

  Habit({
    required this.id,
    this.fromChallenge,
    required this.name,
    this.description,
    this.startDate,
    this.dueDate,
    required this.score,
    required this.isRepeated,
    required this.isCompleted,
    this.repeatedDays,
    this.completedDate,
    this.tag,
  });

  factory Habit.fromRawJson(String str) => Habit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
    id: json["id"],
    fromChallenge: json["from_challenge"],
    name: json["name"],
    description: json["description"],
    startDate: json["start_date"],
    dueDate: json["due_date"],
    score: json["score"],
    isRepeated: json["is_repeated"],
    isCompleted: json["is_completed"],
    repeatedDays: json["repeated_days"],
    completedDate: json["completed_date"],
    tag: json["tag"] == null ? null : Tag.fromJson(json["tag"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "from_challenge": fromChallenge,
    "name": name,
    "description": description,
    "start_date": startDate,
    "due_date": dueDate,
    "score": score,
    "is_repeated": isRepeated,
    "is_completed": isCompleted,
    "repeated_days": repeatedDays,
    "completed_date": completedDate,
    "tag": tag?.toJson(),
  };
}




