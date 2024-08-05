import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  final int? id;
  final String? username;
  final String? email;
  final String? firsName;
  final String? photo;
  final int? score;
  final int? streak;
  final String? inviter;
  final int? followersNum;
  final int? followingsNum;
  final bool? notif_enabled;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.firsName,
    this.photo,
    this.score,
    this.streak,
    this.inviter,
    this.followersNum,
    this.followingsNum,
    this.notif_enabled
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firsName: json["first_name"],
    photo: json["photo"],
    score: json["score"],
    streak: json["streak"],
    inviter: json["inviter"],
    followersNum: json["followers_num"],
    followingsNum: json["followings_num"],
    notif_enabled: json["notif_enabled"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "first_name": firsName,
    "photo": photo,
    "score": score,
    "streak": streak,
    "inviter": inviter,
    "followers_num": followersNum,
    "followings_num": followingsNum,
    "notif_enabled":notif_enabled,

  };
}

