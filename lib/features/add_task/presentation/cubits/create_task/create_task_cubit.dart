import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/add_task/domain/repos/create_task_repo.dart';

part 'create_task_state.dart';

class CreateTaskCubit extends Cubit<CreateTaskState> {
  CreateTaskCubit(this.createTaskRepo) : super(CreateTaskInitial());

  final CreateTaskRepo createTaskRepo;

  Future<void> createTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
  }) async {
    emit(CreateTaskLoading());
    final result = await createTaskRepo.createTask(
      image: image,
      title: title,
      desc: desc,
      priority: priority,
      dueDate: dueDate,
    );
    result.fold(
        (failure) => emit(CreateTaskFailure(errorMessage: failure.message)),
        (createTaskEntity) =>
            emit(CreateTaskSuccess())
    );
  }
}
