import 'package:dartz/dartz.dart';

import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/add_task/data/data_source/create_task_remote_data_source.dart';

import 'package:tasky/features/add_task/domain/create_task_entities/create_task_entity.dart';

import '../../domain/repos/create_task_repo.dart';

class CreateTaskRepoImpl implements CreateTaskRepo {
  final LogoTaskRemoteDataSource createTaskRemoteDataSource;

  CreateTaskRepoImpl({required this.createTaskRemoteDataSource});

  @override
  Future<Either<Failure, CreateTaskEntity>> createTask(
      {required String image,
      required String title,
      required String desc,
      required String priority,
      required String dueDate}) async {
    try {
      final createTaskModel = await createTaskRemoteDataSource.createTask(
        image: image,
        title: title,
        desc: desc,
        priority: priority,
        dueDate: dueDate,
      );

      final createTaskEntity = CreateTaskEntity(
        image: createTaskModel.image ?? '',
        title: createTaskModel.title ?? '',
        desc: createTaskModel.desc ?? '',
        priority: createTaskModel.priority ?? '',
        dueDate: createTaskModel.createdAt.toString() ?? '',
        userId: createTaskModel.id ?? '',
      );
      return Right(createTaskEntity);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
