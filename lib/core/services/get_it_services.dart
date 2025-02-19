import 'package:get_it/get_it.dart';
import 'package:tasky/features/add_task/data/data_source/create_task_remote_data_source.dart';
import 'package:tasky/features/add_task/data/repos/create_task_repo_impl.dart';
import 'package:tasky/features/add_task/domain/repos/create_task_repo.dart';
import 'package:tasky/features/auth/data/data_sources/user_remote_data_source.dart';
import 'package:tasky/features/auth/data/repos/user_repository_impl.dart';
import 'package:tasky/features/auth/domain/repos/user_repository.dart';
import 'package:tasky/features/logo/data/data_sources/logo_remote_data_source.dart';
import 'package:tasky/features/logo/data/repos/logo_repo_impl.dart';
import 'package:tasky/features/logo/domain/repos/logo_repo.dart';
import 'package:tasky/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:tasky/features/profile/domain/repos/profile_repo.dart';

import '../../features/profile/data/repo_impl/profile_repo_impl.dart';
import 'api_service.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ApiService>(ApiService());
  getIt.registerSingleton<UserRemoteDataSource>(
      UserRemoteDataSourceImpl(apiService: getIt.get<ApiService>()));

  getIt.registerSingleton<UserRepository>(
      UserRepositoryImpl(remoteDataSource: getIt.get<UserRemoteDataSource>()));
  
  getIt.registerSingleton<LogoRemoteDataSource>(
    LogoRemoteDataSourceImpl(apiService: getIt.get<ApiService>())
  );

  getIt.registerSingleton<LogoRepo>(
      LogoRepoImpl(remoteDataSource: getIt.get<LogoRemoteDataSource>()));

  getIt.registerSingleton<LogoTaskRemoteDataSource>(
      CreateTaskRemoteDataSourceImpl(apiService: getIt.get<ApiService>())
  );

  getIt.registerSingleton<CreateTaskRepo>(
      CreateTaskRepoImpl(createTaskRemoteDataSource: getIt.get<LogoTaskRemoteDataSource>()));


  getIt.registerSingleton<ProfileRemoteDataSource>(
      ProfileRemoteDataSourceImpl(apiService: getIt.get<ApiService>())
  );

  getIt.registerSingleton<ProfileRepo>(
      ProfileRepoImpl(profileRemoteDataSource: getIt.get<ProfileRemoteDataSource>(), ));
}
