import 'package:tasky/features/logo/data/model/logo_model.dart';
import '../../../../core/errors/server_failure.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/end_point.dart';

abstract class LogoRemoteDataSource {
  Future<List<LogoModel>> getLogo();
  Future<void> editeTask({
    required String image,
    required String title,
    required String desc,
    required String priority,
    required String userId,
    required String status,
  });

  Future<void> deleteTask({required String id});
  Future<void> logout({required String refreshToken});
  Future<LogoModel> getOneTask({required String userId});



}

class LogoRemoteDataSourceImpl implements LogoRemoteDataSource {

  final ApiService apiService;

  LogoRemoteDataSourceImpl({required this.apiService});

  @override
  Future<List<LogoModel>> getLogo() async {
    try {
      final response = await apiService.getRequest(EndPoint.logo);
      final List<LogoModel> data = (response.data as List).map((item) =>
          LogoModel.fromJson(item as Map<String, dynamic>)).toList();
      return data;
    } on ServerFailure catch (e) {
      rethrow;
    }
  }


  @override
  Future<void> editeTask(
      {required String image,
        required String title,
        required String desc,
        required String priority,
        required String status,
        required String userId}) async{
    try {
      apiService.putRequest(
        "${EndPoint.editTask}/$userId",
        data: {
          "image": image,
          "title": title,
          "desc": desc,
          "priority": priority,
          "userId": userId,
          "status": status
        },
      );


    } on ServerFailure catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTask({required String id}) async {
    try {
      apiService.deleteRequest("${EndPoint.deleteTask}/$id");
    } on ServerFailure catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout({required String refreshToken}) async {
    try {
      apiService.postRequest(EndPoint.logout, data: {"refreshToken": refreshToken});
    } on ServerFailure catch (e) {
      rethrow;
    }
  }

  @override
  Future<LogoModel> getOneTask( {required String userId}) async{
    try {
      final response = await apiService.getRequest("${EndPoint.oneTask}/$userId");
      final Map<String, dynamic> data = response.data ;
      return LogoModel.fromJson(data);
    } on ServerFailure catch (e) {
      rethrow;
    }
  }


}