import 'dart:convert';

class Streak {
  final int streak;
  final String state;
  final bool hasNewBadges;

  Streak({
    required this.streak,
    required this.state,
    required this.hasNewBadges,
  });

  factory Streak.fromRawJson(String str) => Streak.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Streak.fromJson(Map<String, dynamic> json) => Streak(
    streak: json["streak"],
    state: json["state"],
    hasNewBadges: json["has_new_badges"],
  );

  Map<String, dynamic> toJson() => {
    "streak": streak,
    "state": state,
    "has_new_badges": hasNewBadges,
  };
}
