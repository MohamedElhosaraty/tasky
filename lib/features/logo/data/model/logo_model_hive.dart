import 'package:hive/hive.dart';
import 'package:tasky/features/logo/domain/logo_entity/logo_entity.dart';

part 'logo_model_hive.g.dart';

@HiveType(typeId: 0)
class LogoModelHive extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String desc;

  @HiveField(3)
  final String priority;

  @HiveField(4)
  final String status;

  @HiveField(5)
  final String user;

  @HiveField(6)
  final String createdAt;

  @HiveField(7)
  final String updatedAt;

@HiveField(8)
  final String image;
@HiveField(9)
  final String userId;

  LogoModelHive({
    required this.id,
    required this.title,
    required this.desc,
    required this.priority,
    required this.status,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
    required this.userId,
  });

  // تحويل Model إلى Entity
  LogoEntity toEntity() {
    return LogoEntity(
      title: title,
      desc: desc,
      priority: priority,
      status: status,
      createdAt: createdAt.toString(),
      updatedAt: updatedAt.toString(),
      image:  image,
      userId: userId,
    );
  }

  // تحويل JSON إلى Model
  factory LogoModelHive.fromJson(Map<String, dynamic> json) {
    return LogoModelHive(
      id: json["_id"],
      title: json["title"],
      desc: json["desc"],
      priority: json["priority"],
      status: json["status"],
      user: json["user"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      image: json["image"],
      userId: json["userId"],
    );
  }

  // تحويل Model إلى JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "desc": desc,
      "priority": priority,
      "status": status,
      "user": user,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "image": image,
      "userId": userId,
    };
  }
}
