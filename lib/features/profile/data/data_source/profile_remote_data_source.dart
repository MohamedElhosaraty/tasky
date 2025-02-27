import '../../../../core/services/api_service.dart';
import '../../../../core/utils/end_point.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> getProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {

  final ApiService apiService;

  ProfileRemoteDataSourceImpl({required this.apiService});
  @override
  Future<ProfileModel> getProfile() async {
    try {
      final response = await apiService.getRequest(EndPoint.profile);
      final Map<String, dynamic> data = response.data;
      return ProfileModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

}