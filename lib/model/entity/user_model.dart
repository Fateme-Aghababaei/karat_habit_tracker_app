import 'dart:convert';

import 'badge_model.dart';

class UserModel {
  final int? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? photo;
  final int? score;
  final int? streak;
  final String? inviter;
  final int? followersNum;
  final int? followingsNum;
  final bool? notif_enabled;
  final List<Badge> badges;
  final int completedChallengesNum;
  final int completedHabitsNum;
  final int unreadNotifsNum;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.photo,
    this.score,
    this.streak,
    this.inviter,
    this.followersNum,
    this.followingsNum,
    this.notif_enabled,
    required this.badges,
    required this.completedChallengesNum,
    required this.completedHabitsNum,
    required this.unreadNotifsNum,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firstName: json["first_name"],
    photo: json["photo"],
    score: json["score"],
    streak: json["streak"],
    inviter: json["inviter"],
    followersNum: json["followers_num"],
    followingsNum: json["followings_num"],
    notif_enabled: json["notif_enabled"],
    badges: List<Badge>.from(json["badges"].map((x) => Badge.fromJson(x))),
    completedChallengesNum: json["completed_challenges_num"],
    completedHabitsNum: json["completed_habits_num"],
    unreadNotifsNum: json["unread_notifs_num"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "first_name": firstName,
    "photo": photo,
    "score": score,
    "streak": streak,
    "inviter": inviter,
    "followers_num": followersNum,
    "followings_num": followingsNum,
    "notif_enabled":notif_enabled,
    "badges": List<dynamic>.from(badges.map((x) => x.toJson())),
    "completed_challenges_num": completedChallengesNum,
    "completed_habits_num": completedHabitsNum,
    "unread_notifs_num": unreadNotifsNum,

  };
}

