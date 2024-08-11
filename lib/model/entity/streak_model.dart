import 'dart:convert';

class Streak {
  final int streak;
  final String state;

  Streak({
    required this.streak,
    required this.state,
  });

  factory Streak.fromRawJson(String str) => Streak.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Streak.fromJson(Map<String, dynamic> json) => Streak(
    streak: json["streak"],
    state: json["state"],
  );

  Map<String, dynamic> toJson() => {
    "streak": streak,
    "state": state,
  };
}
