import 'package:get_it/get_it.dart';
import 'package:tasky/features/auth/data/data_sources/user_remote_data_source.dart';
import 'package:tasky/features/auth/data/repos/user_repository_impl.dart';
import 'package:tasky/features/auth/domain/repos/user_repository.dart';

import 'api_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton<UserRemoteDataSource>(
      UserRemoteDataSourceImpl(apiService: getIt.get<ApiService>()));

  getIt.registerSingleton<UserRepository>(
      UserRepositoryImpl(remoteDataSource: getIt.get<UserRemoteDataSource>()));
}
