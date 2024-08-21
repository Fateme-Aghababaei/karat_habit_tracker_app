import 'dart:convert';

class Badge {
  final String title;
  final String description;
  final String image;
  final String awardedAt;

  Badge({
    required this.title,
    required this.description,
    required this.image,
    required this.awardedAt,
  });

  factory Badge.fromRawJson(String str) => Badge.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Badge.fromJson(Map<String, dynamic> json) =>
      Badge(
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