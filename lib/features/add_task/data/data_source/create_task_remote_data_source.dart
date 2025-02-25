import 'package:tasky/core/services/api_service.dart';
import 'package:tasky/features/add_task/data/models/create_task_model.dart';

import '../../../../core/errors/server_failure.dart';
import '../../../../core/utils/end_point.dart';

abstract class LogoTaskRemoteDataSource {
  Future<CreateTaskModel> createTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
  });

}

class CreateTaskRemoteDataSourceImpl implements LogoTaskRemoteDataSource {
  final ApiService apiService;

  CreateTaskRemoteDataSourceImpl({required this.apiService});

  @override
  Future<CreateTaskModel> createTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String dueDate,
  }) async {
    try {
      final response = await apiService.postRequest(
        EndPoint.createTask,
        data: {
          "image": image,
          "title": title,
          "desc": desc,
          "priority": priority,
          "dueDate": dueDate,
        },
      );

      final Map<String, dynamic> data = response.data;
      return CreateTaskModel.fromJson(data);
    } on ServerFailure catch (e) {
      rethrow;
    }
  }
}
