import 'dart:convert';

class UserModel {
  final String email;
  final String password;
  final String? inviter;

  UserModel({
    required this.email,
    required this.password,
    this.inviter,
  });

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    password: json["password"],
    inviter: json["inviter"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "inviter": inviter,
  };
}
