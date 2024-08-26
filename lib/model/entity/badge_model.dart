import 'dart:convert';

class MyBadge {
  final String title;
  final String description;
  final String image;
  final String awardedAt;

  MyBadge({
    required this.title,
    required this.description,
    required this.image,
    required this.awardedAt,
  });

  factory MyBadge.fromRawJson(String str) => MyBadge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyBadge.fromJson(Map<String, dynamic> json) =>
      MyBadge(
        title: json["title"],
        description: json["description"],
        image: json["image"],
        awardedAt: json["awarded_at"],
      );

  Map<String, dynamic> toJson() =>
      {
        "title": title,
        "description": description,
        "image": image,
        "awarded_at": awardedAt,
      };
}