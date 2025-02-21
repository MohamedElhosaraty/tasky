import 'package:dartz/dartz.dart';

import 'package:tasky/core/errors/failures.dart';
import 'package:tasky/features/logo/data/data_sources/logo_remote_data_source.dart';
import 'package:tasky/features/logo/data/model/logo_model_hive.dart';

import 'package:tasky/features/logo/domain/logo_entity/logo_entity.dart';

import '../../domain/repos/logo_repo.dart';
import '../data_sources/logo_local_data.dart';

class LogoRepoImpl implements LogoRepo {

  final LogoRemoteDataSource remoteDataSource;
  final LogoLocalDataSource logoLocalDataSource;

  LogoRepoImpl({required this.remoteDataSource ,required this.logoLocalDataSource,});

  @override
  Future<Either<Failure, Map<String, Object>>> getLogoRepo() async {
    try {
      final logoList = await remoteDataSource.getLogo();
      final List<LogoEntity> logoEntities = logoList.map((logo) => LogoEntity(
        title: logo.title ?? '',
        desc: logo.desc ?? '',
        image: logo.image ?? '',
        priority: logo.priority?.toString() ?? '0',
        status: logo.status ?? '',
        createdAt: logo.createdAt.toString(),
        updatedAt: logo.updatedAt.toString(),
        userId: logo.id.toString(),
      )).toList();

      // ✅ تحويل `LogoEntity` إلى `LogoModelHive`
      final List<LogoModelHive> logoModels = logoEntities.map((entity) => LogoModelHive(
        id: entity.userId,
        title: entity.title,
        desc: entity.desc,
        image: entity.image,
        priority: entity.priority,
        status: entity.status,
        createdAt: entity.createdAt.toString(),
        updatedAt: entity.updatedAt.toString(),
        user: entity.userId,
        userId: entity.userId,
      )).toList();

      // ✅ حفظ البيانات محليًا
      await logoLocalDataSource.saveTask(logoModels);

      return Right({
        'data': logoEntities,
        'source': 'server',
        'errorMessage': ''
      });
    } on Failure catch (failure) {
      // 🚀 إذا فشل الاتصال، جلب البيانات من التخزين المحلي
      final localTasks = await logoLocalDataSource.getTasks();
      if (localTasks.isNotEmpty) {
        final List<LogoEntity> cachedEntities = localTasks.map((task) => LogoEntity(
          title: task.title,
          desc: task.desc,
          image: task.image,
          priority: task.priority,
          status: task.status,
          createdAt: task.createdAt,
          updatedAt: task.updatedAt,
          userId: task.id,
        )).toList();

        return Right({
          'data': cachedEntities,
          'source': 'local',
          'errorMessage': failure.message // ✅ الاحتفاظ برسالة الخطأ
        });
      } else {
        return Left(failure); // ⚠️ لا توجد بيانات محلية
      }
    }
  }


  @override
  Future<Either<Failure, void>> editeTask(
      {required String image,
        required String title,
        required String desc,
        required String priority,
        required String status,
        required String userId}) async {
    try {
      await remoteDataSource.editeTask(
          image: image,
          title: title,
          desc: desc,
          priority: priority,
          userId: userId,
          status: status);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask({required String userId}) async{
    try {
      await remoteDataSource.deleteTask(id: userId);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, void>> logout({required String refreshToken}) async{
    try {
      await remoteDataSource.logout(refreshToken: refreshToken);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, LogoEntity>> getOneTask({required String userId}) async {
    try {
      final logo = await remoteDataSource.getOneTask(userId: userId);
      final LogoEntity logoEntity = LogoEntity(
        title: logo.title ?? '',
        desc: logo.desc ?? '',
        image: logo.image ?? '',
        priority: logo.priority?.toString() ?? '0',
        status: logo.status ?? '',
        createdAt: logo.createdAt.toString(),
        updatedAt: logo.updatedAt.toString(),
        userId: logo.id.toString(),
      );
      return Right(logoEntity);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}