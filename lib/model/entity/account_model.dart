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


  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };

    if (inviter != null) {
      data["inviter"] = inviter;
    }
    return data;
  }
}
