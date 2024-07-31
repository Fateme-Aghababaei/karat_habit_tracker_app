import 'dart:convert';

class AccountModel {
  final String email;
  final String password;
  final String? inviter;

  AccountModel({
    required this.email,
    required this.password,
    this.inviter,
  });

  factory AccountModel.fromRawJson(String str) => AccountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
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
