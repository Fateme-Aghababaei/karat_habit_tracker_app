import 'dart:convert';

class Follower_Following {
  final String? firstName;
  final String? username;
  final List<Follow>? followers;
  final List<Follow>? followings;

  Follower_Following({
     this.firstName,
     this.username,
    this.followers,
    this.followings,
  });

  factory Follower_Following.fromRawJson(String str) => Follower_Following.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Follower_Following.fromJson(Map<String, dynamic> json) => Follower_Following(
    firstName: json["first_name"],
    username: json["username"],
    followers: List<Follow>.from(json["followers"].map((x) => Follow.fromJson(x))),
    followings: List<Follow>.from(json["followings"].map((x) => Follow.fromJson(x))),

  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "username": username,
    "followers": List<dynamic>.from(followers!.map((x) => x.toJson())),
    "followings": List<dynamic>.from(followings!.map((x) => x.toJson())),
  };
}

class Follow {
  final String firstName;
  final String username;
  final String photo;

  Follow({
    required this.firstName,
    required this.username,
    required this.photo,
  });

  factory Follow.fromRawJson(String str) => Follow.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Follow.fromJson(Map<String, dynamic> json) => Follow(
    firstName: json["first_name"],
    username: json["username"],
    photo: json["photo"],

  );

  Map<String, dynamic> toJson() => {
    "firs_name": firstName,
    "username": username,
    "photo": photo,
  };
}
