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
  final List<Follow>? followers;
  final List<Follow>? followings;
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
    this.followers,
    this.followings,
    this.notif_enabled
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    firsName: json["firs_name"],
    photo: json["photo"],
    score: json["score"],
    streak: json["streak"],
    inviter: json["inviter"],
    followersNum: json["followers_num"],
    followingsNum: json["followings_num"],
    notif_enabled: json["notif_enabled"],
    followers: List<Follow>.from(json["followers"].map((x) => Follow.fromJson(x))),
    followings: List<Follow>.from(json["followings"].map((x) => Follow.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "firs_name": firsName,
    "photo": photo,
    "score": score,
    "streak": streak,
    "inviter": inviter,
    "followers_num": followersNum,
    "followings_num": followingsNum,
    "notif_enabled":notif_enabled,
    "followers": List<dynamic>.from(followers!.map((x) => x.toJson())),
    "followings": List<dynamic>.from(followings!.map((x) => x.toJson())),
  };
}

class Follow {
  final String firsName;
  final String username;
  final String photo;

  Follow({
    required this.firsName,
    required this.username,
    required this.photo,
  });

  factory Follow.fromRawJson(String str) => Follow.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
    firsName: json["firs_name"],
    username: json["username"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "firs_name": firsName,
    "username": username,
    "photo": photo,
  };
}
