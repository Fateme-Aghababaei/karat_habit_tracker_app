import 'dart:convert';

class Brief {
  final String username;
  final String firstName;
  final String? photo;
  final int? score;

  Brief({
    required this.username,
    required this.firstName,
    this.photo,
     this.score,
  });

  factory Brief.fromRawJson(String str) => Brief.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Brief.fromJson(Map<String, dynamic> json) => Brief(
    username: json["username"],
    firstName: json["first_name"],
    photo: json["photo"],
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "first_name": firstName,
    "photo": photo,
    "score": score,
  };
}
