import 'dart:convert';
import 'habit_model.dart';

class Challenge {
  final int id;
  final String name;
  final String description;
  final String? photo;
  final bool isPublic;
  final CreatedBy createdBy;
  final String startDate;
  final String endDate;
  final int score;
  final int price;
  final List<CreatedBy> participants;
  final List<Habit> habits;
  final String shareCode;

  Challenge({
    required this.id,
    required this.name,
    required this.description,
    this.photo,
    required this.isPublic,
    required this.createdBy,
    required this.startDate,
    required this.endDate,
    required this.score,
    required this.price,
    required this.participants,
    required this.habits,
    required this.shareCode,
  });

  factory Challenge.fromRawJson(String str) => Challenge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    photo: json["photo"],
    isPublic: json["is_public"],
    createdBy: CreatedBy.fromJson(json["created_by"]),
    startDate: json["start_date"],
    endDate: json["end_date"],
    score: json["score"],
    price: json["price"],
    participants: List<CreatedBy>.from(json["participants"].map((x) => CreatedBy.fromJson(x))),
    habits: List<Habit>.from(json["habits"].map((x) => Habit.fromJson(x))),
    shareCode: json["share_code"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "photo": photo,
    "is_public": isPublic,
    "created_by": createdBy.toJson(),
    "start_date": startDate,
    "end_date": endDate,
    "score": score,
    "price": price,
    "participants": List<dynamic>.from(participants.map((x) => x.toJson())),
    "habits": List<dynamic>.from(habits.map((x) => x.toJson())),
    "share_code": shareCode,
  };
}

class CreatedBy {
  final String firstName;
  final String username;
  String? photo;

  CreatedBy({
    required this.firstName,
    required this.username,
    this.photo,
  });

  factory CreatedBy.fromRawJson(String str) => CreatedBy.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    firstName: json["first_name"],
    username: json["username"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "username": username,
    "photo": photo,
  };
}


