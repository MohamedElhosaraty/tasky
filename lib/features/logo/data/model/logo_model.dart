class LogoModel {
  String? id;
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  User? user;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  LogoModel({
    this.id,
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.status,
    this.user,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LogoModel.fromJson(Map<String, dynamic> json) => LogoModel(
    id: json["_id"],
    image: json["image"],
    title: json["title"],
    desc: json["desc"],
    priority: json["priority"],
    status: json["status"],
    user: userValues.map[json["user"]] ?? User.THE_6649_FB2_EEF0_BF93_DD00711_BA,
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "title": title,
    "desc": desc,
    "priority": priorityValues.reverse[priority],
    "status": status,
    "user": userValues.reverse[user],
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

enum Priority {
  HIGH,
  LOW,
  MEDIUM
}

final priorityValues = EnumValues({
  "high": Priority.HIGH,
  "low": Priority.LOW,
  "medium": Priority.MEDIUM
});

enum User {
  THE_6649_FB2_EEF0_BF93_DD00711_BA
}

final userValues = EnumValues({
  "6649fb2eef0bf93dd00711ba": User.THE_6649_FB2_EEF0_BF93_DD00711_BA
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
