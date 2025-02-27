class ProfileModel {
  String? id;
  String? displayName;
  String? username;
  List<String>? roles;
  bool? active;
  int? experienceYears;
  String? address;
  String? level;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProfileModel({
    this.id,
    this.displayName,
    this.username,
    this.roles,
    this.active,
    this.experienceYears,
    this.address,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["_id"],
    displayName: json["displayName"],
    username: json["username"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    active: json["active"],
    experienceYears: json["experienceYears"],
    address: json["address"],
    level: json["level"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "displayName": displayName,
    "username": username,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "active": active,
    "experienceYears": experienceYears,
    "address": address,
    "level": level,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
