import 'dart:convert';

class Track {
  final int? id;
  final String? name;
  final String startDatetime;
  final String endDatetime;
  final Tag? tag;

  Track({
    this.id,
    this.name,
    required this.startDatetime,
    required this.endDatetime,
    this.tag,
  });

  factory Track.fromRawJson(String str) => Track.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());


  factory Track.fromJson(Map<String, dynamic> json) => Track(
    id: json["id"],
    name: json["name"],
    startDatetime: json["start_datetime"],
    endDatetime: json["end_datetime"],
    tag: json["tag"] == null ? null : Tag.fromJson(json["tag"]),
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "id": id,
      "name": name,
      "start_datetime": startDatetime,
      "end_datetime": endDatetime,
    };

    if ( tag!= null) {
      data["tag"] = tag?.id;
    }
    return data;

  }
}

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

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    id: json["id"],
    name: json["name"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "color": color,
  };
}
