import 'dart:convert';

class Notification {
  final int id;
  final String title;
  final String description;
  final String createdAt;
  final bool isRead;

  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.isRead,
  });

  factory Notification.fromRawJson(String str) => Notification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    createdAt: json["created_at"],
    isRead: json["is_read"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "created_at": createdAt,
    "is_read": isRead,
  };
}
