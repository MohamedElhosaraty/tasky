class CreateTaskModel {
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CreateTaskModel({
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.status,
    this.user,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CreateTaskModel.fromJson(Map<String, dynamic> json) => CreateTaskModel(
    image: json["image"],
    title: json["title"],
    desc: json["desc"],
    priority: json["priority"],
    status: json["status"],
    user: json["user"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "title": title,
    "desc": desc,
    "priority": priority,
    "status": status,
    "user": user,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
