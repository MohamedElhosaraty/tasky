
class LogoEntity {
  final String title;
  final String desc;
  final String priority;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String image;
  final String userId;

  LogoEntity(
      {required this.title,
      required this.desc,
      required this.image,
      required this.priority,
      required this.userId,
      required this.status,
      required this.createdAt,
      required this.updatedAt});
}
