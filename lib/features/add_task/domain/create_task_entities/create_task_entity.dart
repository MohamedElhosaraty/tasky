class CreateTaskEntity {
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String dueDate;
  final String userId;

  CreateTaskEntity(
      {required this.image,
      required this.title,
      required this.desc,
      required this.priority,
      required this.dueDate,
      required this.userId
      });
}
