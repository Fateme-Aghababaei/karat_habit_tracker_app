import 'dart:convert';

class Tag {
  final int? id;
  final String? name;
  final String? color;

  Tag({
    this.id,
    this.name,
    this.color,
  });

  factory Tag.fromRawJson(String str) => Tag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tag.fromJson(Map<String, dynamic> json) =>
      Tag(
        id: json["id"],
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "name": name,
        "color": color,
      };
}