part of 'create_task_cubit.dart';

sealed class CreateTaskState {}

final class CreateTaskInitial extends CreateTaskState {}

final class CreateTaskLoading extends CreateTaskState {}

final class CreateTaskSuccess extends CreateTaskState {}

final class CreateTaskFailure extends CreateTaskState {
  final String errorMessage;

  CreateTaskFailure({required this.errorMessage});
}

