import 'package:dartz/dartz.dart';
import 'package:tasky/features/add_task/domain/create_task_entities/create_task_entity.dart';

import '../../../../core/errors/failures.dart';

abstract class CreateTaskRepo {
  Future<Either<Failure, CreateTaskEntity>> createTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
  });
}
